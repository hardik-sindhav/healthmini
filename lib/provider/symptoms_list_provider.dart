// ignore_for_file: collection_methods_unrelated_type

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:healthmini/models/symptoms_list_model.dart';

enum SymptomsListState {
  initial,
  loaded,
  loading,
  loadingMore,
  empty,
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

  bool enterSymptoms(String symptoms){
    bool status;
    if (selectedSymptomsList.contains(symptoms)) {
      status = false;
    } else {
      selectedSymptomsList.add(symptoms);
      status = true;
    }
    notifyListeners();
    return status;
  }

  void removeSymptoms(int index){
    selectedSymptomsList.removeAt(index);
    notifyListeners();
  }
}
