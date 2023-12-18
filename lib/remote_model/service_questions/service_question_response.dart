
import 'package:application_1/remote_model/service_questions/service_question_data.dart';

/// error : false
/// message : "success"
/// data : {"id":1,"service_id":1,"name":"Affordable Cleaning Service","status":1,"created_at":"2021-06-02T17:13:15.000000Z","updated_at":"2021-06-02T17:13:15.000000Z","service_question_questions":[{"id":1,"sub_service_id":1,"question":"What is Room size","created_at":"2021-08-09T06:40:24.000000Z","updated_at":"2021-08-09T06:40:24.000000Z","service_question_options":[{"id":10,"question_id":1,"option":"10x10","created_at":"2021-08-09T07:13:52.000000Z","updated_at":"2021-08-09T07:13:52.000000Z"},{"id":11,"question_id":1,"option":"20x20","created_at":"2021-08-09T07:14:00.000000Z","updated_at":"2021-08-09T07:14:00.000000Z"},{"id":12,"question_id":1,"option":"30x30","created_at":"2021-08-09T07:14:11.000000Z","updated_at":"2021-08-09T07:14:11.000000Z"}]},{"id":2,"sub_service_id":1,"question":"What is Room Type","created_at":"2021-08-09T06:43:05.000000Z","updated_at":"2021-08-09T06:43:05.000000Z","service_question_options":[{"id":1,"question_id":2,"option":"Single","created_at":"2021-08-09T07:11:10.000000Z","updated_at":"2021-08-09T07:11:10.000000Z"},{"id":2,"question_id":2,"option":"Double","created_at":"2021-08-09T07:11:36.000000Z","updated_at":"2021-08-09T07:11:36.000000Z"},{"id":3,"question_id":2,"option":"Quad","created_at":"2021-08-09T07:11:44.000000Z","updated_at":"2021-08-09T07:11:44.000000Z"},{"id":4,"question_id":2,"option":"Twin","created_at":"2021-08-09T07:11:54.000000Z","updated_at":"2021-08-09T07:11:54.000000Z"},{"id":5,"question_id":2,"option":"Queen","created_at":"2021-08-09T07:12:05.000000Z","updated_at":"2021-08-09T07:12:05.000000Z"},{"id":6,"question_id":2,"option":"King","created_at":"2021-08-09T07:12:18.000000Z","updated_at":"2021-08-09T07:12:18.000000Z"},{"id":7,"question_id":2,"option":"10x10","created_at":"2021-08-09T07:13:01.000000Z","updated_at":"2021-08-09T07:13:01.000000Z"},{"id":8,"question_id":2,"option":"20x20","created_at":"2021-08-09T07:13:10.000000Z","updated_at":"2021-08-09T07:13:10.000000Z"},{"id":9,"question_id":2,"option":"30x30","created_at":"2021-08-09T07:13:19.000000Z","updated_at":"2021-08-09T07:13:19.000000Z"}]}]}

class ServiceQuestionResponse {
  var error;
  var message;
  var data;

  ServiceQuestionResponse({
      this.error, 
      this.message, 
      this.data});

  ServiceQuestionResponse.fromJson(dynamic json) {
    error = json["error"];
    message = json["message"];
    data = json["data"] != null ? ServiceQuestionData.fromJson(json["data"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["error"] = error;
    map["message"] = message;
    if (data != null) {
      map["data"] = data.toJson();
    }
    return map;
  }

}