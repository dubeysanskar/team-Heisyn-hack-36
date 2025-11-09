import 'package:codifyclub/Core/Constants/colors.dart';
import 'package:codifyclub/presentation/screens/Courses/cources_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/fonts.dart';

class CourcesMain extends StatelessWidget {
  const CourcesMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: AppColors.white,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              height: 300.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.pinkRose,
                image: DecorationImage(
                  image: AssetImage('assets/images/course/javascript.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  InkWell(
                    splashColor:AppColors.transparent,
                    highlightColor:AppColors.transparent,
                    onTap: (){},
                    child: Container(
                      margin: EdgeInsets.only(bottom: 40.h, right: 20.w),
                      height: 50.h,
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                      decoration: BoxDecoration(
                        color: Colors.white, // Replace with AppColors.white
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Center(
                        child: Text(
                          'Buy Now',
                          style: TextStyle(
                            fontSize: 18.sp, // Adjust font size
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(height: 10.h),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Container(
                  margin: EdgeInsets.all(10.r),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      color: AppColors.policeBlue.withOpacity(0.1)),
                  child: ExpansionTile(
                    leading: Icon(
                      Icons.play_lesson_outlined,
                      color: AppColors.policeBlue,
                    ),
                    subtitle: Text('Chapter name'),
                    title: Text(
                      'Chapter ${index + 1}', // Added index for uniqueness
                      style: AppFonts().normalTitleStyle1,
                    ),
                    children: List.generate(5, (childIndex) {
                      return InkWell(
                        splashColor: AppColors.transparent,
                        highlightColor: AppColors.transparent,
                        onTap: () {
                              //Navigator.push(context, MaterialPageRoute(builder: (context)=>YoutubeVideoPlayer(videoUrl: "https://youtu.be/W6NZfCO5SIk?si=jsgBFnjPwpqcqso1")));
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>YoutubeVideoPlayer(videoUrl: "https://youtu.be/QonGrNho4eA")));
                              print('https://youtu.be/QonGrNho4eA');
                        },
                        child: Container(
                            margin: EdgeInsets.all(10.r),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                                color: AppColors.seaBlue.withOpacity(0.3)),
                            height: 60.r,
                            width: double.infinity,
                            child: ListTile(
                              leading: Icon(
                                (childIndex < 3)
                                    ? Icons.check_box_outlined
                                    : Icons.check_box_outline_blank,
                                color: AppColors.policeBlue,
                              ),
                              title: Text('Topic ${childIndex + 1}'),
                            )),
                      );
                    }),
                  ),
                );
              },
              childCount: 20, // Number of ExpansionTile items
            ),
          ),
        ],
      ),
    );
  }
}
