import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:said_store/utils/app_colors.dart';

class OnBoardingIndicator extends StatelessWidget {
  final bool isSelected;
  OnBoardingIndicator({this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      height: 10.h,
      width: 10.h,
      decoration: BoxDecoration(
        color: isSelected ? AppColors.PRIMARY_COLOR : Colors.grey.shade300,
        shape: BoxShape.circle,
      ),
    );
  }
}
