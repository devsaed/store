import 'package:flutter/material.dart';
import 'package:said_store/ui/widgets/app_text_widget.dart';

class Helper {
  static void showSnackBar(
    BuildContext context, {
    required String text,
    bool error = false,
    String? actionTitle,
    Function()? onPressed,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: AppTextWidget(
          content: text,
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        backgroundColor: error ? Colors.red : Colors.blue,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(20),
        elevation: 5,
        duration: Duration(seconds: 3),
        action: actionTitle != null
            ? SnackBarAction(
                onPressed: onPressed ?? () {},
                label: actionTitle,
                textColor: Colors.yellow,
              )
            : null,
        onVisible: () {
          print('VISIBLE - SNACKBAR');
        },
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.zero,
                bottomRight: Radius.circular(10),
                bottomLeft: Radius.zero)),
        // padding: EdgeInsets.all(15),
      ),
    );
  }
}
