import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:said_store/getx/address_getx_controller.dart';
import 'package:said_store/ui/address/add_address_screen.dart';
import 'package:said_store/ui/address/address_edite_screen.dart';
import 'package:said_store/ui/address/address_widget.dart';

class AddressScreen extends StatelessWidget {
  AddressGetxController controller = Get.put(AddressGetxController());

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
                      padding: EdgeInsets.symmetric(horizontal: 29, vertical: 10),
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: controller.addresses.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return AddressWidget(address: controller.addresses[index],);
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
}
