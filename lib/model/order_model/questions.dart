/// question_1 : 10
/// question_2 : 2

class Questions {
  var question1;
  var question2;

  Questions({
      this.question1, 
      this.question2});

  Questions.fromJson(dynamic json) {
    question1 = json["question_1"];
    question2 = json["question_2"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["question_1"] = question1;
    map["question_2"] = question2;
    return map;
  }

}