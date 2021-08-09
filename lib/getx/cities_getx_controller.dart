import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:said_store/api/controllers/cities_api_controller.dart';
import 'package:said_store/model/city.dart';
import 'package:said_store/shared_preferences/preferences.dart';

class CitiesGetxController extends GetxController {
  final CitiesApiController citiesApiController = CitiesApiController();
  RxList<City> cities = <City>[].obs;

  static CitiesGetxController get to => Get.find();

  void onInit() {
    getCities();
    super.onInit();
  }

  Future<void> getCities() async {
    cities.value = await citiesApiController.getCities();
    update();
  }

  String getCityNameById({required int id}){
    int index = cities.indexWhere((element) => element.id == id);
    String cityName = SharedPreferencesController().languageCode == 'ar' ? cities[index].nameAr:cities[index].nameEn;
    return cityName;
  }

}
