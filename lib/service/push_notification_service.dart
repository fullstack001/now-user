import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

import '../AllPages/ProfilePages/plumberprofileView.dart';
import '../AllPages/ProjectPages/controller/home_screen_controller.dart';
import '../AllPages/ProjectPages/home_pass_button_screen.dart';
import '../AllPages/chat/chat_screen.dart';
import '../AllPages/chat/chatt_controller.dart';
import '../AllPages/chat/message_controller.dart';
import '../AllPages/feed_back_page.dart';
import '../AllPages/payable_widget.dart';
import '../All_Refrences/shared_refrence.dart';
import '../model/active_orders_resp/active_orders_data.dart';
import '../model/chat/user_chat_response.dart';
import '../model/notification/notification_response.dart';
import '../model/service_response/service_list_data.dart';
import '../model/service_response/service_response.dart';
import '../screens/Controllers/tabScreenController.dart';
import '../utils/api_utils.dart';

// class PushNotificationService {
//   final FirebaseMessaging _fcm = FirebaseMessaging.instance;
//   final BuildContext context;

//   PushNotificationService(this.context);

//   Future initialise() async {
//     // If you want to test the push notification locally,
//     // you need to get the token and input to the Firebase console
//     // https://console.firebase.google.com/project/YOUR_PROJECT_ID/notification/compose

//     // final IOSInitializationSettings initializationSettingsIOS =
//     //     IOSInitializationSettings(
//     //   requestSoundPermission: true,
//     //   requestBadgePermission: true,
//     //   requestAlertPermission: true,
//     // );
//     const AndroidInitializationSettings initializationSettingsAndroid =
//         AndroidInitializationSettings('ic_launcher_playstore');
//     const DarwinInitializationSettings initializationSettingsIOS =
//         DarwinInitializationSettings(
//       requestSoundPermission: true,
//       requestBadgePermission: true,
//       requestAlertPermission: true,
//     );

//     const InitializationSettings initializationSettings =
//         InitializationSettings(
//             iOS: initializationSettingsIOS,
//             android: initializationSettingsAndroid);
//     FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//         FlutterLocalNotificationsPlugin();
//     await flutterLocalNotificationsPlugin.initialize(
//       initializationSettings,
//     );

//     String? token = await _fcm.getToken();
//     print("FirebaseMessaging token: $token");

//     DarwinNotificationDetails iOSPlatformChannelSpecifics =
//         const DarwinNotificationDetails(
//       presentAlert: true,
//       // Present an alert when the notification is displayed and the application is in the foreground (only from iOS 10 onwards)
//       presentBadge: true,
//       // Present the badge number when the notification is displayed and the application is in the foreground (only from iOS 10 onwards)
//       presentSound: true, // The application's icon badge numbe
//     );

//     NotificationDetails platformChannelSpecifics =
//         NotificationDetails(iOS: iOSPlatformChannelSpecifics);

//     FirebaseMessaging.onBackgroundMessage((message) async {
//       messageReceived(message);
//     });

//     FirebaseMessaging.onMessageOpenedApp.listen((event) {
//       messageReceived(event);
//     });

//     FirebaseMessaging.onMessage.listen((event) async {
//       print("");
//       String title = event.data["title"] == null ? "" : event.data["title"]!;
//       String body = event.data["body"] == null ? "" : event.data["body"]!;
//       String providerId =
//           event.data["provider_id"] == null ? "" : event.data["provider_id"]!;
//       String type = event.data["type"] == null ? "" : event.data["type"]!;
//       String serviceRequestId = event.data["service_request_id"] == null
//           ? ""
//           : event.data["service_request_id"]!;
//       // String payable =
//       //     event.data["payable"] == null ? "" : event.data["payable"]!;
//       // String requestedHours = event.data["requested_hours"] == null
//       //     ? ""
//       //     : event.data["requested_hours"] == null
//       //         ? ""
//       //         : event.data["requested_hours"]!;
//       // String paidAmount =
//       //     event.data["paid_amount"] == null ? "" : event.data["paid_amount"]!;
//       // String workedHours =
//       //     event.data["worked_hours"] == null ? "" : event.data["worked_hours"]!;

