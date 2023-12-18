import 'credit_card_data.dart';

class CardData {
  var object;
  var creditCardData;
  var hasMore;
  var url;

  CardData({this.object, this.creditCardData, this.hasMore, this.url});

  CardData.fromJson(dynamic json) {
    object = json["object"];
    if (json["data"] != null) {
      creditCardData = [];
      json["data"].forEach((v) {
        creditCardData.add(CreditCardData.fromJson(v));
      });
    }
    hasMore = json["has_more"];
    url = json["url"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["object"] = object;
    if (creditCardData != null) {
      map["data"] = creditCardData.map((v) => v.toJson()).toList();
    }
    map["has_more"] = hasMore;
    map["url"] = url;
    return map;
  }
}
