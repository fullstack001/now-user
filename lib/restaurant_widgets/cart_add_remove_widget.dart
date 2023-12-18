import 'package:application_1/model/cart_model/food_cart.dart';
import 'package:application_1/restaurant_controller/cart_controller.dart';
import 'package:application_1/utils/AppColors.dart';
import 'package:application_1/widgets/custom_container.dart';
import 'package:application_1/widgets/text_with_icon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartAddRemoveWidget extends StatelessWidget {
  final  cartController;
  final id;
  final subBtnHeight;
  final subBtnWidth;
  final addBtnHeight;
  final addBtnWidth;
  final subIcon;
  final subBg;
  final addBg;
  final addIcon;
  final removeAll;

  CartAddRemoveWidget(
      {this.cartController,
      this.id,
      this.addBtnHeight,
      this.addBtnWidth,
      this.subBtnHeight,
      this.subBtnWidth,
      this.addBg,
      this.subBg,
      this.addIcon,
      this.subIcon,
      this.removeAll = false});

  @override
  Widget build(BuildContext context) {
    var subHeight = double.parse((subBtnHeight ?? 32).toString());
    var subWidth = double.parse((subBtnWidth ?? 32).toString());
    var addHeight = double.parse((addBtnHeight ?? 32).toString());
    var addWidth = double.parse((addBtnWidth ?? 32).toString());
    return Obx(() => Row(
          children: [
            CustomContainer(
              width: subWidth,
              height: subHeight,
              color: subBg ?? AppColors.appGreen,
              allRadius: 20,
              borderColor: Color(0xffb9bdc5),
              borderWidth: 1,
              onTap: () {
                cartController.removeItem(id, removeAll);
              },
              child: Icon(
                Icons.remove,
                color: Color(0xffb9bdc5),
              ),
            ),
            Expanded(
              child: TextWithIcon(
                width: Get.width,
                height: 32,
                alignment: MainAxisAlignment.center,
                containerAlignment: Alignment.center,
                title: (getItemCount(
                        cartController.foodCart.value.foodCart ?? [], id))
                    .toString()
                    .padLeft(2, "0"),
                fontSize: 18,
              ),
            ),
            CustomContainer(
              width: addWidth,
              height: addHeight,
              allRadius: 20,
              borderColor: AppColors.appBlue,
              borderWidth: 1,
              color: AppColors.appBlue,
              onTap: () {
                cartController.addItem(id);
              },
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ],
        ));
  }

  getItemCount(List list, id) {
    for (int index = 0; index < list.length; index++) {
      print("$index");
      FoodCart value = list[index];
      if (value.foodId == id) {
        return value.quantity;
      } else if (value.productId == id) {
        return value.quantity;
      }
    }

    return 0;
  }
}