//       NotificationResponseData model = NotificationResponseData();
//       model.title = title;
//       model.body = body;
//       model.type = type;
//       model.providerId = providerId;
//       model.serviceRequestId = serviceRequestId;
//       // model.payable = payable;
//       // model.hours = requestedHours;
//       // model.workedHours = workedHours;
//       // model.paidAmount = paidAmount;

//       clickNotification(
//         model,
//         flutterLocalNotificationsPlugin,
//         platformChannelSpecifics,
//         initializationSettings,
//       );
//     });
//   }
// }

// void messageReceived(RemoteMessage event) {
//   print("");
//   print("");
//   String title = event.data["title"] == null ? "" : event.data["title"]!;
//   String body = event.data["body"] == null ? "" : event.data["body"]!;
//   String providerId =
//       event.data["provider_id"] == null ? "" : event.data["provider_id"]!;
//   String type = event.data["type"] == null ? "" : event.data["type"]!;
//   String serviceRequestId = event.data["service_request_id"] == null
//       ? ""
//       : event.data["service_request_id"]!;
//   // String payable =
//   //     event.data["payable"] == null ? "" : event.data["payable"]!;
//   // String requestedHours = event.data["requested_hours"] == null
//   //     ? ""
//   //     : event.data["requested_hours"] == null
//   //         ? ""
//   //         : event.data["requested_hours"]!;
//   // String paidAmount =
//   //     event.data["paid_amoumt"] == null ? "" : event.data["paid_amount"]!;
//   // String workedHours =
//   //     event.data["worked_hours"] == null ? "" : event.data["worked_hours"]!;

//   NotificationResponseData model = NotificationResponseData();
//   model.title = title;
//   model.body = body;
//   model.type = type;
//   model.providerId = providerId;
//   model.serviceRequestId = serviceRequestId;
//   // model.payable = payable;
//   // model.hours = requestedHours;
//   // model.workedHours = workedHours;
//   // model.paidAmount = paidAmount;
//   controlData(model);
// }

clickNotification(
  NotificationResponseData model,
  flutterLocalNotificationsPlugin,
  platformChannelSpecifics,
  initializationSettings,
) async {
  if (chatOpen) {
    return;
  }
  print("parsed");
  MessageController controller = Get.put(MessageController());

  await controller.getUserList();

  HomeScreenController _homeScreenControlle = Get.find();
  WidgetsFlutterBinding.ensureInitialized();
  _homeScreenControlle.getAvailableJobs(flag: true);
  // if (userOpen != model.senderId) {
  if ((model.show) ?? true) {
    if (model.title == "End working on your Service Request") {
      // if (model.payable != null) {
      //   Get.dialog(PayableWidget());
      // } else {
      Future.delayed(const Duration(seconds: 1)).then((value) async {
        String response = await SharedRefrence().getString(key: "orders");
        if (response.isNotEmpty) {
          ServiceResponse parseData =
              ServiceResponse.fromJson(json.decode(response));

          var data;
          if (model.payable != null) {
            data =
                await _homeScreenControlle.getService(model.serviceRequestId!);
          } else {
            for (int index = 0;
                index < parseData.serviceData.serviceListData.length;
                index++) {
              ServiceListData value =
                  parseData.serviceData.serviceListData[index];
              if (model.serviceRequestId == value.id.toString()) {
                data = value;
                break;
              }
            }
          }

          String payable = model.payable ?? "";
          if (data == null || payable.isEmpty) {
            // showNotification(
            //   model,
            //   flutterLocalNotificationsPlugin,
            //   platformChannelSpecifics,
            //   initializationSettings,
            // );
          } else if (data.toString() != "true") {
            if (data != null) {
              if (model.payable != null) {
                var payableData = json.decode(model.payable!);
                bool hasPayable = checkPayable(data);
                Get.dialog(PayableWidget(
                  data: data,
                  payableId: payableData['id'],
                  model: model,
                ));
              } else {
                Get.dialog(FeedBackPage(
                  data: data,
                  onRateComplete: () {
                    _homeScreenControlle.getAvailableJobs(flag: true);
                  },
                ));
              }
            }
          }
        }
      });
      // }
    } else {
      // showNotification(
      //   model,
      //   flutterLocalNotificationsPlugin,
      //   platformChannelSpecifics,
      //   initializationSettings,
      // );
    }
  } else {
    controlData(model);
  }
  // }
  // }
}

