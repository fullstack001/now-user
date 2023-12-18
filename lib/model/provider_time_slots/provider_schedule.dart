/// id : 1
/// provider_id : 48
/// year : "2021"
/// month : "1"
/// date : "5"
/// created_at : "2021-08-10T13:16:00.000000Z"
/// updated_at : "2021-08-10T13:16:00.000000Z"

class ProviderSchedule {
  var id;
  var providerId;
  var year;
  var month;
  var date;
  var createdAt;
  var updatedAt;

  ProviderSchedule({
      this.id, 
      this.providerId, 
      this.year, 
      this.month, 
      this.date, 
      this.createdAt, 
      this.updatedAt});

  ProviderSchedule.fromJson(dynamic json) {
    id = json["id"];
    providerId = json["provider_id"];
    year = json["year"];
    month = json["month"];
    date = json["date"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["provider_id"] = providerId;
    map["year"] = year;
    map["month"] = month;
    map["date"] = date;
    map["created_at"] = createdAt;
    map["updated_at"] = updatedAt;
    return map;
  }

}