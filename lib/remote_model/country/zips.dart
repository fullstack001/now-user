/// id : 4
/// name : "Abbeville"
/// country_id : 1

class Zips {
  Zips({
      this.id, 
      this.code,
      this.countryId,});

  Zips.fromJson(dynamic json) {
    id = json['id'];
    code = json['code'];
    countryId = json['country_id'];
  }
  int? id;
  String? code;
  int? countryId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['code'] = code;
    return map;
  }

}