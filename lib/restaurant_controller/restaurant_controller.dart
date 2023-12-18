import 'package:application_1/AllPages/ExplorePages/shopMenu.dart';
import 'package:application_1/model/menu_types.dart';
import 'package:application_1/model/rest_food/Categories_model.dart';
import 'package:application_1/model/rest_food/restaurant_food_model.dart';
import 'package:application_1/model/restaurant_pfroile/restaurant_pfrofile_model.dart';
import 'package:application_1/model/restaurants/restaurant_model.dart';
import 'package:application_1/restaurant_controller/restaurant_respository.dart';
import 'package:application_1/utils/app_dialog_utils.dart';
import 'package:get/get.dart';

class RestaurantController extends GetxController {
  RestaurantRepository _repository = RestaurantRepository();
  var restaurantList = [].obs;
  var filterList = [].obs;
  var menuFilterList = [].obs;
  var restaurantFoodModel = RestaurantFoodModel().obs;
  var restaurantProfileModel = RestaurantProfileModel().obs;
  var firstInit = false;
  var currentIndex = 0.obs;

  var selectedMenu = -1.obs;
  var menuType = [].obs;

  getAllRestaurant() async {
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
      RestaurantFoodModel model = await _repository.getRestaurantFood(id: id);
      if (!model.error) {
        CategoriesModel models = CategoriesModel();
        models.name = "All";
        models.selected = true;
        (model.categoriesModel ?? []).insert(0, models);
        restaurantFoodModel(model);
        restaurantFoodModel.refresh();
        Get.to(() => ShopMenu());
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
