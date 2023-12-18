import 'sub_services.dart';

/// id : 1
/// name : "Cleaning"
/// status : 1
/// created_at : "2021-06-02T17:12:53.000000Z"
/// updated_at : "2021-06-02T17:12:53.000000Z"
/// sub_services : [{"id":1,"service_id":1,"name":"Affordable Cleaning Service","status":1,"created_at":"2021-06-02T17:13:15.000000Z","updated_at":"2021-06-02T17:13:15.000000Z"},{"id":2,"service_id":1,"name":"Room cleaning","status":1,"created_at":"2021-07-14T21:35:00.000000Z","updated_at":"2021-07-14T21:35:00.000000Z"}]

class MainServicesData {
  var id;
  var name;
  var status;
  var createdAt;
  var updatedAt;
  var subServices;

  MainServicesData(
      {this.id,
      this.name,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.subServices});

  MainServicesData.fromJson(dynamic json) {
    id = json["id"];
    name = json["name"];
    status = json["status"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
    if (json["sub_services"] != null) {
      subServices = [];
      json["sub_services"].forEach((v) {
        subServices.add(SubServices.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["name"] = name;
    map["status"] = status;
    map["created_at"] = createdAt;
    map["updated_at"] = updatedAt;
    if (subServices != null) {
      map["sub_services"] = subServices?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
