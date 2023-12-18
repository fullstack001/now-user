import 'package:application_1/AllPages/ExplorePages/cartAddress.dart';
import 'package:application_1/AllPages/ExplorePages/shopMenu.dart';
import 'package:application_1/AllPages/grocery/controllers/grocery_controller.dart';
import 'package:application_1/AllPages/save_address_controller.dart';
import 'package:application_1/model/cart_model/cart_summary_model.dart';
import 'package:application_1/model/cart_model/food_cart.dart';
import 'package:application_1/model/restaurants/restaurant_data.dart';
import 'package:application_1/restaurant_controller/cart_controller.dart';
import 'package:application_1/restaurant_controller/restaurant_controller.dart';
import 'package:application_1/restaurant_widgets/cart_add_remove_widget.dart';
import 'package:application_1/reuseableWidgets/reuseableSizedbox.dart';
import 'package:application_1/reuseableWidgets/reuseblueButton.dart';
import 'package:application_1/utils/AppColors.dart';
import 'package:application_1/utils/api_utils.dart';
import 'package:application_1/utils/app_dialog_utils.dart';
import 'package:application_1/widgets/custom_container.dart';
import 'package:application_1/widgets/text_with_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

bool init = false;

class Cart extends StatelessWidget {
  CartController _cartController = Get.find();
  RestaurantController _restaurantController = Get.find();
  GroceryController _groceryController = Get.find();
  SaveAddressController _addressController = Get.put(SaveAddressController());

