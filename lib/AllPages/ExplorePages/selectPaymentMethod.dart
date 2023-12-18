import 'package:application_1/AllPages/ExplorePages/paymentMethod.dart';
import 'package:application_1/AllPages/ExplorePages/shopMenu.dart';
import 'package:application_1/restaurant_controller/cart_controller.dart';
import 'package:application_1/widgets/custom_container.dart';
import 'package:application_1/widgets/text_with_icon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectPaymentMethod extends StatelessWidget {
  CartController _cartController = Get.find();

  // bool selected = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double w = size.width;
    double h = size.height;
    bool containerColor = true;
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
        title: Text(
          "Payment Method",
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      body: Obx(() => Column(
            children: [
              Expanded(
                child: CustomContainer(
                  width: Get.width,
                  height: 100,
                  child: Column(
                    children: [
                      TextWithIcon(
                        title: "Credit Or Debit Card?",
                        fontColor: _cartController.selected.value[0]
                            ? Colors.white
                            : Colors.black,
                        fontSize: 18,
                        width: Get.width,
                        height: 44,
                        allRadius: 12,
                        shadowOffsetY: 4,
                        shadowOffsetX: 3,
                        shadowSpreadRadius: 2,
                        bottomLeftRadius: 5,
                        shadowBlurRadius: 5,
                        marginTop: 12,
                        marginRight: 24,
                        marginLeft: 24,
                        shadowColor: Colors.black.withOpacity(0.5),
                        bgColor: _cartController.selected.value[0]
                            ? Colors.blue
                            : Colors.white,
                        fontWeight: FontWeight.w500,
                        containerClick: () {
                          _cartController.clear();
                          _cartController.selected.value[0] = true;
                          _cartController.selected.refresh();
                        },
                      ),
                      TextWithIcon(
                        title: "Cash On  Delivery",
                        fontColor: _cartController.selected.value[1]
                            ? Colors.white
                            : Colors.black,
                        fontSize: 18,
                        width: Get.width,
                        height: 44,
                        allRadius: 12,
                        shadowOffsetY: 4,
                        shadowOffsetX: 3,
                        shadowSpreadRadius: 2,
                        bottomLeftRadius: 5,
                        shadowBlurRadius: 5,
                        marginTop: 12,
                        marginRight: 24,
                        marginLeft: 24,
                        shadowColor: Colors.black.withOpacity(0.5),
                        bgColor: _cartController.selected.value[1]
                            ? Colors.blue
                            : Colors.white,
                        fontWeight: FontWeight.w500,
                        containerClick: () {
                          _cartController.clear();
                          _cartController.selected.value[1] = true;
                          _cartController.selected.refresh();
                        },
                      ),
                    ],
                  ),
                ),
              ),
              TextWithIcon(
                title: "Continue",
                width: Get.width,
                allRadius: 6,
                bgColor: Colors.blue,
                height: 50,
                fontColor: Colors.white,
                fontSize: 16,
                marginBottom: 16,
                marginLeft: 24,
                marginRight: 24,
                containerClick: () {
                  if (_cartController.selected.value[1]) {
                    _cartController.cashOnDelivery(true);
                    _cartController.cashOnDelivery.refresh();
                    Get.back();
                    return;
                  }
                  _cartController.cashOnDelivery(false);
                  _cartController.cashOnDelivery.refresh();
                  // Get.back();
                  Get.to(() => PaymentMethod());
                },
              ),
            ],
          )),
    );
  }
}
