import 'package:application_1/remote_model/order_history/food_history.dart';
import 'package:application_1/remote_model/order_history/restaurant_data.dart';

import 'grocery_store.dart';
import 'product.dart';

class OrderHistoryData {
  OrderHistoryData({
    this.id,
    this.orderNo,
    this.userId,
    this.restaurantId,
    this.grocerId,
    this.transactionId,
    this.categoryId,
    this.addressId,
    this.productId,
    this.foodId,
    this.type,
    this.status,
    this.address,
    this.description,
    this.price,
    this.totalAmount,
    this.quantity,
    this.discount,
    this.paymentType,
    this.paymentStatus,
    this.createdAt,
    this.updatedAt,
    this.product,
    this.groceryStore,
    this.foodHistory,
    this.restaurantData,
  });

  OrderHistoryData.fromJson(dynamic json) {
    id = json['id'];
    product =
        json['product'] != null ? Product.fromJson(json['product']) : null;
    groceryStore = json['grocery_store'] != null
        ? GroceryStore.fromJson(json['grocery_store'])
        : null;
    foodHistory =
        json['food'] != null ? FoodHistory.fromJson(json['food']) : null;
    restaurantData = json['restaurant'] != null
        ? RestaurantData.fromJson(json['restaurant'])
        : null;
    orderNo = json['order_no'];
    userId = json['user_id'];
    restaurantId = json['restaurant_id'];
    grocerId = json['grocer_id'];
    transactionId = json['transaction_id'];
    categoryId = json['category_id'];
    addressId = json['address_id'];
    productId = json['product_id'];
    foodId = json['food_id'];
    type = json['type'];
    status = json['status'];
    address = json['address'];
    description = json['description'];
    price = json['price'];
    totalAmount = json['total_amount'];
    quantity = json['quantity'];
    discount = json['discount'];
    paymentType = json['payment_type'];
    paymentStatus = json['payment_status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  var id;
  var orderNo;
  var userId;
  dynamic restaurantId;
  var grocerId;
  dynamic transactionId;
  dynamic categoryId;
  var addressId;
  var productId;
  dynamic foodId;
  var type;
  var status;
  var address;
  dynamic description;
  var price;
  var totalAmount;
  var quantity;
  dynamic discount;
  var paymentType;
  var paymentStatus;
  var createdAt;
  var updatedAt;
  var product;
  var groceryStore;
  var foodHistory;
  var restaurantData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['order_no'] = orderNo;
    map['user_id'] = userId;
    map['restaurant_id'] = restaurantId;
    map['grocer_id'] = grocerId;
    map['transaction_id'] = transactionId;
    map['category_id'] = categoryId;
    map['address_id'] = addressId;
    map['product_id'] = productId;
    map['food_id'] = foodId;
    map['type'] = type;
    map['status'] = status;
    map['address'] = address;
    map['description'] = description;
    map['price'] = price;
    map['total_amount'] = totalAmount;
    map['quantity'] = quantity;
    map['discount'] = discount;
    map['payment_type'] = paymentType;
    map['payment_status'] = paymentStatus;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    if (product != null) {
      map['product'] = product.toJson();
    }
    if (groceryStore != null) {
      map['grocery_store'] = groceryStore.toJson();
    }
    return map;
  }
}
