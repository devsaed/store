import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:said_store/getx/address_getx_controller.dart';
import 'package:said_store/model/address_details.dart';
import 'package:said_store/ui/address/add_address_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:said_store/ui/address/address_widget.dart';

class AddressScreen extends StatelessWidget {
  AddressGetxController controller = Get.put(AddressGetxController());
  final bool fromOrder;

  AddressScreen({this.fromOrder = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GetX<AddressGetxController>(
        builder: (AddressGetxController controller) {
          return controller.loading.value
              ? Center(child: CircularProgressIndicator())
              : controller.addresses.isNotEmpty
                  ? Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 29.w, vertical: 10.h),
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: controller.addresses.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return AddressWidget(
                            address: controller.addresses[index],
                            onTap: () => popScreen(address: controller.addresses[index]),
                          );
                        },
                      ),
                    )
                  : Center(child: Text('no data'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(AddAddressScreen());
        },
        child: Icon(Icons.add),
      ),
    );
  }

  popScreen({required AddressDetails address}) {
    if (fromOrder) Get.back(result: address);
  }
}
