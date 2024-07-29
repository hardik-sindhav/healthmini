class GeneralFunction {

  String capitalizeFirstLetter(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }

  bool containsDemoDetails({required String string,required String validation}) {
    return string.contains(validation);
  }

}