import 'message.dart';

/// error : true
/// message : {"phone":"The phone has already been taken."}

class SignResponse {
  bool? error;
  Message? message;
  String? messageRes;

  SignResponse({this.error, this.message, this.messageRes});

  SignResponse.fromError(dynamic json) {
    error = json["error"];
    message =
        json["message"] != null ? Message.fromJson(json["message"]) : null;
  }

  SignResponse.fromJson(dynamic json) {
    error = json["error"];
    messageRes = json["message"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["error"] = error;
    if (message != null && error!) {
      map["message"] = message?.toJson();
    }
    if (!error!) {
      map["message"] = messageRes;
    }
    return map;
  }
}
