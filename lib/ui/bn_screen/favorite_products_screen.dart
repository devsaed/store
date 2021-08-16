import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:said_store/getx/product_getx_controller.dart';
import 'package:said_store/ui/product/product_details.dart';
import 'package:said_store/ui/widgets/favorite_product_widget.dart';
import 'package:said_store/ui/product/product_widget.dart';

class FavoriteProductsScreen extends StatefulWidget {
  @override
  _FavoriteProductsScreenState createState() => _FavoriteProductsScreenState();
}

class _FavoriteProductsScreenState extends State<FavoriteProductsScreen> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      await ProductGetxController.to.getFavoriteProducts();
    });
    super.initState();
  }

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
                      crossAxisSpacing: 5,
                      childAspectRatio: 146 / 250,
                      mainAxisSpacing: 20,
                    ),
                    itemBuilder: (context, index) {
                      return FavoriteProductWidget(
                          product: controller.favoriteProducts[index],
                          onTap: () => Get.to(ProductDetailsScreen(
                              productID: controller.favoriteProducts[index].id)));
                    },
                  )
                : Center(child: Text('no data'));
      }),
      padding: EdgeInsets.symmetric(horizontal: 29, vertical: 10),
      // child: GridView.builder(
      //   scrollDirection: Axis.vertical,
      //   itemCount: ProductGetxController.to.favoriteProducts.length,
      //   shrinkWrap: true,
      //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      //     crossAxisCount: 2,
      //     crossAxisSpacing: 25,
      //     childAspectRatio: 146 / 280,
      //     mainAxisSpacing: 40,
      //   ),
      //   itemBuilder: (context, index) {
      //     return ProductWidget(
      //         product: ProductGetxController.to.favoriteProducts[index],
      //         onTap: () => {});
      //   },
      // ),
    );
  }
}
