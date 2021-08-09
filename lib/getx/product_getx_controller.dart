import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:said_store/api/controllers/category_api_controller.dart';
import 'package:said_store/api/controllers/cities_api_controller.dart';
import 'package:said_store/api/controllers/product_api_controller.dart';
import 'package:said_store/model/category.dart';
import 'package:said_store/model/city.dart';
import 'package:said_store/model/product.dart';
import 'package:said_store/model/sub_category.dart';
import 'package:said_store/shared_preferences/preferences.dart';

class ProductGetxController extends GetxController {
  final ProductApiController productApiController = ProductApiController();
  RxList<Product> products = <Product>[].obs;

  static ProductGetxController get to => Get.find();

  Future<void> getProduct({required int id}) async {
    products.value = await productApiController.getProduct(id: id);
    update();
  }
}
