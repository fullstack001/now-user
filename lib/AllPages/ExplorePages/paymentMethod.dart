import 'package:application_1/AllPages/ExplorePages/AddCardDetails.dart';
import 'package:application_1/AllPages/ExplorePages/shopMenu.dart';
import 'package:application_1/AllPages/save_address_controller.dart';
import 'package:application_1/model/card/credit_card_data.dart';
import 'package:application_1/utils/app_dialog_utils.dart';
import 'package:application_1/utils/widgest_utills.dart';
import 'package:application_1/widgets/custom_container.dart';
import 'package:application_1/widgets/text_with_icon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentMethod extends StatelessWidget {
  final onPageChange;
  final body;

  PaymentMethod({this.body, this.onPageChange});

  SaveAddressController _addressController = Get.put(SaveAddressController());

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
              "Select Payment Method",
              style: Theme.of(context).textTheme.headline6,
            ),
          ],
        ),
      ),
      body: Container(
        color: Colors.white.withOpacity(0.1),
        child: Obx(() => Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      TextWithIcon(
                        width: 0,
                        height: 0,
                        title: "${_addressController.crditCards.length}",
                      ),
                      buildUpperContainer(w, h),
                      buildBottomContainer(w, h, context)
                    ],
                  ),
                ),
                if (_addressController.cardDeleteLoading.value)
                  Container(
                    width: Get.width,
                    height: Get.height,
                    color: Colors.black.withOpacity(0.5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        TextWithIcon(
                          marginTop: 12,
                          fontSize: 18,
                          width: Get.width,
                          title: "Please Wait...",
                        )
                      ],
                    ),
                  ),
              ],
            )),
      ),
    );
  }

  Widget buildUpperContainer(double w, double h) {
    return _addressController.crditCards.isEmpty
        ? emptyContainer()
        : CustomContainer(
            width: Get.width,
            color: Colors.white,
            shadowSpreadRadius: 3,
            shadowBlurRadius: 6,
            paddingAll: 12,
            marginAll: 15,
            allRadius: 12,
            shadowOffsetX: 3,
            shadowOffsetY: 3,
            shadowColor: Colors.black.withOpacity(0.5),
            child: Column(
              children: [
                for (int index = 0;
                    index < _addressController.crditCards.length;
                    index++)
                  CustomContainer(
                      onTap: () {
                        CreditCardData value =
                            _addressController.crditCards.value[index];
                        _addressController.selectedCard(value);
                        _addressController.selectedCard.refresh();
                        Get.back();
                        Get.back();
                      },
                      width: Get.width,
                      child: buildListTile(index))
              ],
            ),
          );
  }

  ListTile buildListTile(index) {
    CreditCardData value = _addressController.crditCards.value[index];
    return ListTile(
      leading: Container(
        alignment: Alignment.center,
        width: 20,
        height: 25,
        child: getCard(value.brand.toString().toLowerCase()),
      ),
      trailing: InkWell(
          onTap: () {
            alertDialog(
              title: "Alert",
              content: "Do you want to delete this?",
              confirm: MaterialButton(
                onPressed: () {
                  _addressController.deleteCard(value.id);
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
          child: Icon(Icons.delete)),
      title: Text("${value.brand}"),
      subtitle: Text(".......${value.last4}"),
    );
  }

  Container buildBottomContainer(double w, double h, BuildContext context) {
    return _addressController.crditCards.length == 5
        ? emptyContainer()
        : Container(
            width: w,
            height: h * 0.46,
            color: white,
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
                          child: Text("Do You Want To Add New Card?",
                              style: TextStyle(
                                  color: black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600)),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(AddCardDetails());
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: 266,
                            height: 48,
                            color: Colors.grey.withOpacity(0.2),
                            child: Text(
                              "Add New Card",
                              style: TextStyle(color: blue),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                /*  Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  BuildSizedBox(5),
                  GestureDetector(
                    onTap: () {
                      // Get.to(CartAddress(true, "Checkout"));
                      Get.to(CartAddress(
                        paymentBox: true,
                        txt: "Checkout",
                      ));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: Colors.blue,
                      ),
                      width: w * 0.918,
                      height: h * 0.059,
                      child: Center(
                          child: Text(
                        "Continue with Selected Card",
                        style: TextStyle(color: white),
                      )),
                    ),
                  )
                ],
              ),
            ),
          ),*/
              ],
            ),
          );
  }
}
