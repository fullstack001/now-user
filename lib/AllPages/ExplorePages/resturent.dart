import 'package:application_1/AllPages/ExplorePages/shopMenu.dart';
import 'package:application_1/model/rest_food/restaurant_food_model.dart';
import 'package:application_1/model/restaurants/restaurant_data.dart';
import 'package:application_1/restaurant_controller/cart_controller.dart';
import 'package:application_1/restaurant_controller/restaurant_controller.dart';
import 'package:application_1/restaurant_widgets/cart_widget.dart';
import 'package:application_1/reuseableWidgets/reuseableRatingButton.dart';
import 'package:application_1/reuseableWidgets/reuseableSizedbox.dart';
import 'package:application_1/utils/api_utils.dart';
import 'package:application_1/utils/widgest_utills.dart';
import 'package:application_1/widgets/custom_container.dart';
import 'package:application_1/widgets/custom_toolbar.dart';
import 'package:application_1/widgets/service_item.dart';
import 'package:application_1/widgets/text_with_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'filters.dart';

class Resturent extends StatelessWidget {
  RestaurantController _controller = Get.find();
  CartController _cartController = Get.find();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double w = size.width;
    double h = size.height;
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(

        backgroundColor: white,
        flexibleSpace: CustomToolbar(
          title: "Search restaurant in your area",
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back,
              size: 24,
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: Container(
        width: Get.width,
        height: Get.height,
        child: Obx(
          () => Stack(
            alignment: Alignment.bottomRight,
            children: [
              Column(
                children: [
                  BuildSizedBox(10),
                  Container(
                    width: w * 0.95,
                    height: 50,
                    child: Card(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.search),
                            Expanded(
                              child: TextFormField(
                                keyboardType: TextInputType.text,
                                onChanged: (value) {
                                  if (value.isEmpty) {
                                    _controller.filterList.clear();
                                    _controller.filterList.refresh();
                                  } else {
                                    filterList(_controller.restaurantList.value,
                                        value);
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
                              onTap: () {
                                Get.off(Filter());
                              },
                              child: Container(
                                width: w * 0.055,
                                height: w * 0.055,
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
                  BuildSizedBox(10),
                  Expanded(
                    child: CustomContainer(
                      width: Get.width,
                      height: Get.height,
                      child: gridViews(
                          columnSpan: 2,
                          itemCount: getSize(_controller.restaurantList),
                          flex: 1,
                          builder: (int index, columnSpan) {
                            List list = getListData();
                            return list.length.isOdd &&
                                    index ==
                                        getSize(_controller.restaurantList) - 1
                                ? CustomContainer(
                                    width: 100,
                                    height: 100,
                                    marginLeft: 12,
                                  )
                                : CustomContainer(
                                    marginTop: 12,
                                    width: Get.width / 2,
                                    child: buildAvailableNow(context, index),
                                  );
                          }),

                      /*
                        ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _controller.restaurantList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return buildAvailableNow(context, index);
                          },
                        )
                         */
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 0),
                  //   child: getMostPopularList(context),
                  // ),
                  // Container(
                  //   padding: const EdgeInsets.only(left: 15),
                  //   alignment: Alignment.centerLeft,
                  //   width: w,
                  //   height: 20,
                  //   color: Colors.transparent,
                  //   child: Container(
                  //     height: 20,
                  //     child: Text(
                  //       "Available Now",
                  //       style: Theme.of(context).textTheme.headline6,
                  //     ),
                  //   ),
                  // ),
                  // BuildSizedBox(10),

                  SizedBox(
                    height: 12,
                  )
                ],
              ),
              CartWidget(
                cartController: _cartController,
              ),
            ],
          ),
        ),
      ),
    ));
  }

  Widget buildListContainer(double w, BuildContext context, double h) {
    return InkWell(
      onTap: () {
        // Get.to(() => ShopMenu());
      },
      child: Container(
        width: w * 0.556,
        height: w * 0.34,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(0),
              child: Container(
                width: w * 0.556,
                height: w * 0.34,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    image: DecorationImage(
                        image: AssetImage("assets/image 2x/imageView.png"))),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Container(
                          width: w * 0.2,
                          height: w * 0.09,
                          child: MaterialButton(
                              textColor: blue,
                              color: green,
                              shape: StadiumBorder(),
                              child: Text(
                                'Open',
                                style:
                                    TextStyle(color: white, fontSize: w * 0.04),
                              ),
                              onPressed: () {
                                Get.to(ShopMenu());
                              }),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            BuildSizedBox(7),
            Container(
              alignment: Alignment.centerLeft,
              width: w,
              height: 20,
              color: Colors.transparent,
              child: Container(
                height: 20,
                child: Text(
                  "KFC Family Bucket",
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
            ),
            BuildSizedBox(5),
            Container(
              alignment: Alignment.centerLeft,
              width: w * 0.556,
              height: 25,
              color: Colors.transparent,
              child: Container(
                width: w,
                height: 20,
                child: Text("Kentucky Fried Chicken (KFC)",
                    style: TextStyle(
                        fontSize: 13,
                        color: Colors.black,
                        fontWeight: FontWeight.w200)),
              ),
            ),
            Container(
                width: w * 0.556,
                height: w * 0.08,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ReuseableRatingButton(
                      w: w,
                      h: h,
                      txt: "4.5",
                      onTap: () {},
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
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }

  Widget buildAvailableNow(BuildContext context, int index) {
    List list = getListData();
    RestaurantData value = list[index];

    String image = "${ApiUtills.imageBaseUrl + (value.profileImage ?? "")}";
    int size = _controller.restaurantList.length;
    return CustomContainer(
      child: listWidget(value, index, image, size),
      marginLeft: index.isEven ? 12 : 8,
    );
  }

  mostPopularItem(List<RestaurantData> mostPopularList, int index) {
    RestaurantData value = mostPopularList[index];

    String image = "${ApiUtills.imageBaseUrl + (value.profileImage ?? "")}";
    int size = _controller.restaurantList.length;
    return CustomContainer(
        child: listWidget(mostPopularList[index], index, image, size),
        marginLeft: index == 0 ? 12 : 0,
        marginRight: index == size - 1 ? 16 : 12);
  }

  getMostPopularList(context) {
    List list = _controller.restaurantList;
    List<RestaurantData> mostPopularList = [];

    for (int index = 0; index < list.length; index++) {
      RestaurantData value = list[index];
      if (value.totalOrder > 0) {
        print("${value.totalOrder}");
        mostPopularList.add(value);
      }
    }

    if (mostPopularList.isNotEmpty) {
      mostPopularList.sort((a, b) => a.totalOrder.compareTo(b.totalOrder));
    }
    var w = Get.width;
    var h = Get.height;
    return mostPopularList.isEmpty
        ? emptyContainer()
        : Container(
            width: w,
            height: w * 0.6,
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  width: w,
                  height: 20,
                  color: Colors.transparent,
                  child: Container(
                    margin: EdgeInsets.only(left: 15),
                    height: 20,
                    child: Text(
                      "Most Popular",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                ),
                BuildSizedBox(10),
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        width: w,
                        height: w * 0.5,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            for (int index = 0;
                                index < mostPopularList.length;
                                index++)
                              mostPopularItem(mostPopularList, index),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ));
  }

  Widget listWidget(value, index, image, size, {marginLeft = 16}) {
    var w = Get.width;
    var h = Get.height;
    return CustomContainer(
      onTap: () async {
        await _controller.getRestaurantProfile(id: value.id);
        _controller.restaurantFoodModel.value = RestaurantFoodModel();
        _controller.getRestaurantFood(id: value.id);
        print("");
      },
      width: Get.width * 0.45,
      // color: Colors.white,
      allRadius: 12,
      // shadowColor: Colors.black.withOpacity(0.5),
      // shadowOffsetY: 3,
      // shadowOffsetX: 3,
      // shadowBlurRadius: 6,
      // marginLeft: index == 0 ? 16 : 0,
      // marginRight: index == size - 1 ? 16 : 12,
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Column(
            children: [
              cacheNetworkImage(
                  imageUrl: image,
                  radius: 12,
                  imageWidth: Get.width * 0.45,
                  imageHeight: Get.width * 0.45,
                  placeHolder: "assets/images/img_photo.png"),
              Row(
                children: [
                  Expanded(
                    child: TextWithIcon(
                      title: "${value.name}",
                      fontSize: 16,
                      marginTop: 12,
                      marginLeft: 8,
                      fontColor: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              TextWithIcon(
                marginLeft: 8,
                marginBottom: 12,
                width: Get.width,
                flex: 1,
                overFlow: TextOverflow.ellipsis,
                title: "${value.address}",
                fontSize: 14,
                fontColor: Colors.black,
                fontWeight: FontWeight.w400,
              ),
            ],
          ),
          if (value.rating != null)
            TextWithIcon(
              title: "${value.rating ?? 0.0}",
              marginTop: 6,
              marginLeft: Get.width * 0.22,
              fontSize: 16,
              paddingRight: 12,
              paddingLeft: 12,
              paddingTop: 4,
              paddingBottom: 4,
              allRadius: 20,
              bgColor: Colors.blue,
              icon: Icon(
                Icons.star_border,
                size: 20,
                color: Colors.white,
              ),
              fontColor: Colors.white,
              fontWeight: FontWeight.w500,
            )
        ],
      ),
    );
  }

  getSize(RxList<dynamic> restaurantList) {
    List list = _controller.filterList.isNotEmpty
        ? _controller.filterList
        : _controller.restaurantList;
    if (list.length.isOdd) {
      return list.length + 1;
    }
    return list.length;
  }

  GetAvailableNow(context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            child: CustomContainer(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              for (int index = 0;
                  index < _controller.restaurantList.length;
                  index++)
                if (index.isEven) buildAvailableNow(context, index)
            ],
          ),
        )),
        Expanded(
            child: CustomContainer(
          width: 100,
          height: 200,
          color: Colors.redAccent,
        )),
      ],
    );

    /*gridViews(
                            columnSpan: 2,
                            itemCount: getSize(_controller.restaurantList),
                            flex: 1,
                            builder: (int index, columnSpan) {
                              return _controller.restaurantList.length.isOdd &&
                                      index ==
                                          getSize(_controller.restaurantList) -
                                              1
                                  ? CustomContainer(
                                      width: 100,
                                      height: 100,
                                      marginLeft: 12,
                                    )
                                  : CustomContainer(
                                      marginTop: 12,
                                      width: Get.width / 2,
                                      child: buildAvailableNow(context, 0),
                                    );
                            })*/
  }

  void filterList(List<dynamic> valueY, String valueX) {
    print("");
    _controller.filterList.value.clear();
    for (int index = 0; index < valueY.length; index++) {
      RestaurantData value = valueY[index];
      if (value.name.toLowerCase().contains(valueX.toLowerCase())) {
        _controller.filterList.value.add(value);
        _controller.filterList.refresh();
      }
    }
  }

  List getListData() {
    List list = _controller.filterList.isNotEmpty
        ? _controller.filterList
        : _controller.restaurantList;
    return list;
  }
}
/*
 CustomContainer(
            width: Get.width * 0.556,
            height: Get.width * 0.34,
            allRadius: 4,
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                cacheNetworkImage(
                    imageUrl: image,
                    topLeftRad: 12,
                    topRightRad: 12,
                    imageWidth: Get.width * 0.556,
                    imageHeight: Get.width * 0.34,
                    placeHolder: "assets/images/img_photo.png"),
                TextWithIcon(
                  bgColor: green,
                  marginAll: 12,
                  title: "Open",
                  width: w * 0.2,
                  allRadius: 28,
                  height: w * 0.09,
                  fontSize: 18,
                  shadowOffsetX: 0,
                  shadowSpreadRadius: 0,
                  shadowBlurRadius: 1,
                  shadowOffsetY: 0,
                  shadowColor: Colors.black.withOpacity(0.5),
                  fontColor: Colors.white,
                ),
              ],
            ),
          ),
          BuildSizedBox(7),
          TextWithIcon(
            marginLeft: 12,
            title: "${value.name}",
            fontSize: 20,
            fontColor: Colors.black,
            fontWeight: FontWeight.w700,
          ),
          BuildSizedBox(5),
          TextWithIcon(
            marginLeft: 12,
            marginBottom: 12,
            title: "${value.address}",
            fontSize: 14,
            fontColor: Colors.black,
            fontWeight: FontWeight.w200,
          ),
 */
