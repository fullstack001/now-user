import 'package:application_1/model/cart_model/food_cart.dart';
import 'package:application_1/model/cart_model/food_cart_model.dart';
import 'package:application_1/restaurant_controller/restaurant_respository.dart';
import 'package:application_1/utils/app_dialog_utils.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  RestaurantRepository _repository = RestaurantRepository();

  var foodCart = FoodCartModel().obs;
  var selected = [false, false].obs;
  var summaryList = [].obs;
  var cashOnDelivery = false.obs;

  Future getCart({flag}) async {
    List cartList = foodCart.value.foodCart ?? [];
    if (cartList.isEmpty && flag) {
      AppDialogUtils.dialogLoading();
    }
    try {
      FoodCartModel model = await _repository.getFoodCart();
      if (!model.error) {
        foodCart(model);
        refresh();
        print("${foodCart.value.foodCart.length}");
      } else {
        foodCart.value = FoodCartModel();
        print("${(foodCart.value.foodCart ?? []).length}");
      }
      foodCart.refresh();
      AppDialogUtils.dismiss();
    } catch (ex) {
      AppDialogUtils.dismiss();
      print("$ex");
    }
  }

  void generateCart(int id) async {
    AppDialogUtils.dialogLoading();

    try {
      var model = await _repository.initCart(id: id);
      if (!model) {
        await getCart();
      }
      AppDialogUtils.dismiss();
    } catch (ex) {
      AppDialogUtils.dismiss();
      print("$ex");
    }
  }

  void addItem(id) {
    for (int index = 0; index < foodCart.value.foodCart.length; index++) {
      print("$index");
      FoodCart value = foodCart.value.foodCart[index];
      if (value.foodId == id || value.productId == id) {
        int qty = int.parse(value.quantity);
        qty = qty + 1;
        value.quantity = qty.toString();
        if (!value.startTimer) {
          value.startTimer = true;
          print("Start timer ${value.startTimer}");
          updateCart(value.id);
        }
        foodCart.value.foodCart[index] = value;
        foodCart.value.foodCart = foodCart.value.foodCart;
        foodCart.refresh();
      }
    }
  }

  void removeItem(id, removeAll) {
    for (int index = 0; index < foodCart.value.foodCart.length; index++) {
      print("$index");
      FoodCart value = foodCart.value.foodCart[index];
      if (value.foodId == id) {
        removeItemFromList(value, index, removeAll);
      } else if (value.productId == id) {
        removeItemFromList(value, index, removeAll);
      }
    }
  }

  removeFromCart({id}) async {
    try {
      var response = await _repository.removeFromCart(id: id);
      if (!response) {
        await getCart();
      }
    } catch (ex) {
      print("$ex");
    }
  }

  void updateCart(int id) {
    Future.delayed(Duration(seconds: 3)).then((value) async {
      for (int index = 0;
          index < (foodCart.value.foodCart ?? []).length;
          index++) {
        FoodCart value = foodCart.value.foodCart[index];
        if (value.id == id) {
          foodCart.value.foodCart[index].startTimer = false;
          print("Quantity ${value.quantity}");
          try {
            var response =
                await _repository.updateCart(qty: value.quantity, id: value.id);

            print("response $response");
          } catch (ex) {
            print("$ex");
          }

          break;
        }
      }
    });
  }

  getSubtotalPrice(List summaryList) {
    var count = 0;

    for (int index = 0; index < summaryList.length; index++) {
      bool allSelected = summaryList[index].selected;
      for (int indexX = 0;
          indexX < summaryList[index].foodCart.length;
          indexX++) {
        FoodCart cart = summaryList[index].foodCart[indexX];
        bool itemSelected = allSelected ? true : cart.selected;
        if (itemSelected) {
          if (cart.food != null) {
            count = count +
                (int.parse(cart.quantity ?? "0") * int.parse(cart.food.price));
          } else if (cart.product != null) {
            count = count +
                (int.parse(cart.quantity ?? "0") *
                    int.parse(cart.product['price']));
          }
        }
      }
    }

    return double.parse(count.toString());
  }

  void deleteItem(int id, {onItemDelete}) async {
    AppDialogUtils.dialogLoading();
    try {
      var response = await _repository.removeFromCart(id: id);
      if (!response) {
        await getCart();
        onItemDelete(true);
      }
      AppDialogUtils.dismiss();
    } catch (ex) {
      AppDialogUtils.dismiss();
      print("ex");
    }
  }

  void clear() {
    var flags = [false, false];
    selected(flags);
    selected.refresh();
  }

  void removeItemFromList(FoodCart value, index, removeAll) {
    int qty = int.parse(value.quantity);
    if (removeAll && qty == 1) {
      print("$qty");
    } else {
      qty = qty - 1;
      value.quantity = qty.toString();
    }

    if (qty == 0) {
      removeFromCart(id: value.id);
    } else {
      if (!value.startTimer) {
        value.startTimer = true;
        print("Start timer ${value.startTimer}");
        updateCart(value.id);
      }
    }
    foodCart.value.foodCart[index] = value;
    foodCart.value.foodCart = foodCart.value.foodCart;
    foodCart.refresh();
  }
}
