import 'food.dart';

class FoodCart {
  var id;
  var objectId;
  var productId;
  var foodId;
  var quantity;
  var price;
  var createdAt;
  var updatedAt;
  var food;
  var product;
  var startTimer = false;
  var selected = true;

  FoodCart(
      {this.id,
      this.objectId,
      this.productId,
      this.foodId,
      this.quantity,
      this.price,
      this.createdAt,
      this.updatedAt,
      this.food,
      this.product});

  FoodCart.fromJson(dynamic json) {
    id = json["id"];
    objectId = json["object_id"];
    productId = json["product_id"];
    foodId = json["food_id"];
    quantity = json["quantity"];
    price = json["price"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
    food = json["food"] != null ? Food.fromJson(json["food"]) : null;
    product = json["product"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["object_id"] = objectId;
    map["product_id"] = productId;
    map["food_id"] = foodId;
    map["quantity"] = quantity;
    map["price"] = price;
    map["created_at"] = createdAt;
    map["updated_at"] = updatedAt;
    if (food != null) {
      map["food"] = food.toJson();
    }
    map["product"] = product;
    return map;
  }
}
