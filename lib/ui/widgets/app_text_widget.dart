import 'package:flutter/material.dart';

class AppTextWidget extends StatelessWidget {
  final String content;
  final Color color;
  final FontWeight fontWeight;
  final double fontSize;
  final String fontFamily;
  final TextAlign textAlign;

  AppTextWidget({
    required this.content,
    this.color = Colors.black,
    this.fontFamily = 'sf',
    this.fontWeight = FontWeight.normal,
    this.fontSize = 15,
    this.textAlign = TextAlign.center,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      content,
      textAlign: textAlign,
      style: TextStyle(
        color: color,
        fontWeight: fontWeight,
        fontSize: fontSize,
        fontFamily: fontFamily,
      ),
    );
  }
}
