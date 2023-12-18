import 'card_data.dart';

class CreditCardModel {
  var error;
  var cardData;
  var message;

  CreditCardModel({this.error, this.cardData, this.message});

  CreditCardModel.fromJson(dynamic json) {
    error = json["error"];
    cardData = json["data"] != null ? CardData.fromJson(json["data"]) : null;
    message = json["message"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["error"] = error;
    if (cardData != null) {
      map["card_data"] = cardData.toJson();
    }
    map["message"] = message;
    return map;
  }
}
