import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:said_store/model/sub_category.dart';

class ProductDetails{
  late int id;
  late String nameEn;
  late String nameAr;
  late String infoEn;
  late String infoAr;
  late int price;
  late int quantity;
  late int? overalRate;
  late int subCategoryId;
  late int productRate;
  late double? offerPrice;
  late bool isFavorite;
  late String imageUrl;
  late List<ProductImages> images;
  late SubCategory? subCategory;

  ProductDetails();

  ProductDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameEn = json['name_en'];
    nameAr = json['name_ar'];
    infoEn = json['info_en'];
    infoAr = json['info_ar'];
    price = json['price'];
    quantity = json['quantity'];
    overalRate = json['overal_rate'];
    subCategoryId = json['sub_category_id'];
    productRate = json['product_rate'];
    offerPrice = json['offer_price'];
    isFavorite = json['is_favorite'];
    imageUrl = json['image_url'];
    if (json['images'] != null) {
      images = <ProductImages>[];
      json['images'].forEach((v) {
        images.add(new ProductImages.fromJson(v));
      });
    }
    subCategory = json['sub_category'] != null
        ? SubCategory.fromJson(json['sub_category'])
        : null;
  }
}

class ProductImages {
  late int id;
  late String url;
  late String imageUrl;

  ProductImages();

  ProductImages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
    imageUrl = json['image_url'];
  }
}