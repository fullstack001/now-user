class BookingModel {
  String? vehicleId;
  String? movingFrom;
  String? movingTo;
  String? movingDate;
  String? providerId;
  String? name;
  String? email;
  String? contact;
  String? description;
  String? startLat;
  String? startLng;
  String? endLat;
  String? endLng;
  String? zipCode;

  BookingModel({
    this.vehicleId,
    this.movingFrom,
    this.movingTo,
    this.movingDate,
    this.providerId,
    this.name,
    this.email,
    this.contact,
    this.description,
    this.endLat,
    this.endLng,
    this.startLat,
    this.startLng,
    this.zipCode,
  });

  BookingModel.fromJson(dynamic json) {
    vehicleId = json["vehicle_type_id"];
    movingFrom = json["from_address"];
    movingTo = json["to_address"];
    movingDate = json["date"];
    providerId = json["provider_id"];
    name = json["name"];
    email = json["email"];
    contact = json["phone"];
    description = json["detail"];
    startLat = json["start_lat"];
    startLng = json["start_lng"];
    endLat = json["end_lat"];
    endLng = json["end_lng"];
    zipCode = json["zip_code"];
  }

  /*{
  "vehicle_type_id" : 2,
  "provider_id" : 2,
  "detail" : "sdkjfksdljfksdjhf",
  "name" : "askjd",
  "start_lat": "31.2335435346",
  "start_lng": "71.48583476587",
  "end_lat": "31.2358784",
  "end_lng": "71.8345847",
  "date": "2222-12-22"
  }*/



  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["vehicle_type_id"] = vehicleId;
    map["from_address"] = movingFrom;
    map["to_address"] = movingTo;
    map["date"] = movingDate;
    map["provider_id"] = providerId;
    map["name"] = name;
    map["email"] = email;
    map["phone"] = contact;
    map["detail"] = description;
    map["start_lat"] = startLat;
    map["start_lng"] = startLng;
    map["end_lat"] = endLat;
    map["end_lng"] = endLng;
    map["zip_code"] = zipCode;
    return map;
  }
}
