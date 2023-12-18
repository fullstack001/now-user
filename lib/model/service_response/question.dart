import 'sub_service.dart';

/// id : 1
/// sub_service_id : 1
/// question : "What is Room size"
/// created_at : "2021-08-09T06:40:24.000000Z"
/// updated_at : "2021-08-09T06:40:24.000000Z"
/// sub_service : {"id":1,"service_id":1,"name":"Affordable Cleaning Service","status":1,"created_at":"2021-06-02T17:13:15.000000Z","updated_at":"2021-06-02T17:13:15.000000Z"}

class Question {
  var id;
  var subServiceId;
  var question;
  var createdAt;
  var updatedAt;
  var subService;

  Question({
      this.id, 
      this.subServiceId, 
      this.question, 
      this.createdAt, 
      this.updatedAt, 
      this.subService});

  Question.fromJson(dynamic json) {
    id = json["id"];
    subServiceId = json["sub_service_id"];
    question = json["question"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
    subService = json["sub_service"] != null ? SubService.fromJson(json["sub_service"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["sub_service_id"] = subServiceId;
    map["question"] = question;
    map["created_at"] = createdAt;
    map["updated_at"] = updatedAt;
    if (subService != null) {
      map["sub_service"] = subService.toJson();
    }
    return map;
  }

}