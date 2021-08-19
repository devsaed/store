import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:said_store/getx/address_getx_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:said_store/model/address_details.dart';
import 'package:said_store/model/order.dart';
import 'package:said_store/ui/address/address_edite_screen.dart';
import 'package:said_store/ui/widgets/app_text_widget.dart';
import 'package:said_store/utils/app_colors.dart';

class OrderWidget extends StatelessWidget {
  final Order order;

  OrderWidget({required this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsetsDirectional.only(top: 10.h),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withAlpha(25),
            offset: Offset(0, 0),
            blurRadius: 6,
            spreadRadius: 3,
          )
        ],
        borderRadius: BorderRadius.all(
          Radius.circular(7.h),
        ),
      ),
      height: 70.h,
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppTextWidget(
                content: 'Order ID ${order.id}',
                fontWeight: FontWeight.w500,
                fontSize: 13.sp,
              ),
              SizedBox(height: 5.h),
              AppTextWidget(
                content: 'Total Price: ${order.total}',
                fontWeight: FontWeight.w500,
                fontSize: 12.sp,
                color: AppColors.PRIMARY_TEXT_COLOR,
              ),
            ],
          ),
          Spacer(),
          Container(
            padding: EdgeInsets.all(5.h),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.h),
                color: order.status == 'Waiting' ? Colors.red : Colors.green),
            child: AppTextWidget(
              content: ' ${order.status}',
            ),
          )
        ],
      ),
    );
  }
}
