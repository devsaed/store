import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:said_store/api/controllers/address_api_controller.dart';

import 'package:said_store/api/controllers/product_api_controller.dart';
import 'package:said_store/model/address_details.dart';
import 'package:said_store/model/product.dart';
import 'package:said_store/model/product_details.dart';


class AddressGetxController extends GetxController {
  final AddressApiController addressApiController = AddressApiController();
  RxList<AddressDetails> addresses = <AddressDetails>[].obs;
 RxBool loading = true.obs;


  static AddressGetxController get to => Get.find();


  Future<void> getAddresses() async {
    loading.value = true;
    addresses.value = await addressApiController.getAllAddress();
    loading.value =false;
    update();
  }

  void onInit() {
    super.onInit();
    getAddresses();
    addresses.refresh();
  }

}
