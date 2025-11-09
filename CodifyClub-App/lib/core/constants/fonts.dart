import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'colors.dart';

class AppFonts {
  static const String myfonts = 'Poppins'; //change it according to the project.

  final TextStyle titleStyle = TextStyle(
    fontSize: 30.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.policeBlue,
  );

  final TextStyle normalTitleStyle1 = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.policeBlue.withOpacity(0.9),
  );
  final TextStyle normalTitleStyle = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.policeBlue,
  );

  final TextStyle descriptionStyle = TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.policeBlue.withOpacity(0.7),
  );

  setstr(t1, t2, t3) {
    this.t1 = t1;
    this.t2 = t2;
    this.t3 = t3;
  }

  String t1 = 'App Developer';
  String t2 = 'Flutter, Firebase, Node js.';
  String t3 = '1';
}
