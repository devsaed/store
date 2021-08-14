import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:said_store/api/controllers/category_api_controller.dart';
import 'package:said_store/api/controllers/cities_api_controller.dart';
import 'package:said_store/model/category.dart';
import 'package:said_store/model/city.dart';
import 'package:said_store/model/sub_category.dart';

class CategoryGetxController extends GetxController {
  final CategoryApiController categoryApiController = CategoryApiController();
  RxList<Category> categories = <Category>[].obs;
  RxList<SubCategory> subCategories = <SubCategory>[].obs;
  RxBool loading = true.obs;

  static CategoryGetxController get to => Get.find();

  void onInit() {
    getCategory();
    super.onInit();
  }

  Future<void> getCategory() async {
    loading.value = true;
    categories.value = await categoryApiController.getCategory();
    loading.value = false;
    update();
  }


  Future<void> getSubCategories({required int id}) async {
    loading.value = true;
    subCategories.value = await categoryApiController.getSubCategory(id: id);
    loading.value = false;
    update();
  }

}
