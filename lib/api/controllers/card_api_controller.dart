import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:said_store/api/helper/api_mixin.dart';
import 'package:said_store/model/card.dart';
import '../api_settings.dart';


class CardApiController with ApiMixin {

  Future<List<MyCard>> getAllCard() async {
    var response = await http.get(getUrl(ApiSettings.CARD), headers: requestHeaders);
    if (isSuccessRequest(response.statusCode)) {
      var data = jsonDecode(response.body)['list'] as List;
      List<MyCard> cards = data.map((e) => MyCard.fromJson(e)).toList();
      return cards;
    }
    return [];
  }


  Future<MyCard?> createCard({required BuildContext context
    , required String holderName,
     required String cardNumber,
     required String expDate,
     required String cvv,
     required String type,
  }) async {

    var response = await http.post(
      getUrl(ApiSettings.CARD),
      headers: requestHeaders,
      body: {
        'holder_name': holderName,
        'card_number': cardNumber,
        'exp_date': expDate,
        'cvv': cvv.toString(),
        'type': type,
      },
    );

    if (isSuccessRequest(response.statusCode)) {
      var jsonObject = jsonDecode(response.body)['object'];
      print('true');
      return MyCard.fromJson(jsonObject);
    }
    else if (response.statusCode != 500) {
      showMessage(context, response, error: true);
    }
    handleServerError(context);
    return null;
  }

}
