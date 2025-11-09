import 'dart:convert';
import 'dart:io';

import 'package:codifyclub/presentation/widgets/custom_text_field.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../Core/Constants/colors.dart';
import '../../../core/constants/api_keys.dart';
import '../../../core/constants/fonts.dart';
import '../../../data/models/AiResumeATSModel.dart';

class ResumeSuggestionScreen extends StatefulWidget {
  const ResumeSuggestionScreen({super.key});

  @override
  State<ResumeSuggestionScreen> createState() => _ResumeSuggestionScreenState();
}

class _ResumeSuggestionScreenState extends State<ResumeSuggestionScreen> {
  AiResumeAtsModel? atsModel;
  bool isLoading = false;
  String errorMessage = '';

  // Request file access permission
  Future<void> requestPermissions() async {
    if (await Permission.storage.request().isGranted) {
      // Permission granted
      print('Storage permission granted');
    } else {
      // Permission denied
      setState(() {
        errorMessage = 'Storage permission is required to upload a resume.';
      });
    }
  }

  // File picker to choose a resume file
  Future<String?> pickFile() async {
    await requestPermissions();
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      return result.files.single.path;
    } else {
      return null; // User canceled the picker
    }
  }

  // Process resume file and get ATS score & suggestions from AI
  Future<void> processResume() async {
    setState(() {
      isLoading = true;
      errorMessage = '';
      atsModel = null;
    });

    final filePath = await pickFile();
    if (filePath == null) {
      setState(() {
        isLoading = false;
        errorMessage = 'No file selected.';
      });
      return;
    }

    final file = File(filePath);
    if (!file.existsSync()) {
      setState(() {
        isLoading = false;
        errorMessage = 'File not found.';
      });
      return;
    }

    //   String base64File = '';
    final fileBytes = await file.readAsBytes();
    // base64File = base64Encode(fileBytes);

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

      final data = model
          .startChat(history: [Content.data('application/pdf', fileBytes)]);

      // Create and send the prompt for a single resume analysis

      // File content (base64 encoded): $base64File
      final prompt = """

The above chat have resume pdf file
Give me its ATS score out of 100% (give genuine if not related to provided role then give around 30-40) and provide suggestions point by point based on ${jobRole.text} Role. 
suggest me all the below things like industry level projects(do nto give the project of the file give new project ideas),job recommendation(related to the resume skills),so on in the JSON format
Please format the output as follows:
{ "short_detial_about_resume":"summery with name and skills and personal information"
  "ats_score": "score%", 
  "suggestions": [
    {"title": "title", "suggestion": "suggestion"}, 
    {"title": "title", "suggestion": "suggestion"}
  ], 
  "missing_keywords": ["keyword1", "keyword2"], 
  "missing_social_media": ["social1", "social2"], 
  "industry_level_projects": ["project1", "project2"], 
  "courses": [{"course": "course1", "platform": "platform1"}, {"course": "course2", "platform": "platform2"}],
  "recommended_jobs": ["job1", "job2"]
}
Make sure that the output is only in the above format with no exceptions.
""";

      final response = await data.sendMessage(Content.text(prompt));

      // Clean up response for JSON parsing
      var cleanedResponse = response.text?.replaceAll('```', '').trim() ?? '';
      cleanedResponse = cleanedResponse.replaceAll('json', '');

      print(cleanedResponse);
      final responseJson = jsonDecode(cleanedResponse);

      if (responseJson is Map<String, dynamic>) {
        setState(() {
          atsModel = AiResumeAtsModel.fromJson(responseJson);
          isLoading = false;
        });
      } else {
        print('Format exception in Resume ATS');
        errorMessage = cleanedResponse;
        throw FormatException('Unexpected JSON format $cleanedResponse');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = 'Error processing the resume: $e';
      });
    }
  }

  final jobRole=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title:
            Text('Resume ATS Suggestions', style: AppFonts().normalTitleStyle),
        backgroundColor: AppColors.policeBlue,
      ),
      body: Padding(
        padding: EdgeInsets.all(15.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20.h),
            Text(
              'ATS Score: ${(atsModel?.atsScore ?? 'N/A')}',
              style: AppFonts().normalTitleStyle.copyWith(fontSize: 20.sp),
            ),
            SizedBox(height: 20.h),
            isLoading
                ? CircularProgressIndicator() // Show loading indicator
                : atsModel != null
                    ? Expanded(
                        child: ListView(
                          children: [
                            buildSuggestionsSection(
                                'Suggestions', atsModel!.suggestions ?? []),
                            buildJobsSection('Missing Keywords',
                                atsModel!.missingKeywords ?? []),
                            buildJobsSection('Missing Social Media',
                                atsModel!.missingSocialMedia ?? []),
                            buildJobsSection('Industry-Level Projects',
                                atsModel!.industryLevelProjects ?? []),
                            buildCoursesSection(
                                'Recommended Courses', atsModel!.courses ?? []),
                            buildJobsSection('Other Recommended Jobs',
                                atsModel!.recommendedJobs ?? []),
                          ],
                        ),
                      )
                    : Center(
                        child: Text(
                          errorMessage.isNotEmpty
                              ? errorMessage
                              : 'No resume data available. Please upload a resume.',
                          style: TextStyle(
                            color: errorMessage.isNotEmpty
                                ? Colors.red
                                : Colors.black,
                            fontSize: 16.sp,
                          ),
                        ),
                      ),
            SizedBox(height: 20.h),
            CustomTextField(labelText: 'Job Role', keyboardType: TextInputType.text, onSaved: (value)=>value,controller:jobRole),
            SizedBox(height: 10..h,),
            ElevatedButton(
              onPressed: processResume,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.policeBlue,
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              ),
              child: Text(
                'Upload Resume and Get Suggestions',
                style: TextStyle(fontSize: 18.sp, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSuggestionsSection(String title, List<Suggestions> suggestions) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.policeBlue),
        ),
        SizedBox(height: 10.h),
        ListView.builder(
          itemCount: suggestions.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final suggestion = suggestions[index];
            return Container(
              margin: EdgeInsets.symmetric(vertical: 10.h),
              padding: EdgeInsets.all(15.r),
              decoration: BoxDecoration(
                color: AppColors.seaBlue.withOpacity(0.4),
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(color: AppColors.policeBlue),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    suggestion.title ?? 'No title',
                    style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.policeBlue),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    suggestion.suggestion ?? 'No suggestion available',
                    style:
                        TextStyle(fontSize: 16.sp, color: AppColors.policeBlue),
                  ),
                ],
              ),
            );
          },
        ),
        SizedBox(height: 20.h),
      ],
    );
  }

  Widget buildCoursesSection(String title, List<Courses> courses) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.policeBlue),
        ),
        SizedBox(height: 10.h),
        ListView.builder(
          itemCount: courses.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final course = courses[index];
            return Container(
              margin: EdgeInsets.symmetric(vertical: 10.h),
              padding: EdgeInsets.all(15.r),
              decoration: BoxDecoration(
                color: AppColors.seaBlue.withOpacity(0.4),
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(color: AppColors.policeBlue),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    course.course ?? 'No title',
                    style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.policeBlue),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    course.platform ?? 'No platform available',
                    style:
                        TextStyle(fontSize: 16.sp, color: AppColors.policeBlue),
                  ),
                ],
              ),
            );
          },
        ),
        SizedBox(height: 20.h),
      ],
    );
  }

  Widget buildJobsSection(String title, List<String?> jobs) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.policeBlue),
        ),
        SizedBox(height: 10.h),
        ListView.builder(
          itemCount: jobs.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.symmetric(vertical: 10.h),
              padding: EdgeInsets.all(15.r),
              decoration: BoxDecoration(
                color: AppColors.seaBlue.withOpacity(0.4),
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(color: AppColors.policeBlue),
              ),
              child: Text(
                jobs[index] ?? 'No job available',
                style: TextStyle(fontSize: 16.sp, color: AppColors.policeBlue),
              ),
            );
          },
        ),
        SizedBox(height: 20.h),
      ],
    );
  }
}
