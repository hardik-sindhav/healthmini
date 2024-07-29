class PromptHelper {
  String generatePromptWithSymptoms(List symptoms) {
    return '''
  **Disclaimer:** This information is for informational purposes only and should not replace professional medical advice. Always consult a doctor for medical concerns.

  **Input:** List of symptoms ($symptoms) 

  **Output:** JSON object with the following structure:
  {
    "message": "",  // Initially empty, filled with a message if necessary
    "data": []      // Initially empty, filled with potential disease suggestions
  }

  **Processing:**
  1. **Validate Input:**
     - Check if any symptoms are provided.
     - If no symptoms are provided, set "message" to "Please enter your symptoms." and return the JSON.
     - If symptoms are provided but do not match any diseases, set "message" to "No diseases match your symptoms. Kindly visit your nearest hospital." and return the JSON.
     - If the symptoms list is wrong or invalid, set "message" to "The symptoms provided are not valid. Please enter a valid list of symptoms." and return the JSON.
     - If the symptoms list is wrong or invalid and make sure if not match any diseases, set "message" to "The symptoms provided are not valid. Please enter a valid list of symptoms." and return the JSON.
  2. **Disease Suggestion Simulation (Example):**
     - **Simulate** a lookup process for potential diseases based on the symptoms.
     - For each potential disease:
       - Create an object with the following properties (replace placeholders with simulated values):
         - "prediction_percentage": Check List of symptoms how much match with disease and then make prediction_percentage
         - "disease_name": "Disease Name"
         - "disease_symptoms": ["Symptom 1", "Symptom 2", ...]
         - "disease_reason": ["Reason 1", "Reason 2", ...]
         - "medicine_for_disease": ["medicine name 1", "medicine name 2", ...]  // Emphasize disclaimer
         - "home_treatment": ["treatment 1", "treatment 2", ...]  // Home treatment suggestions
         - "best_hospital": [
             {
               "name": "Hospital Name",
               "address": {
                 "street": "Street Name",
                 "pin": "PIN Code",
                 "city": "City",
                 "state": "State",
                 "country": "Country"
               },
               "contact": {
                 "mobile": "Mobile Number",
                 "email": "Email Address"
               }
             },
             {
               "name": "Hospital Name 2",
               "address": {
                 "street": "Street Name",
                 "pin": "PIN Code",
                 "city": "City",
                 "state": "State",
                 "country": "Country"
               },
               "contact": {
                 "mobile": "Mobile Number",
                 "email": "Email Address"
               }
             }
           ]  
       - Add the disease object to the "data" array.
       
  3. **Location-Based Hospital Suggestions:**
     - As the user location is provided (Surat), suggest the best hospitals around Surat.
     - Ensure the hospital names, addresses, and contact details are realistic but also emphasize the disclaimer that location information is simulated.
          
  4. **Error Handling:**
     - If the simulation encounters any errors, set "message" to "An error occurred. Please try again later."
     
  **App Crash Prevention:**
     - **Avoid excessive data:** Limit the simulated data returned (e.g., to 3-5 diseases)
     - **Error handling:** Implement proper error handling in your app

  **Please note that this is a simulated process and does not provide a medical diagnosis.**
  ''';
  }

  String generateUserQuestionPrompt(String userQuestion) {
    return '''
  **Input:** User asks a question: "$userQuestion"

  **Output:** JSON object with the following structure:
  {
    "user": "ai",
    "message": ""  // Filled with the response message
  }

  **Processing:**
  1. **Check Question Category:**
     - Determine if the user's question is health-related.
     - If the question is not health-related, set "message" to "I'm here to assist with health-related queries. For other questions, please seek an appropriate resource." and return the JSON.
  2. **Health-Related Questions:**
     - If the question is health-related, process the question to provide a helpful response.
     - The response should be based on general health knowledge and should always emphasize the importance of consulting a professional for medical concerns.
     - Set "message" to the appropriate health-related response.
  3. **Error Handling:**
     - If an error occurs during processing, set "message" to "An error occurred. Please try again later."

  **Response Example for Health-Related Question:**
  {
    "user": "ai",
    "message": "For a fever, it is important to stay hydrated and rest. If the fever persists, please consult a doctor."
  }

  **Response Example for Non-Health-Related Question:**
  {
    "user": "ai",
    "message": "I'm here to assist with health-related queries. For other questions, please seek an appropriate resource."
  }
  ''';
  }

  String exercisePrompt() {
    return '''Suggest a yoga exercise and return it in the following JSON format:

{
  "message": "",
  "data": {
    "exercise_name": "",
    "duration": "",
    "difficulty_level": "",
    "steps": ["step description 1", "step description 2", "step description 3", ...],
    "benefit": ["benefit 1", "benefit 2", "benefit 3", ...]
  }
}

Please ensure the following:
- "exercise_name" is a non-empty string.
- "duration" is a non-empty string indicating the time required to perform the exercise.
- "difficulty_level" is a non-empty string indicating the difficulty level (e.g., beginner, intermediate, advanced).
- "steps" is a non-empty array of strings, each representing a step in the exercise process, clearly explained and easy to follow.
- "benefit" is a non-empty array of strings, each representing a health benefit of the exercise.

If any validation fails or an error occurs, return the following JSON format:

{
  "message": "An error occurred while generating the exercise.",
  "data": {}
}
''';
  }

  String recipePrompt() {
    return '''Generate a healthy recipe and return it in the following JSON format:

{
  "message": "",
  "data": {
    "recipe_name": "",
    "cook_time": "",
    "serving_size": "",
    "ingredients": ["ingredient 1", "ingredient 2", "ingredient 3", ...],
    "how_to_cook": ["step description 1", "step description 2", "step description 3", ...],
    "benefit": ["benefit 1", "benefit 2", "benefit 3", ...],
    "nutritional_information": {
      "calories": "",
      "protein": "",
      "fat": "",
      "carbohydrates": "",
"sugar" : ""
    },
    "dietary_tags": ["tag 1", "tag 2", ...]
  }
}

Please ensure the following:
- "recipe_name" is a non-empty string.
- "cook_time" is a non-empty string indicating the time required to cook.
- "serving_size" is a non-empty string indicating the number of servings.
- "ingredients" is a non-empty array of strings, each representing an ingredient.
- "how_to_cook" is a non-empty array of strings, each representing a step in the cooking process, clearly explained and easy to follow.
- "benefit" is a non-empty array of strings, each representing a health benefit of the recipe.
- "nutritional_information" includes non-empty strings for calories, protein, fat,  carbohydrates and sugar.
- "dietary_tags" is a non-empty array of strings representing dietary attributes.

If any validation fails or an error occurs, return the following JSON format:

{
  "message": "An error occurred while generating the recipe.",
  "data": {}
}
''';
  }
}