bool checkPayable(data) {
  int hours = int.parse(data.hours.toString());
  int workedHours = int.parse(data.workedHours.toString());
  int result = hours - workedHours;
  bool has = result < 0 ? true : false;
  return has;
}

void controlData(data) {
  MessageController _messageController = Get.find();
  MessageController controller = Get.find();
  TabScreenController _tabScreenController = Get.put(TabScreenController());
  HomeScreenController _homeScreenControlle = Get.find();
  NotificationResponseData modelParsed = data;

  var id = modelParsed.serviceRequestId;
  var lists = _homeScreenControlle.availableJos.value.serviceListData;
  for (int index = 0; index < lists.length; index++) {
    ServiceListData value = lists[index];
    if (modelParsed.title == "Request ACCEPTED") {
      Get.to(() => HomePassButtonScreen(
            datas: value,
          ));
      // _tabScreenController.setTabIndex(1);
      // return;
    } else if (value.id.toString() == id) {
      if (modelParsed.title!.contains("Start working")) {
        Get.to(() => HomePassButtonScreen(
              datas: value,
            ));
      } else if (modelParsed.title!.contains("End working")) {
        Get.to(PlumberProfileView(
          data: value,
          hasPayable: false,
        ));
        3.delay().then((value) {
          Get.dialog(FeedBackPage(
            data: data,
            onRateComplete: () {
              _homeScreenControlle.getAvailableJobs(flag: true);
            },
          ));
        });
      } else if (modelParsed.title!.contains("New message received")) {
        for (int indexJ = 0; indexJ < controller.messageList.length; indexJ++) {
          print("index");
          if (controller.messageList.value[indexJ].id.toString() ==
              modelParsed.serviceRequestId) {
            ChatController _chatController = Get.put(ChatController());
            _chatController.chatData(UserChatResponse());
            ActiveOrdersData data = controller.messageList.value[indexJ];
            Get.to(() => ChatScreen(
                  senderId: data.message.receiverId,
                  receiverId: data.message.senderId,
                  orderId: value.id.toString(),
                  name: getProviderName(value.provider),
                  onUpdate: () async {
                    await _messageController.getUserList();
                  },
                ));
          }
        }
      }

      break;
    }
  }
  print("");
}

getProviderName(var provider) {
  return "${provider.firstName.toString().capitalizeFirst} ${provider.lastName.toString().capitalizeFirst}";
}

// void showNotification(
//     NotificationResponseData model,
//     flutterLocalNotificationsPlugin,
//     platformChannelSpecifics,
//     initializationSettings) async {
//   String payLoad = json.encode(model.toJson());

//   DarwinNotificationDetails iOSPlatformChannelSpecifics =
//       const DarwinNotificationDetails(
//     presentAlert: true,
//     // Present an alert when the notification is displayed and the application is in the foreground (only from iOS 10 onwards)
//     presentBadge: true,
//     // Present the badge number when the notification is displayed and the application is in the foreground (only from iOS 10 onwards)
//     presentSound: true, // The application's icon badge numbe
//   );

//   NotificationDetails platformChannelSpecific =
//       NotificationDetails(iOS: iOSPlatformChannelSpecifics);

//   // await flutterLocalNotificationsPlugin.show(
//   //     0, model.title, model.body, platformChannelSpecific,
//   //     payload: payLoad);

//   // await flutterLocalNotificationsPlugin.initialize(initializationSettings,
//   //     onSelectNotification: (value) async {
//   //   var data = json.decode(value!);
//   //   NotificationResponseData model = NotificationResponseData.fromJson(data);
//   //   controlData(model);
//   // });
// }
