import 'package:application_1/AllPages/ExplorePages/grocer_menu.dart';
import 'package:application_1/AllPages/ExplorePages/shopMenu.dart';
import 'package:application_1/AllPages/grocery/controllers/grocery_controller.dart';
import 'package:application_1/model/rest_food/restaurant_food_data.dart';
import 'package:application_1/restaurant_controller/cart_controller.dart';
import 'package:application_1/restaurant_widgets/build_menu_widget.dart';
import 'package:application_1/restaurant_widgets/cart_widget.dart';
import 'package:application_1/reuseableWidgets/reuseableRatingButton.dart';
import 'package:application_1/reuseableWidgets/reuseableSizedbox.dart';
import 'package:application_1/utils/AppColors.dart';
import 'package:application_1/utils/api_utils.dart';
import 'package:application_1/utils/widgest_utills.dart';
import 'package:application_1/widgets/custom_container.dart';
import 'package:application_1/widgets/text_with_icon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GrocerMenu extends StatelessWidget {
  GroceryController _controller = Get.find();
  CartController _cartController = Get.find();
  List<Widget> pageList = [];
  PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    _controller.firstInit = false;
    if (!_controller.firstInit) {
      pageList.clear();
      _controller.firstInit = true;
      List list = _controller.restaurantFoodModel.value.restaurantFoodData;
      List<RestaurantFoodData> mostOrder = [];

      for (int index = 0; index < list.length; index++) {
        RestaurantFoodData value = list[index];
        if (value.totalOrder > 0) {
          mostOrder.add(value);
        }
      }

      if (mostOrder.isNotEmpty) {
        mostOrder.sort((a, b) => a.totalOrder.compareTo(b.totalOrder));
      }
      for (int index = 0; index < mostOrder.length; index++) {
        BuildMenuWidget item = BuildMenuWidget(
          hide: true,
          controller: _controller,
          cartController: _cartController,
          index: index,
          value: mostOrder[index],
        );
        pageList.add(item);
      }
    }
    Size size = MediaQuery.of(context).size;
    double w = size.width;
    double h = size.height;
    return SafeArea(
      child: Scaffold(
        body: WillPopScope(
          onWillPop: () async {
            Get.back();
            return true;
          },
          child: Obx(
            () => Stack(
              alignment: Alignment.bottomRight,
              children: [
                Container(
                  color: Colors.white12,
                  child: Obx(() => Column(
                        children: [
                          CustomContainer(
                            width: Get.width,
                            marginBottom: 12,
                            child: Column(
                              children: [
                                Container(
                                  width: w,
                                  height: h * 0.335,
                                  child: Stack(
                                    children: [
                                      networImage(w, h),
                                      Container(
                                        width: w,
                                        alignment: Alignment.bottomLeft,
                                        height: h * 0.26,
                                        color: Colors.black.withOpacity(0.4),
                                      ),
                                      Container(
                                        width: w,
                                        height: h * 0.335,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            TextWithIcon(
                                              icon: Icon(
                                                Icons.location_on_outlined,
                                                color: Colors.grey[400],
                                              ),
                                              marginLeft: 24,
                                              title:
                                                  "${_controller.restaurantProfileModel.value.restaurantPfrofileData.address}",
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14,
                                            ),
                                            TextWithIcon(
                                              icon: Icon(
                                                Icons.access_time_outlined,
                                                color: Colors.grey[400],
                                              ),
                                              marginLeft: 24,
                                              title: "Open now",
                                              fontColor: AppColors.appGreen,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: w,
                                        height: h * 0.26,
                                        child: CustomContainer(
                                          marginLeft: 24,
                                          marginBottom: 24,
                                          alignment: Alignment.bottomLeft,
                                          marginRight: 32,
                                          height: h * 0.26,
                                          child: Text(
                                            "${_controller.restaurantProfileModel.value.restaurantPfrofileData.name}",
                                            style: TextStyle(
                                                fontSize: 28,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Align(
                                          alignment: Alignment.topLeft,
                                          child: IconButton(
                                              icon: Icon(
                                                Icons.arrow_back,
                                                size: 24,
                                                color: Colors.white,
                                              ),
                                              onPressed: () {
                                                Get.back();
                                              }),
                                        ),
                                      ),
                                      Align(
                                          alignment: Alignment.topRight,
                                          child: CustomContainer(
                                            height: 48,
                                            width: 48,
                                            marginTop: h * 0.22,
                                            allRadius: 48,
                                            marginRight: 24,
                                            child: Icon(
                                              Icons.favorite_border,
                                              color: Colors.white,
                                            ),
                                            color: AppColors.blue,
                                          )
                                          // Container(
                                          //   width: w * 0.312,
                                          //   height: w * 0.312,
                                          //   decoration: BoxDecoration(
                                          //       shape: BoxShape.circle,
                                          //       image: DecorationImage(
                                          //           image: AssetImage(
                                          //               "assets/image 2x/shopProfile.png"))),
                                          // ),
                                          ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          getMostOrder(context),
                          CustomContainer(),
                          // Container(
                          //   width: w,
                          //   child: Column(
                          //     children: [
                          //       Row(
                          //         children: [
                          //           Expanded(
                          //             child: Container(
                          //               alignment: Alignment.centerLeft,
                          //               width: w,
                          //               margin: EdgeInsets.only(left: 16),
                          //               height: 20,
                          //               child: Text(
                          //                 "Menu",
                          //                 style: TextStyle(
                          //                     fontSize: 18,
                          //                     fontWeight: FontWeight.w500),
                          //               ),
                          //             ),
                          //           ),
                          //           // CustomContainer(
                          //           //   alignment: Alignment.centerLeft,
                          //           //   marginRight: 16,
                          //           //   height: 20,
                          //           //   onTap: () {
                          //           //     Get.to(() => RestaurantAllScreen());
                          //           //   },
                          //           //   child: Text(
                          //           //     "See All",
                          //           //     style: TextStyle(
                          //           //         fontSize: 18,
                          //           //         color: blue,
                          //           //         fontWeight: FontWeight.w500),
                          //           //   ),
                          //           // ),
                          //         ],
                          //       ),
                          //       Container(
                          //         width: w,
                          //         height: w * 0.82,
                          //         child: ListView.builder(
                          //           itemCount: _controller.restaurantFoodModel
                          //               .value.restaurantFoodData.length,
                          //           scrollDirection: Axis.horizontal,
                          //           itemBuilder:
                          //               (BuildContext context, int index) {
                          //             return BuildMenuWidget(
                          //               controller: _controller,
                          //               cartController: _cartController,
                          //               index: index,
                          //               value: _controller.restaurantFoodModel
                          //                   .value.restaurantFoodData[index],
                          //             );
                          //           },
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                        ],
                      )),
                ),
                CustomContainer(
                    width: 0,
                    height: 0,
                    child: Text("${_cartController.foodCart.value.foodCart}")),
                CartWidget(
                  cartController: _cartController,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container buildCardContainer(
    double w,
    BuildContext context,
    double h,
    String image,
    title,
  ) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: w * 0.558,
            height: w * 0.34,
            child: Image(
              fit: BoxFit.fill,
              image: AssetImage(image),
            ),
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.headline6,
          ),
          BuildSizedBox(5),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: w * 0.558,
                height: w * 0.08,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ReuseableRatingButton(
                      w: w,
                      h: h,
                      txt: "4.5",
                      onTap: (){},
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      padding: EdgeInsets.all(3),
                      alignment: Alignment.center,
                      width: w * 0.19,
                      height: w * 0.08,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15), color: blue),
                      child: Text(
                        "1500 PKR",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: white, fontSize: w <= 360 ? 12 : 14),
                      ),
                    ),
                  ],
                ),
              ),
              BuildSizedBox(5),
              GestureDetector(
                onTap: () {
                  // Get.to(Cart());
                },
                child: Container(
                  padding: EdgeInsets.all(1),
                  alignment: Alignment.center,
                  width: w * 0.33,
                  height: w * 0.065,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15), color: green),
                  child: Text(
                    "ADD to Cart",
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(color: white, fontSize: w <= 360 ? 12 : 14),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  getMostOrder(context) {
    List list = _controller.restaurantFoodModel.value.restaurantFoodData;
    List<RestaurantFoodData> mostOrder = [];

    for (int index = 0; index < list.length; index++) {
      RestaurantFoodData value = list[index];
      if (value.totalOrder > 0) {
        mostOrder.add(value);
      }
    }

    if (mostOrder.isNotEmpty) {
      mostOrder.sort((a, b) => a.totalOrder.compareTo(b.totalOrder));
    }

    var w = Get.width;
    var h = Get.height;
    return Column(
      children: [
        mostOrder.isEmpty
            ? emptyContainer()
            : Container(
                width: w,
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 15),
                      alignment: Alignment.centerLeft,
                      width: w,
                      height: 20,
                      child: Text(
                        "Featured Items",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Container(
                        width: w,
                        height: w * 0.6,
                        child:
                            // ListView(
                            //                 scrollDirection: Axis.horizontal,
                            //                 children: [
                            // for (int index = 0; index < mostOrder.length; index++)
                            PageView(
                          controller: _pageController,
                          children: pageList,
                          onPageChanged: (index) {
                            _controller.currentIndex(index);
                            _controller.currentIndex.refresh();
                          },
                        )
                        //   ],
                        // ),
                        ),
                    CustomContainer(
                      width: Get.width,
                      child: getIndicators(),
                    ),
                  ],
                ),
              ),
        TextWithIcon(
          width: Get.width,
          height: 48,
          marginLeft: 24,
          marginRight: 24,
          allRadius: 6,
          marginTop: 24,
          fontSize: 18,
          fontColor: Colors.white,
          bgColor: AppColors.appBlue,
          title: "See Menu",
          containerClick: () {
            _controller.createMenus();
            Get.to(() => StoreListMenu());
          },
        )
      ],
    );
  }

  getIndicators() {
    List list = _controller.restaurantFoodModel.value.restaurantFoodData;
    List<RestaurantFoodData> mostOrder = [];

    for (int index = 0; index < list.length; index++) {
      RestaurantFoodData value = list[index];
      if (value.totalOrder > 0) {
        mostOrder.add(value);
      }
    }

    if (mostOrder.isNotEmpty) {
      mostOrder.sort((a, b) => a.totalOrder.compareTo(b.totalOrder));
    }

    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (int index = 0; index < mostOrder.length; index++)
            CustomContainer(
              marginLeft: index == 0 ? 0 : 8,
              width: 24,
              height: 24,
              allRadius: 24,
              borderColor: Colors.black,
              borderWidth: 1,
              color: _controller.currentIndex.value == index
                  ? AppColors.appBlue
                  : white,
            )
        ],
      ),
    );
  }

  networImage(w, h) {
    String url = _controller
            .restaurantProfileModel.value.restaurantPfrofileData.coverImage ??
        "";
    return Container(
        width: w,
        height: h * 0.26,
        child: cacheNetworkImage(
            imageWidth: w,
            imageHeight: h * 0.26,
            imageUrl: "${ApiUtills.imageBaseUrl}$url"));
  }
}

/*
import 'package:application_1/AllPages/ExplorePages/shopMenu.dart';
import 'package:application_1/AllPages/grocery/controllers/grocery_controller.dart';
import 'package:application_1/model/rest_food/restaurant_food_data.dart';
import 'package:application_1/restaurant_controller/cart_controller.dart';
import 'package:application_1/restaurant_widgets/build_menu_widget.dart';
import 'package:application_1/restaurant_widgets/cart_widget.dart';
import 'package:application_1/reuseableWidgets/reuseableRatingButton.dart';
import 'package:application_1/reuseableWidgets/reuseableSizedbox.dart';
import 'package:application_1/utils/widgest_utills.dart';
import 'package:application_1/widgets/custom_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GrocerMenu extends StatelessWidget {
  GroceryController _controller = Get.find();
  CartController _cartController = Get.find();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double w = size.width;
    double h = size.height;
    return SafeArea(
      child: Scaffold(
        body: Obx(() => Stack(
              alignment: Alignment.bottomRight,
              children: [
                SingleChildScrollView(
                  child: Container(
                    color: Colors.white12,
                    child: Obx(() => Column(
                          children: [
                            CustomContainer(
                              width: Get.width,
                              marginBottom: 12,
                              child: Column(
                                children: [
                                  Container(
                                    width: w,
                                    height: h * 0.305,
                                    child: Stack(
                                      children: [
                                        Container(
                                          width: w,
                                          height: h * 0.26,
                                          child: Image(
                                            fit: BoxFit.cover,
                                            image: AssetImage(
                                                "assets/image 2x/shopBackground.png"),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Align(
                                            alignment: Alignment.topRight,
                                            child: IconButton(
                                                icon: Icon(
                                                  Icons.close,
                                                  size: 24,
                                                  color: Colors.white,
                                                ),
                                                onPressed: () {
                                                  Get.back();
                                                }),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Container(
                                            width: w * 0.312,
                                            height: w * 0.312,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                    image: AssetImage(
                                                        "assets/image 2x/shopProfile.png"))),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Column(
                                      children: [
                                        BuildSizedBox(10),
                                        Text(
                                          "${_controller.restaurantProfileModel.value.restaurantPfrofileData.name}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6,
                                        ),
                                        BuildSizedBox(5),
                                        Text(
                                          "${_controller.restaurantProfileModel.value.restaurantPfrofileData.address}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w300,
                                              fontSize: 14),
                                        ),
                                        BuildSizedBox(5),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            mostOrderList(context, w, h),
                            Container(
                              width: w,
                              child: Column(
                                children: [
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    width: w,
                                    margin: EdgeInsets.only(left: 16),
                                    height: 20,
                                    child: Text(
                                      "Menu",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  Container(
                                    width: w,
                                    height: w * 0.92,
                                    child: ListView.builder(
                                      itemCount: _controller.restaurantFoodModel
                                          .value.restaurantFoodData.length,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return BuildMenuWidget(
                                            controller: _controller,
                                            cartController: _cartController,
                                            index: index,
                                            value: _controller
                                                .restaurantFoodModel
                                                .value
                                                .restaurantFoodData[index]);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )),
                  ),
                ),
                CustomContainer(
                    width: 0,
                    height: 0,
                    child: Text("${_cartController.foodCart.value.foodCart}")),
                CartWidget(
                  cartController: _cartController,
                ),
              ],
            )),
      ),
    );
  }

  Container buildCardContainer(
    double w,
    BuildContext context,
    double h,
    String image,
    title,
  ) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: w * 0.558,
            height: w * 0.34,
            child: Image(
              fit: BoxFit.fill,
              image: AssetImage(image),
            ),
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.headline6,
          ),
          BuildSizedBox(5),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: w * 0.558,
                height: w * 0.08,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ReuseableRatingButton(
                      w: w,
                      h: h,
                      txt: "4.5",
                      onTap: null,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      padding: EdgeInsets.all(3),
                      alignment: Alignment.center,
                      width: w * 0.19,
                      height: w * 0.08,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15), color: blue),
                      child: Text(
                        "1500 PKR",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: white, fontSize: w <= 360 ? 12 : 14),
                      ),
                    ),
                  ],
                ),
              ),
              BuildSizedBox(5),
              GestureDetector(
                onTap: () {
                  // Get.to(Cart());
                },
                child: Container(
                  padding: EdgeInsets.all(1),
                  alignment: Alignment.center,
                  width: w * 0.33,
                  height: w * 0.065,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15), color: green),
                  child: Text(
                    "ADD to Cart",
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(color: white, fontSize: w <= 360 ? 12 : 14),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  mostOrderList(BuildContext context, double w, double h) {
    List list = _controller.restaurantFoodModel.value.restaurantFoodData;
    List<RestaurantFoodData> mostOrder = [];

    for (int index = 0; index < list.length; index++) {
      RestaurantFoodData value = list[index];
      if (value.totalOrder > 0) {
        mostOrder.add(value);
      }
    }

    if (mostOrder.isNotEmpty) {
      mostOrder.sort((a, b) => a.totalOrder.compareTo(b.totalOrder));
    }

    return mostOrder.isEmpty
        ? emptyContainer()
        : Container(
            width: w,
            height: w * 0.90,
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  width: w,
                  margin: EdgeInsets.only(left: 15),
                  height: 20,
                  child: Text(
                    "Most Ordered",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ),
                Container(
                  width: w,
                  height: w * 0.82,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      for (int index = 0; index < mostOrder.length; index++)
                        BuildMenuWidget(
                          hide: true,
                          controller: _controller,
                          cartController: _cartController,
                          index: index,
                          value: mostOrder[index],
                        )
                    ],
                  ),
                ),
              ],
            ),
          );
  }
}
*/
