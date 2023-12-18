import 'package:application_1/AllPages/ExplorePages/AddCardDetails.dart';
import 'package:application_1/AllPages/ExplorePages/addNewAddress.dart';
import 'package:application_1/AllPages/ExplorePages/selectPaymentMethod.dart';
import 'package:application_1/AllPages/ExplorePages/shopMenu.dart';
import 'package:application_1/AllPages/save_address_controller.dart';
import 'package:application_1/model/cart_model/food_cart_model.dart';
import 'package:application_1/model/menu_types.dart';
import 'package:application_1/restaurant_controller/cart_controller.dart';
import 'package:application_1/utils/AppColors.dart';
import 'package:application_1/utils/app_dialog_utils.dart';
import 'package:application_1/utils/widgest_utills.dart';
import 'package:application_1/widgets/custom_container.dart';
import 'package:application_1/widgets/text_with_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';

class CartAddress extends StatelessWidget {
  var paymentBox;
  var txt;

  CartAddress({this.paymentBox = false, this.txt = ""});

  CartController _cartController = Get.find();

  SaveAddressController _addressController = Get.put(SaveAddressController());
  bool paymentMethodSelected = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double w = size.width;
    double h = size.height;
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
              "Checkout",
              style: Theme.of(context).textTheme.headline6,
            ),
          ],
        ),
      ),
      body: Container(
        color: Colors.white.withOpacity(0.1),
        child: Obx(() => Column(
              children: [
                Expanded(
                    child: ListView(
                  children: [
                    for (int index = 0;
                        index < _addressController.checkOutList.length;
                        index++)
                      createCheckOutList(
                          index, _addressController.checkOutList.value),
                  ],
                )),
                TextWithIcon(
                  title: "Process Order",
                  bgColor: AppColors.appBlue,
                  width: Get.width,
                  paddingAll: 14,
                  fontSize: 19,
                  marginRight: 24,
                  marginLeft: 24,
                  marginBottom: 12,
                  allRadius: 12,
                  fontColor: Colors.white,
                  fontWeight: FontWeight.w700,
                  containerClick: () {
                    if (_addressController.cardIndex.value == -1) {
                      alertDialog(
                          title: "Alert",
                          content: "Please select payment method",
                          confirm: MaterialButton(
                            onPressed: () {
                              Get.back();
                            },
                            child: Text("Okay"),
                          ));
                      return;
                    }
                    if (_addressController.addressIndex.value == -1) {
                      alertDialog(
                          title: "Alert",
                          content: "Please select delivery address",
                          confirm: MaterialButton(
                            onPressed: () {
                              Get.back();
                            },
                            child: Text("Okay"),
                          ));
                      return;
                    }

                    var addressId = _addressController.addressList
                        .value[_addressController.addressIndex.value].id;

                    var cardIds = getCartIds(_cartController.foodCart.value);

                    int cID = _addressController.cardIndex.value;

                    if (cID != -2 && cID != -1) {
                      // cardIds = _addressController.crditCards.value[cID].id;
                    }

                    Map body = <String, dynamic>{
                      "cart_ids": cardIds,
                      "address": "new order"
                    };

                    if (cID == -2 && cardIds != -1) {
                      body['type'] = "CASH_ON_DELIVERY";
                    } else {
                      body['card_id'] =
                          "${_addressController.crditCards.value[cID].id}";
                      body.remove("key");
                    }

                    body["address_id"] = addressId;
                    print("$body");
                    print("abc");

                    _addressController.createOrder(body);
                    // Get.back();
                  },
                )
              ],
            )),
      ),
    );
  }

  createCheckOutList(int index, List<dynamic> checkoutList) {
    MenuTypes value = checkoutList[index];
    return CustomContainer(
      marginLeft: 12,
      alignment: Alignment.center,
      marginRight: 12,
      width: Get.width,
      child: Column(
        children: [
          Divider(),
          CustomContainer(
            onTap: () {
              print("list index ${checkoutList[index].selected}");
              // for (int indexY = 0;
              //     indexY < _addressController.checkOutList.length;
              //     indexY++) {
              //   if (index != indexY) {
              //     _addressController.checkOutList.value[index].selected = false;
              //   }
              // }
              bool flag = _addressController.checkOutList.value[index].selected;
              flag = !checkoutList[index].selected;
              print("flag $flag");
              _addressController.checkOutList.value[index].selected = flag;
              _addressController.checkOutList.refresh();
            },
            paddingLeft: 12,
            paddingRight: 12,
            paddingTop: 12,
            width: Get.width,
            height: 50,
            alignment: Alignment.center,
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextWithIcon(
                      title: "${value.name}",
                      fontSize: 17,
                    ),
                    CustomContainer(
                      child: Icon(
                        value.selected
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                        size: 28,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          if (value.selected) expandAbleList(index)
        ],
      ),
    );
  }

  expandAbleList(int index) {
    String type = index == 0
        ? "cardList"
        : index == 1
            ? "addressList"
            : "deliveryMethod";
    return index == 0
        ? cardListView()
        : index == 1
            ? addressListView()
            : emptyContainer();
  }

  cardListView() {
    return Column(
      children: [
        for (int index = 0;
            index < _addressController.crditCards.length;
            index++)
          CustomContainer(
            onTap: () {
              _addressController.cardIndex(index);
              _addressController.cardIndex.refresh();
            },
            paddingAll: 8,
            width: Get.width,
            borderColor: _addressController.cardIndex.value == index
                ? AppColors.appBlue
                : Color(0xffeaeceb),
            borderWidth: 1,
            marginTop: index == 0 ? 0 : 8,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                getCard("${_addressController.crditCards.value[index].brand}"
                    .toLowerCase()),
                Expanded(
                  child: TextWithIcon(
                    title:
                        "**** **** **** ${_addressController.crditCards.value[index].last4}",
                    alignment: MainAxisAlignment.start,
                    marginLeft: 24,
                    fontSize: 17,
                  ),
                ),
                if (_addressController.cardIndex.value == index)
                  Icon(
                    Icons.check_circle,
                    color: AppColors.appBlue,
                  ),
                InkWell(
                    onTap: () {
                      alertDialog(
                        title: "Alert",
                        content: "Do you want to delete this?",
                        confirm: MaterialButton(
                          onPressed: () {
                            _addressController.deleteCard(
                                _addressController.crditCards.value[index].id);
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
                    child: Icon(
                      Icons.delete,
                      color: Colors.grey,
                    )),
              ],
            ),
          ),
        CustomContainer(
          onTap: () {
            _addressController.cardIndex(-2);
            _addressController.cardIndex.refresh();
          },
          paddingAll: 8,
          width: Get.width,
          borderColor: _addressController.cardIndex.value == -2
              ? AppColors.appBlue
              : Color(0xffeaeceb),
          borderWidth: 1,
          marginTop: 8,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Fontisto.dollar,
                color: Colors.grey,
              ),
              Expanded(
                child: TextWithIcon(
                  title: "Cash On Delivery",
                  alignment: MainAxisAlignment.start,
                  marginLeft: 24,
                  fontSize: 17,
                ),
              ),
              if (_addressController.cardIndex.value == -2)
                Icon(
                  Icons.check_circle,
                  color: AppColors.appBlue,
                )
            ],
          ),
        ),
        if (_addressController.crditCards.length < 5)
          TextWithIcon(
            containerClick: () {
              // Get.to(() => AddCardDetails());
              Get.to(() => AddCardDetails());
            },
            marginTop: 12,
            width: Get.width,
            icon: Icon(
              Icons.add,
              color: AppColors.appBlue,
            ),
            title: "Add Card",
            fontSize: 17,
            fontColor: AppColors.appBlue,
          )
      ],
    );
  }

  addressListView() {
    return Column(
      children: [
        for (int index = 0;
            index < _addressController.addressList.length;
            index++)
          CustomContainer(
            onTap: () {
              _addressController.addressIndex(index);
              _addressController.addressIndex.refresh();
            },
            paddingAll: 8,
            width: Get.width,
            borderColor: _addressController.addressIndex.value == index
                ? AppColors.appBlue
                : Color(0xffeaeceb),
            borderWidth: 1,
            marginTop: index == 0 ? 0 : 8,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextWithIcon(
                  title: "${_addressController.addressList.value[index].type}",
                  alignment: MainAxisAlignment.start,
                  fontSize: 17,
                ),
                Expanded(
                  child: TextWithIcon(
                    width: Get.width,
                    flex: 1,
                    title:
                        "${_addressController.addressList.value[index].address}",
                    alignment: MainAxisAlignment.start,
                    marginLeft: 24,
                    fontSize: 17,
                  ),
                ),
                if (_addressController.addressIndex.value == index)
                  Icon(
                    Icons.check_circle,
                    color: AppColors.appBlue,
                  ),
                InkWell(
                    onTap: () {
                      alertDialog(
                        title: "Alert",
                        content: "Do you want to delete this?",
                        confirm: MaterialButton(
                          onPressed: () {
                            _addressController.deleteAddress(_addressController
                                .addressList.value[index].id
                                .toString());
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
                    child: Icon(
                      Icons.delete,
                      color: Colors.grey,
                    )),
              ],
            ),
          ),
        if (_addressController.addressList.length < 5)
          TextWithIcon(
            containerClick: () {
              // Get.to(() => SelectAddress());
              Get.to(() => AddNewAddress());
            },
            marginTop: 12,
            width: Get.width,
            icon: Icon(
              Icons.add,
              color: AppColors.appBlue,
            ),
            title: "Add Address",
            fontSize: 17,
            fontColor: AppColors.appBlue,
          )
      ],
    );
  }

  getCartIds(FoodCartModel value) {
    print("");
    List ids = [];
    for (int index = 0; index < value.foodCart.length; index++) {
      ids.add(value.foodCart[index].id);
    }
    return ids;
  }
}

/*
import 'package:application_1/AllPages/ExplorePages/selectAddress.dart';
import 'package:application_1/AllPages/ExplorePages/shopMenu.dart';
import 'package:application_1/AllPages/save_address_controller.dart';
import 'package:application_1/model/card/credit_card_data.dart';
import 'package:application_1/model/cart_model/food_cart_model.dart';
import 'package:application_1/restaurant_controller/cart_controller.dart';
import 'package:application_1/reuseableWidgets/reuseableSizedbox.dart';
import 'package:application_1/reuseableWidgets/reuseblueButton.dart';
import 'package:application_1/utils/AppColors.dart';
import 'package:application_1/utils/widgest_utills.dart';
import 'package:application_1/widgets/custom_container.dart';
import 'package:application_1/widgets/getLocation.dart';
import 'package:application_1/widgets/text_with_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class CartAddress extends StatelessWidget {
  bool paymentBox = false;
  String txt = "";

  CartAddress({this.paymentBox, this.txt});

  CartController _cartController = Get.find();

  SaveAddressController _addressController = Get.put(SaveAddressController());
  bool paymentMethodSelected = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double w = size.width;
    double h = size.height;
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
              "Checkout",
              style: Theme.of(context).textTheme.headline6,
            ),
          ],
        ),
      ),
      body: Container(
        color: Colors.white.withOpacity(0.1),
        child: Obx(() => Column(
              children: [
                // buildUpperContainer(w, h),
                buildPaymentContainer(),
                Expanded(
                  child: SizedBox(
                    height: 140,
                  ),
                ),
                buildBottomContainer(w, h, context)
              ],
            )),
      ),
    );
  }

  buildPaymentContainer() {
    return CustomContainer(
      width: Get.width,
      marginAll: 15,
      shadowColor: Colors.black.withOpacity(0.5),
      shadowBlurRadius: 5,
      shadowSpreadRadius: 3,
      color: Colors.white,
      allRadius: 12,
      paddingAll: 12,
      shadowOffsetY: 3,
      shadowOffsetX: 3,
      child: Column(
        children: [
          TextWithIcon(
              title: "Please Enter Your Details",
              fontSize: 18,
              fontWeight: FontWeight.w600),
          if (_addressController.selectedCard.value.id != null)
            Column(
              children: [
                SizedBox(
                  height: 18,
                ),
                CustomContainer(
                  onTap: () {
                    if (_cartController.cashOnDelivery.value) {
                      _cartController.cashOnDelivery.value =
                          !_cartController.cashOnDelivery.value;
                      _cartController.cashOnDelivery.refresh();
                      paymentMethodSelected = true;
                    }
                  },
                  child: Row(
                    children: [
                      createIcon(
                          check: _cartController.cashOnDelivery.value
                              ? false
                              : true),
                      buildListTile(),
                    ],
                  ),
                ),
              ],
            ),
          BuildSizedBox(5),
          TextWithIcon(
            marginTop: 12,
            icon: createIcon(check: _cartController.cashOnDelivery.value),
            title: "Cash On Delivery",
            fontSize: 14,
            containerClick: () {
              print("");
              if (!_cartController.cashOnDelivery.value) {
                _cartController.cashOnDelivery.value =
                    !_cartController.cashOnDelivery.value;
                _cartController.cashOnDelivery.refresh();
                paymentMethodSelected = true;
              }
            },
            fontWeight: FontWeight.w600,
          ),
        ],
      ),
    );
  }

  createIcon({bool check}) {
    return !check
        ? Icon(Icons.radio_button_off, color: AppColors.appGreen)
        : FaIcon(FontAwesome.check_circle, color: AppColors.appGreen);
  }

  Widget buildUpperContainer(double w, h) {
    return CustomContainer(
      color: Colors.white,
      shadowColor: Colors.black.withOpacity(0.5),
      marginTop: 15,
      marginLeft: 15,
      marginRight: 15,
      allRadius: 12,
      shadowOffsetX: 3,
      shadowOffsetY: 3,
      shadowBlurRadius: 5,
      shadowSpreadRadius: 2,
      width: w,
      child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  width: w,
                  height: h * 0.038,
                  child: Text(
                    "Delivery Address",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ),
                BuildSizedBox(h * 0.01),
                Container(
                  width: w,
                  height: h * 0.209,
                  child: GetLocation(
                    w: w,
                    h: h,
                  ),
                ),
                BuildSizedBox(h * 0.01),
                Container(
                  alignment: Alignment.centerLeft,
                  width: w,
                  height: h * 0.038,
                  child: Text(
                    "Subway Eat Fresh",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  width: w,
                  height: h * 0.038,
                  child: Text(
                    "1 Manchester Ave Zurich Lake, IL 60047",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w200),
                  ),
                ),
              ],
            ),
          )),
    );
  }

  Widget buildBottomContainer(double w, double h, BuildContext context) {
    return CustomContainer(
      width: w,
      color: white,
      shadowColor: Colors.black.withOpacity(0.5),
      shadowBlurRadius: 6,
      shadowSpreadRadius: 5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              width: w,
              height: h * 0.2,
              color: Colors.white,
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Payment Method",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: Column(
                      children: [
                        ListTile(
                          onTap: () {
                            _addressController.getCreditCard();
                          },
                          leading: Icon(Icons.add, color: blue),
                          title: Text(
                            "Add Payment Method",
                            style: TextStyle(color: blue),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  // buildRow(context, "Total", "342.0"),
                  buildRow(
                    context,
                    TextWithIcon(
                      title: "Subtotal",
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                    TextWithIcon(
                      title:
                          "RS ${_cartController.getSubtotalPrice(_cartController.summaryList.value)}",
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  BuildSizedBox(5),
                  ReuseableBlueButton(
                    w: w,
                    h: h,
                    text: txt,
                    onTap: () async {
                      await _addressController.getAddress();
                      paymentMethodSelected = checkSelection();
                      if (!paymentMethodSelected) {
                        snackBar("Please selected payment method", context);
                        return;
                      }
                      var cardIds = getCartIds(_cartController.foodCart.value);

                      Map body = <String, dynamic>{
                        "cart_ids": cardIds,
                        "address": "new order"
                      };

                      if (_cartController.cashOnDelivery.value) {
                        body['type'] = "CASH_ON_DELIVERY";
                        body.remove("card_id");
                      } else {
                        body['card_id'] =
                            "${_addressController.selectedCard.value.id}";
                        body.remove("key");
                      }
                      Get.to(() => SelectAddress(body: body));
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

  buildListTile() {
    CreditCardData value = _addressController.selectedCard.value;
    return Row(
      children: [
        CustomContainer(
          width: 20,
          height: 25,
          marginLeft: 16,
          marginRight: 24,
          child: getCard(value.brand.toLowerCase()),
        ),
        Column(
          children: [
            TextWithIcon(
              title: "${value.brand}",
              fontSize: 16,
            ),
            TextWithIcon(
              title: ".......${value.last4}",
              fontSize: 14,
              fontColor: Colors.grey,
            ),
          ],
        )
      ],
    );
  }

  bool checkSelection() {
    if (_addressController.selectedCard.value.id != null) {
      return true;
    }
    if (_cartController.cashOnDelivery.value) {
      return true;
    }
    return false;
  }

  getCartIds(FoodCartModel value) {
    print("");
    List ids = [];
    for (int index = 0; index < value.foodCart.length; index++) {
      ids.add(value.foodCart[index].id);
    }
    return ids;
  }
}
*/
