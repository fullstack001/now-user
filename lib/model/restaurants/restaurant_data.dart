class RestaurantData {
  var id;
  var userId;
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
  dynamic createdAt;
  dynamic updatedAt;
  dynamic user;
  var totalOrder;
  var rating;
  var coverImage;

  RestaurantData({
    this.id,
    this.userId,
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
    this.user,
    this.totalOrder,
    this.coverImage,
    this.rating,
  });

  RestaurantData.fromJson(dynamic json) {
    id = json["id"];
    totalOrder = json['total_order'] == null ? 0 : json['total_order'];
    userId = json["user_id"];
    name = json["name"];
    address = json["address"];
    rating = json["rating"];
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
    updatedAt = json["updated_at"];
    user = json["user"];
    coverImage = json["cover_image"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["total_order"] = totalOrder;
    map["user_id"] = userId;
    map["name"] = name;
    map["rating"] = rating;
    map["cover_image"] = coverImage;
    map["address"] = address;
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
    map["user"] = user;
    return map;
  }
}
