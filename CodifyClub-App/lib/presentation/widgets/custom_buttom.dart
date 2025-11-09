import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Core/Constants/colors.dart';

class CustomButton extends StatelessWidget {
  final double height;
  final double width;
  final double font_and_icon_size;
  final String text;
  final IconData? icon;
  final Image? image;
  final VoidCallback onTap;
  final bool isEnabled;
  final bool borderOnly;

  const CustomButton(
      {super.key,
      this.font_and_icon_size = 18,
      this.height = 50,
      this.width = 140,
      required this.text,
      this.icon,
      this.image,
      required this.onTap,
      this.isEnabled = true,
      this.borderOnly = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Container(
        height: height.h,
        width: width.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: borderOnly
              ? Border.all(
                  color: AppColors
                      .policeBlue) // Enable border only when borderOnly is true
              : null,
          gradient: borderOnly
              ? null
              : LinearGradient(
                  colors: const [AppColors.policeBlue, AppColors.seaBlue],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (image != null) image!,
            if (icon != null)
              Icon(
                icon,
                color: borderOnly
                    ? AppColors
                        .policeBlue // Change color to policeBlue when borderOnly is true
                    : AppColors.white, // Otherwise, keep it white
                size: font_and_icon_size.sp,
              ),
            if (icon != null || image != null) SizedBox(width: 8.w),
            Text(
              text,
              style: TextStyle(
                color: borderOnly
                    ? AppColors
                        .policeBlue // Change text color to policeBlue when borderOnly is true
                    : AppColors.white, // Otherwise, keep it white
                fontWeight: FontWeight.w600,
                fontSize: font_and_icon_size.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
