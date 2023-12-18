import 'food_cart.dart';

class FoodCartModel {
  var error;
  var foodCart;
  var totalPrice;

  FoodCartModel({
      this.error, 
      this.foodCart, 
      this.totalPrice});

  FoodCartModel.fromJson(dynamic json) {
    error = json["error"];
    if (json["cart"] != null) {
      foodCart = [];
      json["cart"].forEach((v) {
        foodCart.add(FoodCart.fromJson(v));
      });
    }
    totalPrice = json["total_price"];
  }


  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["error"] = error;
    if (foodCart != null) {
      map["cart"] = foodCart.map((v) => v.toJson()).toList();
    }
    map["total_price"] = totalPrice;
    return map;
  }

}