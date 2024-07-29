import 'package:healthmini/const/list_data.dart';

class SymptomsValidFunction {
  int checkSubstringMatches({required List<String> userPhrases}) {
    Set<String> predefinedSet = Set.from(predefinedSymptomsList);

    int matchCount = 0;

    for (String phrase in userPhrases) {
      String lowerCasePhrase = phrase.toLowerCase();

      bool foundMatch = false;

      for (String word in predefinedSet) {
        if (lowerCasePhrase.contains(word.toLowerCase())) {
          foundMatch = true;
          break;
        }
      }

      if (foundMatch) {
        matchCount++;
      }
    }

    return matchCount;
  }
}
