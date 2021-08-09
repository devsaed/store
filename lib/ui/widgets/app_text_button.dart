
import 'package:flutter/material.dart';

import 'app_text_widget.dart';

class AppTextButton extends StatelessWidget {
  final String text;
  final Color textColor;
  final Color buttonColor;
  final FontWeight fontWeight;
  final double fontSize;
  final String fontFamily;
  final TextAlign textAlign;
  final void Function() onPressed;

  AppTextButton(
      {required this.text,
        this.textColor = Colors.white,
        this.fontFamily = 'sf',
        this.fontWeight = FontWeight.normal,
        this.fontSize = 15,
        this.textAlign = TextAlign.start,
        this.buttonColor = Colors.white,
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
        primary: buttonColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      onPressed: onPressed

    );
  }
}
