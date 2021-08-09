import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:said_store/getx/product_getx_controller.dart';
import 'package:said_store/ui/widgets/product_widget.dart';

class ProductScreen extends StatefulWidget {
  final int id;

  ProductScreen({required this.id});

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  ProductGetxController controller = Get.put(ProductGetxController());

  @override
  void initState() {
    controller.getProduct(id: widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: GetX<ProductGetxController>(
          builder: (ProductGetxController controller) {
            return controller.products.isEmpty
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.separated(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: controller.products.length,
                    itemBuilder: (context, index) {
                      return ProductWidget(
                          product: controller.products[index], onTap: () => {});
                      // onTap: () => Get.to(ProductScreen(id: controller.products[index].id)));
                    },
                    separatorBuilder: (context, index) {
                      return Divider(
                        height: 0,
                        color: Colors.grey,
                      );
                    },
                  );
          },
        ),
      ),
    );
  }
}
