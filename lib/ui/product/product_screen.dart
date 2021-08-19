import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:said_store/getx/product_getx_controller.dart';
import 'package:said_store/ui/product/product_details.dart';
import 'package:said_store/ui/widgets/app_text_widget.dart';
import 'package:said_store/ui/product/product_widget.dart';
import 'package:said_store/utils/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
          fontSize: 20.sp,
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
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
                crossAxisSpacing: 5.h,
                childAspectRatio: 146.w / 250.h,
                mainAxisSpacing: 20.w,
              ),
              itemBuilder: (context, index) {
                return ProductWidget(
                  product: controller.products[index],
                  onTap: () => Get.to(
                    ProductDetailsScreen(
                        productDetails: controller.products[index]),
                  ),
                );
              },
            ):Center(child: Text('No Data'));
          },
        ),
      ),
    );
  }
}