  @override
  Widget build(BuildContext context) {
    // if (!init) {
    init = true;

    _cartController
        .summaryList(createCart(_cartController.foodCart.value.foodCart));
    // }

    Size size = MediaQuery.of(context).size;
    double w = size.width;
    double h = size.height;
    print(w);
    print(h);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.close,
            size: 24,
            color: blue,
          ),
        ),
        backgroundColor: white,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Order",
              style: Theme.of(context).textTheme.headline6,
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Container(
          height: Get.height,
          child: Obx(() => Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Padding(
                  //   padding: const EdgeInsets.all(2.0),
                  //   child: buildUpperContainer(w, h),
                  // ),
                  // buildBottomContainer(w, h, context)

                  Expanded(
                      child: Container(
                    width: Get.width,
                    height: 100,
                    child: ListView(
                      children: [
                        TextWithIcon(
                          width: 0,
                          height: 0,
                          title:
                              (_cartController.foodCart.value.foodCart).length,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: buildUpperContainer(w, h),
                        ),
                      ],
                    ),
                  )),
                  CustomContainer(
                    // width: Get.width,
                    // shadowBlurRadius: 22,
                    // shadowSpreadRadius: 2,
                    // shadowOffsetY: 12,
                    // shadowColor: Colors.black.withOpacity(0.5),
                    child: buildBottomContainer(w, h, context),
                  )
                ],
              )),
        ),
      ),
    );
  }

  Container buildUpperContainer(double w, double h) {
    return Container(
      width: w,
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          CustomContainer(
            color: Colors.transparent,
            width: w * 0.918,
            child: Column(
              children: [
                for (int index = 0;
                    index < _cartController.summaryList.length;
                    index++)
                  Column(
                    children: [
                      Row(
                        children: [
                          TextWithIcon(
                            title: _cartController.summaryList[index].title,
                            fontSize: 18,
                            marginBottom: 12,
                            icon: createIcon(
                                check: _cartController
                                    .summaryList[index].selected),
                            fontWeight: FontWeight.w700,
                            onTap: () {
                              allTrue(index);
                            },
                          )
                        ],
                      ),
                      for (int indexX = 0;
                          indexX <
                              _cartController
                                      .summaryList[index].foodCart.length +
                                  0;
                          indexX++)
                        CustomContainer(
                          paddingAll: 4,
                          width: w * 0.918,
                          // color: Colors.white,
                          // marginTop: indexX == 0 ? 0 : 10,
                          // shadowColor: Colors.black.withOpacity(0.5),
                          // allRadius: 12,
                          marginBottom: indexX ==
                                  _cartController
                                          .summaryList[index].foodCart.length -
                                      1
                              ? 12
                              : 0,
                          // shadowOffsetY: 3,
                          // shadowOffsetX: 3,
                          // shadowBlurRadius: 5,
                          child: cartItem(
                            indexX,
                            _cartController.summaryList[index].foodCart,
                            _cartController.summaryList[index],
                            parentId: index,
                          ),
                        ),
                    ],
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Container buildBottomContainer(double w, double h, BuildContext context) {
    return Container(
      width: w,
      // color: white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(0),
            child: Container(
              width: w,
              // color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextWithIcon(
                    title: "Total",
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    marginLeft: 12,
                    marginTop: 12,
                    marginRight: 12,
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  CustomContainer(
                    width: Get.width,
                    height: 44,
                    paddingTop: 12,
                    marginLeft: 12,
                    marginRight: 12,
                    child: buildRow(
                      context,
                      TextWithIcon(
                        title: "Subtotal",
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                      TextWithIcon(
                        title:
                            "\$ ${_cartController.getSubtotalPrice(_cartController.summaryList.value)}",
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  //delivery
                  /* Divider(),
                  CustomContainer(
                    width: Get.width,
                    height: 44,
                    paddingTop: 12,
                    marginLeft: 12,
                    marginRight: 12,
                    child: buildRow(
                      context,
                      TextWithIcon(
                        title: "Delivery",
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                      TextWithIcon(
                        title: "\$ 5.00",
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  )*/
                ],
              ),
            ),
          ),
          Divider(),
          Container(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  buildRow(
                    context,
                    TextWithIcon(
                      title: "To Pay",
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                    TextWithIcon(
                      title:
                          "\$ ${_cartController.getSubtotalPrice(_cartController.summaryList.value)}",
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  BuildSizedBox(48),
                  ReuseableBlueButton(
                    w: w,
                    h: h,
                    text: "Checkout",
                    onTap: () {
                      _addressController.createCheckOutList();
                      bool itemSelected =
                          checkItemSelected(_cartController.summaryList.value);
                      if (itemSelected) {
                        _addressController.getCreditCard(
                            onResponseGet: () async {
                          _addressController.getAddress(
                              flag: true, onResponseGet: () {});
                          Get.to(
                              CartAddress(paymentBox: true, txt: "Continue"));
                          AppDialogUtils.dismiss();
                        });
                      } else {
                        alertDialog(
                            title: "Alert",
                            content: "Please selected atleast one item",
                            confirm: MaterialButton(
                              onPressed: () {
                                Get.back();
                              },
                              child: Text("Okay"),
                            ));
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding buildRow(BuildContext context, head, price) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [head, price],
      ),
    );
  }

  Widget buildContainer(
    int indexY,
    int val,
    String title,
    price,
    double h,
    image,
    bool selected,
    onTap,
  ) {
    return CustomContainer(
      paddingAll: 2,
      width: Get.width,
      child: Column(
        children: [
          if (indexY != 0) Divider(),
          Row(
            children: [
              InkWell(
                onTap: onTap,
                child: createIcon(check: selected),
              ),
              // CustomContainer(
              //   width: 60,
              //   height: 60,
              //   marginLeft: 12,
              //   child: cacheNetworkImage(
              //       radius: 12,
              //       imageUrl: "${ApiUtills.imageBaseUrl + (image ?? "")}",
              //       placeHolder: 'assets/images/img_photo.png'),
              // ),
              Expanded(
                child: Column(
                  children: [
                    TextWithIcon(
                      title: title,
                      fontSize: 16,
                      width: Get.width,
                      marginLeft: 12,
                      flex: 1,
                      fontColor: AppColors.black,
                    ),
                    TextWithIcon(
                      title: price,
                      marginTop: 4,
                      fontSize: 16,
                      marginLeft: 12,
                      fontColor: Colors.grey,
                    ),
                  ],
                ),
              ),
              CustomContainer(
                width: 114,
                child: CartAddRemoveWidget(
                  cartController: _cartController,
                  subBtnHeight: 28,
                  subBtnWidth: 28,
                  addBtnHeight: 28,
                  addBtnWidth: 28,
                  subBg: Colors.transparent,
                  addBg: Colors.transparent,
                  subIcon: Colors.black,
                  addIcon: Colors.black,
                  removeAll: true,
                  id: val,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  cartItem(
    int indexY,
    List foodCart,
    summaryList, {
    parentId,
  }) {
    var h = Get.height * 0.912;
    FoodCart value = foodCart[indexY];
    bool allSelected = summaryList.selected;
    bool itemSelected = allSelected ? true : foodCart[indexY].selected;
    return Slidable(
      enabled: true,
      key: ValueKey(indexY),
      endActionPane: ActionPane(
        extentRatio: 0.15,
        motion: ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (BuildContext context) {
              print("delete id: ${value.id}");
              alertDialog(
                title: "Alert",
                content: "Do you want to remove it from cart?",
                confirm: MaterialButton(
                  onPressed: () {
                    _cartController.deleteItem(value.id, onItemDelete: (value) {
                      _cartController.summaryList.value[parentId].foodCart
                          .removeAt(indexY);

                      if (_cartController
                          .summaryList.value[parentId].foodCart.isEmpty) {
                        _cartController.summaryList.value.removeAt(parentId);
                      }
                      _cartController.summaryList.refresh();
                    });
                    Get.back();
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
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            spacing: 2,
          ),
        ],
      ),
      child: Column(
        children: [
          buildContainer(
              indexY,
              value.foodId != null ? value.foodId : value.productId,
              "${value.food != null ? value.food.name : value.product['name']}",
              "\$ ${value.food != null ? value.food.price : value.product['price']}",
              h,
              value.food != null ? value.food.image : value.product['image'],
              itemSelected, () {
            print("${foodCart[indexY].id}");

            for (int index = 0;
                index < _cartController.summaryList.length;
                index++) {
              for (int indexX = 0;
                  indexX < _cartController.summaryList[index].foodCart.length;
                  indexX++) {
                FoodCart cart =
                    _cartController.summaryList[index].foodCart[indexX];
                if (cart.id == foodCart[indexY].id) {
                  _cartController.summaryList[index].foodCart[indexX].selected =
                      !cart.selected;
                }

                bool allSelected = checkAllSelected(
                    _cartController.summaryList[index].foodCart);
                _cartController.summaryList[index].selected = allSelected;
                _cartController.summaryList.refresh();
              }
            }
          }),
          /* CartAddRemoveWidget(
                    cartController: _cartController,
                  )*/
        ],
      ),
    );
  }

  void doNothing(BuildContext context) {}

  createCart(List foodCart) {
    List<CartSummaryModel> summaryList = [];
    if (shopType == "food_id") {
      summaryList = getFoodList(foodCart);
    } else if (shopType == "product_id") {
      summaryList = getGroceryList(foodCart);
    }
    return summaryList;
  }

  getPrice(FoodCart value) {
    int qty = int.parse(value.quantity);
    var result = value.price * qty;

    return double.parse(result.toString());
  }

  getRestaurant(int restaurantId) {
    for (int index = 0;
        index < _restaurantController.restaurantList.length;
        index++) {
      RestaurantData value = _restaurantController.restaurantList[index];
      if (value.id == restaurantId) {
        return value;
      }
    }
  }

  getGrocer(int restaurantId) {
    for (int index = 0;
        index < _groceryController.restaurantList.length;
        index++) {
      RestaurantData value = _groceryController.restaurantList[index];
      if (value.id == restaurantId) {
        return value;
      }
    }
  }

  bool isExist(List<CartSummaryModel> summaryList, int id) {
    for (int index = 0; index < summaryList.length; index++) {
      CartSummaryModel value = summaryList[index];
      if (value.id == id) {
        return true;
      }
    }
    return false;
  }

  createIcon({var check}) {
    return !check
        ? Icon(Icons.radio_button_off, color: AppColors.appGreen)
        : FaIcon(FontAwesome.check_circle, color: AppColors.appGreen);
  }

  bool checkAllSelected(List foodCart) {
    for (int index = 0; index < foodCart.length; index++) {
      FoodCart cart = foodCart[index];
      if (!cart.selected) {
        return false;
      }
    }
    return true;
  }

  void allTrue(int indexX) {
    _cartController.summaryList[indexX].selected =
        !_cartController.summaryList[indexX].selected;

    for (int index = 0;
        index < _cartController.summaryList[indexX].foodCart.length;
        index++) {
      _cartController.summaryList[indexX].foodCart[index].selected =
          _cartController.summaryList[indexX].selected;
    }

    _cartController.summaryList.refresh();
  }

  bool checkItemSelected(List<dynamic> value) {
    for (int index = 0; index < value.length; index++) {
      bool all = value[index].selected;
      for (int indexX = 0; indexX < value[index].foodCart.length; indexX++) {
        FoodCart cart = value[index].foodCart[indexX];
        bool item = all ? true : cart.selected;
        print("${cart.selected}");
        if (item) {
          return true;
        }
      }
    }

    return false;
  }

  List<CartSummaryModel> getFoodList(List? foodCart) {
    List<CartSummaryModel> summaryList = [];
    for (int index = 0; index < (foodCart ?? []).length; index++) {
      print("$index");
      FoodCart value = foodCart![index];
      if (value.foodId != null) {
        RestaurantData restaurant = getRestaurant(value.food.restaurantId);
        if (restaurant != null) {
          CartSummaryModel model = CartSummaryModel();
          List foodCartFilter = [];
          bool exist = isExist(summaryList, restaurant.id);
          if (!exist) {
            for (int indexX = 0; indexX < foodCart.length; indexX++) {
              FoodCart valueX = foodCart[indexX];
              if (valueX.foodId != null) {
                if (valueX.food.restaurantId == restaurant.id) {
                  foodCartFilter.add(valueX);
                }
              }
            }
            print("${restaurant.name}");
            model.id = restaurant.id;
            model.title = restaurant.name;
            model.foodCart = foodCartFilter;

            summaryList.add(model);
          }
        }
      }
    }
    return summaryList;
  }

  List<CartSummaryModel> getGroceryList(List foodCart) {
    List<CartSummaryModel> summaryList = [];
    for (int index = 0; index < (foodCart).length; index++) {
      print("$index");
      FoodCart value = foodCart[index];
      if (value.productId != null) {
        RestaurantData restaurant = getGrocer(value.product['grocer_id']);
        if (restaurant != null) {
          CartSummaryModel model = CartSummaryModel();
          List foodCartFilter = [];
          bool exist = isExist(summaryList, restaurant.id);
          if (!exist) {
            for (int indexX = 0; indexX < foodCart.length; indexX++) {
              FoodCart valueX = foodCart[indexX];
              if (valueX.productId != null) {
                if (valueX.product['grocer_id'] == restaurant.id) {
                  foodCartFilter.add(valueX);
                }
              }
            }
            print("${restaurant.name}");
            model.id = restaurant.id;
            model.title = restaurant.name;
            model.foodCart = foodCartFilter;

            summaryList.add(model);
          }
        }
      }
    }
    return summaryList;
  }
}
