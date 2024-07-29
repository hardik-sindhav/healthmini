import 'dart:convert';
import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';


class GeminiApi {
  Future callGemini(String prompt) async {
    var apiKey = dotenv.env['GEMINI_API_KEY'];
    if (apiKey == null) {
      print('No \$API_KEY environment variable');
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
      final jsonResponse = jsonDecode(response.text??"");
      print(jsonResponse);
      return jsonResponse;
    } catch (e) {
      print('Failed to decode JSON: $e');
      return null;
    }
  }
}


