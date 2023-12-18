import 'package:application_1/model/cart_model/food_cart.dart';

class CartSummaryModel {
  var title;
  var id;
  var selected = true;

  var foodCart;

  CartSummaryModel({this.foodCart, this.title, this.id});
}
