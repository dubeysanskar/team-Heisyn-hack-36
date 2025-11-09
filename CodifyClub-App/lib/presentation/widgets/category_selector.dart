import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Core/Constants/colors.dart';
import '../../core/constants/fonts.dart';

class CategorySelectorWidget extends StatelessWidget {
  final List<String> categories;
  final int selectedCategory;
  final Function(int) onCategorySelected;

  const CategorySelectorWidget({
    Key? key,
    required this.categories,
    required this.selectedCategory,
    required this.onCategorySelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
      height: 70.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          bool isSelected = selectedCategory == index;
          return InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () => onCategorySelected(index),
            child: Container(
              margin: EdgeInsets.all(10.r),
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.policeBlue : AppColors.white,
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(color: AppColors.policeBlue, width: 1),
              ),
              child: Center(
                child: Text(
                  categories[index],
                  style: isSelected
                      ? TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.white.withOpacity(0.9),
                  )
                      : AppFonts().normalTitleStyle1,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
