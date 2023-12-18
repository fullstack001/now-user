import 'service_question_options.dart';

/// id : 1
/// sub_service_id : 1
/// question : "What is Room size"
/// created_at : "2021-08-09T06:40:24.000000Z"
/// updated_at : "2021-08-09T06:40:24.000000Z"
/// service_question_options : [{"id":10,"question_id":1,"option":"10x10","created_at":"2021-08-09T07:13:52.000000Z","updated_at":"2021-08-09T07:13:52.000000Z"},{"id":11,"question_id":1,"option":"20x20","created_at":"2021-08-09T07:14:00.000000Z","updated_at":"2021-08-09T07:14:00.000000Z"},{"id":12,"question_id":1,"option":"30x30","created_at":"2021-08-09T07:14:11.000000Z","updated_at":"2021-08-09T07:14:11.000000Z"}]

class ServiceQuestionQuestions {
  var id;
  var subServiceId;
  var question;
  var createdAt;
  var updatedAt;
  var serviceQuestionOptions;
  var is_multiple;

  ServiceQuestionQuestions(
      {this.id,
      this.subServiceId,
      this.question,
      this.createdAt,
      this.updatedAt,
      this.is_multiple,
      this.serviceQuestionOptions});

  ServiceQuestionQuestions.fromJson(dynamic json) {
    id = json["id"];
    subServiceId = json["sub_service_id"];
    question = json["question"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
    is_multiple = json["is_multiple"];
    if (json["options"] != null) {
      serviceQuestionOptions = [];
      json["options"].forEach((v) {
        serviceQuestionOptions.add(ServiceQuestionOptions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["sub_service_id"] = subServiceId;
    map["question"] = question;
    map["created_at"] = createdAt;
    map["updated_at"] = updatedAt;
    map["is_multiple"] = is_multiple;
    if (serviceQuestionOptions != null) {
      map["options"] = serviceQuestionOptions.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
