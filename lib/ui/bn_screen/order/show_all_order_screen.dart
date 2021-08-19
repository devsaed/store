import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:said_store/getx/order_getx_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:said_store/ui/bn_screen/order/order_widget.dart';

class ShowAllOrdersScreen extends StatefulWidget {

  @override
  _ShowAllOrdersScreenState createState() => _ShowAllOrdersScreenState();
}

class _ShowAllOrdersScreenState extends State<ShowAllOrdersScreen> {
  @override
  void initState() {
    Future.delayed(Duration.zero,()async{
      await OrderGetxController.to.getOrders();
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GetX<OrderGetxController>(
        builder: (OrderGetxController controller) {
          return controller.loading.value
              ? Center(child: CircularProgressIndicator())
              : controller.orders.isNotEmpty
              ? Padding(
            padding: EdgeInsets.symmetric(horizontal: 29.w, vertical: 10.h),
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: controller.orders.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return OrderWidget(
                  order: controller.orders[index],
                );
              },
            ),
          )
              : Center(child: Text('No Data'));
        },
      ),
    );
  }
}
