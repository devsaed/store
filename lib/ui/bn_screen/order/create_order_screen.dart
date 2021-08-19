import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:said_store/getx/card_getx_controller.dart';
import 'package:said_store/getx/cart_getx_controller.dart';
import 'package:said_store/getx/order_getx_controller.dart';
import 'package:said_store/model/address_details.dart';
import 'package:said_store/model/card.dart';
import 'package:said_store/ui/address/address_screen.dart';
import 'package:said_store/ui/credit_card/display_cards_screen.dart';
import 'package:said_store/ui/widgets/app_elevated_button.dart';
import 'package:said_store/ui/widgets/app_text_widget.dart';
import 'package:said_store/utils/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:said_store/utils/helper.dart';

class OrderScreen extends StatefulWidget {
  final String cart;

  OrderScreen({required this.cart});

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  bool isOnline = true;
  AddressDetails? address;
  MyCard? card;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: AppTextWidget(
          content: 'Make Order',
          color: AppColors.PRIMARY_TEXT_COLOR,
          fontSize: 20.sp,
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(32.h),
        children: [
          GestureDetector(
            onTap: () async {
              AddressDetails selectedAddress = await Get.to(AddressScreen(
                fromOrder: true,
              ));
              setState(() {
                address = selectedAddress;
              });
            },
            child: Container(
              padding: EdgeInsetsDirectional.only(start: 28.w, end: 10.w),
              alignment: AlignmentDirectional.centerStart,
              height: 50.h,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFF999999).withAlpha(25),
                      offset: Offset(0, 5.h),
                      blurRadius: 10.h,
                      spreadRadius: 0,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(25.h),
                  border: Border.all(color: Colors.grey)),
              child: Row(
                children: [
                  getAddress(),
                  Spacer(),
                  Icon(
                    Icons.keyboard_arrow_down_sharp,
                    color: AppColors.PRIMARY_COLOR,
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 20.h),
          GestureDetector(
            onTap: () async {
              MyCard selectedCard = await Get.to(DisplayCardScreen(fromOrder: true,));
              setState(() {
                card = selectedCard;
              });
            },
            child: Container(
                padding: EdgeInsetsDirectional.only(start: 28.w, end: 10.w),
                alignment: AlignmentDirectional.centerStart,
                height: 50.h,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFF999999).withAlpha(25),
                        offset: Offset(0, 5.h),
                        blurRadius: 10.h,
                        spreadRadius: 0,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(25.h),
                    border: Border.all(color: Colors.grey)),
                child: Row(
                  children: [
                    getCard(),
                    Spacer(),
                    Icon(
                      Icons.keyboard_arrow_down_sharp,
                      color: AppColors.PRIMARY_COLOR,
                    )
                  ],
                )),
          ),
          SizedBox(height: 20.h),
          Row(
            children: [
              Expanded(
                child: CheckboxListTile(
                  checkColor: Colors.white,
                  activeColor: AppColors.PRIMARY_COLOR,
                  value: isOnline,
                  onChanged: (var selected) {
                    setState(() {
                      isOnline = true;
                    });
                  },
                  title: AppTextWidget(
                    content: 'Online',
                    fontSize: 16.sp,
                    color: AppColors.PRIMARY_TEXT_COLOR,
                  ),
                ),
              ),
              VerticalDivider(
                color: Colors.red,
                width: 50.w,
                thickness: 5.h,
              ),
              Expanded(
                child: CheckboxListTile(
                  checkColor: Colors.white,
                  activeColor: AppColors.PRIMARY_COLOR,
                  value: !isOnline,
                  onChanged: (var selected) {
                    setState(() {
                      isOnline = false;
                    });
                  },
                  title: AppTextWidget(
                    content: 'Offline',
                    fontSize: 16.sp,
                    color: AppColors.PRIMARY_TEXT_COLOR,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 42.h),
          AppElevatedButton(
            text: 'Confirm Order',
            onPressed: () async => await performOrder(),
          ),
        ],
      ),
    );
  }

  Widget getCard() {
    if (card == null) {
      return AppTextWidget(
        content: 'Select Card',
        color: Colors.grey,
      );
    } else {
      return AppTextWidget(
        content: card!.cardNumber,
        color: AppColors.PRIMARY_TEXT_COLOR,
        fontSize: 16.sp,
      );
    }
  }

  Widget getAddress() {
    if (address == null) {
      return AppTextWidget(
        content: 'Select Address',
        color: Colors.grey,
      );
    } else {
      return AppTextWidget(
        content: address!.info,
        color: AppColors.PRIMARY_TEXT_COLOR,
        fontSize: 16.sp,
      );
    }
  }

  Future<void> performOrder() async {
    if (checkData())
      await makeOrder();
    else
      Helper.showSnackBar(context, text: 'Enter Required Data');
  }

  bool checkData() {
    if (card != null && address != null) return true;
    return false;
  }

  Future<void> makeOrder() async {
    bool status = await OrderGetxController.to.createOrder(
        context: context,
        cart: widget.cart,
        paymentType: isOnline ? 'Online' : 'Offline',
        addressId: address!.id,
        cardId: card!.id);
    if (status) {
      await CartGetxController.to.deleteAllItem();
      Get.back();
    }
  }
}
