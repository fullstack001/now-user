class Product {
  Product({
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
    this.updatedAt,
    this.totalOrder,
    this.rating,
  });

  Product.fromJson(dynamic json) {
    id = json['id'];
    restaurantId = json['restaurant_id'];
    grocerId = json['grocer_id'];
    categoryId = json['category_id'];
    type = json['type'];
    name = json['name'];
    discountPrice = json['discount_price'];
    price = json['price'];
    quantity = json['quantity'];
    description = json['description'];
    image = json['image'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    totalOrder = json['total_order'];
    rating = json['rating'];
  }
  var id;
  dynamic restaurantId;
  var grocerId;
  dynamic categoryId;
  var type;
  var name;
  dynamic discountPrice;
  var price;
  var quantity;
  var description;
  var image;
  var status;
  var createdAt;
  var updatedAt;
  var totalOrder;
  var rating;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['restaurant_id'] = restaurantId;
    map['grocer_id'] = grocerId;
    map['category_id'] = categoryId;
    map['type'] = type;
    map['name'] = name;
    map['discount_price'] = discountPrice;
    map['price'] = price;
    map['quantity'] = quantity;
    map['description'] = description;
    map['image'] = image;
    map['status'] = status;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['total_order'] = totalOrder;
    map['rating'] = rating;
    return map;
  }
}
