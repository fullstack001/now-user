import 'package:application_1/remote_model/order_history/order_history_data.dart';
import 'package:application_1/restaurant_controller/order_history_controller.dart';
import 'package:application_1/utils/AppColors.dart';
import 'package:application_1/utils/date_time_utils.dart';
import 'package:application_1/widgets/custom_container.dart';
import 'package:application_1/widgets/text_with_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import 'orderHistoryDetailPage.dart';

class OrderHistoryListView extends StatefulWidget {
  var viewType;
  var viewTitle;

  OrderHistoryListView({
    Key? key,
    this.viewType,
    this.viewTitle,
  }) : super(key: key);

  @override
  _OrderHistoryListViewState createState() => _OrderHistoryListViewState();
}

class _OrderHistoryListViewState extends State<OrderHistoryListView> {
  int Buttoncurrent = 0;
  int Timecurrent = 0;
  OrderHistoryController _historyController = Get.find();
  List<String> list = ["Active Order", "Complete Order", "Cancelled"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        leading: CustomContainer(
          alignment: Alignment.center,
          height: 50,
          marginLeft: 12,
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.close,
            color: AppColors.blue,
            size: 22,
          ),
        ),
        title: Text(
          "${widget.viewTitle}",
          style: Theme.of(context).textTheme.headline6,
        ),
        elevation: 1,
        centerTitle: false,
      ),
      body: LayoutBuilder(
        builder: (context, size) {
          return ConstrainedBox(
            constraints: BoxConstraints(minHeight: size.maxHeight),
            child: Obx(() => Column(
                  children: [
                    SizedBox(
                      height: 8,
                      child: Container(
                        color: Colors.grey.shade300,
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.symmetric(horizontal: 2),
                          width: size.maxWidth,
                          child:
                              optionButton(_historyController.selectedButton),
                        )),
                    Expanded(
                        flex: 9,
                        child: _createList(
                            _historyController.selectedButton.value))
                  ],
                )),
          );
        },
      ),
    );
  }

  optionButton(RxString selectedButton) {
    return Row(
      children: [
        for (int index = 0; index < list.length; index++)
          Expanded(
            child: TextWithIcon(
              containerClick: () {
                _historyController.selectedButton(list[index]);
                _historyController.selectedButton.refresh();
              },
              width: Get.width,
              marginTop: 18,
              marginRight: index == list.length - 1 ? 12 : 0,
              fontColor: checkSelected(selectedButton, index)
                  ? Colors.blue
                  : Color(0xff757575),
              borderWidth: 2,
              borderColor: checkSelected(selectedButton, index)
                  ? Colors.blue
                  : Colors.transparent,
              marginLeft: index == 0 ? 12 : 8,
              paddingTop: 12,
              paddingBottom: 12,
              allRadius: 40,
              fontSize: 14,
              bgColor: checkSelected(selectedButton, index)
                  ? Colors.white
                  : Color(0xffF3F4F4),
              title: "${list[index]}",
            ),
          )
      ],
    );
  }

  bool checkSelected(RxString selectedButton, int index) {
    if (selectedButton.value == list[index]) {
      return true;
    }
    return false;
  }

  _createList(String values) {
    List<OrderHistoryData> orderHistoryData = [];
    for (int index = 0;
        index < _historyController.orderHistoryData.length;
        index++) {
      OrderHistoryData value = _historyController.orderHistoryData.value[index];
      print("${value.status}");
      if (widget.viewType == value.type.toLowerCase()) {
        if (values == "Active Order") {
          if (value.status.toString().toLowerCase() == "pending") {
            orderHistoryData.add(value);
          }
        }
      }
    }
    return orderHistoryData.isEmpty
        ? TextWithIcon(
            width: Get.width,
            height: Get.height,
            fontSize: 20,
            title: "Data not available",
          )
        : Container(
            child: ListView.builder(
                itemCount: orderHistoryData.length,
                itemBuilder: (context, index) {
                  OrderHistoryData value = orderHistoryData[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: Container(
                        width: Get.width,
                        height: Get.height * 0.25,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${getName(value, widget.viewType)}",
                                style: Theme.of(context).textTheme.headline6,
                              ),
                              Text(
                                "${getStoryName(value, widget.viewType)}",
                                style: TextStyle(
                                    color: Colors.black38,
                                    fontWeight: FontWeight.w300),
                              ),
                              Text(
                                "${getTime(value)}",
                                style: TextStyle(
                                    color: Colors.black38,
                                    fontWeight: FontWeight.w300),
                              ),
                              SmoothStarRating(
                                color: Colors.blue,
                                borderColor: Colors.blue,
                                size: 18,
                                allowHalfRating: true,
                                rating: 3.0,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${getPrice(value, widget.viewType)}",
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Get.to(OrderHistoryDetailPage(
                                        value: value,
                                        viewType: widget.viewType,
                                      ));
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: Get.width * 0.25,
                                      height: 37,
                                      decoration: BoxDecoration(
                                          color: AppColors.green,
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Text(
                                        "Active Now",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
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
}
