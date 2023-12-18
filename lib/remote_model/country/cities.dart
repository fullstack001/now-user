import 'package:application_1/remote_model/country/zips.dart';

/// id : 1
/// country_id : 1
/// name : "New York"
/// created_at : "2022-04-04T06:33:02.000000Z"
/// updated_at : "2022-04-04T06:33:02.000000Z"
/// deleted_at : null

class Cities {
  Cities({
    this.id,
    this.countryId,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.zips,
    this.deletedAt,
  });

  Cities.fromJson(dynamic json) {
    id = json['id'];
    countryId = json['country_id'];
    name = json['name'];
    if (json['zip_codes'] != null) {
      zips = [];
      json['zip_codes'].forEach((v) {
        zips?.add(Zips.fromJson(v));
      });
    }
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  int? id;
  int? countryId;
  String? name;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
  List<Zips>? zips;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['country_id'] = countryId;
    map['name'] = name;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['deleted_at'] = deletedAt;
    return map;
  }
}
