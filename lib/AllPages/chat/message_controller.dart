import 'package:application_1/All_Refrences/shared_refrence.dart';
import 'package:application_1/model/active_orders_resp/active_orders_data.dart';
import 'package:application_1/model/active_orders_resp/active_orders_response.dart';
import 'package:application_1/model/inbox/inbox_data.dart';
import 'package:application_1/resources/repositories/service_repository.dart';
import 'package:application_1/utils/api_utils.dart';
import 'package:application_1/utils/app_dialog_utils.dart';
import 'package:application_1/utils/date_time_utils.dart';
import 'package:get/get.dart';

class MessageController extends GetxController {
  ServiceReposiotry _serviceReposiotry = ServiceReposiotry();
  var messageList = [].obs;
  var newList = [].obs;

  Future<void> getUserList({flag}) async {
    bool hide = flag ?? false;
    if (messageList.isEmpty) {
      if (!hide) {
        AppDialogUtils.dialogLoading();
      }
    }

    String authToken =
        await SharedRefrence().getString(key: ApiUtills.authToken);

    await _serviceReposiotry
        .getInboxList(authToken: authToken)
        .then((ActiveOrdersResponse? response) {
      AppDialogUtils.dismiss();
      if (response != null) {
        DateTime now = DateTime.now();
        List<ActiveOrdersData> list = [];
        if (response.activeOrdersData != null) {
          for (int index = 0;
              index < response.activeOrdersData.length;
              index++) {
            ActiveOrdersData value = response.activeOrdersData[index];
            DateTime time = DateTimeUtils().convertStringWoT(value.updatedAt);
            var seconds = now.difference(time).inSeconds;
            value.seconds = seconds;

            list.add(value);
          }
          messageList(list);
          messageList.refresh();
        }
      }
    });
  }

  List sortList(List<dynamic> value) {
    var list = value;
    for (int index = 0; index < list.length; index++) {
      if (list[index].updatedAt == null) {
        list.removeAt(index);
      }
    }
    list.sort((a, b) =>
        timeInMinutes(DateTimeUtils().convertStringWoT(lastMessageTime(a)))
            .compareTo(timeInMinutes(
                DateTimeUtils().convertStringWoT(lastMessageTime(b)))));
    return list;
  }

  String lastMessageTime(InboxData value) {
    int senderLastUpdateTime = 0;
    int receiverLastUpdateTime = 0;

    if (value.senderMessage != null) {
      DateTime update = DateTimeUtils().convertStringWoT(
          value.senderMessage.updatedAt ?? DateTime.now().toString());
      String since = DateTimeUtils().checkSince(update);
      print("sender time: $since");
      senderLastUpdateTime = timeInMinutes(update);
    }
    if (value.receiverMessage != null) {
      DateTime update = DateTimeUtils().convertStringWoT(
          value.receiverMessage.updatedAt ?? DateTime.now().toString());
      String since = DateTimeUtils().checkSince(update);
      print("sender time: $since");
      receiverLastUpdateTime = timeInMinutes(update);
    }
    if (value.receiverMessage == null && value.senderMessage == null) {
      return value.updatedAt ?? DateTime.now().toString();
    }
    if (value.senderMessage == null) {
      return value.receiverMessage.updatedAt;
    }
    if (value.receiverMessage == null) {
      return value.senderMessage.updatedAt;
    }
    if (senderLastUpdateTime == 0) {
      return value.receiverMessage.updatedAt;
    }
    if (receiverLastUpdateTime == 0) {
      return value.senderMessage.updatedAt;
    }
    if (senderLastUpdateTime < receiverLastUpdateTime) {
      return value.senderMessage.updatedAt;
    }

    return value.receiverMessage.updatedAt;
  }

  int timeInMinutes(DateTime update) {
    final startTime = DateTime(2020, 02, 20, 10, 30);
    final currentTime = DateTime.now();

    final diff_dy = currentTime.difference(update).inDays;
    final diff_hr = currentTime.difference(update).inHours;
    final diff_mn = currentTime.difference(update).inMinutes;
    final diffSc = currentTime.difference(update).inSeconds;

    print(diff_dy);
    print(diff_hr);
    print(diff_mn);
    print(diffSc);
    return diffSc;
  }
}
