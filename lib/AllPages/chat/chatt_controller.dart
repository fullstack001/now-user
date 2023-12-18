import 'package:application_1/All_Refrences/shared_refrence.dart';
import 'package:application_1/model/chat/user_chat_response.dart';
import 'package:application_1/resources/repositories/service_repository.dart';
import 'package:application_1/utils/api_utils.dart';
import 'package:application_1/utils/app_dialog_utils.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  ServiceReposiotry _serviceReposiotry = ServiceReposiotry();
  var chatData = UserChatResponse().obs;

  void sendMessage(body, {onUpdate}) async {
    String authToken =
        await SharedRefrence().getString(key: ApiUtills.authToken);
    await _serviceReposiotry.sendMessage(authToken: authToken, body);
    if (onUpdate != null) {
      onUpdate();
    }
  }

  // void autoMateMessages({flag, id, update}) {
  //   bool flagList = flag ?? false;
  //   fetchUserChat(id: id, update: update);
  //   if (flagList) {
  //     Future.delayed(Duration(seconds: 30)).then((value) {
  //       // if (chatData.value.userChatData != null) {
  //       autoMateMessages(flag: flagList, id: id,update: update);
  //
  //     });
  //   }
  // }
  void fetchUserChat({id, update, orderId, page}) async {
    if (chatData.value.userChatData == null) {
      AppDialogUtils.dialogLoading();
    }

    String authToken =
        await SharedRefrence().getString(key: ApiUtills.authToken);
    await _serviceReposiotry
        .getUserChat(
      authToken: authToken,
      id: id.toString(),
      page: page,
      orderId: orderId,
    )
        .then((UserChatResponse? response) {
      if (response != null) {
        if (!response.error) {
          // response.userChatData.userChatListData =
          //     response.userChatData.userChatListData.reversed.toList();
          chatData(response);
          // update();
          if (update != null) {
            update();
          }
        }
        AppDialogUtils.dismiss();
      }
    });
  }
}
