import 'package:application_1/AllPages/moving/model/booking_model.dart';
import 'package:application_1/AllPages/moving/model/dashboard_model.dart';
import 'package:application_1/AllPages/moving/screes/drivers_list_screen.dart';
import 'package:application_1/AllPages/moving/screes/moving_dashboard_screen.dart';
import 'package:application_1/All_Refrences/shared_refrence.dart';
import 'package:application_1/App_Routes/app_routes.dart';
import 'package:application_1/model/prediction/prediction_respnse.dart';
import 'package:application_1/model/vehicle_list/vehicle_response.dart';
import 'package:application_1/remote_model/provider_list/provider_list_response_model.dart';
import 'package:application_1/resources/Api_Services/services.dart';
import 'package:application_1/resources/repositories/service_repository.dart';
import 'package:application_1/screens/Controllers/tabScreenController.dart';
import 'package:application_1/utils/api_utils.dart';
import 'package:application_1/utils/app_dialog_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  var dashboardList = [].obs;
  var screenSelected = [true, false].obs;
  var hideArrow = false.obs;
  var selectedDate = "".obs;
  var predictionResult = [].obs;
  var bookingData = BookingModel().obs;
  Map bookingMap = <String, dynamic>{};
  var zipCodes = [].obs;
  var driverData = ProviderListResponse().obs;

  var fromError = false.obs;
  var toError = false.obs;
  var zipCodeError = false.obs;
  var movingDateError = false.obs;
  var filterClick = false.obs;

  ServiceReposiotry _reposiotry = ServiceReposiotry();

  createList() {
    List<DashboardModel> list = [
      DashboardModel(
        name: "Book Mini Truck",
        icon: getIcon('assets/icons/ic_mini_truck.svg'),
        selected: true,
      ),
      DashboardModel(
        name: "Book Pickup",
        icon: getIcon('assets/icons/ic_pickup.svg'),
        selected: false,
      ),
      DashboardModel(
        name: "Book Van",
        icon: getIcon('assets/icons/ic_van.svg'),
        selected: false,
      ),
      DashboardModel(
        name: "Book Mega Truck",
        icon: getIcon('assets/icons/ic_mega_truck.svg'),
        selected: false,
      ),
      DashboardModel(
        name: "Book Mini Moto",
        icon: getIcon('assets/icons/ic_mini_moto.svg'),
        selected: false,
      ),
      DashboardModel(
        name: "Book Mini",
        icon: getIcon('assets/icons/ic_scooter.svg'),
        selected: false,
      ),
    ];
    if (dashboardList.isEmpty) {
      dashboardList(list);
      refreshView();
    }
  }

  getIcon(String icon) {
    return SvgPicture.asset(icon);
  }

  setCurrentScreen(index) {
    List<bool> list = [false, false];
    list[index] = true;
    hideArrow.value = list.length - 1 == index ? true : false;
    screenSelected(list);
    refreshView();
  }

  refreshView() {
    update();
    refresh();
  }

  void setDashboardSelected(index) {
    List list = dashboardList.value;
    for (int index = 0; index < list.length; index++) {
      list[index].selected = false;
    }
    list[index].selected = true;
    print("name: ${list[index].title}");
    dashboardList(list);
    dashboardList.refresh();
    refreshView();
  }

  void setDate(String picked) {
    selectedDate(picked);
    refreshView();
  }

  void getVehicleList() async {
    try {
      AppDialogUtils.dialogLoading();
      VehicleResponse response = await _reposiotry.getVheicleList();
      if (!response.error) {
        for (int index = 0; index < response.vehicleData.length; index++) {
          if (index == 0) {
            response.vehicleData[index].selected = false;
          } else {
            response.vehicleData[index].selected = false;
          }
        }
        dashboardList(response.vehicleData);
        dashboardList.refresh();
        refreshView();
        Get.to(() => MovingDashboardScreen());
      }
      AppDialogUtils.dismiss();
    } catch (ex) {
      print("$ex");
      AppDialogUtils.dismiss();
    }
  }

  void setData({key, data}) {
    Map temp = bookingMap;
    temp[key] = data;
    bookingMap = temp;
    getData();
  }

  getData() {
    print(bookingMap.toString());
    BookingModel temp = BookingModel.fromJson(bookingMap);
    bookingData(temp);
    bookingData.refresh();
    refreshView();
  }

  void searchAddress(String value) async {
    await Services().searchPlaceByZip(value).then((PredictionResponse? result) {
      if (result != null) {
        predictionResult(result.predictions);
        predictionResult.refresh();
      }
    });
  }

  void getDriverList(zipCode, vId) async {
    // Get.to(() => DriversListScreen());

    AppDialogUtils.dialogLoading();

    await ServiceReposiotry()
        .getProviderList(zipCode: zipCode, moving: true, vId: vId)
        .then((ProviderListResponse? response) {
      AppDialogUtils.dismiss();
      if (response != null) {
        if (response.message == "not found") {
          Get.defaultDialog(
              title: "Alert",
              content: Text("Provider list not found"),
              confirm: MaterialButton(
                onPressed: () {
                  Get.back();
                },
                child: Text(
                  "Okay",
                  style: getStyle(fontSize: 16),
                ),
              ));
        } else if (response.error) {
          AppDialogUtils.errorDialog(
              "${response.message.toLowerCase() == "not found" ? "Provider List ${response.message}" : "Server error"}");
        } else {
          driverData(response.providerListData);
          Get.to(() => DriversListScreen());
        }
      }
    });
  }

  void bookDriver(Map<dynamic, dynamic> body) async {
    TabScreenController _tab = Get.find();
    try {
      AppDialogUtils.dialogLoading();
      String authToken =
          await SharedRefrence().getString(key: ApiUtills.authToken);
      var response = await _reposiotry.bookDriver(body, authToken);
      if (response) {
        Get.offNamedUntil(AppRoutes.TABSCREEN, (route) => false);
        _tab.setTabIndex(1);
        resetData();
      }
      AppDialogUtils.dismiss();
    } catch (ex) {
      print("$ex");
      AppDialogUtils.dismiss();
    }
  }

  bool vehicleSelected() {
    if (bookingData.value == null) {
      return false;
    }
    if (bookingData.value.vehicleId == null) {
      return false;
    }
    if (bookingData.value.vehicleId!.isNotEmpty) {
      return true;
    }
    if (bookingData.value.vehicleId!.isEmpty) {
      return false;
    }
    return false;
  }

  resetData() {
    bookingData(null);
  }
}
