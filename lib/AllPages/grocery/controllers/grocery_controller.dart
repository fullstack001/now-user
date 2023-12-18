import 'package:application_1/AllPages/grocery/grocer_menu.dart';
import 'package:application_1/AllPages/grocery/repository/grocery_repository.dart';
import 'package:application_1/model/menu_types.dart';
import 'package:application_1/model/rest_food/Categories_model.dart';
import 'package:application_1/model/rest_food/restaurant_food_model.dart';
import 'package:application_1/model/restaurant_pfroile/restaurant_pfrofile_model.dart';
import 'package:application_1/model/restaurants/restaurant_model.dart';
import 'package:application_1/utils/app_dialog_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GroceryController extends GetxController {
  GroceryRepository _repository = GroceryRepository();
  var restaurantList = [].obs;
  var restaurantFoodModel = RestaurantFoodModel().obs;
  var restaurantProfileModel = RestaurantProfileModel().obs;
  var firstInit = false;
  var filterList = [].obs;
  var menuFilterList = [].obs;
  var currentIndex = 0.obs;
  var selectedMenu = -1.obs;

  var menuType = [].obs;

  Future<void> getGroceryStores() async {
    if (restaurantList.isEmpty) {
      AppDialogUtils.dialogLoading();
    }
    try {
      RestaurantModel model = await _repository.getAllRestaurants();
      if (!model.error) {
        restaurantList(model.restaurantData);
        restaurantList.refresh();
      }

      AppDialogUtils.dismiss();
    } catch (ex) {
      AppDialogUtils.dismiss();
      print("$ex");
    }
  }

  Future getRestaurantProfile({id}) async {
    AppDialogUtils.dialogLoading();

    try {
      RestaurantProfileModel model =
          await _repository.getRestaurantProfile(id: id);
      if (!model.error) {
        restaurantProfileModel(model);
      }
    } catch (ex) {
      print("$ex");
    }
  }

  getRestaurantFood({id}) async {
    try {
      RestaurantFoodModel model = await _repository.getGroceryItem(id: id);
      if (!model.error) {
        CategoriesModel models = CategoriesModel();
        models.name = "All";
        models.selected = true;
        (model.categoriesModel ?? []).insert(0, models);
        restaurantFoodModel(model);
        restaurantFoodModel.refresh();
        Get.to(() => GrocerMenu());
      } else {
        alertDialog(
          title: "Alert",
          content: "${model.message}",
          confirm: MaterialButton(
            onPressed: () {
              Get.back();
            },
            child: Text("Okay"),
          ),
        );
      }

      AppDialogUtils.dismiss();
    } catch (ex) {
      AppDialogUtils.dismiss();
      print("$ex");
    }
  }

  void createMenus() {
    MenuTypes menu1 = MenuTypes(name: "Starter", selected: true);
    MenuTypes menu2 = MenuTypes(name: "Appetizer", selected: false);
    MenuTypes menu3 = MenuTypes(name: "Main Course", selected: false);
    List<MenuTypes> list = [menu1, menu2, menu3];
    menuType(list);
    menuType.refresh();
  }
}
