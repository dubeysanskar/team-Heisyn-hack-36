import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:url_launcher/url_launcher.dart'; // Import the url_launcher package

import '../../../core/constants/api_keys.dart';
import '../../../data/models/RoadmapMode.dart';

// RoadmapPage widget
class RoadmapPage extends StatefulWidget {
  final String c1;
  final String c2;

  const RoadmapPage({super.key, required this.c1, required this.c2});

  @override
  State<RoadmapPage> createState() => _RoadmapPageState();
}

// State class for RoadmapPage
class _RoadmapPageState extends State<RoadmapPage> {
  bool isLoading = true;
  String errorMessage = '';
  RoadMapModel? resumemodel; // Nullable to handle null safety

  @override
  void initState() {
    super.initState();
    processRoadmap();
  }

  Future<void> processRoadmap() async {
    setState(() {
      isLoading = true;
      errorMessage = ''; // Clear error message on each new attempt
    });

    try {
      // Create a new GenerativeModel instance for each resume
      final apiKey = geminiApiKey;
      final model = GenerativeModel(
        model: 'gemini-2.0-flash',
        apiKey: apiKey,
        generationConfig: GenerationConfig(
          temperature: 1,
        ),
      );

      final prompt = """
I know the ${widget.c1}, and I want to learn cross-platform ${widget.c2}. Give me a proper roadmap as per my given interest in JSON format with tips and tricks, as well as how much of each thing I need to learn, from where, and how much time it will take. Provide this for each step/topic.
Give me the response in JSON format like this:
{
  "topic": "",
  "description": "",
  "steps": [
    {
      "step": "",
      "description": "",
      "resources": [
        {
          "name": "",
          "link": "",
          "time_estimate": ""
        },
        {
          "name": "",
          "link": "",
          "time_estimate": ""
        }
      ]
    }
  ],
  "tips_and_tricks": [
    {
      "tip": "",
      "description": ""
    }
  ]
}. Ensure there are no; syntax errors in the JSON format and do not have any extra content in json and avoid format exception.Please must provide in only in the above format
""";

      final response = await model.generateContent([Content.text(prompt)]);

      // Clean up response for JSON parsing
      var cleanedResponse = response.text?.replaceAll('```', '').trim() ?? '';
      cleanedResponse = cleanedResponse.replaceAll('json', '');

      final responseJson = jsonDecode(cleanedResponse);

      if (responseJson is Map<String, dynamic>) {
        setState(() {
          resumemodel = RoadMapModel.fromJson(responseJson);
          isLoading = false;
        });
      } else {
        setState(() {
          errorMessage = 'Unexpected JSON format: $cleanedResponse';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error processing the roadmap: $e';
        isLoading = false;
      });
    }
  }

  // Function to launch URL
  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Roadmap"),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (resumemodel != null) ...[
                Text(
                  'Topic: ${resumemodel?.topic ?? ''}',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  'Description: ${resumemodel?.description ?? ''}',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Steps:',
                  style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                for (var step in resumemodel?.steps ?? [])
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Step: ${step.step}',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Description: ${step.description}',
                        style: const TextStyle(fontSize: 14),
                      ),
                      const Text(
                        'Resources:',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      for (var resource in step.resources)
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Name: ${resource.name}',
                                style: const TextStyle(fontSize: 14),
                              ),
                              InkWell(
                                child: Text(
                                  'Link: ${resource.link}',
                                  style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.blue,
                                      decoration: TextDecoration.underline),
                                ),
                                onTap: () => _launchURL(resource.link),
                              ),
                              Text(
                                'Time Estimate: ${resource.timeEstimate}',
                                style: const TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                      const SizedBox(height: 10),
                    ],
                  ),
                const SizedBox(height: 20),
                const Text(
                  'Tips and Tricks:',
                  style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                for (var tip in resumemodel?.tipsAndTricks ?? [])
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      'Tip: ${tip.tip}\nDescription: ${tip.description}',
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
              ],
              if (errorMessage.isNotEmpty)
                Text(
                  errorMessage,
                  style: const TextStyle(color: Colors.red),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
