
import 'package:flutter/material.dart';
import 'package:said_store/model/city.dart';
import 'package:said_store/model/product.dart';
import 'package:said_store/shared_preferences/preferences.dart';

import 'app_text_widget.dart';

class ProductWidget extends StatelessWidget {
  final Product product;
  final void Function() onTap;

  ProductWidget({required this.product, required this.onTap});

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
                content : SharedPreferencesController().languageCode == 'ar' ? product.nameAr[0]: product.nameEn[0],
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 15),
            Text(SharedPreferencesController().languageCode == 'ar' ? product.nameAr: product.nameEn),
          ],
        ),
      ),
    );
  }
}
