import 'package:application_1/AllPages/ExplorePages/cart.dart';
import 'package:application_1/restaurant_controller/cart_controller.dart';
import 'package:application_1/utils/AppColors.dart';
import 'package:application_1/utils/api_utils.dart';
import 'package:application_1/utils/widgest_utills.dart';
import 'package:application_1/widgets/custom_container.dart';
import 'package:application_1/widgets/text_with_icon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartWidget extends StatelessWidget {
  final  cartController;

  CartWidget({this.cartController});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Stack(
          alignment: Alignment.topRight,
          children: [
            getCount(shopType) == 0
                ? emptyContainer()
                : CustomContainer(
                    width: 80,
                    height: 80,
                    marginAll: 24,
                    allRadius: 60,
                    paddingAll: 10,
                    child: CustomContainer(
                      width: 80,
                      height: 80,
                      allRadius: 60,
                      shadowColor: Colors.black.withOpacity(0.5),
                      shadowSpreadRadius: 3,
                      shadowBlurRadius: 5,
                      shadowOffsetX: 3,
                      shadowOffsetY: 3,
                      color: AppColors.appBlue,
                      child: Icon(
                        Icons.shopping_cart_outlined,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                  ),
            getCount(shopType) == 0
                ? emptyContainer()
                : TextWithIcon(
                    width: 28,
                    height: 28,
                    marginAll: 28,
                    allRadius: 60,
                    title: getCount(shopType),
                    fontColor: Colors.white,
                    bgColor: AppColors.appGreen,
                    containerClick: () {
                      init = false;
                      Get.to(() => Cart());
                    },
                  ),
          ],
        ));
  }

  getCount(shopType) {
    int count = 0;
    List data = cartController.foodCart.value.foodCart ?? [];
    for (int index = 0; index < data.length; index++) {
      if (shopType == "product_id") {
        if (data[index].productId != null) {
          count = count + 1;
        }
      } else if (shopType == "food_id") {
        if (data[index].foodId != null) {
          count = count + 1;
        }
      }
    }
    return count;
  }
}
