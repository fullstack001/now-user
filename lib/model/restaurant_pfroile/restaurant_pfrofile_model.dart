import 'restaurant_pfrofile_data.dart';

class RestaurantProfileModel {
  var error;
  var restaurantPfrofileData;
  var message;

  RestaurantProfileModel({
      this.error, 
      this.restaurantPfrofileData, 
      this.message});

  RestaurantProfileModel.fromJson(dynamic json) {
    error = json["error"];
    restaurantPfrofileData = json["data"] != null ? RestaurantProfileData.fromJson(json["data"]) : null;
    message = json["message"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["error"] = error;
    if (restaurantPfrofileData != null) {
      map["data"] = restaurantPfrofileData.toJson();
    }
    map["message"] = message;
    return map;
  }

}