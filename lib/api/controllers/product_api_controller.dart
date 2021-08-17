import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:said_store/api/helper/api_mixin.dart';
import 'package:said_store/local_storge/shared_preferences/preferences.dart';
import 'package:said_store/model/category.dart';
import 'package:said_store/model/product_details.dart';
import 'package:said_store/model/sub_category.dart';
import '../api_settings.dart';
import 'package:http/http.dart' as http;

class ProductApiController with ApiMixin {

  Future<List<ProductDetails>> getProduct({required int id}) async {
    var response = await http.get(getUrl(ApiSettings.PRODUCT+'/$id'),headers: header);
    if (isSuccessRequest(response.statusCode)) {
      var data = jsonDecode(response.body)['list'] as List;
      List<ProductDetails> products = data.map((e) => ProductDetails.fromJson(e)).toList();
      return products;
    }
    return [];
  }

  Future<List<ProductDetails>> getFavoriteProducts() async {
    var response = await http.get(getUrl(ApiSettings.FAVORITE_PRODUCT),headers: {
      'Accept':'application/json',
      HttpHeaders.authorizationHeader: SharedPreferencesController().token,
      'X-Requested-With': 'XMLHttpRequest',
    });
    if (isSuccessRequest(response.statusCode)) {
      var data = jsonDecode(response.body)['list'] as List;
      List<ProductDetails> favoriteProducts = data.map((e) => ProductDetails.fromJson(e)).toList();
      return favoriteProducts;
    }
    return [];
  }



  Future<ProductDetails?> getProductDetails({required int id}) async {
    var response = await http.get(
        getUrl(ApiSettings.PRODUCT_DETAILS +'/$id'),
        headers: {
          HttpHeaders.authorizationHeader: SharedPreferencesController().token,
          'X-Requested-With': 'XMLHttpRequest',
          'lang': SharedPreferencesController().languageCode,
        });
    if (isSuccessRequest(response.statusCode)) {
      var data = jsonDecode(response.body)['object'];
      var productDetails = ProductDetails.fromJson(data);
      return productDetails;
    }
  }

  Future<bool> addFavoriteProducts(BuildContext context, {required int id}) async {
    var response = await http.post(
        getUrl(ApiSettings.FAVORITE_PRODUCT),
        body: {'product_id': id.toString()},
        headers: requestHeaders
    );
    if (isSuccessRequest(response.statusCode)) {
      showMessage(context, response);
      return true;
    } else if (response.statusCode != 500) {
      showMessage(context, response, error: true);
    }else{
      handleServerError(context);
    }
    return false;
  }


  Future<bool> productRate(BuildContext context, {required int id,required double ratting}) async {
    var response = await http.post(
        getUrl(ApiSettings.RATTING_PRODUCT),
        body: {'product_id': id.toString(), 'rate' :ratting.toString()},
        headers: requestHeaders
    );
    if (isSuccessRequest(response.statusCode)) {
      showMessage(context, response);
      return true;
    } else if (response.statusCode != 500) {
      showMessage(context, response, error: true);
    }else{
      handleServerError(context);
    }
    return false;
  }
}