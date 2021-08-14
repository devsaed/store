import 'dart:convert';
import 'package:said_store/api/helper/api_mixin.dart';
import 'package:said_store/model/category.dart';
import 'package:said_store/model/sub_category.dart';
import '../api_settings.dart';
import 'package:http/http.dart' as http;

class CategoryApiController with ApiMixin {

  Future<List<Category>> getCategory() async {
    var response = await http.get(getUrl(ApiSettings.CATEGORY),headers: header);
    if (isSuccessRequest(response.statusCode)) {
      var data = jsonDecode(response.body)['list'] as List;
      List<Category> categories = data.map((e) => Category.fromJson(e)).toList();
      return categories;
    }
    return [];
  }

  Future<List<SubCategory>> getSubCategory({required int id}) async {
    var response = await http.get(getUrl(ApiSettings.CATEGORY + '/$id'),headers: header);
    if (isSuccessRequest(response.statusCode)) {
      var data = jsonDecode(response.body)['list'] as List;
      List<SubCategory> subCategories = data.map((e) => SubCategory.fromJson(e)).toList();
      return subCategories;
    }
    return [];
  }
}