class PromptHelper {

  String generatePromptWithSymptoms(String symptoms) {
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
     - If symptoms are provided but not match with any diseases then set "message" to "No any diseases match with your symptoms. Kindly visit your near hospital" and return the JSON.
  2. **Disease Suggestion Simulation (Example):**
     - **Simulate** a lookup process for potential diseases based on the symptoms.
     - medicine_for_disease only medicine name
     - if user provide location then find best hospital around his location
     - For each potential disease:
       - Create an object with the following properties (replace placeholders with simulated values):
         - "prediction_percentage": A random percentage
         - "disease_name": "Disease Name"
         - "disease_symptoms": ["Symptom 1", "Symptom 2", ...]
         - "disease_reason": ["Reason 1", "Reason 2", ...]
         - "medicine_for_disease": ["medicine name 1","medicine name 2", ...]  // Emphasize disclaimer
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

}