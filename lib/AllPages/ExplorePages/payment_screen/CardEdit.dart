import 'package:application_1/AllPages/ExplorePages/AddCardDetails.dart';
import 'package:application_1/AllPages/ExplorePages/payment_screen/select_payment_method.dart';
import 'package:application_1/AllPages/ExplorePages/selectPaymentMethod.dart';
import 'package:application_1/AllPages/save_address_controller.dart';
import 'package:application_1/model/card/credit_card_data.dart';
import 'package:application_1/reuseableWidgets/reuseableSizedbox.dart';
import 'package:application_1/utils/AppColors.dart';
import 'package:application_1/utils/app_dialog_utils.dart';
import 'package:application_1/utils/widgest_utills.dart';
import 'package:application_1/widgets/custom_container.dart';
import 'package:application_1/widgets/text_with_icon.dart';
import 'package:fdottedline/fdottedline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../custom_package/card_ui/credit_card.dart';
import '../../../custom_package/card_ui/extra/card_type.dart';

class CardEdit extends StatelessWidget {
  var fromService;
  CardEdit({Key? key, this.fromService}) : super(key: key);
  SaveAddressController _addressController = Get.put(SaveAddressController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffE0E0E0).withOpacity(0.3),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColors.white,
          iconTheme: IconTheme.of(context).copyWith(color: black),
          title: Text(
            "Payment",
            style: Theme.of(context).textTheme.headline6,
          ),
          centerTitle: false,
        ),
        body: Obx(() {
          return Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    TextWithIcon(
                      width: 0,
                      height: 0,
                      title: "${_addressController.crditCards.length}",
                    ),
                    buildUpperContainer(Get.width, Get.height),
                    buildBottomContainer(Get.width, Get.height, context)
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
          );
        }));
  }

  Widget buildUpperContainer(double w, double h) {
    return _addressController.crditCards.isEmpty
        ? emptyContainer()
        : CustomContainer(
            width: Get.width,
            // color: Colors.white,
            // shadowSpreadRadius: 3,
            // shadowBlurRadius: 6,
            paddingAll: 12,
            // marginAll: 15,
            // allRadius: 12,
            // shadowOffsetX: 3,
            // shadowOffsetY: 3,
            // shadowColor: Colors.black.withOpacity(0.5),
            child: Column(
              children: [
                12.height,
                for (int index = 0;
                    index < _addressController.crditCards.length;
                    index++)
                  CustomContainer(
                      onTap: () {
                        CreditCardData value =
                            _addressController.crditCards.value[index];
                        _addressController.selectedCard(value);
                        _addressController.selectedCard.refresh();
                        // Get.back();
                        // Get.back();
                      },
                      width: Get.width,
                      child: buildListTile(index))
              ],
            ),
          );
  }

  buildListTile(index) {
    CreditCardData value = _addressController.crditCards.value[index];
    String month = value.expMonth.toString();
    String slash = "/";
    String year = value.expYear.toString();
    return GestureDetector(
      onLongPress: () {
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
      child: Container(
        padding: EdgeInsets.all(3),
        height: 200,
        width: Get.width,
        child: CreditCard(
            cardNumber: "**** **** **** ${value.last4}",
            cardExpiry: "10/25",
            cardHolderName: " ",
            cvv: "456",
            bankName: "${value.brand}",
            cardType: value.brand.toString().toLowerCase() == "visa"
                ? CardType.visa
                : CardType
                    .masterCard, // Optional if you want to override Card Type
            showBackSide: false,
            frontBackground: Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [
                Color(0xff3EB0E5),
                Color(0xff0050AD),
              ])),
            ),
            backBackground: Container(color: redColor),
            showShadow: false,
            width: double.infinity,
            textExpDate: 'Exp Date:',
            textName: '',
            textExpiry: 'MM/YY'),
      ),
    );

    // return Card(
    //   elevation: 0,
    //   shape: RoundedRectangleBorder(
    //       borderRadius: BorderRadius.circular(18),
    //       side: BorderSide(color: Colors.black12)),
    //   child: ListTile(
    //     leading: Container(
    //       alignment: Alignment.center,
    //       width: 20,
    //       height: 25,
    //       child: getCard(value.brand.toString().toLowerCase()),
    //     ),
    //     trailing: InkWell(
    //         onTap: () {
    //           alertDialog(
    //             title: "Alert",
    //             content: "Do you want to delete this?",
    //             confirm: MaterialButton(
    //               onPressed: () {
    //                 _addressController.deleteCard(value.id);
    //                 Get.back();
    //               },
    //               child: Text("Yes"),
    //             ),
    //             cancel: MaterialButton(
    //               onPressed: () {
    //                 Get.back();
    //               },
    //               child: Text("No"),
    //             ),
    //           );
    //         },
    //         child: Icon(Icons.delete)),
    //     title: Text("${value.brand}"),
    //     subtitle: Text(".......${value.last4}"),
    //   ),
    // );
  }

  buildBottomContainer(double w, double h, BuildContext context) {
    return _addressController.crditCards.length == 5
        ? emptyContainer()
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
            child: GestureDetector(
              onTap: () {
                // Get.to(AddCardDetails());
                Get.to(SelectMethod(
                  formService: false,
                ));
              },
              child: FDottedLine(
                color: AppColors.solidBlue,
                corner: FDottedLineCorner.all(12),
                child: Container(
                  alignment: Alignment.center,
                  width: Get.width,
                  height: 48,
                  decoration: BoxDecoration(
                      color: white, borderRadius: BorderRadius.circular(12)),
                  child: Text(
                    "+ Add New Card",
                    style: TextStyle(color: AppColors.solidBlue),
                  ),
                ),
              ),
            ),
          );
  }
}
