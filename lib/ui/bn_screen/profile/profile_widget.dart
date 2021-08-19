import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../widgets/app_text_widget.dart';

class ProfileWidget extends StatelessWidget {
  final String label;
  final Icon leading;
  final IconData? trailingIcon;
  final Color labelColor;
  final void Function()? onTap;

  ProfileWidget({
    required this.label,
    required this.leading,
    this.trailingIcon,
    this.onTap,
    this.labelColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () {},
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 23.h, horizontal: 20.w),
        margin: EdgeInsets.symmetric(vertical: 8.h),
        child: Row(
          children: [
            leading,
            SizedBox(width: 15.w),
            AppTextWidget(
              content: label,
              color: labelColor,
              fontWeight: FontWeight.w500,
              fontSize: 15.sp,
            ),
            Spacer(),
            trailingIcon != null ? Icon(trailingIcon, size: 13.h, color: Colors.grey,) : Container(),
          ],
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18.h),
          color: Colors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey,
                offset: Offset(0, 3),
                blurRadius: 7,
                spreadRadius: 0)
          ],
        ),
      ),
    );
  }
}
