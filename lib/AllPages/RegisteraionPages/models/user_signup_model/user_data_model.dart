import 'signup_data.dart';

/// signup_data : {"user_data":{"id":3,"first_name":"user","last_name":"user","email":"user2@site.com","email_verified_at":null,"phone":"+923008383978","zip_code":"23423","role":"USER","status":"ACTIVE","created_at":"2021-07-07T09:37:44.000000Z","updated_at":"2021-07-07T09:37:44.000000Z","phone_verification":0,"spend_each_month":null,"provider_type":"Individual"},"auth_token":"Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiMTY1MWY1NDVkMmE3NDVmOTA1ZjllMDY2ZTM5MTUwOGFmODIwMDhiMTQ1NTQ4MDk0Y2E0NTQxMTZhNWU3ZmYyMmE0MjY5ODViMmY4M2Q2NzkiLCJpYXQiOjE2MjU2NTA2NjQsIm5iZiI6MTYyNTY1MDY2NCwiZXhwIjoxNjU3MTg2NjY0LCJzdWIiOiIzIiwic2NvcGVzIjpbXX0.b6T_8HIy0YBF2RERqjz6p28XmyB3jcoLjlRbNVrNr-_sjmLRNZJPPIuNnDfA3D_6nEA-3LReWgKpmCJ_CCDRXEEH8dCzcKU4_AGV6iPGx4fpVde3zNgUuDYSKibPrJSp3QMzXj4IHtTnRBntANF-xsARimPVtP8dVaAoOJYc1TzuifU-NTBMS2mPIleu50JMq64uGbw-vfL5BnTbTgKGFvaNxvgXcmoqhk8k4WH0laF1s7yrEDo_oqJMD0aJ082yev6Xs46mI6_pRHYiiHO_Vf6DzaDkEkWeX6L-49wiJQocF8mYhjfqSNQgtT0gl8qbHTADFbcy35uKK_PNyLUN81zXFfe4JOKzVV-wWGwEGBN3RmFgJuIt6FvGjyaosO4QLRqlRVMAxJ--CatnV1hLcy6GWu8GTI7fb3x5mDe4lrqI6hUOASynoX2q6YEHCcEPkbD9EaWRH8NTZdVzyirPiUa925LTNSaIbIosfAiXM8zrvhSZKbZtUzICt8eu925rtlAPNlyOIdwkxGEpdcL694gk3dBKmRFnfl-f4DY6Fc5w5QxBXCXUEbLwdIH9ZTCcPOJ_B597X14Jy3-Zs4e77VIuXr-8c0eXjNE-ELLmWfeYPv6sqOC-vJwj9w7_WAtpMLe3QCWWHewsLwNIPXsJDBfaD2kyE45Nb6D8wam-TOU","expires_at":"2022-07-07 09:37:44"}

class UserDataModel {
  var signupData;

  UserDataModel({this.signupData});

  UserDataModel.fromJson(dynamic json) {
    signupData =
        json["data"] != null ? SignupData.fromJson(json["data"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (signupData != null) {
      map["data"] = signupData.toJson();
    }
    return map;
  }
}
