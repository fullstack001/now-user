import 'dart:convert';

import 'package:application_1/All_Refrences/shared_refrence.dart';
import 'package:application_1/App_Routes/app_routes.dart';
import 'package:application_1/model/order_status/order_status_response.dart';
import 'package:application_1/model/service_response/service_data.dart';
import 'package:application_1/model/service_response/service_list_data.dart';
import 'package:application_1/model/service_response/service_response.dart';
import 'package:application_1/resources/repositories/service_repository.dart';
import 'package:application_1/utils/api_utils.dart';
import 'package:application_1/utils/app_dialog_utils.dart';
import 'package:application_1/utils/date_time_utils.dart';
import 'package:get/get.dart';

import '../../../remote_model/country/Country_list_model.dart';
import '../../../utils/project_widget.dart';
import '../project.dart';

class HomeScreenController extends GetxController {
  var availableJos = ServiceData().obs;
  ServiceReposiotry _serviceReposiotry = ServiceReposiotry();
  int count = 0;
  int updateTry = 0;
  var requested = [].obs;
  var rejected = [].obs;
  var charRequest = [].obs;
  var accepted = [].obs;
  var onGoing = [].obs;
  var complete = [].obs;
  var moving = [].obs;
  var zipFilters = [].obs;
  var countryList = [].obs;
  var selectedId = 0.obs;
  var selectedCountryIndex = 0.obs;
  var cityId = 0.obs;
  var cityName = "".obs;
  var timmerResponse = TimmerResponse().obs;
  var orderStatus = OrderStatusResponse().obs;

  HomeScreenController({flag}) {
    getCountryList();
    bool check = flag ?? false;
    if (!check) {
      getAvailableJobs(flag: check);
    }
  }

  // void recursiveCall() {
  //   getAvailableJobs(flag: true);
  //   Future.delayed(Duration(seconds: 5)).then((value) {
  //     recursiveCall();
  //     print("call init");
  //   });
  // }

  getCountryList() async {
    await _serviceReposiotry.getCountryList().then((CountryListModel? value) {
      if (value != null) {
        countryList(value.data);
        if (value.data != null) {
          selectedId.value = value.data!.first.id!;

          if (value.data!.first.cities!.isNotEmpty) {
            cityId.value = value.data!.first.cities!.first.id!;
            selectedCountryIndex(value.data!.first.id);
          }
        }
      }
    });
  }

  void getAvailableJobs({flag, feedbk}) async {
    bool checkFlag = flag ?? false;
    if (availableJos.value.serviceListData != null) {
      availableJos.value.serviceListData.clear();
    }
    if ((availableJos.value.serviceListData ?? []).isEmpty) {
      if (!checkFlag) {
        AppDialogUtils.dialogLoading();
      }
    }

    String authToken =
        await SharedRefrence().getString(key: ApiUtills.authToken);
    print(authToken);

    await _serviceReposiotry
        .getAvailableJobs(authToken)
        .then((ServiceResponse? response) {
      AppDialogUtils.dismiss();
      if (response != null) {
        if (!response.error) {
          for (int index = 0;
              index < response.serviceData.serviceListData.length;
              index++) {
            DateTime now = DateTime.now();
            DateTime jobTime = DateTimeUtils().convertStringSeconds(
                response.serviceData.serviceListData[index].createdAt);

            int seconds = now.difference(jobTime).inSeconds;
            response.serviceData.serviceListData[index].seconds = seconds;
          }
          List service = response.serviceData.serviceListData;
          service.sort((a, b) => a.createdAt.compareTo(b.createdAt));
          var data = json.encode(response.toJson());
          SharedRefrence().saveString(key: "orders", data: data);

          // service = service.reversed.toList();
          response.serviceData.serviceListData = service;
          List<ServiceListData> newList = [];
          for (int index = 0;
              index < response.serviceData.serviceListData.length;
              index++) {
            if (response.serviceData.serviceListData[index].workedHours !=
                null) {
              if (response.serviceData.serviceListData[index].paidAmount !=
                  null) {
                newList.add(response.serviceData.serviceListData[index]);
              }
            }
          }
          // response.serviceData.serviceListData = newList;
          availableJos(response.serviceData);
          filterData(response.serviceData);
          if (feedbk != null) {
            if (feedbk) {
              Get.offNamedUntil(AppRoutes.TABSCREEN, (route) => false);
            }
          }
        }
      }
    });
  }

  void updateStatus(int id, String status, {newStatus}) async {
    if (updateTry >= 2) {
      updateTry = 0;
    }
    AppDialogUtils.dialogLoading();
    try {
      String authToken =
          await SharedRefrence().getString(key: ApiUtills.authToken);

      await _serviceReposiotry
          .updateStatus(authToken, id, status)
          .then((respons) {
        var response = json.decode(respons);
        AppDialogUtils.dismiss();
        if (!response['error']) {
          getAvailableJobs(flag: true);
          if (newStatus != null) {
            newStatus(respons);
          }
        } else {
          AppDialogUtils.errorDialog(response.message);
        }
      });
    } catch (e) {
      // if (updateTry < 2) {
      //   updateStatus(
      //     id,
      //     status,
      //     newStatus: newStatus,
      //   );
      //   print("try $updateTry");
      //   updateTry = updateTry + 1;
      // } else {
      //   updateTry = 0;
      //   AppDialogUtils.errorDialog("Server Error");
      //   AppDialogUtils.dismiss();
      //   print("error");
      // }
    }
  }

