import 'links.dart';
import 'meta.dart';
import 'restaurant_data.dart';

class RestaurantModel {
  var error;
  var restaurantData;
  var message;
  var links;
  var meta;

  RestaurantModel(
      {this.error, this.restaurantData, this.message, this.links, this.meta});

  RestaurantModel.fromJson(dynamic json) {
    error = json["error"];
    if (json["data"] != null) {
      restaurantData = [];
      json["data"].forEach((v) {
        restaurantData.add(RestaurantData.fromJson(v));
      });
    }
    message = json["message"];
    links = json["links"] != null ? Links.fromJson(json["links"]) : null;
    meta = json["meta"] != null ? Meta.fromJson(json["meta"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["error"] = error;
    if (restaurantData != null) {
      map["data"] = restaurantData.map((v) => v.toJson()).toList();
    }
    map["message"] = message;
    if (links != null) {
      map["links"] = links.toJson();
    }
    if (meta != null) {
      map["meta"] = meta.toJson();
    }
    return map;
  }
}
