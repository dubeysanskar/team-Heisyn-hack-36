import 'dart:async';
import 'package:codifyclub/Core/Constants/colors.dart';
import 'package:codifyclub/blocs/aiInterview/interviewBloc.dart';
import 'package:codifyclub/core/constants/fonts.dart';
import 'package:codifyclub/data/models/AiInterviewModel.dart';
import 'package:codifyclub/presentation/screens/Interview%20AI/interview_result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:permission_handler/permission_handler.dart';
import '../../widgets/custom_buttom.dart';

class InterviewQuestionsScreen extends StatefulWidget {
  const InterviewQuestionsScreen({super.key});

  @override
  State<InterviewQuestionsScreen> createState() => _InterviewQuestionsScreenState();
}

class _InterviewQuestionsScreenState extends State<InterviewQuestionsScreen> {
  int selectedIndex = 0;
  bool isRecording = false;
  String recordedAnswer = "";
  stt.SpeechToText _speech = stt.SpeechToText();
  List<String> answers = List.filled(8, 'None'); // Initialize list with 8 null values
  Timer? _inactivityTimer;
  final FlutterTts _flutterTts = FlutterTts();
  String question = "";
  bool isSpeaking = false; // Manage speaking state

  // Method to speak text
  _speak(String text) async {
    if (isSpeaking) {
     // await _flutterTts.stop(); // Stop speaking if already speaking
      await _flutterTts.stop();
      print('stop speeking');
      setState(() {
        isSpeaking = false; // Update speaking state
      });
      return;
    }
    await _flutterTts.setLanguage("en-US");
    await _flutterTts.setPitch(1.0); // Set pitch for better clarity
    await _flutterTts.speak(text);
    setState(() {
      isSpeaking = true; // Update speaking state
    });

    // Listen for completion
    _flutterTts.setCompletionHandler(() {
      setState(() {
        isSpeaking = false; // Update speaking state when done
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _initializeSpeechRecognition();
  }

  Future<void> _initializeSpeechRecognition() async {
    bool available = await _speech.initialize();
    if (!available) {
      print("Speech recognition not available.");
    }
  }

  void requestMicrophonePermission() async {
    var status = await Permission.microphone.request();
    if (status.isGranted) {
      print("Microphone permission granted");
    } else {
      print("Microphone permission denied");
    }
  }

  void _toggleRecording() async {
    if (isRecording) {
      await _stopRecording();
    } else {
      await _startRecording();
    }
  }

  Future<void> _startRecording() async {
    var status = await Permission.microphone.request();
    if (status.isGranted) {
      if (!_speech.isAvailable) {
        bool available = await _speech.initialize();
        if (!available) {
          print("Speech recognition not available.");
          return;
        }
      }

      setState(() {
        isRecording = true;
      });

      _speech.listen(onResult: (result) {
        setState(() {
          recordedAnswer = result.recognizedWords;
        });
        _resetInactivityTimer();
      });
    } else {
      print("Microphone permission denied");
    }
  }

  Future<void> _stopRecording() async {
    setState(() {
      isRecording = false;
    });
    await _speech.stop();
    print(recordedAnswer);
    _storeAnswer();
  }

  void _resetInactivityTimer() {
    _inactivityTimer?.cancel();
    _inactivityTimer = Timer(Duration(seconds: 3), () {
      if (isRecording) {
        _stopRecording(); // Stop recording due to inactivity
        print("Recording stopped due to inactivity");
      }
    });
  }

  void _storeAnswer() {
    if (recordedAnswer.isNotEmpty) {
      answers[selectedIndex] = recordedAnswer; // Store at the current index
      recordedAnswer = "";
    }
  }

  void nextQuestion() {
    setState(() {
      if (selectedIndex < 7) {
        selectedIndex++;
      } else {
        selectedIndex = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(15.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              Text('Questions', style: AppFonts().titleStyle),
              SizedBox(height: 30.h),
              Wrap(
                spacing: 18.w,
                runSpacing: 10.h,
                children: List.generate(
                  8,
                      (index) => CircleAvatar(
                    backgroundColor: (index == selectedIndex)
                        ? AppColors.policeBlue
                        : AppColors.grey.withOpacity(0.4),
                    radius: 30.r,
                    child: Text(
                      'Q${index + 1}',
                      style: TextStyle(
                        color: (index == selectedIndex)
                            ? AppColors.white
                            : AppColors.policeBlue,
                        fontSize: 25.sp,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 30.h, bottom: 20.h),
                width: double.infinity,
                padding: EdgeInsets.all(15.r),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(15.r),
                  border: Border.all(
                      color: AppColors.grey.withOpacity(0.7), width: 1.5),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BlocBuilder<InterviewBloc, InterviewState>(
                      builder: (context, state) {
                        if (state is InterviewLoaded) {
                          question = state.questionAnswerPairs[selectedIndex].getQuestion();
                          return Text(
                            state.questionAnswerPairs[selectedIndex].getQuestion(),
                            style: AppFonts().normalTitleStyle,
                          );
                        } else if (state is InterviewError) {
                          return Center(child: Text(state.errorMessage));
                        } else {
                          return Center(child: CircularProgressIndicator(color: AppColors.policeBlue));
                        }
                      },
                    ),
                    SizedBox(height: 10.h),
                    IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        _speak(question);
                      },
                      icon: Icon(
                        (isSpeaking)?Icons.volume_off_outlined :Icons.volume_up_outlined,
                        size: 30.sp,
                        color: AppColors.policeBlue,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(
                  top: 10.h,
                  bottom: 30.h,
                  left: MediaQuery.of(context).size.width / 5,
                  right: MediaQuery.of(context).size.width / 5,
                ),
                height: MediaQuery.of(context).size.width / 2,
                padding: EdgeInsets.all(15.r),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(
                    color: AppColors.grey.withOpacity(0.7),
                    width: 1.5,
                  ),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      'https://media.istockphoto.com/id/1963246662/photo/young-beautiful-latin-american-woman-with-headset-phone-talking-on-video-call-using-laptop.jpg?s=612x612&w=0&k=20&c=DjVJvMiC7W2K54V40U2OT-5ZGugvTgNpmfCdrTve35g=',
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: CustomButton(
                  text: isRecording ? 'Stop Recording' : 'Record Answer',
                  onTap: _toggleRecording,
                  borderOnly: true,
                  icon: isRecording ? Icons.mic_off : Icons.mic_outlined,
                  width: 180,
                ),
              ),
              SizedBox(height: 30.h),
              Row(
                children: [
                  (selectedIndex == 0)
                      ? SizedBox()
                      : CustomButton(
                    text: 'Prv Question',
                    onTap: () {
                      setState(() {
                        selectedIndex--;
                      });
                    },
                    height: 60.h,
                    width: 160.w,
                    font_and_icon_size: 20.sp,
                  ),
                  Spacer(),
                  CustomButton(
                    text: (selectedIndex < 7) ? 'Next Question' : 'End Interview',
                    onTap: () {
                      setState(() {
                        if (selectedIndex == 7) {
                          _storeAnswer();
                          context.read<InterviewBloc>().add(FetchInterviewFeedback(answers));
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => InterviewResult(),
                            ),
                          );
                        } else {
                          nextQuestion();
                        }
                      });
                    },
                    height: 60.h,
                    width: 160.w,
                    font_and_icon_size: 20.sp,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
