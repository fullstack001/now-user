class GroceryStore {
  GroceryStore({
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
    this.totalOrder,
  });

  GroceryStore.fromJson(dynamic json) {
    id = json['id'];
    userId = json['user_id'];
    name = json['name'];
    address = json['address'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    businessPhone = json['business_phone'];
    website = json['website'];
    type = json['type'];
    restaurantType = json['restaurant_type'];
    profileImage = json['profile_image'];
    about = json['about'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    totalOrder = json['total_order'];
  }
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
  var updatedAt;
  var totalOrder;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['user_id'] = userId;
    map['name'] = name;
    map['address'] = address;
    map['city'] = city;
    map['state'] = state;
    map['country'] = country;
    map['business_phone'] = businessPhone;
    map['website'] = website;
    map['type'] = type;
    map['restaurant_type'] = restaurantType;
    map['profile_image'] = profileImage;
    map['about'] = about;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['total_order'] = totalOrder;
    return map;
  }
}
