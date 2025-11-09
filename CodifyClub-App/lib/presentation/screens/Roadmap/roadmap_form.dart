import 'package:codifyclub/presentation/screens/Roadmap/roadmap_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../Core/Constants/colors.dart';
import '../../../core/constants/fonts.dart';
import '../../widgets/custom_buttom.dart';
import '../../widgets/custom_text_field.dart';
import '../Interview AI/interview_screen.dart';

class RoadmapForm extends StatelessWidget {
  const RoadmapForm({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController c1 = TextEditingController();
    final TextEditingController c2 = TextEditingController();
    final TextEditingController c3 = TextEditingController();


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
                'Tell Us about Your Learning Goals and Previous Knowledge',
                style: AppFonts().titleStyle,
              ),
              SizedBox(height: 10.h),
              Text(
                'Add Details about your Current Tech Stack/Knowledge, Next Goal ',
                style: AppFonts().descriptionStyle,
              ),
              SizedBox(height: 30.h),

              // Custom text fields
              CustomTextField(
                labelText: 'Current Tech Stack/Knowledge',
                keyboardType: TextInputType.text,
                onSaved: (value) {},
                controller: c1,
                hintText: 'MERN Stack',
                prefixIcon: Icons.person_outline,
              ),
              SizedBox(height: 30.h),
              CustomTextField(
                labelText: 'Next Goal',
                keyboardType: TextInputType.text,
                onSaved: (value) {},
                controller: c2,
                hintText: 'App Development',
                prefixIcon: Icons.list_alt_outlined,
                maxLength: 200,
              ),
              SizedBox(height: 30.h),


              // Custom button
              CustomButton(
                text: 'Get Roadmap',
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>RoadmapPage(c1: c1.text, c2: c2.text)));
                  // Navigator.pop(context);
                  // context.read<InterviewBloc>().add(FetchInterviewQuestions(
                  //     c1.text, c2.text, c3.text.toString()
                  // ));
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => InterviewScreen(jobRole: c1.text,jobDescription: c2.text,experience: c3.text.toString(),)));
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
