
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:said_store/model/sub_category.dart';
import 'package:said_store/utils/app_colors.dart';

import 'app_text_widget.dart';

class SubCategoryWidget extends StatelessWidget {
  final SubCategory subCategory;
  final void Function() onTap;

  SubCategoryWidget({required this.subCategory, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(8),
              child: CachedNetworkImage(
                height: 172,
                width: double.infinity,
                imageUrl: subCategory.imageUrl,
                placeholder: (context, url) => Center(
                  child: CircularProgressIndicator(
                    color: AppColors.PRIMARY_COLOR,
                  ),
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            AppTextWidget(
              content: subCategory.nameEn,
              fontSize: 15,
              color: AppColors.PRIMARY_TEXT_COLOR,
              fontWeight: FontWeight.w600,
            ),

          ],
        ),
      ),
    );
  }
}
