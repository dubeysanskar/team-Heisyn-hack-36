import 'dart:convert';
import 'package:google_generative_ai/google_generative_ai.dart';
import '../../data/models/AiInterviewModel.dart';
import '../constants/api_keys.dart';

class AiInterviewService {
  int counter=0;
  Future<List<AiInterviewModel>?> gemnicode(
      String position, String description, String experience) async {
    final apiKey = geminiApiKey; // Replace with your actual API key

    try {
      // Create a generative model with the hardcoded API key
      final model = GenerativeModel(
        model: 'gemini-2.0-flash',
        apiKey: apiKey,
      );

      final prompt =
          'Job Position: $position ,Job Description: $description, Years of Experience: $experience. Please provide 8 interview questions with answers in JSON format {"question": ,"answer":}.Please Ensure that output must be JSON format and there is no format exception';

      // Request content generation
      final response = await model.generateContent([Content.text(prompt)]);
      print(response.text);
      // Handle the response
      if (response.text != null && response.text!.isNotEmpty) {
        var cleanedResponse =
            response.text!.replaceAll('```', '').replaceFirst('json', '');
        List<dynamic> jsonData = jsonDecode(cleanedResponse);

        return jsonData
            .map((jsonItem) => AiInterviewModel.fromJson(jsonItem))
            .toList();
      } else {
        print('No valid content returned from the API.');
      }
    }on FormatException{
      if(counter==15){
        return null;
      }
        counter++;
        print('Format Exception $counter');
        return gemnicode(position, description, experience);
    }
    catch (e) {
      print('Error generating content: $e');
    }

    return null; // Return null if no valid content or an error occurs
  }

  Future<Map<String, String>?> getFeedback(String question, String answer) async {

    print('service called');

    final apiKey = geminiApiKey; // Replace with your actual API key

    try {
      // Instantiate the generative model
      final model = GenerativeModel(
        model: 'gemini-1.5-flash',
        apiKey: apiKey,
      );

      // Prepare the prompt for generating feedback
      final feedbackPrompt =
          'Question: $question , user answer: $answer. Based on this, provide a rating (1-10) and a 3-5 line improvement suggestion. Return a JSON with fields: "rating" and "feedback and give rating as string".';

      // Request the feedback
      final feedbackResponse =
      await model.generateContent([Content.text(feedbackPrompt)]);

      // Handle the response
      if (feedbackResponse.text != null && feedbackResponse.text!.isNotEmpty) {
        var cleanedFeedback = feedbackResponse.text!
            .replaceAll('```', '')
            .replaceFirst('json', '');

        // Parse the response into a Map
        Map<String, dynamic> feedbackData = jsonDecode(cleanedFeedback);

        // Return the rating and feedback
        return {
          'rating': feedbackData['rating'],
          'feedback': feedbackData['feedback'] as String,
        };
      } else {
        print('No feedback returned from the API.');
      }
    }on FormatException{
      if(counter==15){

        return null;
      }
      counter++;
      print('Format Exception at feedback');
      getFeedback(question, answer);
    }
    catch (e) {
      print('Error generating feedback: $e');
    }

    return null; // Return null if no feedback or an error occurs
  }
}
