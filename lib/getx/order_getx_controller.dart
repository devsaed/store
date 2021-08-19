import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:said_store/api/controllers/address_api_controller.dart';
import 'package:said_store/api/controllers/order_api_controller.dart';
import 'package:said_store/model/address_details.dart';
import 'package:said_store/model/order.dart';

class OrderGetxController extends GetxController {
  final OrderApiController orderApiController = OrderApiController();
  RxList<Order> orders = <Order>[].obs;
  RxBool loading = false.obs;

  static OrderGetxController get to => Get.find();

  Future<void> getOrders() async {
    loading.value = true;
    orders.value = await orderApiController.getAllOrders();
    loading.value = false;
    update();
  }

  void onInit() {
    super.onInit();
    getOrders();
    orders.refresh();
  }

  Future<bool> createOrder({
    required BuildContext context,
    required String cart,
    required String paymentType,
    required int addressId,
    required int cardId,
  }) async {
    bool isAdded = await orderApiController.createOrder(
      context: context,
      cart: cart,
      paymentType: paymentType,
      addressId: addressId,
      cardId: cardId,
    );
    if (isAdded) {
      return true;
    }
    return false;
  }
}
