/// error : false
/// message : "Phone verified."

class OtpVerificationResponse {
  bool? error;
  String? message;
  String? token;

  OtpVerificationResponse({this.error, this.message});

  OtpVerificationResponse.fromJson(dynamic json) {
    error = json["error"];
    message = json["message"];
    token = json["token"] == null ? null : json["token"];
    print(json);
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["error"] = error;
    map["message"] = message;
    map["token"] = token;
    return map;
  }
}
