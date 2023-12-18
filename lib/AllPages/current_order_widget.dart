import 'package:application_1/AllPages/ProjectPages/controller/home_screen_controller.dart';
import 'package:application_1/AllPages/chat/chat_screen.dart';
import 'package:application_1/AllPages/chat/chatt_controller.dart';
import 'package:application_1/AllPages/chat/message_controller.dart';
import 'package:application_1/model/active_orders_resp/active_orders_data.dart';
import 'package:application_1/model/chat/user_chat_response.dart';
import 'package:application_1/model/service_response/service_list_data.dart';
import 'package:application_1/utils/api_utils.dart';
import 'package:application_1/utils/date_time_utils.dart';
import 'package:application_1/utils/widgest_utills.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';

class CurrentOrderWidget extends StatefulWidget {
  final senderId;
  final receiverId;
  final onUpdate;

  CurrentOrderWidget({
    Key? key,
    this.senderId,
    this.receiverId,
    this.onUpdate,
  }) : super(key: key);

  @override
  _CurrentOrderWidgetState createState() => _CurrentOrderWidgetState();
}

class _CurrentOrderWidgetState extends State<CurrentOrderWidget> {
  HomeScreenController _screenController = Get.find();
  MessageController _messageController = Get.find();
  ChatController _chatController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconTheme.of(context).copyWith(color: black),
        title: Text(
          "Current Services",
          style: TextStyle(color: black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Container(
            //   width: Get.width,
            //   height: Get.height,
            //   child: Padding(
            //     padding: const EdgeInsets.all(10.0),
            //     /*child: Card(
            //             child: TextFormField(
            //               onChanged: (val) {},
            //               decoration: InputDecoration(
            //                   prefixIcon: Icon(
            //                     Icons.search,
            //                     color: Colors.black26,
            //                     size: 18,
            //                   ),
            //                   fillColor: AppColors.white,
            //                   contentPadding: EdgeInsets.symmetric(vertical: 10),
            //                   border:
            //                       OutlineInputBorder(borderSide: BorderSide.none),
            //                   hintText: "Search service you want...",
            //                   hintStyle:
            //                       TextStyle(fontSize: 14, color: Colors.black38)),
            //             ),
            //           ),*/
            //   ),
            // ),
            Container(
              width: Get.width,
              height: Get.height,
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 18),
              child: Obx(() => !hasActiveOrder(
                      _screenController.availableJos.value.serviceListData ??
                          [],
                      widget.receiverId)
                  ? Container(
                      width: Get.width,
                      height: Get.height,
                      alignment: Alignment.center,
                      child: Text(
                        "No Active Order",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ))
                  : objectList(_messageController.messageList.value)),
            )
          ],
        ),
      ),
    );
  }

  getProviderName(var provider) {
    return "${provider["first_name"].toString().capitalizeFirst} ${provider['last_name'].toString().capitalizeFirst}";
  }

  String checkSince(var value) {
    DateTime update = DateTimeUtils().convertString(value.createdAt);
    String since = DateTimeUtils().checkSince(update);
    return since;
  }

  hasActiveOrder(List serviceListData, receiverId) {
    for (int index = 0; index < serviceListData.length; index++) {
      ServiceListData value = serviceListData[index];
      if (value.providerId == receiverId &&
          value.status.toString().toLowerCase() == "accepted" &&
          value.provider.id != null) {
        return true;
      } else if (value.isReplied == 1) {
        return true;
      }
    }
    return false;
  }

  networktImage(ActiveOrdersData value) {
    String image = value.provider['image'] ?? "";
    return Container(
      width: 50,
      height: 50,
      child: Stack(
        children: [
          Container(
            width: 48,
            height: 48,
            child: cacheNetworkImage(
                imageUrl: "${ApiUtills.imageBaseUrl + image}",
                placeHolder: 'assets/user_assets/png/user.png',
                imageHeight: 50,
                imageWidth: 50,
                radius: 100),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              decoration: BoxDecoration(shape: BoxShape.circle, color: white),
              padding: EdgeInsets.all(2),
              child: Container(
                  margin: EdgeInsets.only(bottom: 2, right: 2),
                  width: 12,
                  height: 12,
                  decoration:
                      BoxDecoration(shape: BoxShape.circle, color: greenColor)),
            ),
          )
        ],
      ),
    );
  }

  messageItem(ActiveOrdersData value, int index) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        minVerticalPadding: 10,
        // trailing: Icon(Icons.message),
        leading: Container(
          width: 50,
          height: 50,
          child: networktImage(value),
        ),
        title: Text(
          getProviderName(value.provider),
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            2.height,
            Text(
              DateTimeUtils().checkSince(DateFormat("yyyy-MM-ddTHH:mm:ss")
                  .parse(value.updatedAt, true)),
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
            ),
            2.height,
            Marquee(
              direction: Axis.horizontal,

              // child: FittedBox(child: Text(value.message.message.toString().substring(0,50)))
              child: Text(shortenName(value.message.message.toString(),
                  addDots: true, nameLimit: 12)),
            )
          ],
        ),
      ),
    );
    // return CustomContainer(
    //   width: Get.width,
    //   shadowColor: Colors.black.withOpacity(0.5),
    //   shadowBlurRadius: 0,
    //   shadowSpreadRadius: 0,
    //   shadowOffsetX: 1,
    //   shadowOffsetY: 1,
    //   color: Colors.white,
    //   allRadius: 16,
    //   marginTop: index == 0 ? 0 : 16,
    //   marginBottom: index == _messageController.messageList.length - 1 ? 16 : 0,
    //   child: ListTile(
    //     minVerticalPadding: 10,
    //     trailing: Icon(Icons.message),
    //     leading: Container(
    //       width: 58,
    //       height: 58,
    //       child: networktImage(value),
    //     ),
    //     title: Text(
    //       getProviderName(value.provider),
    //       style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
    //     ),
    //     subtitle: Text(DateTimeUtils().checkSince(
    //         DateFormat("yyyy-MM-ddTHH:mm:ss").parse(value.updatedAt, true))),
    //   ),
    // );
  }

  static String shortenName(String nameRaw,
      {int nameLimit = 10, bool addDots = false}) {
    //* Limiting val should not be gt input length (.substring range issue)
    final max = nameLimit < nameRaw.length ? nameLimit : nameRaw.length;
    //* Get short name
    final name = nameRaw.substring(0, max);
    //* Return with '..' if input string was sliced
    if (addDots && nameRaw.length > max) return name + '....';
    return name;
  }

  Widget listBuilder(ActiveOrdersData value, int index) {
    return value.provider == null
        ? emptyContainer()
        : value.provider['first_name'] == null &&
                value.provider['last_name'] == null
            ? Container()
            : widget.receiverId != value.provider['id'].toString()
                ? emptyContainer()
                : value.status.toString().toLowerCase() == "accepted"
                    ? MaterialButton(
                        padding:
                            EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                        elevation: 0,
                        onPressed: () {
                          _chatController.chatData(UserChatResponse());
                          Get.to(ChatScreen(
                            isComplete: value.isCompleted,
                            image: value.provider['image'],
                            senderId: widget.senderId,
                            receiverId: widget.receiverId,
                            orderId: value.id.toString(),
                            name: getProviderName(value.provider),
                            onUpdate: () async {
                              await _messageController.getUserList();
                              setState(() {});
                            },
                          ));
                        },
                        child: messageItem(value, index),
                      )
                    : emptyContainer();
  }

  objectList(List<dynamic> valueX) {
    return ListView.builder(
      itemCount: valueX.length,
      itemBuilder: (BuildContext context, int index) {
        int size = valueX.length - 1;
        size = size - index;
        valueX.sort((a, b) => a.seconds.compareTo(b.seconds));
        ActiveOrdersData value = valueX[index];

        return listBuilder(value, index);
      },
    );
  }
}
