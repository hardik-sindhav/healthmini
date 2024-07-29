// ignore_for_file: collection_methods_unrelated_type, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:healthmini/api/gemini_api.dart';
import 'package:healthmini/functions/general_function.dart';
import 'package:healthmini/functions/symptoms_valid_function.dart';
import 'package:healthmini/helper/prompt_helper.dart';
import 'package:healthmini/models/details_model.dart';
import 'package:healthmini/models/symptoms_list_model.dart';
import 'package:healthmini/utils/snackbar.dart';

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
        int selectedSymptomsValid = SymptomsValidFunction()
            .checkSubstringMatches(userPhrases: selectedSymptomsList);

        if (selectedSymptomsValid > 2) {
          var res = await GeminiApi().callGemini(
              PromptHelper().generatePromptWithSymptoms(selectedSymptomsList));


          if (res != null && res['data'] != null) {
            DetailsModel detailsModel = DetailsModel.fromJson(res);
            detailsList = detailsModel.data ?? [];

            findSymptomsState = FindSymptomsState.loaded;
            notifyListeners();

            print(res);
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
          message = "You enter or selected symptoms are not valid or not match with any symptoms !";

          showCustomSnackbar(
              context, 'You enter or selected symptoms are not valid or not match with any symptoms !', MessageType.error);
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
      print('Error occurred: $e');
      showCustomSnackbar(
          context, 'An error occurred. Please try again.', MessageType.error);
      findSymptomsState = FindSymptomsState.error;
      notifyListeners();
    }
  }
}
