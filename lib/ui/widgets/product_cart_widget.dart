import 'package:flutter/material.dart';
import 'package:said_store/model/cart_item.dart';
import 'package:said_store/ui/widgets/app_text_widget.dart';

class ProductCartWidget extends StatelessWidget {
  final CartItem cartItem;
  final void Function() onTap;

  ProductCartWidget({required this.cartItem, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: Colors.white,
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.grey,
                offset: Offset(0, 3),
                blurRadius: 5,
                spreadRadius: 0,
              )
            ],
          ),
          child: Row(
            children: [
              Image.network(cartItem.imageUrl,
                  height: 150, width: 120, fit: BoxFit.fill),
              SizedBox(
                width: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppTextWidget(
                    content: 'Price For 1 Pic : ${cartItem.price}',
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(height: 8),
                  AppTextWidget(
                    content: 'Quantity: ${cartItem.quantity} pic',
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(height: 8),
                  AppTextWidget(
                    content: 'Total Price: : ${cartItem.price * cartItem.quantity}',
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              )
            ],
          ),
        ),
        PositionedDirectional(
          top: 5,
          end: 10,
          child: IconButton(
            onPressed: onTap,
            icon: Icon(
              Icons.delete,
              color: Colors.red.shade900,
              size: 30,
            ),
          ),
        ),
      ],
    );
  }
}
