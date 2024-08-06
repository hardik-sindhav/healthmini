// ignore_for_file: collection_methods_unrelated_type, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:healthmini/api/gemini_api.dart';
import 'package:healthmini/api/pexels_api.dart';
import 'package:healthmini/helper/prompt_helper.dart';
import 'package:healthmini/models/pexels_model.dart';
import 'package:healthmini/models/recipe_model.dart';
import 'package:healthmini/utils/snackbar.dart';


enum RecipeState {
  initial,
  loaded,
  loading,
  error,
}

class RecipeListProvider extends ChangeNotifier {
  RecipeState _recipeState = RecipeState.initial;
  String message = '';

  RecipeState get recipeState => _recipeState;


  List<RecipeModel> recipeList = [];
  PexelsModel? pexelsModel;

  Future<void> getRecipeList({required BuildContext context}) async {
    recipeList = [];
    _recipeState = RecipeState.loading;
    notifyListeners();

    try {

      var res = await GeminiApi().callGemini(
          PromptHelper().recipePrompt());


      if (res != null && res['data'] != null) {
        RecipeModel recipeModel = RecipeModel.fromJson(res);
        recipeList.add(recipeModel);
        print(res);
        pexelsModel = await PexelsApi().searchPhotos(recipeModel.data?.recipeName??"");
        _recipeState = RecipeState.loaded;
        notifyListeners();

        print(res);
      } else if (res['message'] != '') {
        message = res['message'];
        _recipeState = RecipeState.loaded;
        notifyListeners();
      } else {
        message = "An error occurred. Please try again.";
        showCustomSnackbar(context, 'An error occurred. Please try again.',
            MessageType.warning);
        _recipeState = RecipeState.error;
        notifyListeners();
      }


    } catch (e) {
      print('Error occurred: $e');
      showCustomSnackbar(
          context, 'An error occurred. Please try again.', MessageType.error);
      _recipeState = RecipeState.error;
      notifyListeners();
    }
  }
}
