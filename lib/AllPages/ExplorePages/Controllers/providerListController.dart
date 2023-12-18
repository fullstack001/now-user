import 'dart:convert';

import 'package:application_1/remote_model/main_services/main_services_response.dart';
import 'package:application_1/remote_model/service_questions/service_question_response.dart';
import 'package:application_1/resources/repositories/service_repository.dart';
import 'package:application_1/utils/app_dialog_utils.dart';
import 'package:get/get.dart';

class ProviderListController extends GetxController {
  int id = 0;

  var mainServices = [].obs;
  var allServices = [].obs;
  var filterList = [].obs;

  ProviderListController({flag}) {
    bool checkFlag = flag ?? false;

    if (checkFlag) {
      getMainServices(flag: checkFlag);
    }
  }

  setSelected(int val) {
    id = val;
    update();
  }

  void getMainServices({flag = false}) async {
    if (!flag) {
      AppDialogUtils.dialogLoading();
    }
    await ServiceReposiotry()
        .getMainServices()
        .then((MainServicesResponse? response) {
      if (response != null) {
        if (response.error) {
          // AppDialogUtils.errorDialog("${response.message}");
        } else {
          allServices.clear();
          AppDialogUtils.dismiss();
          if (response.mainServicesData != null) {
            mainServices(response.mainServicesData);
            for (int index = 0;
                index < response.mainServicesData.length;
                index++) {
              if (response.mainServicesData[index].subServices.isNotEmpty) {
                allServices
                    .addAll(response.mainServicesData[index].subServices);
              }
            }
          }
          // print("all services: ${allServices.length}");
        }
      } else {
        AppDialogUtils.dismiss();
      }
    });
  }

  void getQuestions(int id, {onResponse}) async {
    AppDialogUtils.dialogLoading();
    try {
      ServiceQuestionResponse response =
          await ServiceReposiotry().getQuestions(id);
      if (response.error) {
        AppDialogUtils.errorDialog("Server error!");
      } else {
        AppDialogUtils.dismiss();
        print("${mainServices.length}");
        String question = json.encode(response.data.toJson());
        onResponse(question);
      }
    } catch (exception) {
      print("exception $exception");
    }
  }
}
