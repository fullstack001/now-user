import 'feedback.dart';

class FeedbackResponse {
  var feedback;

  FeedbackResponse({this.feedback});

  FeedbackResponse.fromJson(dynamic json) {
    if (json["feedback"] != null) {
      feedback = [];
      json["feedback"].forEach((v) {
        feedback.add(FeedBack.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (feedback != null) {
      map["feedback"] = feedback.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
