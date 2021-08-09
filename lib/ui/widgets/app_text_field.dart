import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:said_store/utils/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String label;
  final Widget? prefix;
  final Widget? suffix;
  final TextAlign textAlign;
  final bool isPassword;
  final String? errorMsg;
  final TextInputType textInputType;


  AppTextField({
    required this.controller,
    required this.label,
    this.prefix,
    this.suffix,
    this.textAlign = TextAlign.start,
    this.isPassword = false,
    this.errorMsg,
    this.textInputType = TextInputType.text
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      textAlign: textAlign,
      obscureText: isPassword,
      keyboardType: textInputType,
      decoration: InputDecoration(
        errorText: errorMsg,
        fillColor: Colors.white,
        filled: true,
        suffixIcon: suffix,
        labelText: label,
        contentPadding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 15.h),
        enabledBorder: createBorder(color: Colors.grey.shade300),
        border: createBorder(color: AppColors.PRIMARY_COLOR),
        focusedBorder: createBorder(color: AppColors.PRIMARY_COLOR),
        errorBorder: createBorder(color: Colors.red),
        focusedErrorBorder: createBorder(color: Colors.red),
        prefixIcon: getPrefixIcon(),
        labelStyle: TextStyle(
          fontFamily: 'sf',
          fontWeight: FontWeight.normal,
          color: Color(0xFFBFC3DB),
          fontSize: 14.sp,
        ),
      ),
      style: TextStyle(
        fontFamily: 'sf',
        fontWeight: FontWeight.normal,
        color: AppColors.PRIMARY_TEXT_COLOR,
        fontSize: 16.sp,
      ),
    );
  }

  OutlineInputBorder createBorder({required Color color}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(25.h),
      borderSide: BorderSide(color: color, width: 1.5.w),
    );
  }

  dynamic getPrefixIcon() {
    return prefix != null
        ? Padding(
            padding: EdgeInsetsDirectional.only(
              start: 15,
              top: 13,
            ),
            child: prefix,
          )
        : null;
  }
}
