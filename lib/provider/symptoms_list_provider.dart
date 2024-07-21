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
  List<SymptomsListModel> dataList = [];

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

      dataList = querySnapshot.docs
          .map((doc) => SymptomsListModel.fromFirestore(doc.data()))
          .toList();
      setSymptomsListState(SymptomsListState.loaded);
    } catch (error) {
      setSymptomsListState(SymptomsListState.error);
      print("Error getting data: $error");
    }
  }
}
