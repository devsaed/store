import 'package:flutter/material.dart';

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
        padding: EdgeInsets.symmetric(vertical: 23, horizontal: 20),
        margin: EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            leading,
            SizedBox(width: 15),
            AppTextWidget(
              content: label,
              color: labelColor,
              fontWeight: FontWeight.w500,
              fontSize: 15,
            ),
            Spacer(),
            trailingIcon != null ? Icon(trailingIcon, size: 13, color: Colors.grey,) : Container(),
          ],
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
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
