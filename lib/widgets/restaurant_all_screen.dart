import 'package:application_1/AllPages/ExplorePages/shopMenu.dart';
import 'package:application_1/restaurant_controller/cart_controller.dart';
import 'package:application_1/restaurant_controller/restaurant_controller.dart';
import 'package:application_1/restaurant_widgets/build_menu_widget.dart';
import 'package:application_1/widgets/custom_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RestaurantAllScreen extends StatelessWidget {
  RestaurantAllScreen({Key? key}) : super(key: key);
  RestaurantController _controller = Get.find();
  CartController _cartController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back,
            size: 24,
            color: blue,
          ),
        ),
        backgroundColor: white,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Restaurants",
              style: Theme.of(context).textTheme.headline6,
            ),
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: customGridView(
              itemCount: _controller
                  .restaurantFoodModel.value.restaurantFoodData.length,
              columnSpan: 2,
              builder: (int index) {
                return CustomContainer(
                  width: Get.width,
                  alignment: Alignment.topCenter,
                  marginTop: 8,
                  child: BuildMenuWidget(
                    controller: _controller,
                    cartController: _cartController,
                    index: index,
                  ),
                );
              },
            ),
          ),
/*          gridViews(
              itemCount: 100,
              builder: (index) {
                return CustomContainer(
                  paddingAll: 8,
                  marginAll: 8,
                  color: Colors.redAccent,
                  child: Text("$index"),
                );
              }),*/
        ],
      ),
    );
  }

  customGridView({builder, itemCount, columnSpan}) {
    int count = 0;
    return Container(
      width: Get.width,
      height: Get.height,
      alignment: Alignment.topCenter,
      child: ListView(
        children: [
          for (int index = 0; index < itemCount / columnSpan; index++)
            Row(
              children: [
                for (int indexX = 0; indexX < columnSpan; indexX++, count++)
                  Expanded(child: builder(count))
              ],
            )
        ],
      ),
    );
  }
}
