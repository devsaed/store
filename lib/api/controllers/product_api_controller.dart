import 'dart:convert';
import 'package:said_store/api/helper/api_mixin.dart';
import 'package:said_store/model/category.dart';
import 'package:said_store/model/product.dart';
import 'package:said_store/model/sub_category.dart';
import '../api_settings.dart';
import 'package:http/http.dart' as http;

class ProductApiController with ApiMixin {

  Future<List<Product>> getProduct({required int id}) async {
    var response = await http.get(getUrl(ApiSettings.PRODUCT+'/$id'),headers: header);
    if (isSuccessRequest(response.statusCode)) {
      var data = jsonDecode(response.body)['list'] as List;
      List<Product> categories = data.map((e) => Product.fromJson(e)).toList();
      return categories;
    }
    return [];
  }
}