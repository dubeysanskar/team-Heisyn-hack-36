import 'package:codifyclub/presentation/screens/Interview%20AI/interview_questions_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../Core/Constants/colors.dart';
import '../../../core/constants/fonts.dart';
import '../../widgets/custom_buttom.dart';

class InterviewScreen extends StatelessWidget {
  final jobRole;
  final jobDescription;
  final experience;
  const InterviewScreen({super.key,this.jobRole,this.jobDescription,this.experience});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      // appBar: AppBar(automaticallyImplyLeading: false,),
      body: Padding(
        padding: EdgeInsets.all(15.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30.h),
            Text(
              "Let's Get Started",
              style: AppFonts().titleStyle,
            ),
            SizedBox(height: 20.h),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Job Role/Job Position: ",
                    style: AppFonts().normalTitleStyle,
                  ),
                  TextSpan(
                      text: jobRole,
                      style: AppFonts().normalTitleStyle1),
                ],
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Job Description/Tech Stack: ",
                    style: AppFonts().normalTitleStyle,
                  ),
                  TextSpan(
                      text:jobDescription,
                      style: AppFonts().normalTitleStyle1),
                ],
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Years of Experience: ",
                    style: AppFonts().normalTitleStyle,
                  ),
                  TextSpan(text: experience, style: AppFonts().normalTitleStyle1),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20.h, bottom: 20.h),
              padding: EdgeInsets.all(20.r),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.yellow.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(15.r),
                  border: Border.all(color: Colors.orangeAccent)),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.lightbulb_outlined,
                        color: Colors.orangeAccent,
                        size: 25.sp,
                      ),
                      Text(
                        '  Information',
                        style: TextStyle(
                            color: Colors.orangeAccent,
                            fontSize: 25.sp,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    "Enable Video Web Cam and Microphone to Start your AI Generated Mock Interview, It Has 5 question which you can answer and at the last you will get the report on the basis of your answer. NOTE: We never record your video , Web cam access you can disable at any time if you want",
                    style:
                        TextStyle(fontSize: 20.sp, color: Colors.orangeAccent),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30.h,
            ),
            Align(
              alignment: Alignment.center,
              child: CustomButton(
                text: 'Start Interview',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => InterviewQuestionsScreen()));
                },
                height: 60.h,
                width: 200.w,
                font_and_icon_size: 22.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
