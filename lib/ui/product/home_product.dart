import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:said_store/model/product.dart';
import 'package:said_store/utils/app_colors.dart';

import '../widgets/app_text_widget.dart';

class HomeProductWidget extends StatelessWidget {
  final Product product;
  final void Function() onTap;

  HomeProductWidget({required this.product, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 165,
      child: GestureDetector(
        onTap: onTap,
        child: Card(
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CachedNetworkImage(
                height: 190,
                width: double.infinity,
                imageUrl: product.imageUrl,
                placeholder: (context, url) => Center(
                  child: CircularProgressIndicator(
                    color: AppColors.PRIMARY_COLOR,
                  ),
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
                fit: BoxFit.cover,
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppTextWidget(
                          content: product.nameEn,
                          fontSize: 13,
                          color: AppColors.PRIMARY_TEXT_COLOR,
                        ),
                        product.offerPrice == null
                            ? AppTextWidget(
                          content: '${product.price}\₪',
                          fontSize: 13,
                          color: AppColors.PRIMARY_TEXT_COLOR,
                          fontWeight: FontWeight.bold,
                        )
                            : AppTextWidget(
                          content: '${product.price}\₪',
                          fontSize: 13,
                          color: AppColors.PRIMARY_TEXT_COLOR,
                          fontWeight: FontWeight.bold,
                          textDecoration: TextDecoration.lineThrough,
                          decorationColor: Colors.red,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    product.offerPrice != null
                        ? AppTextWidget(
                      content: 'Offer: ${product.offerPrice}\₪',
                      color: AppColors.PRIMARY_TEXT_COLOR,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'sf',
                    )
                        : Container(),
                    SizedBox(
                      height: 12,
                    ),
                    AppTextWidget(
                      content: '${product.quantity} product available',
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Icon(Icons.star,color: Colors.amber,size: 15,),
                        SizedBox(width: 5,),
                        AppTextWidget(
                          content: '(${product.overalRate})',
                          fontSize: 10,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                    AppTextWidget(
                      content: '${product.isFavorite}',
                      fontSize: 8,
                      color: Colors.grey,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
