
import 'package:flutter/material.dart';
import 'package:said_store/model/city.dart';
import 'package:said_store/shared_preferences/preferences.dart';

import 'app_text_widget.dart';

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
              width: 50,
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.lightBlueAccent,
                  borderRadius: BorderRadius.circular(10)),
              child: AppTextWidget(
                content : SharedPreferencesController().languageCode == 'ar' ? city.nameAr[0]: city.nameEn[0],
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 15),
            Text(SharedPreferencesController().languageCode == 'ar' ? city.nameAr: city.nameEn),
          ],
        ),
      ),
    );
  }
}
