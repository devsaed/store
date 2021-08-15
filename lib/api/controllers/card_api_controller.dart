import 'dart:convert';
import 'package:flutter/cupertino.dart';
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


  Future<MyCard?> createCard({required BuildContext context, required MyCard card}) async {
    var response = await http.post(
      getUrl(ApiSettings.CARD),
      headers: requestHeaders,
      body: {
        'holder_name': card.holderName,
        'card_number': card.cardNumber,
        'exp_date': card.expDate,
        'cvv': card.cvv.toString(),
        'type': card.type,
      },
    );


    if (isSuccessRequest(response.statusCode)) {
      var jsonObject = jsonDecode(response.body)['object'];
      print(MyCard.fromJson(jsonObject));
      return MyCard.fromJson(jsonObject);
    }
    else if (response.statusCode != 500) {
      showMessage(context, response, error: true);
    }
    print('response.statusCode  ${response.statusCode}');
    handleServerError(context);
    return null;
  }

}
