import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:said_store/getx/cart_getx_controller.dart';
import 'package:said_store/model/cart_item.dart';
import 'package:said_store/ui/bn_screen/order/create_order_screen.dart';
import 'package:said_store/ui/widgets/app_elevated_button.dart';
import 'package:said_store/ui/bn_screen/cart/product_cart_widget.dart';
import 'package:said_store/utils/helper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GetX<CartGetxController>(
        builder: (CartGetxController controller) {
          return controller.loading.value
              ? Center(child: CircularProgressIndicator())
              : controller.cartItem.isNotEmpty
              ? Container(
            padding: EdgeInsets.symmetric(horizontal: 29.w, vertical: 10.h),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: controller.cartItem.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return ProductCartWidget(
                        cartItem: controller.cartItem[index],
                        onTap: () async {
                          await deleteItem(
                            cartItem: controller.cartItem[index],
                            context: context,
                          );
                        },
                      );
                    },
                  ),
                ),
                AppElevatedButton(
                  text: 'Make Order',
                  onPressed: () {
                    Get.to(OrderScreen(cart: cart,));
                  },
                ),
              ],
            ),
          )
              : Center(
            child: Text('No Data'),
          );
        },
      ),
    );
  }

  deleteItem({required CartItem cartItem, required BuildContext context}) async {
    bool status = await CartGetxController.to.deleteItem(cartItem.id);
    String msg = status ? 'delete success' : 'delete fail';
    Helper.showSnackBar(context, text: msg);
  }

  String get cart {
    List<Map<String, dynamic>> items = [];
    CartGetxController.to.cartItem.map((element) => items.add({'product_id': element.productId, 'quantity': element.quantity})).toList();
    return jsonEncode(items);
  }


}
