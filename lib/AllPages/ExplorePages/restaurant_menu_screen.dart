import 'package:application_1/model/cart_model/food_cart.dart';
import 'package:application_1/model/rest_food/Categories_model.dart';
import 'package:application_1/model/rest_food/restaurant_food_data.dart';
import 'package:application_1/restaurant_controller/cart_controller.dart';
import 'package:application_1/restaurant_controller/restaurant_controller.dart';
import 'package:application_1/restaurant_widgets/cart_widget.dart';
import 'package:application_1/utils/AppColors.dart';
import 'package:application_1/utils/app_dialog_utils.dart';
import 'package:application_1/utils/widgest_utills.dart';
import 'package:application_1/widgets/custom_container.dart';
import 'package:application_1/widgets/rating_start.dart';
import 'package:application_1/widgets/text_with_icon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RestaurantMenuScreen extends StatelessWidget {
  RestaurantMenuScreen({Key? key}) : super(key: key);
  RestaurantController _controller = Get.find();
  CartController cartController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Menu",
          style: TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 25,
          ),
        ),
      ),
      body: SafeArea(
        child: Obx(() => Stack(
              alignment: Alignment.bottomRight,
              children: [
                Column(
                  children: [
                    CustomContainer(
                      marginTop: 12,
                      marginRight: 24,
                      marginLeft: 24,
                      width: Get.width,
                      height: 50,
                      child: Card(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                  icon: Icon(Icons.search), onPressed: () {}),
                              Expanded(
                                child: TextFormField(
                                  keyboardType: TextInputType.text,
                                  onChanged: (value) {
                                    if (value.isEmpty) {
                                      if (_controller.selectedMenu == -1) {
                                        _controller.menuFilterList.clear();
                                        _controller.menuFilterList.refresh();
                                      } else {
                                        filterByMenu(_controller.selectedMenu
                                            .toString());
                                      }
                                    } else {
                                      filterMenue(value);
                                    }
                                  },
                                  decoration: InputDecoration(
                                      filled: true,
                                      hintText: "Search service you want..",
                                      hintStyle: TextStyle(
                                          height: 1,
                                          fontSize: 14,
                                          color: Colors.grey.shade500),
                                      fillColor: Colors.white10,
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide.none)),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: Container(
                                  width: Get.width * 0.055,
                                  height: Get.width * 0.055,
                                  child: Image(
                                    image: AssetImage(
                                      "assets/image 1.5x/preference.png",
                                    ),
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        for (int index = 0;
                            index <
                                (_controller.restaurantFoodModel.value
                                            .categoriesModel ??
                                        [])
                                    .length;
                            index++)
                          menuItem(index)
                      ],
                    ),
                    Expanded(
                        child: CustomContainer(
                      width: Get.width,
                      height: Get.height,
                      child: isListEmpty(_controller.selectedMenu.toString())
                          ? TextWithIcon(
                              width: Get.width,
                              height: Get.height,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              title: "Food item available",
                            )
                          : ListView.builder(
                              itemCount: getCount(),
                              itemBuilder: (BuildContext context, int index) {
                                List list = getList();
                                RestaurantFoodData value = list[index];
                                return menuListItem(index, value);
                              },
                            ),
                    ))
                  ],
                ),
                CartWidget(
                  cartController: cartController,
                )
              ],
            )),
      ),
    );
  }

  isEmpty(List foodCart, int id) {
    if (foodCart.isEmpty) {
      return true;
    }
    for (int index = 0; index < foodCart.length; index++) {
      FoodCart value = foodCart[index];
      if (value.foodId == id) {
        return false;
      } else if (value.productId == id) {
        return false;
      }
    }

    return true;
  }

  removeFromCart(List foodCart, var id) {
    for (int index = 0; index < foodCart.length; index++) {
      FoodCart value = foodCart[index];
      print("${value.id}");
    }
  }

  Widget menuListItem(int index, RestaurantFoodData value) {
    return CustomContainer(
      width: Get.width,
      marginLeft: 24,
      alignment: Alignment.centerLeft,
      marginRight: 24,
      marginTop: index == 0 ? 18 : 9,
      child: Obx(() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (index != 0) Divider(),
              if (index != 0)
                SizedBox(
                  height: 9,
                ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  cacheNetworkImage(
                      imageUrl: "image",
                      radius: 12,
                      imageWidth: 100,
                      imageHeight: 100,
                      placeHolder: "assets/images/img_photo.png"),
                  Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: TextWithIcon(
                              marginLeft: 8,
                              flex: 1,
                              width: Get.width,
                              maxLine: 1,
                              overFlow: TextOverflow.ellipsis,
                              title: "${value.name}",
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        flex: 0,
                        child: TextWithIcon(
                          width: Get.width,
                          alignment: MainAxisAlignment.start,
                          containerAlignment: Alignment.topLeft,
                          height: 40,
                          flex: 1,
                          maxLine: 2,
                          overFlow: TextOverflow.ellipsis,
                          marginLeft: 8,
                          title: "${value.description}",
                          fontSize: 16,
                          fontColor: Color(0xff757575),
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      RatingStar(
                        size: 24,
                        rating: 4.0,
                        color: Colors.yellow,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextWithIcon(
                            marginLeft: 8,
                            title: "\$${value.price}",
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),

                          !isEmpty(cartController.foodCart.value.foodCart ?? [],
                                  value.id)
                              ? CustomContainer(
                                  width: 32,
                                  allRadius: 32,
                                  height: 32,
                                  onTap: () {
                                    alertDialog(
                                      title: "Alert",
                                      content:
                                          "Do you want to remove it from cart?",
                                      confirm: MaterialButton(
                                        onPressed: () {
                                          print("");
                                          deleteItem(value);
                                        },
                                        child: Text("Yes"),
                                      ),
                                      cancel: MaterialButton(
                                        onPressed: () {
                                          Get.back();
                                        },
                                        child: Text("No"),
                                      ),
                                    );
                                  },
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                  ),
                                  color: Colors.red,
                                )
                              : CustomContainer(
                                  onTap: () {
                                    cartController.generateCart(value.id);
                                    cartController.foodCart.refresh();
                                  },
                                  width: 32,
                                  height: 32,
                                  allRadius: 32,
                                  color: AppColors.appBlue,
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ),
                                )
                        ],
                      ),
                    ],
                  ))
                ],
              )
            ],
          )),
    );
  }

  getId(List foodCart, id) {
    for (int index = 0; index < foodCart.length; index++) {
      if (foodCart[index].foodId == id) {
        return foodCart[index].id;
      }
    }
    return -1;
  }

  void deleteItem(RestaurantFoodData value) {
    var id = getId(cartController.foodCart.value.foodCart, value.id);
    if (id != -1) {
      cartController.deleteItem(id, onItemDelete: (value) {
        removeFromCart(cartController.foodCart.value.foodCart, id);
        cartController.summaryList.refresh();
      });
      Get.back();
    }
  }

  void filterMenue(String value) {
    List restaurantFoodData =
        _controller.restaurantFoodModel.value.restaurantFoodData;
    _controller.menuFilterList.value.clear();
    for (int index = 0; index < restaurantFoodData.length; index++) {
      RestaurantFoodData valueX = restaurantFoodData[index];
      if (valueX.name.toLowerCase().contains(value.toLowerCase())) {
        if (_controller.selectedMenu.toString() ==
            valueX.categoryId.toString()) {
          _controller.menuFilterList.value.add(valueX);
        } else if (_controller.selectedMenu == -1) {
          _controller.menuFilterList.value.add(valueX);
        }
        _controller.menuFilterList.refresh();
      }
    }
  }

  getCount() {
    if (_controller.menuFilterList.isNotEmpty) {
      return _controller.menuFilterList.length;
    }
    return _controller.restaurantFoodModel.value.restaurantFoodData.length;
  }

  List getList() {
    if (_controller.menuFilterList.isNotEmpty) {
      return _controller.menuFilterList;
    }
    return _controller.restaurantFoodModel.value.restaurantFoodData;
  }

  menuItem(int index) {
    CategoriesModel value =
        _controller.restaurantFoodModel.value.categoriesModel[index];
    return CustomContainer(
      marginLeft: index == 0 ? 24 : 12,
      marginTop: 12,
      child: TextWithIcon(
        bgColor: value.selected ? AppColors.appBlue : Colors.white,
        title: "${value.name}",
        fontColor: value.selected ? AppColors.white : Colors.black,
        shadowOffsetY: 3,
        shadowOffsetX: 3,
        paddingLeft: 18,
        paddingRight: 18,
        paddingTop: 8,
        allRadius: 12,
        fontSize: 15,
        paddingBottom: 8,
        shadowSpreadRadius: 1,
        shadowBlurRadius: 4,
        shadowColor: Colors.black.withOpacity(0.5),
        containerClick: () {
          for (int i = 0;
              i < _controller.restaurantFoodModel.value.categoriesModel.length;
              i++) {
            _controller.restaurantFoodModel.value.categoriesModel[i].selected =
                false;
          }
          _controller
              .restaurantFoodModel.value.categoriesModel[index].selected = true;
          _controller.selectedMenu =
              value.name.toLowerCase() == "all" ? -1 : value.id ?? -2;
          filterByMenu((value.id ?? -6).toString());
          _controller.restaurantFoodModel.refresh();
        },
      ),
    );
  }

  void filterByMenu(String value) {
    _controller.menuFilterList.clear();
    List restaurantFoodData =
        _controller.restaurantFoodModel.value.restaurantFoodData;
    for (int index = 0; index < restaurantFoodData.length; index++) {
      RestaurantFoodData values = restaurantFoodData[index];
      if (values.categoryId.toString() == value) {
        _controller.menuFilterList.value.add(values);
      }
    }
    _controller.menuFilterList.refresh();
  }

  isListEmpty(String value) {
    List restaurantFoodData =
        _controller.restaurantFoodModel.value.restaurantFoodData;
    if (_controller.selectedMenu == -1) {
      return restaurantFoodData.isEmpty;
    }
    for (int index = 0; index < _controller.menuFilterList.length; index++) {
      RestaurantFoodData values = _controller.menuFilterList[index];
      if (values.categoryId.toString() == value) {
        return false;
      }
    }
    return true;
  }
}
