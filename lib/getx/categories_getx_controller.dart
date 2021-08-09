import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:said_store/api/controllers/category_api_controller.dart';
import 'package:said_store/api/controllers/cities_api_controller.dart';
import 'package:said_store/model/category.dart';
import 'package:said_store/model/city.dart';
import 'package:said_store/model/sub_category.dart';
import 'package:said_store/shared_preferences/preferences.dart';

class CategoryGetxController extends GetxController {
  final CategoryApiController categoryApiController = CategoryApiController();
  RxList<Category> categories = <Category>[].obs;
  RxList<SubCategory> subCategories = <SubCategory>[].obs;

  static CategoryGetxController get to => Get.find();

  void onInit() {
    getCities();
    super.onInit();
  }

  Future<void> getCities() async {
    categories.value = await categoryApiController.getCategory();
    update();
  }


  Future<void> getSubCategories({required int id}) async {
    subCategories.value = await categoryApiController.getSubCategory(id: id);
    update();
  }
}
