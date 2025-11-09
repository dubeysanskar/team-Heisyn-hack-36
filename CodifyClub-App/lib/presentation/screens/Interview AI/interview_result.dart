import 'package:codifyclub/core/constants/fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../Core/Constants/colors.dart';
import '../../../blocs/aiInterview/interviewBloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InterviewResult extends StatelessWidget {
  const InterviewResult({super.key});

  // Reusable method for rendering the content of each section (Question, Answer, Feedback)
  Widget buildSection({
    required String title,
    required String content,
    required Color borderColor,
    required Color backgroundColor,
    required Color textColor,
    required double fontSize,
  }) {
    return Container(
      margin: EdgeInsets.only(top: 10.h, bottom: 10.h),
      padding: EdgeInsets.all(20.r),
      width: double.infinity,
      decoration: BoxDecoration(
        color: backgroundColor.withOpacity(0.4),
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: textColor,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Text(
            content,
            style: TextStyle(fontSize: fontSize.sp, color: textColor),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: BlocBuilder<InterviewBloc, InterviewState>(
        builder: (context, state) {
          if (state is InterviewLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is InterviewLoaded) {
            final interviewData = state.questionAnswerPairs;
            double overallRating = interviewData.fold(
                0.0, (sum, item) => sum + double.parse(item.rating.toString()));
            double calculatedRating = overallRating / interviewData.length;

            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(15.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 30.h,
                    ),
                    Text(
                      'Congratulations!',
                      style: AppFonts().titleStyle,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      'Here is your Interview Feedback ',
                      style: AppFonts().normalTitleStyle,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Your Overall Interview Rating is : ',
                            style: TextStyle(
                              color: AppColors.pinkRose,
                              fontSize: 20.sp,
                            ),
                          ),
                          TextSpan(
                            text:
                                '${calculatedRating.toStringAsFixed(1)}/10', // Display calculated rating
                            style: TextStyle(
                              color: AppColors.pinkRose,
                              fontSize: 20.sp,
                              fontWeight:
                                  FontWeight.bold, // Make this part bold
                            ),
                          ),
                        ],
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: interviewData
                          .length, // Dynamically show the length of data
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return ExpansionTile(
                          subtitle:
                              Text('Rating ${interviewData[index].rating}/10'),
                          title: Text(
                            'Question ${index + 1}',
                            style: AppFonts().normalTitleStyle1,
                          ),
                          children: [
                            buildSection(
                              title: 'Question:',
                              content: interviewData[index]
                                  .getQuestion(), // Use data from the bloc state
                              borderColor: Colors.orange,
                              backgroundColor: Colors.yellow,
                              textColor: Colors.orange,
                              fontSize: 16,
                            ),
                            buildSection(
                              title: 'Your Answer:',
                              content: interviewData[index].userAnswer ??
                                  'No answer provided', // Handle null values
                              borderColor: Colors.redAccent,
                              backgroundColor: Colors.redAccent,
                              textColor: Colors.red,
                              fontSize: 16,
                            ),
                            buildSection(
                              title: 'Feedback:',
                              content: interviewData[index].feedback ??
                                  'No feedback available', // Handle null feedback
                              borderColor: Colors.greenAccent,
                              backgroundColor: Colors.greenAccent,
                              textColor: Colors.green,
                              fontSize: 16,
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          } else if (state is InterviewError) {
            return Center(child: Text('Error: ${state.errorMessage}'));
          } else {
            return Center(child: Text('No interview data available.'));
          }
        },
      ),
    );
  }
}
