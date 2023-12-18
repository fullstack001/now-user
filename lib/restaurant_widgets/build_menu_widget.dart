import 'package:application_1/AllPages/ExplorePages/shopMenu.dart';
import 'package:application_1/model/cart_model/food_cart.dart';
import 'package:application_1/model/rest_food/restaurant_food_data.dart';
import 'package:application_1/restaurant_controller/cart_controller.dart';
import 'package:application_1/restaurant_widgets/cart_add_remove_widget.dart';
import 'package:application_1/reuseableWidgets/reuseableSizedbox.dart';
import 'package:application_1/utils/api_utils.dart';
import 'package:application_1/utils/widgest_utills.dart';
import 'package:application_1/widgets/custom_container.dart';
import 'package:application_1/widgets/rating_start.dart';
import 'package:application_1/widgets/text_with_icon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BuildMenuWidget extends StatelessWidget {
  final controller;
  final  cartController;
  final hide;
  final index;
  final  value;

  BuildMenuWidget({
    this.index,
    this.hide = false,
    this.controller,
    this.cartController,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    String imagePath = "${ApiUtills.imageBaseUrl + (value.image ?? "")}";
    String urlPath = value.image ?? "";
    var w = Get.width;
    var h = Get.height;
    int sizes = controller.restaurantList.length;
    return Obx(() => CustomContainer(
          width: Get.width,
          // color: Colors.white,
          allRadius: 12,
          marginTop: 12,
          marginLeft: 12,
          marginRight: index == sizes - 1 ? 0 : 12,
          // shadowColor: Colors.black.withOpacity(0.5),
          // shadowOffsetY: 3,
          // shadowOffsetX: 3,
          // shadowBlurRadius: 6,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              urlPath.isEmpty
                  ? Image(
                      image: AssetImage("assets/images/img_photo.png"),
                      height: Get.height * 0.10,
                      width: Get.height * 0.13,
                    )
                  : cacheNetworkImage(
                      imageUrl: "$imagePath",
                      radius: 12,
                      imageWidth: Get.width,
                      imageHeight: Get.width * 0.34,
                      placeHolder: "assets/images/img_photo.png",
                    ),
              BuildSizedBox(7),
              Row(
                children: [
                  Expanded(
                    child: TextWithIcon(
                      marginLeft: 12,
                      title: "${value.name}",
                      width: Get.width,
                      fontSize: 20,
                      flex: 1,
                      fontColor: Colors.black,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Container(
                    child: RatingStar(
                      rating: 3.6,
                      size: 24,
                      color: Colors.yellow,
                    ),
                  )
                ],
              ),
              BuildSizedBox(5),
              TextWithIcon(
                marginLeft: 12,
                marginRight: 12,
                marginBottom: 12,
                title: "\$${value.price}",
                fontSize: 14,
                width: Get.width,
                maxLine: 2,
                overFlow: TextOverflow.ellipsis,
                flex: 1,
                fontColor: Colors.black,
                fontWeight: FontWeight.w200,
              ),
              TextWithIcon(
                height: 0,
                width: 0,
                title: cartController.foodCart.value.foodCart ?? [],
              ),
              hide
                  ? Container(
                      height: 0,
                    )
                  : Container(
                      child: isEmpty(
                              cartController.foodCart.value.foodCart ?? [],
                              value.id)
                          ? TextWithIcon(
                              marginTop: 12,
                              bgColor: green,
                              fontColor: Colors.white,
                              paddingTop: 5,
                              width: Get.width,
                              paddingBottom: 5,
                              paddingLeft: 32,
                              shadowColor: Colors.black.withOpacity(0.5),
                              paddingRight: 32,
                              marginLeft: 12,
                              marginRight: 12,
                              marginBottom: 12,
                              fontSize: 16,
                              allRadius: 24,
                              title: "ADD to Cart",
                              containerClick: () async {
                                cartController.generateCart(value.id);
                              },
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: CustomContainer(
                                    width: Get.width,
                                    marginRight: 32,
                                    marginLeft: 32,
                                    alignment: Alignment.center,
                                    child: CartAddRemoveWidget(
                                      cartController: cartController,
                                      id: value.id,
                                    ),
                                    marginBottom: 12,
                                    marginTop: 12,
                                  ),
                                )
                              ],
                            ),
                    )
            ],
          ),
        ));
  }

  isEmpty(List<FoodCart> foodCart, int id) {
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
}
