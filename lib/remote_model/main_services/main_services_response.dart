import 'main_services_data.dart';

/// error : false
/// message : "success"
/// main_services_data : [{"id":1,"name":"Cleaning","status":1,"created_at":"2021-06-02T17:12:53.000000Z","updated_at":"2021-06-02T17:12:53.000000Z","sub_services":[{"id":1,"service_id":1,"name":"Affordable Cleaning Service","status":1,"created_at":"2021-06-02T17:13:15.000000Z","updated_at":"2021-06-02T17:13:15.000000Z"},{"id":2,"service_id":1,"name":"Room cleaning","status":1,"created_at":"2021-07-14T21:35:00.000000Z","updated_at":"2021-07-14T21:35:00.000000Z"}]},{"id":3,"name":"Moving","status":1,"created_at":"2021-07-14T21:38:35.000000Z","updated_at":"2021-07-14T21:38:35.000000Z","sub_services":[{"id":3,"service_id":3,"name":"Apartment Moving","status":1,"created_at":"2021-07-14T21:39:07.000000Z","updated_at":"2021-07-14T21:39:07.000000Z"},{"id":4,"service_id":3,"name":"House moving","status":1,"created_at":"2021-07-14T21:39:29.000000Z","updated_at":"2021-07-14T21:39:29.000000Z"},{"id":5,"service_id":3,"name":"Office Moving","status":0,"created_at":"2021-07-14T21:39:40.000000Z","updated_at":"2021-07-14T21:40:55.000000Z"}]},{"id":2,"name":"Plumbing","status":1,"created_at":"2021-07-14T21:22:36.000000Z","updated_at":"2021-07-14T21:22:36.000000Z","sub_services":[]}]

class MainServicesResponse {
  var error;
  var message;
  var mainServicesData;

  MainServicesResponse({
      this.error, 
      this.message, 
      this.mainServicesData});

  MainServicesResponse.fromJson(dynamic json) {
    error = json["error"];
    message = json["message"];
    if (json["data"] != null) {
      mainServicesData = [];
      json["data"].forEach((v) {
        mainServicesData?.add(MainServicesData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["error"] = error;
    map["message"] = message;
    if (mainServicesData != null) {
      map["main_services_data"] = mainServicesData?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}