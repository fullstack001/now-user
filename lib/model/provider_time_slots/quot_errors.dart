/// address : "The address must be at least 10 characters."
/// detail : "The detail must be at least 20 characters."

class QuotErrors {
  var address;
  var detail;
  var isHourly;

  QuotErrors({this.address, this.detail});
  QuotErrors.fromJson(dynamic json) {
    address = json["address"];
    detail = json["detail"];
    isHourly = json["is_hourly"];
    print(detail);
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["address"] = address;
    map["detail"] = detail;
    map["is_hourly"] = isHourly;
    return map;
  }
}
