import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:said_store/utils/app_colors.dart';

import 'app_text_widget.dart';

class AppElevatedButton extends StatelessWidget {
  final String text;
  final Color textColor;
  final Color buttonColor;
  final FontWeight fontWeight;
  final double fontSize;
  final String fontFamily;
  final TextAlign textAlign;
  final void Function() onPressed;

  AppElevatedButton(
      {required this.text,
      this.textColor = Colors.white,
      this.fontFamily = 'sf',
      this.fontWeight = FontWeight.bold,
      this.fontSize = 16,
      this.textAlign = TextAlign.start,
      this.buttonColor = AppColors.PRIMARY_COLOR,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: AppTextWidget(
        content: text,
        fontFamily: fontFamily,
        color: textColor,
        fontWeight: fontWeight,
        fontSize: fontSize,
      ),
      style: ElevatedButton.styleFrom(
        minimumSize: Size(double.infinity, 50.h),
        primary: buttonColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
           25.h,
          ),
        ),
      ),
      onPressed: onPressed,
    );
  }
}
