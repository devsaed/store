import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:said_store/getx/product_getx_controller.dart';
import 'package:said_store/ui/product/product_details.dart';
import 'package:said_store/ui/bn_screen/favorite/favorite_product_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavoriteProductsScreen extends StatefulWidget {
  @override
  _FavoriteProductsScreenState createState() => _FavoriteProductsScreenState();
}

class _FavoriteProductsScreenState extends State<FavoriteProductsScreen> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GetX<ProductGetxController>(
          builder: (ProductGetxController controller) {
        return controller.loading.value
            ? Center(child: CircularProgressIndicator())
            : controller.favoriteProducts.isNotEmpty
                ? GridView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: controller.favoriteProducts.length,
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 5.h,
                      childAspectRatio: 146.w / 280.h,
                      mainAxisSpacing: 20.w,
                    ),
                    itemBuilder: (context, index) {
                      return FavoriteProductWidget(
                          product: controller.favoriteProducts[index],
                          onTap: () => Get.to(ProductDetailsScreen(
                              productDetails: controller.favoriteProducts[index])));
                    },
                  )
                : Center(child: Text('no data'));
      }),
      padding: EdgeInsets.symmetric(horizontal: 29.w, vertical: 10.h),
    );
  }
}
