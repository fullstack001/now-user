import 'package:application_1/AllPages/ExplorePages/payment_screen/CardEdit.dart';
import 'package:application_1/AllPages/save_address_controller.dart';
import 'package:application_1/model/card/credit_card_data.dart';
import 'package:application_1/remote_model/order_history/order_history_data.dart';
import 'package:application_1/reuseableWidgets/reuseableSizedbox.dart';
import 'package:application_1/reuseableWidgets/reuseblueButton.dart';
import 'package:application_1/utils/AppColors.dart';
import 'package:application_1/utils/date_time_utils.dart';
import 'package:application_1/widgets/text_with_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderHistoryDetailPage extends StatelessWidget {
  final value;
  final viewType;

  OrderHistoryDetailPage({
    Key? key,
    this.value,
    this.viewType,
  }) : super(key: key);
  SaveAddressController _addressController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, size) {
            return ConstrainedBox(
              constraints: BoxConstraints(minHeight: size.maxHeight),
              child: Column(
                children: [
                  Expanded(
                      flex: 4,
                      child: Container(
                        child: Stack(
                          children: [
                            getImage(value, viewType),
                            Container(
                              alignment: Alignment.center,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    width: size.maxWidth * 0.28,
                                    height: size.maxWidth * 0.28,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: AssetImage(
                                                "assets/image 2x/dp.png"))),
                                  ),
                                  BuildSizedBox(size.maxHeight * 0.01),
                                  Container(
                                    child: Column(
                                      children: [
                                        Text(
                                          "${getStoryName(value, viewType)}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6,
                                        ),
                                        Text(
                                          "",
                                          style: TextStyle(
                                              color: AppColors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w300),
                                        ),
                                        // SmoothStarRating(
                                        //   rating: 3.0,
                                        //   allowHalfRating: true,
                                        //   color: AppColors.blue,
                                        //   size: 18,
                                        //   borderColor: AppColors.blue,
                                        // ),
                                        BuildSizedBox(size.maxHeight * 0.02)
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      )),
                  Expanded(
                      flex: 6,
                      child: Container(
                        padding: EdgeInsets.all(12),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Order details",
                                style: Theme.of(context).textTheme.headline6,
                              ),
                            ),
                            Container(
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Your Order number",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 16),
                                    ),
                                    BuildSizedBox(9),
                                    Container(
                                      color: Colors.blueGrey.shade100,
                                      child: Text(
                                        "${value.orderNo}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w300,
                                            fontSize: 16),
                                      ),
                                    ),
                                  ],
                                )),
                            Container(
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Payment method",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 16),
                                    ),
                                    value.paymentType == "CASH_ON_DELIVERY"
                                        ? TextWithIcon(
                                            title: "Cash On Delivery",
                                            marginBottom: 24,
                                            marginTop: 12,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                          )
                                        : Container(
                                            child: TextWithIcon(
                                              title: "Card",
                                              marginBottom: 24,
                                              marginTop: 12,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            /*child: ListTile(
                                            leading: Image(
                                              fit: BoxFit.cover,
                                              image: AssetImage(
                                                  "assets/image 1.5x/mastercard.png"),
                                            ),
                                            title: Text(
                                              "${getCardName(value)}",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            subtitle: Text(
                                              "...........2064",
                                              style: TextStyle(fontSize: 16),
                                            ),
                                          )*/
                                          ),
                                    getList(value, viewType),
                                    Text(
                                      "",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ],
                                )),
                            getRow("", ""),
                            getRow("", ""),
                            getRow("", "")
                            // getRow("Subtotal", "Rs. ${value.totalAmount}"),
                            // getRow("Discount", "- Rs 20.16"),
                            // getRow("Tax", "Rs 10.16")
                          ],
                        ),
                      )),
                  Expanded(
                      flex: 2,
                      child: Container(
                        padding: EdgeInsets.all(12),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Total",
                                  style: TextStyle(fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  "RS ${value.totalAmount}",
                                  style: TextStyle(
                                      color: AppColors.blue,
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                            ReuseableBlueButton(
                              w: size.maxWidth,
                              h: size.maxHeight,
                              onTap: () {
                                // Get.to(CardEdit());
                              },
                              text: "Payment ${value.paymentStatus}",
                              // text: "Reorder",
                            )
                          ],
                        ),
                      )),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Row getRow(String title, price) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.w300),
        ),
        Text(
          price,
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ],
    );
  }

  getName(OrderHistoryData value, String viewType) {
    if (viewType == "grocery") {
      return "${value.product.name}";
    }
    return "${value.foodHistory.name}";
  }

  getPrice(OrderHistoryData value, String viewType) {
    return "${value.totalAmount} PKR";
  }

  getStoryName(OrderHistoryData value, String viewType) {
    if (viewType == "grocery") {
      return "${value.groceryStore.name}";
    }
    return "${value.restaurantData.name}";
  }

  getTime(OrderHistoryData value) {
    String createdAt = value.createdAt;
    var time = DateTimeUtils().convertStringWoT(createdAt);
    var parsedTime =
        DateTimeUtils().parseDateTime(time, "dd/MM/yyyy, hh:mm aa");
    return parsedTime;
  }

  getImage(OrderHistoryData value, String viewType) {
    String? image = viewType.toLowerCase() == "grocery"
        ? value.groceryStore.profileImage
        : null;

    var img = image == null
        ? Image.asset(
            "assets/image 2x/shopBackground.png",
            fit: BoxFit.cover,
          )
        : Image.network(
            image,
            fit: BoxFit.cover,
          );
    return Container(
      color: Colors.blue,
      width: Get.width,
      height: Get.height * 0.17,
      child: Opacity(
        opacity: 0.2,
        child: img,
      ),
    );
  }

  getList(OrderHistoryData value, String viewType) {
    return Container();
  }

  getCardName(OrderHistoryData value) {
    for (int index = 0; index < _addressController.crditCards.length; index++) {
      CreditCardData valueX = _addressController.crditCards.value[index];
      if (valueX.id == value.transactionId) {
        return valueX.name;
      }
    }
    return "";
  }
}
