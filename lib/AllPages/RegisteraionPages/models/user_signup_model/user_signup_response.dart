import 'package:application_1/AllPages/RegisteraionPages/models/user_signup_model/signup_data.dart';
import 'package:application_1/AllPages/RegisteraionPages/models/user_signup_model/signup_errors_message.dart';

/// error : true
/// message : {"first_name":"The first name field is required.","last_name":"The last name field is required.","zip_code":"The zip code field is required.","email":"The email field is required.","password":"The password field is required.","phone":"The phone field is required."}

class UserSignupResponse {
  var error;
  var message;
  var messageStr;
  var userDataModel;

  UserSignupResponse(
      {this.error, this.message, this.userDataModel, this.messageStr});

  UserSignupResponse.errorJson(dynamic json) {
    error = json["error"];
    message = json["message"].runtimeType != String
        ? SignupErrorsMessage.fromJson(json["message"])
        : json["message"].runtimeType != null
            ? json["message"]
            : null;
  }

  UserSignupResponse.fromJson(dynamic json) {
    error = json["error"];
    messageStr = json["message"];
    userDataModel =
        json["data"] == null ? null : SignupData.fromJson(json["data"]);
  }

  UserSignupResponse.userProfile(dynamic json) {
    error = json["error"];
    messageStr = json["message"];
    userDataModel = SignupData.userProfile(json["data"]);
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["error"] = error;
    if (message != null && error) {
      map["message"] = message.toJson();
    }
    if (!error) {
      map['message'] = messageStr;
      map['data'] = userDataModel;
    }
    return map;
  }
}
