import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:said_store/getx/card_getx_controller.dart';
import 'package:said_store/model/card.dart';
import 'package:said_store/ui/credit_card/create_credit_card.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:said_store/ui/credit_card/my_card_widget.dart';
import 'package:said_store/utils/app_colors.dart';

class DisplayCardScreen extends StatelessWidget {
  CardGetxController controller = Get.put(CardGetxController());
  final bool fromOrder;

  DisplayCardScreen({this.fromOrder = false});

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
            padding: EdgeInsets.symmetric(horizontal: 29.w, vertical: 10.h),
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: controller.cards.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    popScreen(card: controller.cards[index]);
                  },
                  child: MyCardWidget(
                    expiryDate: controller.cards[index].expDate,
                    flag: false,
                    cardHolderName: controller.cards[index].holderName,
                    cardNumber: controller.cards[index].cardNumber,
                    cardType: controller.cards[index].type == 'Visa' ? CardType.visa : CardType.mastercard,
                  ),
                );
              },
            ),
          )
              : Center(child: Text('No Data'));
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Get.to(CreateCreditCard());
        },
        backgroundColor: AppColors.PRIMARY_COLOR,
        child: Icon(Icons.add),
      ),
    );
  }

  popScreen({required MyCard card}) {
    print(fromOrder);
    if (fromOrder) Get.back(result: card);
  }
}
