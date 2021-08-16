import 'package:flutter/material.dart';
import 'package:said_store/local_storge/shared_preferences/preferences.dart';
import 'package:said_store/model/city.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/app_text_widget.dart';

class CityWidget extends StatelessWidget {
  final City city;
  final void Function() onTap;

  CityWidget({required this.city, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Row(
          children: [
            Container(
              width: 50.w,
              height: 50.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(10.h),
              ),
              child: Icon(
                Icons.location_on,
                color: Colors.red,
                size: 30.h,
              ),
            ),
            SizedBox(width: 15.w),
            AppTextWidget(
              content: SharedPreferencesController().languageCode == 'ar'
                  ? city.nameAr
                  : city.nameEn,
            ),
          ],
        ),
      ),
    );
  }
}
