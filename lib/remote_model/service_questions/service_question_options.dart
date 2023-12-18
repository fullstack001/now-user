/// id : 10
/// question_id : 1
/// option : "10x10"
/// created_at : "2021-08-09T07:13:52.000000Z"
/// updated_at : "2021-08-09T07:13:52.000000Z"

class ServiceQuestionOptions {
  var id;
  var questionId;
  var option;
  var createdAt;
  var updatedAt;
  var selected = false;

  ServiceQuestionOptions(
      {this.id, this.questionId, this.option, this.createdAt, this.updatedAt});

  ServiceQuestionOptions.fromJson(dynamic json) {
    id = json["id"];
    questionId = json["question_id"];
    option = json["option"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["question_id"] = questionId;
    map["option"] = option;
    map["created_at"] = createdAt;
    map["updated_at"] = updatedAt;
    return map;
  }
}
