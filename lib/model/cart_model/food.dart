class Food {
  var id;
  var restaurantId;
  dynamic grocerId;
  dynamic categoryId;
  var type;
  var name;
  dynamic discountPrice;
  var price;
  dynamic quantity;
  var description;
  dynamic image;
  var status;
  dynamic createdAt;
  dynamic updatedAt;

  Food({
      this.id, 
      this.restaurantId, 
      this.grocerId, 
      this.categoryId, 
      this.type, 
      this.name, 
      this.discountPrice, 
      this.price, 
      this.quantity, 
      this.description, 
      this.image, 
      this.status, 
      this.createdAt, 
      this.updatedAt});

  Food.fromJson(dynamic json) {
    id = json["id"];
    restaurantId = json["restaurant_id"];
    grocerId = json["grocer_id"];
    categoryId = json["category_id"];
    type = json["type"];
    name = json["name"];
    discountPrice = json["discount_price"];
    price = json["price"];
    quantity = json["quantity"];
    description = json["description"];
    image = json["image"];
    status = json["status"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["restaurant_id"] = restaurantId;
    map["grocer_id"] = grocerId;
    map["category_id"] = categoryId;
    map["type"] = type;
    map["name"] = name;
    map["discount_price"] = discountPrice;
    map["price"] = price;
    map["quantity"] = quantity;
    map["description"] = description;
    map["image"] = image;
    map["status"] = status;
    map["created_at"] = createdAt;
    map["updated_at"] = updatedAt;
    return map;
  }

}