import 'service_question_questions.dart';

/// id : 1
/// service_id : 1
/// name : "Affordable Cleaning Service"
/// status : 1
/// created_at : "2021-06-02T17:13:15.000000Z"
/// updated_at : "2021-06-02T17:13:15.000000Z"
/// service_question_questions : [{"id":1,"sub_service_id":1,"question":"What is Room size","created_at":"2021-08-09T06:40:24.000000Z","updated_at":"2021-08-09T06:40:24.000000Z","service_question_options":[{"id":10,"question_id":1,"option":"10x10","created_at":"2021-08-09T07:13:52.000000Z","updated_at":"2021-08-09T07:13:52.000000Z"},{"id":11,"question_id":1,"option":"20x20","created_at":"2021-08-09T07:14:00.000000Z","updated_at":"2021-08-09T07:14:00.000000Z"},{"id":12,"question_id":1,"option":"30x30","created_at":"2021-08-09T07:14:11.000000Z","updated_at":"2021-08-09T07:14:11.000000Z"}]},{"id":2,"sub_service_id":1,"question":"What is Room Type","created_at":"2021-08-09T06:43:05.000000Z","updated_at":"2021-08-09T06:43:05.000000Z","service_question_options":[{"id":1,"question_id":2,"option":"Single","created_at":"2021-08-09T07:11:10.000000Z","updated_at":"2021-08-09T07:11:10.000000Z"},{"id":2,"question_id":2,"option":"Double","created_at":"2021-08-09T07:11:36.000000Z","updated_at":"2021-08-09T07:11:36.000000Z"},{"id":3,"question_id":2,"option":"Quad","created_at":"2021-08-09T07:11:44.000000Z","updated_at":"2021-08-09T07:11:44.000000Z"},{"id":4,"question_id":2,"option":"Twin","created_at":"2021-08-09T07:11:54.000000Z","updated_at":"2021-08-09T07:11:54.000000Z"},{"id":5,"question_id":2,"option":"Queen","created_at":"2021-08-09T07:12:05.000000Z","updated_at":"2021-08-09T07:12:05.000000Z"},{"id":6,"question_id":2,"option":"King","created_at":"2021-08-09T07:12:18.000000Z","updated_at":"2021-08-09T07:12:18.000000Z"},{"id":7,"question_id":2,"option":"10x10","created_at":"2021-08-09T07:13:01.000000Z","updated_at":"2021-08-09T07:13:01.000000Z"},{"id":8,"question_id":2,"option":"20x20","created_at":"2021-08-09T07:13:10.000000Z","updated_at":"2021-08-09T07:13:10.000000Z"},{"id":9,"question_id":2,"option":"30x30","created_at":"2021-08-09T07:13:19.000000Z","updated_at":"2021-08-09T07:13:19.000000Z"}]}]

class ServiceQuestionData {
  var id;
  var serviceId;
  var name;
  var status;
  var createdAt;
  var updatedAt;
  var serviceQuestionQuestions;

  ServiceQuestionData(
      {this.id,
      this.serviceId,
      this.name,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.serviceQuestionQuestions});

  ServiceQuestionData.fromJson(dynamic json) {
    id = json["id"];
    serviceId = json["service_id"];
    name = json["name"];
    status = json["status"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
    if (json["questions"] != null) {
      serviceQuestionQuestions = [];
      json["questions"].forEach((v) {
        serviceQuestionQuestions.add(ServiceQuestionQuestions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["service_id"] = serviceId;
    map["name"] = name;
    map["status"] = status;
    map["created_at"] = createdAt;
    map["updated_at"] = updatedAt;
    if (serviceQuestionQuestions != null) {
      map["questions"] =
          serviceQuestionQuestions.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
