import 'dart:convert';

import 'package:application_1/resources/repositories/service_repository.dart';

import 'package:get/get.dart';

import '../../All_Refrences/shared_refrence.dart';
import '../../utils/api_utils.dart';
import '../../utils/app_dialog_utils.dart';
import 'model/subscribe_plan.dart';

class PackageController extends GetxController {
  bool isShow = true;
  updateIsShow(bool value) {
    isShow = value;
    update();
  }

  bool isLoading = false;

  // List<Datum> planListData = [];
  // updatePlanList(List<Datum> data) {
  //   planListData.assignAll(data);
  //   update();
  // }

// {error: true, message: {title: The title has already been taken.}}

  @override
  void onInit() {
    subscribePackageList();
    super.onInit();
  }

  deletePackage({id}) async {
    AppDialogUtils.dialogLoading();
    String authToken =
        await SharedRefrence().getString(key: ApiUtills.authToken);
    await ServiceReposiotry()
        .deletePackagePlan(id: id, authToken: authToken)
        .then((String? value) async {
      AppDialogUtils.dismiss();
      if (value != null) {
        var json = jsonDecode(value);
        if (!json["error"]) {
          await subscribePackageList();
          Get.back();
          AppDialogUtils.successDialog(json["message"]);
        } else {
          Get.back();
          AppDialogUtils.errorDialog(json["message"]);
        }
      }
    });
    AppDialogUtils.dismiss();
  }

  List<SubscribeData> subscribeplan = [];
  updataData(List<SubscribeData> data) {
    subscribeplan = data;
    update();
  }

  subscribePackageList() async {
    subscribeplan.clear();
    try {
      String authToken =
          await SharedRefrence().getString(key: ApiUtills.authToken);
      await ServiceReposiotry()
          .getSubscribePackage(authToken: authToken)
          .then((value) {
        print(value);
        updataData(value.data);
      });
    } catch (e) {
      print(e);
    }
  }
}
