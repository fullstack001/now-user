import 'vehicle_data.dart';

class VehicleResponse {
  var error;
  var vehicleData;
  var message;

  VehicleResponse({
      this.error, 
      this.vehicleData, 
      this.message});

  VehicleResponse.fromJson(dynamic json) {
    error = json["error"];
    if (json["data"] != null) {
      vehicleData = [];
      json["data"].forEach((v) {
        vehicleData.add(VehicleData.fromJson(v));
      });
    }
    message = json["message"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["error"] = error;
    if (vehicleData != null) {
      map["vehicle_data"] = vehicleData.map((v) => v.toJson()).toList();
    }
    map["message"] = message;
    return map;
  }

}