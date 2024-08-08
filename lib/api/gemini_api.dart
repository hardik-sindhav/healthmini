import 'package:healthmini/utils/general_imports.dart';

class GeminiApi {
  Future callGemini(String prompt) async {
    var apiKey = dotenv.env['GEMINI_API_KEY'];
    if (apiKey == null) {
      exit(1);
    }

    final model = GenerativeModel(
      model: 'gemini-1.5-flash',
      apiKey: apiKey,
      generationConfig: GenerationConfig(
        responseMimeType: "application/json",
      ),
    );
    final content = [Content.text(prompt)];
    final response = await model.generateContent(content);

    try {
      final jsonResponse = jsonDecode(response.text ?? "");
      return jsonResponse;
    } catch (e) {
      return null;
    }
  }
}
