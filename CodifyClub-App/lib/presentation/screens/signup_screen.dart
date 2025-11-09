import 'dart:convert';
import 'dart:io';
import 'package:codifyclub/presentation/screens/Algo%20Visualizer/MerMaidDiagram.dart';
import 'package:codifyclub/presentation/screens/Algo%20Visualizer/SortingVisualizer3D.dart';
import 'package:codifyclub/presentation/screens/Resume%20AI/resume_suggestion_screen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:codifyclub/Core/Constants/colors.dart';
import 'package:codifyclub/core/constants/fonts.dart';
import 'package:codifyclub/data/models/AiInterviewModel.dart';
import 'package:codifyclub/main.dart';
import 'package:codifyclub/presentation/screens/Interview%20AI/interviewform.dart';
import 'package:codifyclub/presentation/screens/code_editor.dart';
import 'package:codifyclub/presentation/widgets/custom_buttom.dart';
import 'package:codifyclub/presentation/widgets/custom_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:codifyclub/core/constants/api_keys.dart';
import 'package:permission_handler/permission_handler.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Future<void> requestPermissions() async {
  //   // Requesting permission for reading storage
  //   //PermissionStatus status = await Permission.storage.request();
  //   PermissionStatus status = await Permission.manageExternalStorage.request();
  //
  //   if (status.isGranted) {
  //     print("Permission granted");
  //   } else if (status.isDenied) {
  //     print("Permission denied");
  //   } else if (status.isPermanentlyDenied) {
  //     // Show user a dialog or navigate to settings to enable permission
  //     print("Permission permanently denied");
  //   }
  // }

  //

  Future<void> requestPermissions() async {
    PermissionStatus status = await Permission.storage.request();
    if (status.isGranted) {
      print('Permission granted');
    } else if (status.isDenied) {
      print('Permission denied');
    }
  }

  Future<String?> pickFile() async {
    print('in pickfile');
    requestPermissions();
    // Let the user pick a file

    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      // Get the file path
      String? filePath = result.files.single.path;

      if (filePath != null) {
        print('File path: $filePath');
        return filePath; // Return the selected file path
      }
    } else {
      print('User canceled the file selection.');
    }

    return null; // Return null if no file is selected
  }

  Future<void> testcode() async {
    final apiKey = geminiApiKey; // Ensure your API key is set correctly

    // Define the model with configuration
    final model = GenerativeModel(
      model: 'gemini-2.0-flash',
      apiKey: apiKey,
      generationConfig: GenerationConfig(
        temperature: 1,
        responseMimeType: 'text/plain',

      ),
    );

    // Pick the file first
    final filePath = await pickFile();

    // Proceed if a file was selected
    if (filePath == null) {
      print('No file selected. Exiting...');
      return; // Exit if no file was selected
    }

    // Check if the file exists
    final file = File(filePath);
    if (!file.existsSync()) {
      stderr.writeln('File not found: $filePath');
      return; // Exit the function if the file doesn't exist
    }

    // Read file content as bytes
    final fileBytes = await file.readAsBytes();

    // Encode the file as a base64 string
    final base64File = base64Encode(fileBytes);

    // Start chat with file content and text
    final chat = model.startChat(history: [
      Content.multi([
        TextPart('File content (base64 encoded): $base64File'),
         TextPart('Give me its ATS score out of 100% and provide suggestions point by point. Please format it as JSON with the ATS score as a string and suggestions.'),
        // TextPart(
        //     'Please Give me the Name Detials of the resume in JSON formate don\'t give the irrelvent skill some times i uplad other resume'),

      ]),
    ]);

    // Send a message and await response
    // final response = await chat.sendMessage(Content.text('Process the resume for ATS evaluation.'));
    String message = 'Process the resume for ATS evaluation.';
    final response = await chat.sendMessage(Content.text(message));
    print(response.text); // Print the response
  }

//


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.seaBlue,
              AppColors.cream,
              AppColors.pinkRose,
              AppColors.pinkRose,
              AppColors.pinkRose,
              AppColors.pinkRose,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 30.h),
            SizedBox(
              height: 240.h,
              child: Lottie.asset(
                'assets/images/laptoplottie.json',
                controller: _controller,
                onLoaded: (composition) {
                  setState(
                    () {
                      _controller.duration = composition.duration;
                      _controller.repeat();
                    },
                  );
                },
                height: 240.h,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.cream,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40.r),
                    topRight: Radius.circular(40.r),
                  ),
                ),
                padding: EdgeInsets.only(
                    top: 20.h, left: 20.w, right: 20.w, bottom: 10.h),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Sign Up',
                        style: TextStyle(
                          fontSize: 40.sp,
                          color: AppColors.pinkRose,
                          fontFamily: AppFonts.myfonts,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CustomButton(
                            text: 'Facebook',
                            onTap: () {
                              //  Navigator.push(context, MaterialPageRoute(builder: (context)=>Interviewform()));
                              showModalBottomSheet(
                                context: context,
                                builder: (context) => InterviewForm(),
                                isScrollControlled: true,
                                isDismissible: false,
                                enableDrag: true,
                              );
                            },
                            icon: Icons.facebook_outlined,
                            width: 160.w,
                          ),
                          CustomButton(
                            text: 'Google',
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>ResumeSuggestionScreen()));
                            },
                            icon: Icons.alternate_email,
                            width: 160.w,
                          ),
                        ],
                      ),
                      SizedBox(height: 25.h),
                      CustomTextField(
                        labelText: 'Username',
                        keyboardType: TextInputType.text,
                        onSaved: (value) {},
                        prefixIcon: Icons.alternate_email_outlined,
                      ),
                      SizedBox(height: 25.h),
                      CustomTextField(
                        labelText: 'Email',
                        keyboardType: TextInputType.emailAddress,
                        onSaved: (value) {},
                        prefixIcon: Icons.email_outlined,
                      ),
                      SizedBox(height: 25.h),
                      CustomTextField(
                        labelText: 'Password',
                        keyboardType: TextInputType.text,
                        onSaved: (value) {},
                        prefixIcon: Icons.password,
                      ),
                      SizedBox(height: 25.h),
                      CustomTextField(
                        labelText: 'Confirm Password',
                        keyboardType: TextInputType.text,
                        onSaved: (value) {},
                        prefixIcon: Icons.password,
                        suffix: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.visibility),
                        ),
                      ),
                      SizedBox(height: 25.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Already Have Account ? ',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: AppColors.seaBlue,
                              fontFamily: AppFonts.myfonts,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          InkWell(
                            onTap: () {

                             // testcode();

                              Navigator.push(context, MaterialPageRoute(builder: (context)=>SortingVisualizer()));
                            //  Navigator.push(context, MaterialPageRoute(builder: (context)=>MermaidDiagramWebView()));
                            },
                            child: Text(
                              ' Login   ',
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: AppColors.policeBlue,
                                fontFamily: AppFonts.myfonts,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 25.h),
                      CustomButton(
                        text: 'Signup',
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CodeEditor()));
                        },
                        height: 60.h,
                        width: 200.w,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
