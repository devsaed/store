import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:said_store/getx/card_getx_controller.dart';
import 'package:said_store/ui/credit_card/create_credit_card.dart';

import 'package:said_store/ui/credit_card/my_card_widget.dart';

class DisplayCardScreen extends StatelessWidget {
  CardGetxController controller = Get.put(CardGetxController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GetX<CardGetxController> (
        builder: (CardGetxController controller){
          return controller.loading.value
              ? Center(child: CircularProgressIndicator())
              : controller.cards.isNotEmpty
              ? Padding(
            padding: EdgeInsets.symmetric(horizontal: 29, vertical: 10),
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: controller.cards.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                // return AddressWidget(
                //   address: controller.addresses[index],
                // );
                return MyCardWidget(
                  expiryDate: controller.cards[index].expDate,
                  // cvvCode: controller.cards[index].cvv,
                  flag: false,
                  cardHolderName: controller.cards[index].holderName,
                  cardNumber: controller.cards[index].cardNumber,
                  cardType: controller.cards[index].type == 'Visa' ? CardType.visa : CardType.mastercard,
                );
              },
            ),
          )
              : Center(child: Text('no data'));
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Get.to(CreateCreditCard());
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
