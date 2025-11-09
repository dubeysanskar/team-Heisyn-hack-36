import 'package:codifyclub/Core/Constants/colors.dart';
import 'package:codifyclub/core/constants/fonts.dart';
import 'package:codifyclub/presentation/screens/Interview%20AI/interview_screen.dart';
import 'package:codifyclub/presentation/widgets/custom_buttom.dart';
import 'package:codifyclub/presentation/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../blocs/aiInterview/interviewBloc.dart';

class InterviewForm extends StatefulWidget {
  InterviewForm({super.key});

  @override
  _InterviewFormState createState() => _InterviewFormState();
}

class _InterviewFormState extends State<InterviewForm> {
  final TextEditingController c1 = TextEditingController();
  final TextEditingController c2 = TextEditingController();
  final TextEditingController c3 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: EdgeInsets.all(20.r),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.close,
                    color: AppColors.policeBlue,
                    size: 30.sp,
                  ),
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                'Tell Us about Your Job Interviewing',
                style: AppFonts().titleStyle,
              ),
              SizedBox(height: 10.h),
              Text(
                'Add Details about your job position/role, Job description and years of experience',
                style: AppFonts().descriptionStyle,
              ),
              SizedBox(height: 30.h),

              // Custom text fields
              CustomTextField(
                labelText: 'Job Role/Job Position',
                keyboardType: TextInputType.text,
                onSaved: (value) {},
                controller: c1,
                hintText: 'Flutter Developer',
                prefixIcon: Icons.person_outline,
              ),
              SizedBox(height: 30.h),
              CustomTextField(
                labelText: 'Job Description/Tech Stack (in short)',
                keyboardType: TextInputType.text,
                onSaved: (value) {},
                controller: c2,
                hintText: 'Flutter, Firebase, SQLite, Node.js',
                prefixIcon: Icons.list_alt_outlined,
                maxLength: 200,
              ),
              SizedBox(height: 30.h),
              CustomTextField(
                labelText: 'Years of Experience',
                keyboardType: TextInputType.number,
                onSaved: (value) {},
                hintText: '3',
                controller: c3,
                prefixIcon: Icons.access_time_outlined,
                maxlines: 3,
              ),
              SizedBox(height: 30.h),

              // Custom button
              CustomButton(
                text: 'Start Interview',
                onTap: () {
                  Navigator.pop(context);
                  context.read<InterviewBloc>().add(FetchInterviewQuestions(
                      c1.text, c2.text, c3.text.toString()
                  ));
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => InterviewScreen(jobRole: c1.text,jobDescription: c2.text,experience: c3.text.toString(),)));
                },
                height: 60.h,
                width: 200.w,
                font_and_icon_size: 22.sp,
              ),
              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }
}
