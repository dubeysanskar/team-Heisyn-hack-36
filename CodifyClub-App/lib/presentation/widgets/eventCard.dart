import 'package:codifyclub/Core/Constants/colors.dart';
import 'package:codifyclub/presentation/screens/Events/event_view_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:ui';

class EventCard extends StatelessWidget {
  final String day;
  final String month;
  final String eventName;
  final String eventCategory;
  final String time;
  final String imagepath;
  final bool isMini; // Added the `isMini` boolean flag

  const EventCard({
    super.key,
    required this.day,
    required this.month,
    required this.eventName,
    required this.eventCategory,
    required this.time,
    required this.imagepath,
    this.isMini = true, // Set `isMini` to true by default
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: AppColors.transparent,
      highlightColor: AppColors.transparent,
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>EventViewScreen()));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 5.w),
        width: isMini ? 250.w : double.infinity, // Adjust width based on `isMini`
       // height: isMini ? null : 300.h, // Adjust height based on `isMini`
        decoration: BoxDecoration(
          color: AppColors.pinkRose, // Replace with your AppColors
          borderRadius: BorderRadius.circular(25.r),
          image: DecorationImage(
            image: AssetImage(imagepath),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            // Date Section
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 15.h, right: 15.w),
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                  decoration: BoxDecoration(
                    color: Colors.white, // Replace with AppColors.white
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Column(
                    children: [
                      Text(
                        day,
                        style: TextStyle(
                          fontSize: isMini ? 10.sp : 18.sp, // Adjust font size
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        month,
                        style: TextStyle(
                          fontSize: isMini ? 10.sp : 16.sp, // Adjust font size
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: isMini ? 50.h : 100.h), // Adjust space based on `isMini`

            // Event Info Section
            Container(
              width: double.infinity,
              color: AppColors.transparent,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25.r),
                  bottomRight: Radius.circular(25.r),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 30.0, sigmaY: 30.0), // Blur intensity
                  child: Container(
                    padding: EdgeInsets.all(10.r),
                    decoration: BoxDecoration(
                      // color: AppColors.policeBlue.withOpacity(0.2), // Optional overlay
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(25.r),
                        bottomRight: Radius.circular(25.r),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          eventName,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: isMini ? 15.sp : 25.sp, // Adjust font size
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: isMini ? 5.h : 10.h),
                        Row(
                          children: [
                            // Event Category
                            Row(
                              children: [
                                Icon(
                                  Icons.headset_mic_outlined,
                                  color: Colors.white,
                                  size: isMini ? 16.sp : 20.sp, // Adjust icon size
                                ),
                                SizedBox(width: 5.w),
                                Text(
                                  eventCategory,
                                  style: TextStyle(
                                    fontSize: isMini ? 8.sp : 16.sp, // Adjust font size
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            // Time
                            Row(
                              children: [
                                Icon(
                                  Icons.access_time_outlined,
                                  color: Colors.white,
                                  size: isMini ? 16.sp : 20.sp, // Adjust icon size
                                ),
                                SizedBox(width: 5.w),
                                Text(
                                  time,
                                  style: TextStyle(
                                    fontSize: isMini ? 8.sp : 16.sp, // Adjust font size
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: 10.w),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: isMini ? 5.h : 15.h),
                      ],
                    ),
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
