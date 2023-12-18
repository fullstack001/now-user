/// id : 5
/// code : "4545"
/// created_at : "2021-08-13T06:03:49.000000Z"
/// updated_at : "2021-08-13T06:03:49.000000Z"

class ZipSearchList {
  var id;
  var code;
  var createdAt;
  var updatedAt;

  ZipSearchList({
      this.id, 
      this.code, 
      this.createdAt, 
      this.updatedAt});

  ZipSearchList.fromJson(dynamic json) {
    id = json["id"];
    code = json["code"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["code"] = code;
    map["created_at"] = createdAt;
    map["updated_at"] = updatedAt;
    return map;
  }

}