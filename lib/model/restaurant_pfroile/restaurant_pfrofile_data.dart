import 'restaurant_pfrofile_user.dart';

class RestaurantProfileData {
  var id;
  var name;
  var address;
  var city;
  var state;
  var country;
  var businessPhone;
  var website;
  var type;
  dynamic restaurantType;
  dynamic profileImage;
  var about;
  var coverImage;
  dynamic createdAt;
  dynamic updatedAt;
  var restaurantPfrofileUser;

  RestaurantProfileData(
      {this.id,
      this.name,
      this.address,
      this.city,
      this.state,
      this.country,
      this.businessPhone,
      this.website,
      this.type,
      this.restaurantType,
      this.profileImage,
      this.about,
      this.createdAt,
      this.updatedAt,
      this.restaurantPfrofileUser});

  RestaurantProfileData.fromJson(dynamic json) {
    id = json["id"];
    name = json["name"];
    address = json["address"];
    city = json["city"];
    state = json["state"];
    country = json["country"];
    businessPhone = json["business_phone"];
    website = json["website"];
    type = json["type"];
    restaurantType = json["restaurant_type"];
    profileImage = json["profile_image"];
    about = json["about"];
    createdAt = json["created_at"];
    coverImage = json["cover_image"];
    updatedAt = json["updated_at"];
    restaurantPfrofileUser = json["user"] != null
        ? RestaurantProfileUser.fromJson(json["user"])
        : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["name"] = name;
    map["address"] = address;
    map["cover_image"] = coverImage;
    map["city"] = city;
    map["state"] = state;
    map["country"] = country;
    map["business_phone"] = businessPhone;
    map["website"] = website;
    map["type"] = type;
    map["restaurant_type"] = restaurantType;
    map["profile_image"] = profileImage;
    map["about"] = about;
    map["created_at"] = createdAt;
    map["updated_at"] = updatedAt;
    if (restaurantPfrofileUser != null) {
      map["user"] = restaurantPfrofileUser.toJson();
    }
    return map;
  }
}
