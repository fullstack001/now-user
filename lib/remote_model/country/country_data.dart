

import 'package:application_1/remote_model/country/cities.dart';

/// id : 1
/// name : "United States"
/// created_at : "2022-04-04T06:33:02.000000Z"
/// updated_at : "2022-04-04T06:33:02.000000Z"
/// deleted_at : null
/// cities : [{"id":1,"country_id":1,"name":"New York","created_at":"2022-04-04T06:33:02.000000Z","updated_at":"2022-04-04T06:33:02.000000Z","deleted_at":null},{"id":3,"country_id":1,"name":"Washington","created_at":"2022-04-04T06:59:09.000000Z","updated_at":"2022-04-04T06:59:09.000000Z","deleted_at":null},{"id":4,"country_id":1,"name":"Abbeville","created_at":"2022-04-04T06:59:09.000000Z","updated_at":"2022-04-04T06:59:09.000000Z","deleted_at":null},{"id":5,"country_id":1,"name":"Alexandria","created_at":"2022-04-04T06:59:09.000000Z","updated_at":"2022-04-04T06:59:09.000000Z","deleted_at":null},{"id":6,"country_id":1,"name":"Hydaburg","created_at":"2022-04-04T06:59:09.000000Z","updated_at":"2022-04-04T06:59:09.000000Z","deleted_at":null},{"id":7,"country_id":1,"name":"Los Angeles","created_at":"2022-04-04T10:36:16.000000Z","updated_at":"2022-04-04T10:36:16.000000Z","deleted_at":null},{"id":8,"country_id":1,"name":"Glencoe","created_at":"2022-04-04T10:36:16.000000Z","updated_at":"2022-04-04T10:36:16.000000Z","deleted_at":null}]

class CountryData {
  CountryData({
      this.id, 
      this.name, 
      this.createdAt, 
      this.updatedAt, 
      this.deletedAt, 
      this.cities,});

  CountryData.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    if (json['states'] != null) {
      cities = [];
      json['states'].forEach((v) {
        cities?.add(Cities.fromJson(v));
      });
    }
  }
  int? id;
  String? name;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
  List<Cities>? cities;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['deleted_at'] = deletedAt;
    if (cities != null) {
      map['states'] = cities?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}