class RecipeModel {
  String? message;
  Data? data;

  RecipeModel({this.message, this.data});

  RecipeModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? recipeName;
  String? cookTime;
  String? servingSize;
  List<String>? ingredients;
  List<String>? howToCook;
  List<String>? benefit;
  NutritionalInformation? nutritionalInformation;
  List<String>? dietaryTags;

  Data(
      {this.recipeName,
      this.cookTime,
      this.servingSize,
      this.ingredients,
      this.howToCook,
      this.benefit,
      this.nutritionalInformation,
      this.dietaryTags});

  Data.fromJson(Map<String, dynamic> json) {
    recipeName = json['recipe_name'];
    cookTime = json['cook_time'];
    servingSize = json['serving_size'];
    ingredients = json['ingredients'].cast<String>();
    howToCook = json['how_to_cook'].cast<String>();
    benefit = json['benefit'].cast<String>();
    nutritionalInformation = json['nutritional_information'] != null
        ? NutritionalInformation.fromJson(json['nutritional_information'])
        : null;
    dietaryTags = json['dietary_tags'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['recipe_name'] = recipeName;
    data['cook_time'] = cookTime;
    data['serving_size'] = servingSize;
    data['ingredients'] = ingredients;
    data['how_to_cook'] = howToCook;
    data['benefit'] = benefit;
    if (nutritionalInformation != null) {
      data['nutritional_information'] = nutritionalInformation!.toJson();
    }
    data['dietary_tags'] = dietaryTags;
    return data;
  }
}

class NutritionalInformation {
  String? calories;
  String? protein;
  String? fat;
  String? carbohydrates;
  String? sugar;

  NutritionalInformation(
      {this.calories, this.protein, this.fat, this.carbohydrates, this.sugar});

  NutritionalInformation.fromJson(Map<String, dynamic> json) {
    calories = json['calories'];
    protein = json['protein'];
    fat = json['fat'];
    carbohydrates = json['carbohydrates'];
    sugar = json['sugar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['calories'] = calories;
    data['protein'] = protein;
    data['fat'] = fat;
    data['carbohydrates'] = carbohydrates;
    data['sugar'] = sugar;
    return data;
  }
}
