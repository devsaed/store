import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:said_store/api/controllers/card_api_controller.dart';
import 'package:said_store/model/card.dart';


class CardGetxController extends GetxController {
  final CardApiController cardApiController = CardApiController();
  RxList<MyCard> cards = <MyCard>[].obs;
  RxBool loading = false.obs;

  static CardGetxController get to => Get.find();


  Future<void> getCards() async {
    loading.value = true;
    cards.value = await cardApiController.getAllCard();
    loading.value = false;
    update();
  }

  void onInit() {
    super.onInit();
    getCards();
    cards.refresh();
  }

  Future<bool> createCard({required BuildContext context, required MyCard card}) async {
    MyCard? newAddress = await cardApiController.createCard(context: context, card: card);
    if (newAddress != null) {
      return true;
    }
    return false;
  }
}