  Future<dynamic> getService(String serviceRequestId) async {
    String authToken =
        await SharedRefrence().getString(key: ApiUtills.authToken);

    await _serviceReposiotry
        .getAvailableJobs(authToken)
        .then((ServiceResponse? response) {
      if (response != null) {
        if (response.error) {
          return "true";
        } else {
          for (int index = 0;
              index < response.serviceData.serviceListData.length;
              index++) {
            if (response.serviceData.serviceListData[index].id.toString() ==
                serviceRequestId.toString()) {
              return response.serviceData.serviceListData[index];
            }
          }
          return "true";
        }
      }
    });
  }

  void filterData(ServiceData serviceData) {
    serviceData.serviceListData = serviceData.serviceListData.reversed.toList();
    requested.value.clear();
    rejected.value.clear();
    charRequest.value.clear();
    complete.value.clear();
    accepted.value.clear();
    onGoing.value.clear();
    for (int index = 0; index < serviceData.serviceListData.length; index++) {
      ServiceListData value = serviceData.serviceListData[index];
      if (value.status.toString().toLowerCase() == "pending" &&
          value.directContact == 0) {
        requested.value.add(value);
        requested(requested.value);
        update();
      } else if (value.status.toString().toLowerCase() == "rejected" &&
          value.directContact == 0) {
        rejected.value.add(value);
        rejected(rejected.value);
        update();
      } else if (value.status.toString().toLowerCase() == "accepted" &&
          value.isCompleted == 0 &&
          value.workingStatus.toString().toLowerCase() != "started" &&
          value.directContact == 0) {
        accepted.value.add(value);
        accepted(accepted.value);
        update();
      } else if (value.status.toString().toLowerCase() == "accepted" &&
          value.isCompleted == 0 &&
          value.workingStatus.toString().toLowerCase() == "started" &&
          value.directContact == 0) {
        onGoing.value.add(value);
        onGoing(onGoing.value);
        update();
      } else if (value.isCompleted == 0 && value.directContact == 1) {
        charRequest.value.add(value);
        charRequest(charRequest.value);
        update();
      } else if (value.isCompleted == 1) {
        complete.value.add(value);
        complete(complete.value);
        update();
      }
    }
    print("requested: ${requested.value.length}\n"
        "rejected: ${rejected.value.length}\n"
        "accepted: ${accepted.value.length}\n"
        "onGoing: ${onGoing.value.length}\n"
        "complete: ${complete.value.length}\n"
        "charRequest: ${charRequest.value.length}\n");
  }

  Future<void> cancelRequest(id) async {
    print("$id");
    AppDialogUtils.dialogLoading();
    try {
      String authToken =
          await SharedRefrence().getString(key: ApiUtills.authToken);

      var response =
          await _serviceReposiotry.cancelRequest(authToken, id.toString());
      getAvailableJobs(flag: false);
    } catch (ex) {
      print("error $ex");
    }
  }

  void getOrderStatus(id, {upDateView, flag}) async {
    bool hide = flag ?? false;
    if (hide) {
      AppDialogUtils.dialogLoading();
    }
    try {
      String authToken =
          await SharedRefrence().getString(key: ApiUtills.authToken);
      OrderStatusResponse obj =
          await _serviceReposiotry.getOrderStatus(authToken, id);
      if (!obj.error) {
        orderStatus(obj);
        if (upDateView != null) {
          upDateView();
        }
      }

      AppDialogUtils.dismiss();
    } catch (e) {
      print("$e");
      AppDialogUtils.dismiss();
    }
  }

  getTimeFromPrefs() async {
    String res = await SharedRefrence().getString(key: "time");
    if (res.isNotEmpty) {
      var obj = json.decode(res);
      timmerResponse(TimmerResponse.fromJson(obj));
    }
  }
}

class TimmerResponse {
  var timerData;

  TimmerResponse({this.timerData});

  TimmerResponse.fromJson(dynamic json) {
    if (json["timer_data"] != null) {
      timerData = [];
      json["timer_data"].forEach((v) {
        timerData.add(TimerData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (timerData != null) {
      map["timer_data"] = timerData.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class TimerData {
  var serviceRequestId;
  var isPaused;
  var time;
  var type;
  var pauseTime;

  TimerData({
    this.serviceRequestId,
    this.isPaused,
    this.time,
    this.type,
    this.pauseTime,
  });

  TimerData.fromJson(dynamic json) {
    serviceRequestId = json["service_request_id"];
    isPaused = json["is_paused"];
    time = json["time"];
    type = json["type"];
    pauseTime = json["pause_time"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["service_request_id"] = serviceRequestId;
    map["is_paused"] = isPaused;
    map["time"] = time;
    map["type"] = type;
    map["pause_time"] = pauseTime;
    return map;
  }
}
