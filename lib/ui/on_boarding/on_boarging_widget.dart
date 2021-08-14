import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:said_store/ui/widgets/app_text_widget.dart';

class OnBoardingWidget extends StatelessWidget {

  final String title;
  final String subTitle;
  final String image;


  OnBoardingWidget({required this.title, required this.subTitle,required this.image});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'assets/image/$image.jpg',
          height: 513.h,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        Align(
          alignment: AlignmentDirectional.bottomCenter,
          child: Container(
            padding: EdgeInsets.all(77.h),
            height: 338.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40.h),
                topRight: Radius.circular(40.h),
              ),
            ),
            child: Column(
              children: [
                AppTextWidget(
                  content: title,
                  color: Colors.black,
                  fontSize: 26.sp,
                  fontWeight: FontWeight.w600,
                ),
                SizedBox(height:13.h),
                AppTextWidget(
                  content: subTitle,
                  color: Colors.grey,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.normal,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
