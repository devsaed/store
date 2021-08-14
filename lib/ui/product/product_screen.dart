import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:said_store/getx/product_getx_controller.dart';
import 'package:said_store/ui/product/product_details.dart';
import 'package:said_store/ui/widgets/app_text_widget.dart';
import 'package:said_store/ui/widgets/product_widget.dart';
import 'package:said_store/utils/app_colors.dart';

class ProductScreen extends StatefulWidget {
  final int id;

  ProductScreen({required this.id});

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {

  @override
  void initState() {
    Future.delayed(Duration.zero,()async{
      await ProductGetxController.to.getProduct(id: widget.id);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: AppTextWidget(
          content: 'Products',
          color: AppColors.PRIMARY_TEXT_COLOR,
          fontSize: 20,
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: GetX<ProductGetxController>(
          builder: (ProductGetxController controller) {
            return controller.loading.value
                ? Center(child: CircularProgressIndicator())
                : controller.products.isNotEmpty?
            GridView.builder(
              scrollDirection: Axis.vertical,
              itemCount: controller.products.length,
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 5,
                childAspectRatio: 146 / 230,
                mainAxisSpacing: 20,
              ),
              itemBuilder: (context, index) {
                return ProductWidget(
                  product: controller.products[index],
                  onTap: () => Get.to(
                    ProductDetailsScreen(
                        productID: controller.products[index].id),
                  ),
                );
              },
            ):Center(child: Text('no data'));
          },
        ),
      ),
    );
  }
}
