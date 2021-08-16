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
  final int line;

  AppTextField(
      {required this.controller,
      required this.label,
      this.prefix,
      this.suffix,
      this.textAlign = TextAlign.start,
      this.isPassword = false,
      this.errorMsg,
      this.textInputType = TextInputType.text,
      this.line = 1});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18.h),
        color: Colors.white,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0, 3),
            blurRadius: 5,
            spreadRadius: 0,
          )
        ],
      ),
      child: TextField(
        controller: controller,
        textAlign: textAlign,
        obscureText: isPassword,
        keyboardType: textInputType,
        maxLines: line,
        minLines: line,

        decoration: InputDecoration(
          errorText: errorMsg,
          fillColor: Colors.white,
          filled: true,
          suffixIcon: suffix,
          hintText: label,
          contentPadding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 15.h),
          enabledBorder: createBorder(color: Colors.white),
          border: createBorder(color: AppColors.PRIMARY_COLOR),
          focusedBorder: createBorder(color: AppColors.PRIMARY_COLOR),
          errorBorder: createBorder(color: Colors.red),
          focusedErrorBorder: createBorder(color: Colors.red),
          prefixIcon: getPrefixIcon(),
          hintStyle: TextStyle(
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
      ),
    );
  }

  OutlineInputBorder createBorder({required Color color}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(18.h),
      borderSide: BorderSide(color: color, width: 1.5.w),
    );
  }

  dynamic getPrefixIcon() {
    return prefix != null
        ? Padding(
            padding: EdgeInsetsDirectional.only(
              start: 15.w,
              top: 13.h,
            ),
            child: prefix,
          )
        : null;
  }
}
