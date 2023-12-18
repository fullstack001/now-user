import 'questions.dart';

/// address : "New Garden Town Block C Muslim Town, Lahore, Pakistan"
/// questions : {"question_1":10,"question_2":2}
/// is_hourly : "1"
/// provider_id : "139"
/// slots : ["192"]

class OrderResponse {
  var address;
  var questions;
  var isHourly;
  var providerId;
  var slots;

  OrderResponse({
      this.address, 
      this.questions, 
      this.isHourly, 
      this.providerId, 
      this.slots});

  OrderResponse.fromJson(dynamic json) {
    address = json["address"];
    questions = json["questions"] != null ? Questions.fromJson(json["questions"]) : null;
    isHourly = json["is_hourly"];
    providerId = json["provider_id"];
    slots = json["slots"] != null ? json["slots"].cast<String>() : [];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["address"] = address;
    if (questions != null) {
      map["questions"] = questions.toJson();
    }
    map["is_hourly"] = isHourly;
    map["provider_id"] = providerId;
    map["slots"] = slots;
    return map;
  }

}