
import 'package:application_1/model/service_response/option.dart';
import 'package:application_1/model/service_response/question.dart';

/// id : 11
/// service_request_id : 17
/// question_id : 1
/// option_id : 11
/// created_at : "2021-08-16T10:53:27.000000Z"
/// updated_at : "2021-08-16T10:53:27.000000Z"
/// detail : null
/// reply : null
/// duration : null
/// price : null
/// question : {"id":1,"sub_service_id":1,"question":"What is Room size","created_at":"2021-08-09T06:40:24.000000Z","updated_at":"2021-08-09T06:40:24.000000Z","sub_service":{"id":1,"service_id":1,"name":"Affordable Cleaning Service","status":1,"created_at":"2021-06-02T17:13:15.000000Z","updated_at":"2021-06-02T17:13:15.000000Z"}}
/// option : {"id":11,"question_id":1,"option":"20x20","created_at":"2021-08-09T07:14:00.000000Z","updated_at":"2021-08-09T07:14:00.000000Z"}

class RequestInfos {
  var id;
  var serviceRequestId;
  var questionId;
  var optionId;
  var createdAt;
  var updatedAt;
  dynamic detail;
  dynamic reply;
  dynamic duration;
  dynamic price;
  var question;
  var option;

  RequestInfos({
      this.id, 
      this.serviceRequestId, 
      this.questionId, 
      this.optionId, 
      this.createdAt, 
      this.updatedAt, 
      this.detail, 
      this.reply, 
      this.duration, 
      this.price, 
      this.question, 
      this.option});

  RequestInfos.fromJson(dynamic json) {
    id = json["id"];
    serviceRequestId = json["service_request_id"];
    questionId = json["question_id"];
    optionId = json["option_id"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
    detail = json["detail"];
    reply = json["reply"];
    duration = json["duration"];
    price = json["price"];
    question = json["question"] != null ? Question.fromJson(json["question"]) : null;
    option = json["option"] != null ? Option.fromJson(json["option"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["service_request_id"] = serviceRequestId;
    map["question_id"] = questionId;
    map["option_id"] = optionId;
    map["created_at"] = createdAt;
    map["updated_at"] = updatedAt;
    map["detail"] = detail;
    map["reply"] = reply;
    map["duration"] = duration;
    map["price"] = price;
    if (question != null) {
      map["question"] = question.toJson();
    }
    if (option != null) {
      map["option"] = option.toJson();
    }
    return map;
  }

}