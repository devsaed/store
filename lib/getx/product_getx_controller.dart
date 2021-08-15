import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:said_store/api/controllers/product_api_controller.dart';
import 'package:said_store/model/product.dart';
import 'package:said_store/model/product_details.dart';


class ProductGetxController extends GetxController {
  final ProductApiController productApiController = ProductApiController();
  RxList<Product> products = <Product>[].obs;
  RxList<ProductDetails> favoriteProducts = <ProductDetails>[].obs;
  Rx<ProductDetails?> productDetails = ProductDetails().obs;
  RxBool loading = false.obs;


  static ProductGetxController get to => Get.find();

  Future<void> getProduct({required int id}) async {
    loading.value = true;
    products.value = await productApiController.getProduct(id: id);
    loading.value = false;
    update();
  }

  Future<void> getFavoriteProducts() async {
    loading.value = true;
    favoriteProducts.value = await productApiController.getFavoriteProducts();
    loading.value =false;
    update();
  }

  void onInit() {
    super.onInit();
    getFavoriteProducts();
  }
  Future<void> getProductDetails({required int id}) async {
    loading.value = true;
    productDetails.value = await productApiController.getProductDetails(id: id);
    loading.value = false;
    update();
  }

  Future<void> addFavoriteProducts({required ProductDetails product,required BuildContext context}) async {
    bool status = await productApiController.addFavoriteProducts(context, id: product.id);
    if(status){
      int index = products.indexWhere((element) => element.id == product.id);
      products[index].isFavorite == false ? favoriteProducts.add(product):favoriteProducts.remove(product) ;
      products[index].isFavorite = !products[index].isFavorite;
      productDetails.value!.isFavorite = products[index].isFavorite ;
    }
    productDetails.refresh();
    products.refresh();
    favoriteProducts.refresh();
    update();
  }

  Future<void> rattingProduct({required Product product,required BuildContext context,required double rate}) async {
    bool status = await productApiController.productRate(context, id: product.id,ratting: rate);
    if(status){
      int index = products.indexWhere((element) => element.id == product.id);
      products[index].productRate = rate;
    }
    update();
  }
}
