import 'package:application_1/AllPages/RegisteraionPages/Controllers/RegistrationController.dart';
import 'package:application_1/AllPages/chat/message_controller.dart';
import 'package:application_1/AllPages/current_order_widget.dart';
import 'package:application_1/model/active_orders_resp/active_orders_data.dart';
import 'package:application_1/model/inbox/inbox_data.dart';
import 'package:application_1/model/service_response/service_list_data.dart';
import 'package:application_1/utils/AppColors.dart';
import 'package:application_1/utils/AppString.dart';
import 'package:application_1/utils/api_utils.dart';
import 'package:application_1/utils/widgest_utills.dart';
import 'package:application_1/widgets/custom_container.dart';
import 'package:application_1/widgets/custom_toolbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../utils/date_time_utils.dart';

class Messages extends StatefulWidget {
  @override
  _MessagesState createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  MessageController _messageController = Get.find();
  RegistrationController _registrationController = Get.find();

  List<ActiveOrdersData> filterList = [];
  String query = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _messageController.getUserList().then((value) {
      setState(() {});
    });
  }

  List? activeOrderList;

  @override
  Widget build(BuildContext context) {
    activeOrderList = getOrderList(_messageController.messageList);
    _messageController.newList(activeOrderList);

    return Scaffold(
        backgroundColor: const Color(0xfff5f5f5),
        appBar: AppBar(
          backgroundColor: white,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            "Messages",
            style: TextStyle(
                color: Color(0xff151415),
                fontSize: 18,
                fontWeight: FontWeight.w500),
          ),
        ),
        body: Column(
          children: [
            SizedBox(
              height: 12,
            ),
            Expanded(
              child: Obx(() => Container(
                    child: _messageController.newList.isEmpty
                        ? emptyNote()
                        : ListView.builder(
                            itemCount: query.isNotEmpty
                                ? filterList.length
                                : _messageController.newList.length,
                            itemBuilder: (context, index) {
                              ActiveOrdersData value = query.isNotEmpty
                                  ? filterList[index]
                                  : _messageController.newList.value[index];
                              return checkNull(value)
                                  ? emptyContainer()
                                  : inboxItem(value, index);
                            }),
                  )),
            )
          ],
        ));
  }

  String getName(ActiveOrdersData value) {
    String? firstName = value.provider['first_name'].toString().capitalizeFirst;
    String? lastName = value.provider['last_name'].toString().capitalizeFirst;

    return "$firstName $lastName";
    // return "abc";
  }

  inboxItem(ActiveOrdersData value, int index) {
    final RegistrationController data = Get.find();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 2),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: CustomContainer(
              onTap: () {
                ActiveOrdersData inbox =
                    _messageController.newList.value[index];

                String senderId =
                    _registrationController.userData.value.id.toString();
                String receiverId = inbox.provider['id'].toString();
                Get.to(CurrentOrderWidget(
                  receiverId: receiverId,
                  senderId: senderId,
                  onUpdate: () {
                    _messageController.getUserList();
                    setState(() {});
                  },
                ));
              },
              width: Get.width,
              child: ListTile(
                leading: Container(
                  width: 50,
                  height: 50,
                  child: Stack(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        child: cacheNetworkImage(
                            imageUrl: ApiUtills.imageBaseUrl +
                                getProviderImage(value),
                            placeHolder: 'assets/user_assets/png/user.png',
                            imageHeight: 60,
                            imageWidth: 60,
                            radius: 90),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: white),
                          padding: const EdgeInsets.all(2),
                          child: Container(
                              width: 12,
                              height: 12,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle, color: greenColor)),
                        ),
                      )
                    ],
                  ),
                ),
                title: Row(
                  children: [
                    Text(
                      getProviderName(value),
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                    5.width,
                    Icon(
                      Icons.verified,
                      color: value.verifiedAt != null
                          ? AppColors.solidBlue
                          : Color(0xffE0E0E0),
                      size: 18,
                    )
                  ],
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      DateTimeUtils().checkSince(
                          DateFormat("yyyy-MM-ddTHH:mm:ss")
                              .parse(value.updatedAt, true)),
                      style: TextStyle(
                          color: Color(0xff757575),
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      value.message.message.toString(),
                      maxLines: 1,
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }

  hasActiveOrder(List<ServiceListData> serviceListData, receiverId) {
    for (int index = 0; index < serviceListData.length; index++) {
      ServiceListData value = serviceListData[index];
      if (value.status.toString().toLowerCase() == "accepted" &&
          value.provider.id != null) {
        return true;
      } else if (value.isReplied == 1) {
        return true;
      }
    }
    return false;
  }

  emptyNote() {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          16.height,
          SvgPicture.asset(
            'assets/user_assets/svg/no_message.svg',
          ),
          // SizedBox(
          //   height: 6,
          // ),
          // Text(
          //   "Once you start a new conversation,\nYou will see it listed here",
          //   textAlign: TextAlign.center,
          // ),
        ],
      ),
    );
  }

  checkMessageList(object) {
    //InboxData
    for (int index = 0; index < object.value.length; index++) {
      ActiveOrdersData value = object.value[index];
      print("abc");
      /*if (object.value[index].id != _registrationController.userData.value.id &&
          value.receiverMessage != null) {
        if (value.receiverMessage.senderId ==
            _registrationController.userData.value.id) {
          return false;
        }
        if (value.senderMessage.receiverId ==
            _registrationController.userData.value.id) {
          return false;
        }
      }*/
    }
    return true;
  }

  checkNull(ActiveOrdersData value) {
    if (value.provider == null) {
      return true;
    }
    return false;
  }

  bool userExiest(InboxData value) {
    if (value.receiverMessage != null) {
      return false;
    }
    if (value.senderMessage != null) {
      return false;
    }
    if (value.receiverMessage.senderId ==
        _registrationController.userData.value.id) {
      return false;
    }
    if (value.senderMessage.receiverId ==
        _registrationController.userData.value.id) {
      return false;
    }
    return true;
  }

  String getProviderImage(ActiveOrdersData value) {
    if (value.provider == null) {
      return "";
    }
    if (value.provider['image'] == null) {
      return "";
    }
    return value.provider['image'];
  }

  String getProviderName(ActiveOrdersData value) {
    String userName =
        "${value.provider['first_name']} ${value.provider['last_name']}";
    return userName;
  }

  getOrderList(RxList<dynamic> messageList) {
    List list = [];
    DateTime now = DateTime.now();

    for (int index = 0; index < messageList.length; index++) {
      ActiveOrdersData value = messageList.value[index];
      if (!existObject(list, value)) {
        var group = getGroup(messageList, value);
        list.add(group);
      }
    }
    list = list.reversed.toList();
    list.sort((a, b) => a.seconds.compareTo(b.seconds));

    return list;
  }

  bool existObject(List<dynamic> list, ActiveOrdersData value) {
    if (value.provider == null) {
      return true;
    }
    for (int index = 0; index < list.length; index++) {
      ActiveOrdersData obj = list[index];
      if (value.provider['id'] == obj.provider['id']) {
        return true;
      }
    }

    return false;
  }

  getGroup(RxList<dynamic> messageList, ActiveOrdersData valueX) {
    List list = [];
    for (int index = 0; index < messageList.length; index++) {
      ActiveOrdersData value = messageList.value[index];
      if (value.provider != null) {
        if (value.provider['id'] == valueX.provider['id']) {
          print("");
          list.add(value);
        }
      }
    }
    var objects = list.reduce((a, b) => a.seconds < b.seconds ? a : b);
    return objects;
  }
}
