import 'package:codifyclub/Core/Constants/colors.dart';
import 'package:codifyclub/Presentation/Screens/signup_screen.dart';
import 'package:codifyclub/blocs/aiInterview/interviewBloc.dart';
import 'package:codifyclub/core/services/ai_interview_service.dart';
import 'package:codifyclub/presentation/screens/Algo%20Visualizer/RBT.dart';
import 'package:codifyclub/presentation/screens/HomePage/homepagescreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => InterviewBloc(AiInterviewService()),
        child: ScreenUtilInit(
          designSize: const Size(412, 915),
          splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            theme: ThemeData(
              primaryColor: AppColors.seaBlue,
              iconButtonTheme: IconButtonThemeData(
                style: ButtonStyle(
                  iconColor: WidgetStatePropertyAll(AppColors.seaBlue),
                ),
              ),
            ),
            debugShowCheckedModeBanner: false,
            // home: SignupScreen(),
            home: Homepagescreen(),
          );
        },
      ),
    );
  }
}
