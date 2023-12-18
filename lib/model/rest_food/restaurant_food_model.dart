import 'Categories_model.dart';
import 'links.dart';
import 'meta.dart';
import 'restaurant_food_data.dart';

class RestaurantFoodModel {
  var error;
  var restaurantFoodData;
  var message;
  var links;
  var meta;
  var categoriesModel;

  RestaurantFoodModel({
    this.error,
    this.restaurantFoodData,
    this.message,
    this.links,
    this.meta,
    this.categoriesModel,
  });

  RestaurantFoodModel.fromJson(dynamic json) {
    error = json["error"];
    if (json["data"] != null) {
      restaurantFoodData = [];
      json["data"].forEach((v) {
        restaurantFoodData.add(RestaurantFoodData.fromJson(v));
      });
    }
    if (json["categories"] != null) {
      categoriesModel = [];
      json["categories"].forEach((v) {
        categoriesModel.add(CategoriesModel.fromJson(v));
      });
    }
    message = json["message"];
    links = json["links"] != null ? Links.fromJson(json["links"]) : null;

    meta = json["meta"] != null ? Meta.fromJson(json["meta"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["error"] = error;
    if (restaurantFoodData != null) {
      map["data"] = restaurantFoodData.map((v) => v.toJson()).toList();
    }
    if (categoriesModel != null) {
      map["categories"] = categoriesModel.map((v) => v.toJson()).toList();
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
