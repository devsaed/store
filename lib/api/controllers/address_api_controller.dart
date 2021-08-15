import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:said_store/api/helper/api_mixin.dart';
import 'package:said_store/model/address.dart';
import 'package:said_store/model/address_details.dart';

import '../api_settings.dart';


class AddressApiController with ApiMixin {

  Future<List<AddressDetails>> getAllAddress() async {
    var response = await http.get(getUrl(ApiSettings.ADDRESS), headers: requestHeaders);
    if (isSuccessRequest(response.statusCode)) {
      var data = jsonDecode(response.body)['list'] as List;
      List<AddressDetails> addresses = data.map((e) => AddressDetails.fromJson(e)).toList();
      return addresses;
    }
    return [];
  }


  Future<Address?> createAddress({required BuildContext context, required Address address}) async {
    var response = await http.post(
      getUrl(ApiSettings.ADDRESS),
      headers: requestHeaders,
      body: {
        'name': address.name,
        'info': address.info,
        'contact_number': address.contactNumber,
        'city_id': address.cityId.toString(),
        'lat': address.lat??'',
        'lang': address.lang??'',
      },
    );
    if (isSuccessRequest(response.statusCode)) {
      var jsonObject = jsonDecode(response.body)['object'];
      return Address.fromJson(jsonObject);
    }
    else if (response.statusCode != 500) {
      showMessage(context, response, error: true);
    }
    handleServerError(context);
    return null;
  }


  Future<bool> updateTask({required BuildContext context, required Address address}) async {
    var response = await http.put(
        getUrl(ApiSettings.ADDRESS + '/${address.id}'),
        headers: requestHeaders,
        body: {
          'name': address.name,
          'info': address.info,
          'contact_number': address.contactNumber,
          'city_id': address.cityId,
          'lat': address.lat,
          'lang': address.lang,
        },
    );
    if (isSuccessRequest(response.statusCode)) {
      return true;
    } else if (response.statusCode != 500) {
      showMessage(context, response);
      return false;
    }
    handleServerError(context);
    return false;
  }

  Future<bool> deleteAddress({required BuildContext context, required addressId}) async {
    var response = await http.delete(
      getUrl(ApiSettings.ADDRESS + '/$addressId'),
      headers: requestHeaders,
    );

    if (isSuccessRequest(response.statusCode)) {
      return true;
    } else if (response.statusCode != 500) {
      showMessage(context, response);
      return false;
    }
    handleServerError(context);
    return false;
  }
}
