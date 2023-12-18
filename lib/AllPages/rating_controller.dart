import 'package:application_1/All_Refrences/shared_refrence.dart';
import 'package:application_1/resources/repositories/service_repository.dart';
import 'package:application_1/utils/api_utils.dart';
import 'package:application_1/utils/app_dialog_utils.dart';
import 'package:get/get.dart';

class RatingController extends GetxController {
  ServiceReposiotry _serviceReposiotry = ServiceReposiotry();
  sendFeedback({body, onSendFeedback}) async {
    AppDialogUtils.dialogLoading();
    try {
      String authToken =
          await SharedRefrence().getString(key: ApiUtills.authToken);
      var response = await _serviceReposiotry.sendFeedback(
          authToken: authToken, body: body);
      print("");
      if (onSendFeedback != null) {
        onSendFeedback();
      }
      AppDialogUtils.dismiss();
    } catch (ex) {
      AppDialogUtils.dismiss();
      print("Error $ex");
    }
  }
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    cardIndex=0;
  }

  int cardIndex = 0;
  increamentIndexofCard() {
    cardIndex++;
    update();
  }

  decreamentIndexofCard() {
    if (cardIndex > 0) {
      cardIndex--;
    }
    update();
  }

  resetIndex() {
    cardIndex = 0;
    print(cardIndex);
    update();
  }
}
