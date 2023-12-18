import 'package:application_1/AllPages/save_address_controller.dart';
import 'package:application_1/restaurant_controller/cart_controller.dart';
import 'package:application_1/screens/tabScreen.dart';
import 'package:application_1/utils/AppColors.dart';
import 'package:application_1/widgets/custom_container.dart';
import 'package:application_1/widgets/text_with_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class OrderDone extends StatelessWidget {
  final data;

  OrderDone({this.data});

  CartController _cartController = Get.find();
  SaveAddressController _addressController = Get.find();

  removeUi() {
    Get.offAll(() => TabsScreen());
    _addressController.dispose();
    _cartController.dispose();

    Get.delete<CartController>();
    Get.delete<SaveAddressController>();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
            extendBody: true,
            body: SafeArea(
              child: CustomContainer(
                width: Get.width,
                height: Get.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomContainer(
                      width: 170,
                      height: 170,
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          CustomContainer(
                            width: 200,
                            height: 200,
                            child: SvgPicture.asset(
                              'assets/icons/ic_order_done.svg',
                            ),
                          ),
                          CustomContainer(
                              width: 58,
                              height: 58,
                              allRadius: 58,
                              color: Colors.white,
                              child: Icon(
                                Icons.check_circle,
                                color: AppColors.appGreen,
                                size: 58,
                              )),
                        ],
                      ),
                    ),
                    TextWithIcon(
                      width: Get.width,
                      fontSize: 28,
                      marginTop: 50,
                      fontWeight: FontWeight.w700,
                      title: "Order was successful",
                    ),
                    TextWithIcon(
                      width: Get.width,
                      fontSize: 19,
                      marginTop: 12,
                      textAlign: TextAlign.center,
                      title:
                          "Check on the status of your order\nin the \"Orders\" section.",
                    ),
                    TextWithIcon(
                      width: Get.width,
                      fontSize: 19,
                      marginTop: 32,
                      paddingAll: 14,
                      marginLeft: 32,
                      allRadius: 12,
                      fontWeight: FontWeight.w700,
                      fontColor: Colors.white,
                      marginRight: 32,
                      bgColor: AppColors.appBlue,
                      textAlign: TextAlign.center,
                      title: "Continue Shopping",
                      containerClick: () {
                        removeUi();
                      },
                    ),
                    // TextWithIcon(
                    //   width: Get.width,
                    //   fontSize: 18,
                    //   marginTop: 50,
                    //   underline: TextDecoration.underline,
                    //   fontWeight: FontWeight.w700,
                    //   title: "Go to Orders",
                    //   fontColor: AppColors.appBlue,
                    // ),
                  ],
                ),
              ),
            )),
        onWillPop: () async {
          removeUi();
          return true;
        });
  }
}
/*
import 'package:application_1/AllPages/ExplorePages/shopMenu.dart';
import 'package:application_1/AllPages/save_address_controller.dart';
import 'package:application_1/model/add_address/data.dart';
import 'package:application_1/model/cart_model/food_cart.dart';
import 'package:application_1/restaurant_controller/cart_controller.dart';
import 'package:application_1/reuseableWidgets/reuseableSizedbox.dart';
import 'package:application_1/reuseableWidgets/reuseblueButton.dart';
import 'package:application_1/screens/exploreScreen.dart';
import 'package:application_1/screens/tabScreen.dart';
import 'package:application_1/utils/widgest_utills.dart';
import 'package:application_1/widgets/text_with_icon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderDone extends StatelessWidget {
  final data;

  OrderDone({this.data});

  CartController _cartController = Get.find();
  SaveAddressController _addressController = Get.find();

  removeUi() {
    Get.offAll(() => TabsScreen());
    _addressController.dispose();
    _cartController.dispose();

    Get.delete<CartController>();
    Get.delete<SaveAddressController>();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
            extendBody: true,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: white,
              leading: IconButton(
                onPressed: removeUi,
                icon: Icon(
                  Icons.arrow_back,
                  color: black,
                ),
              ),
              title: Text(
                "Order Placed",
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            body: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints viewPort) {
                double w = viewPort.maxWidth;
                double h = viewPort.maxHeight;

                return ConstrainedBox(
                  constraints: BoxConstraints(minHeight: viewPort.minHeight),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Container(
                          alignment: Alignment.center,
                          width: w,
                          child: Card(
                            elevation: 0,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "Estimated Delivery Time",
                                  style: TextStyle(
                                      color: black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                Text(
                                  "15 - 20 Mins",
                                  style: TextStyle(
                                      color: black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                CircleAvatar(
                                  radius: h * 0.075,
                                  child: Icon(
                                    Icons.check,
                                    size: h * 0.075,
                                    color: white,
                                  ),
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                Text(
                                  "your order number is : ${data['data'][0]["order_no"]}",
                                  style: TextStyle(
                                      color: black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                getAddrress(),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        width: w,
                        height: h * 0.478,
                        padding: EdgeInsets.all(15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Order  Placed",
                                      style: TextStyle(
                                          color: black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    BuildSizedBox(15),
                                    getItemList(),
                                    /*Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Discount",
                                      style: TextStyle(
                                          color: black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w300),
                                    ),
                                    Text(
                                      "RS -20.16",
                                      style: TextStyle(
                                          color: black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Tax",
                                      style: TextStyle(
                                          color: black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w300),
                                    ),
                                    Text(
                                      "RS -20.16",
                                      style: TextStyle(
                                          color: black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),*/
                                    BuildSizedBox(15),
                                    Text(
                                      "Paid With",
                                      style: TextStyle(
                                          color: black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    BuildSizedBox(10),
                                    _cartController.cashOnDelivery.value
                                        ? TextWithIcon(
                                            title: "Cash on delivery",
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                          )
                                        : ListTile(
                                            title: Text(
                                              "${_addressController.selectedCard.value.brand}",
                                              style: TextStyle(
                                                  color: black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            subtitle: Text(
                                              ".......${_addressController.selectedCard.value.last4}",
                                              style: TextStyle(
                                                  color: black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w200),
                                            ),
                                            leading: Container(
                                              alignment: Alignment.center,
                                              width: 30,
                                              height: 30,
                                              child: getCard(_addressController
                                                  .selectedCard.value.brand
                                                  .toLowerCase()),
                                            ),
                                          ),
                                  ],
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Total",
                                  style: TextStyle(
                                      color: black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  "RS ${_cartController.getSubtotalPrice(_cartController.summaryList.value)}",
                                  style: TextStyle(
                                      color: black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            BuildSizedBox(5),
                            Container(
                              width: w,
                              alignment: Alignment.center,
                              child: ReuseableBlueButton(
                                w: w,
                                h: h,
                                text: "Go to main screen",
                                onTap: removeUi,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            )),
        onWillPop: () async {
          removeUi();
          return true;
        });
  }

  getItemList() {
    List list = _cartController.summaryList.value;
    return Column(
      children: [
        for (int index = 0; index < list.length; index++)
          for (int indexX = 0; indexX < list[index].foodCart.length; indexX++)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${list[index].foodCart[indexX].quantity}x",
                  style: TextStyle(
                      color: black, fontSize: 18, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  width: 12,
                ),
                Expanded(
                    child: Text(
                        "${getProductName(list[index].foodCart[indexX])}")),
                Text(
                  "RS ${getCount(list[index].foodCart[indexX])}",
                  style: TextStyle(
                      color: black, fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ],
            ),
      ],
    );
  }

  getCount(FoodCart foodCart) {
    double qty = double.parse((foodCart.quantity ?? 0).toString());
    double price = double.parse((foodCart.price ?? 0).toString());
    double result = price * qty;
    return "$result";
  }

  getAddrress() {
    var index = _addressController.index.value;
    AddressData value = _addressController.addressList.value[index];
    return Container(
      alignment: Alignment.bottomLeft,
      padding: EdgeInsets.symmetric(horizontal: 10),
      width: Get.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${value.type}",
            style: TextStyle(
                color: black, fontSize: 18, fontWeight: FontWeight.w600),
          ),
          Text(
            "${value.address}",
            style: TextStyle(
                color: black, fontSize: 12, fontWeight: FontWeight.w200),
          ),
          SizedBox(
            height: 24,
          )
        ],
      ),
    );
  }

  getProductName(foodCart) {
    if (foodCart.product != null) {
      return foodCart.product['name'];
    }
    return foodCart.food.name;
  }
}

 */
