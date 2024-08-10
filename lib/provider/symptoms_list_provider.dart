// ignore_for_file: collection_methods_unrelated_type, use_build_context_synchronously
import 'package:healthmini/models/details_model.dart';
import 'package:healthmini/models/symptoms_list_model.dart';
import 'package:healthmini/utils/general_imports.dart';

enum SymptomsListState {
  initial,
  loaded,
  loading,
  loadingMore,
  empty,
  error,
}

enum FindSymptomsState {
  initial,
  loaded,
  loading,
  error,
}

class SymptomsListProvider extends ChangeNotifier {
  SymptomsListState _symptomsListState = SymptomsListState.initial;
  String message = '';
  List<SymptomsListModel> symptomsList = [];
  List<String> selectedSymptomsList = [];

  SymptomsListState get symptomsListState => _symptomsListState;

  void setSymptomsListState(SymptomsListState state) {
    _symptomsListState = state;
    notifyListeners();
  }

  Future<void> getSymptomsList() async {
    setSymptomsListState(SymptomsListState.loading);
    try {
      final collectionRef = FirebaseFirestore.instance.collection("symptoms");
      final querySnapshot = await collectionRef.get();

      symptomsList = querySnapshot.docs
          .map((doc) => SymptomsListModel.fromFirestore(doc.data()))
          .toList();
      selectedSymptomsList = [];
      setSymptomsListState(SymptomsListState.loaded);
    } catch (error) {
      setSymptomsListState(SymptomsListState.error);
    }
  }

  void selectedSymptoms(String symptoms) {
    if (selectedSymptomsList.contains(symptoms)) {
      selectedSymptomsList.remove(symptoms);
    } else {
      selectedSymptomsList.add(symptoms);
    }

    notifyListeners();
  }

  bool enterSymptoms(String symptoms) {
    String text = GeneralFunction().capitalizeFirstLetter(symptoms);
    bool status;
    if (selectedSymptomsList.contains(text)) {
      status = false;
    } else {
      selectedSymptomsList.add(text);
      status = true;
    }
    notifyListeners();
    return status;
  }

  void removeSymptoms(int index) {
    selectedSymptomsList.removeAt(index);
    notifyListeners();
  }

  FindSymptomsState findSymptomsState = FindSymptomsState.initial;

  List<Data> detailsList = [];

  Future<void> sendSymptoms({required BuildContext context}) async {
    detailsList = [];
    findSymptomsState = FindSymptomsState.loading;
    notifyListeners();

    try {
      if (selectedSymptomsList.isNotEmpty) {
        String? country = SharedPreferencesService()
            .getString(SharedPreferencesService().countryKey);

        String? state = SharedPreferencesService()
            .getString(SharedPreferencesService().stateKey);

        String? city = SharedPreferencesService()
            .getString(SharedPreferencesService().cityKey);

        String? age = SharedPreferencesService()
            .getString(SharedPreferencesService().ageKey);

        String? gender = SharedPreferencesService()
            .getString(SharedPreferencesService().genderKey);

        var res = await GeminiApi().callGemini(PromptHelper()
            .generatePromptWithSymptoms(selectedSymptomsList, city ?? 'Surat',
                state ?? "Gujarat", country ?? 'India',
                age: int.parse(age ?? "0"), gender: gender));

        if (res != null && res['data'] != null) {
          DetailsModel detailsModel = DetailsModel.fromJson(res);
          detailsList = detailsModel.data ?? [];
          if (country != "" &&
              city != "" &&
              state != "" &&
              age != "" &&
              gender != "" &&
              country != null &&
              city != null &&
              state != null &&
              age != null &&
              gender != null) {
            await FirebaseFirestore.instance.collection('query_data').add({
              'country': country,
              'state': state,
              'city': city,
              'symptoms': selectedSymptomsList,
              'age': age,
              'gender': gender,
              'timestamp': FieldValue.serverTimestamp(),
            });
          }
          findSymptomsState = FindSymptomsState.loaded;
          notifyListeners();
        } else if (res['message'] != '') {
          message = res['message'];
          findSymptomsState = FindSymptomsState.loaded;
          notifyListeners();
        } else {
          message = "An error occurred. Please try again.";
          showCustomSnackbar(context, 'An error occurred. Please try again.',
              MessageType.warning);
          findSymptomsState = FindSymptomsState.error;
          notifyListeners();
        }
      } else {
        message =
            "You enter or selected symptoms are not valid or not match with any symptoms !";

        showCustomSnackbar(
            context,
            'You enter or selected symptoms are not valid or not match with any symptoms !',
            MessageType.error);
        findSymptomsState = FindSymptomsState.error;
        notifyListeners();
      }
    } catch (e) {
      showCustomSnackbar(
          context, 'An error occurred. Please try again.', MessageType.error);
      findSymptomsState = FindSymptomsState.error;
      notifyListeners();
    }
  }
}
