import 'dart:convert';

import 'package:application_1/resources/repositories/service_repository.dart';
import 'package:flutter_local_notifications_platform_interface/src/types.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../AllPages/ProfilePages/plumberprofileView.dart';
import '../AllPages/ProjectPages/controller/home_screen_controller.dart';
import '../AllPages/ProjectPages/home_pass_button_screen.dart';
import '../AllPages/chat/chat_screen.dart';
import '../AllPages/chat/chatt_controller.dart';
import '../AllPages/chat/message_controller.dart';
import '../AllPages/feed_back_page.dart';
import '../App_Routes/app_routes.dart';
import '../model/active_orders_resp/active_orders_data.dart';
import '../model/chat/user_chat_response.dart';
import '../model/notification/notification_response.dart';
import '../model/service_response/service_list_data.dart';
import '../screens/Controllers/tabScreenController.dart';
import '../service/push_notification_service.dart';
import '../utils/project_widget.dart';

ServiceReposiotry _repo = ServiceReposiotry();

abstract class ForgroundNotification {
  static void accountStatusChangeNotification(
      NotificationResponseData model) async {
    if (model.title == "Account suspended") {
      await SharedPreferences.getInstance().then((value) {
        value.clear();
        Get.offAllNamed(AppRoutes.START);
      });
    } else if (model.title == "Account active") {}
  }

  static void updateAvailableJobs(NotificationResponseData model) {
    HomeScreenController _homeScreenControlle = Get.find();
    _homeScreenControlle.getAvailableJobs(flag: true);
    if (model.title == "End working on your Service Request") {
      3.delay().then((value) {
        Get.dialog(FeedBackPage(
          data: model,
          onRateComplete: () {
            _homeScreenControlle.getAvailableJobs(flag: true);
          },
        ));
      });
    }
  }

  static void handleOnClickNotification(
      NotificationResponse notificationResponse) {
    // MessageController controller = Get.find();
    TabScreenController _tabScreenController = Get.put(TabScreenController());
    HomeScreenController _homeScreenControlle = Get.find();

    NotificationResponseData model = NotificationResponseData.fromJson(
        jsonDecode(notificationResponse.payload!));

    if (model.type == "SERVICE_REQUEST") {
      Get.offNamed(AppRoutes.TABSCREEN);
      _tabScreenController.setTabIndex(1);
      _tabScreenController.setProjectTabIndex(1);
      if (model.title == "End working on your Service Request") {
        5.delay().then((value) {
          Get.dialog(FeedBackPage(
            data: model,
            onRateComplete: () {
              _homeScreenControlle.getAvailableJobs(flag: true);
            },
          ));
        });
      }
      // switch (model.title) {
      //   case "Request ACCEPTED":
      //     Get.offNamed(AppRoutes.TABSCREEN);
      //     _tabScreenController.setTabIndex(1);
      //     _tabScreenController.setProjectTabIndex(1);

      //     break;
      //   case "Resume working on your Service Request":
      //     _tabScreenController.setTabIndex(1);
      //     _tabScreenController.setProjectTabIndex(1);

      //     Get.offNamed(AppRoutes.TABSCREEN);

      //     break;
      //   case "Stop working on your Service Request":
      //     _tabScreenController.setTabIndex(1);
      //     _tabScreenController.setProjectTabIndex(1);
      //     Get.offNamed(AppRoutes.TABSCREEN);
      //     break;
      //   case "End working on your Service Request":
      //     break;
      //   case "Start working on your Service Request":
      //     break;
      //   default:
      // }
    }

    if (model.type == "MESSAGE") {
      Get.offNamed(AppRoutes.TABSCREEN);
      _tabScreenController.setTabIndex(2);
      _tabScreenController.setProjectTabIndex(2);
    }
    // String id = model.serviceRequestId!;
    // var lists = _homeScreenControlle.availableJos.value.serviceListData;
    // for (int index = 0; index < lists.length; index++) {
    //   ServiceListData value = lists[index];
    //   if (model.title == "Request ACCEPTED") {
    //     // Get.to(() => HomePassButtonScreen(
    //     //       datas: value,
    //     //     ));
    //     _tabScreenController.setTabIndex(1);
    //     flagTabs[0] = true;
    //     Get.offNamed(AppRoutes.TABSCREEN);

    //     return;
    //   } else if (model.title == "Resume working on your Service Request") {
    //     _tabScreenController.setTabIndex(1);
    //     // flagTabs[0] = true;
    //     Get.offNamed(AppRoutes.TABSCREEN);
    //     // Get.to(() => HomePassButtonScreen(
    //     //       datas: value,
    //     //     ));
    //   } else if (model.title == "Stop working on your Service Request") {
    //     _tabScreenController.setTabIndex(1);
    //     flagTabs[2] = true;
    //     Get.offNamed(AppRoutes.TABSCREEN);
    //     // Get.to(() => HomePassButtonScreen(
    //     //       datas: value,
    //     //     ));
    //   } else if (value.id.toString() == id) {
    //     if (model.title!.contains("Start working")) {
    //       Get.to(() => HomePassButtonScreen(
    //             datas: value,
    //           ));
    //     } else if (model.title!.contains("End working")) {
    //       // Get.to(PlumberProfileView(
    //       //   data: value,
    //       //   hasPayable: false,
    //       // ));
    //       Get.to(() => HomePassButtonScreen(
    //             datas: value,
    //           ));
    //       3.delay().then((value) {
    //         Get.dialog(FeedBackPage(
    //           data: model,
    //           onRateComplete: () {
    //             _homeScreenControlle.getAvailableJobs(flag: true);
    //           },
    //         ));
    //       });
    //     } else if (model.title!.contains("New message received")) {
    //       for (int indexJ = 0;
    //           indexJ < controller.messageList.length;
    //           indexJ++) {
    //         print("index");
    //         if (controller.messageList.value[indexJ].id.toString() ==
    //             model.serviceRequestId) {
    //           ChatController _chatController = Get.put(ChatController());
    //           _chatController.chatData(UserChatResponse());
    //           ActiveOrdersData data = controller.messageList.value[indexJ];
    //           Get.to(() => ChatScreen(
    //                 senderId: data.message.receiverId,
    //                 receiverId: data.message.senderId,
    //                 orderId: value.id.toString(),
    //                 name: getProviderName(value.provider),
    //                 onUpdate: () async {
    //                   await controller.getUserList();
    //                 },
    //               ));
    //         }
    //       }
    //     }

    //     break;
    //   }
    // }
  }
}
