
import 'package:codifyclub/Core/Constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/helpers/code_editor_helper.dart';

class CodeToolbar extends StatelessWidget {
  final CodeController controller;

  CodeToolbar({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.shade800, Colors.blue.shade600],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      height: 60.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _buildToolbarButton('TAB', () => insertTextAtCursor(controller, '\t')),
          SizedBox(width: 5.w),
          _buildToolbarButton('{}', () => insertTextAtCursor(controller, '{}')),
          SizedBox(width: 5.w),
          _buildToolbarButton('()', () => insertTextAtCursor(controller, '()')),
        ],
      ),
    );
  }

  Widget _buildToolbarButton(String label, VoidCallback onPressed) {
    return SizedBox(
      width: 100.w,
      height: 60.h,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: AppColors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Text(label, style: TextStyle(color: AppColors.black, fontSize: 16)),
      ),
    );
  }
}
