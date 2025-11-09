import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Core/Constants/colors.dart';


class CustomTextField extends StatelessWidget {
  final String hintText;
  final String labelText;
  final TextInputType keyboardType;
  final int? maxLength;
  final bool counterText;
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String>? validator;
  final controller;
  final prefixIcon;
  final suffix;
  final maxlines;

  const CustomTextField({
    super.key,
     this.hintText='',
     this.maxlines=1,
    required this.labelText,
    required this.keyboardType,
    required this.onSaved,
    this.maxLength,
    this.prefixIcon=null,
    this.suffix=null,
    this.counterText = false,
    this.validator,
    this.controller=null
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: maxlines,
      minLines: 1,
      cursorColor: AppColors.black,
      keyboardType: keyboardType,
      maxLength: maxLength,
      decoration: InputDecoration(
        prefixIcon: prefixIcon!=null? Icon(prefixIcon,color: AppColors.policeBlue,):null,
        suffixIcon:suffix,
        suffixIconColor: AppColors.policeBlue,
        hintText: hintText,
        labelStyle: TextStyle(color: AppColors.policeBlue,fontSize: 16.sp),
        labelText: labelText,
        counterText: counterText ? null : '',
        hintStyle: TextStyle(
          //fontFamily: Fonts.inter, // Use your custom font
          fontWeight: FontWeight.w400,
          color: AppColors.policeBlue.withOpacity(0.7),
          fontSize: 14.sp,
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.policeBlue,
            width: 2,
          ),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.seaBlue,
            width: 3,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.policeBlue,
            width: 2,
          ),
        ),
      ),
      onSaved: onSaved,
      validator: validator,
    );
  }
}