import 'dart:async';

import 'package:application_1/AllPages/ExplorePages/ProviderList.dart';
import 'package:application_1/AllPages/ExplorePages/shopMenu.dart';
import 'package:application_1/AllPages/introPages/questionPages/models/button_selection_model.dart';
import 'package:application_1/model/location_detail/address_components.dart';
import 'package:application_1/model/zip_search/zip_search_data.dart';
import 'package:application_1/model/zip_search/zip_search_response.dart';
import 'package:application_1/remote_model/provider_list/provider_list_response_model.dart';
import 'package:application_1/remote_model/service_questions/service_question_data.dart';
import 'package:application_1/resources/repositories/service_repository.dart';
import 'package:application_1/utils/api_utils.dart';
import 'package:application_1/utils/app_dialog_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jumping_dot/jumping_dot.dart';
import 'package:loading_overlay_pro/loading_overlay_pro.dart';

import '../../model/postal_code/Postal_code_response.dart';

class IntroController extends GetxController {
  var homeType = "Apartment / Condo".obs;
  var whatBest = "Renter".obs;
  var address = "".obs;
  var zipCode = "".obs;
  var selectZipCode = "".obs;
  var selectedAddrexx = "".obs;

  var visibleKeyboard = false.obs;

  var selectedService = "".obs;
  var selectedZipCode = "".obs;
  var selectedAddress = "".obs;
  var selectedServiceId = -1.obs;
  var selectedSeriveName = "".obs;
  var resp = ServiceQuestionData().obs;
  var predictionResults = [].obs;
  var components = [].obs;
  var locationList = [].obs;
  var providerData = Data().obs;
  var providerListData = [].obs;
  var filterproviderListData = [].obs;
  var zipCodeList = [].obs;
  var filter = false.obs;
  var zipCodeData = ZipSearchData().obs;
  List<ButtonSelectionModel> buttonModel = List<ButtonSelectionModel>.from([
    ButtonSelectionModel(title: "See Inspiration", selected: true),
    ButtonSelectionModel(title: "Hire a pro", selected: false),
    ButtonSelectionModel(title: "Plan my project", selected: false),
    ButtonSelectionModel(title: "Browse pros", selected: false),
    ButtonSelectionModel(title: "Compare prices", selected: false),
    ButtonSelectionModel(title: "Other", selected: false),
  ]);

  reset(List<ButtonSelectionModel> buttonModel) {
    this.buttonModel = buttonModel;
    update();
  }

  double progress = 0;
  updateProgress(double a) {
    print(a);
    progress = a;
    update();
  }

  void getProviderListFilter(var zipCode, selectedServiceId,
      {hourly = false,
      quotation = false,
      start_slot = "",
      end_slot = "",
      rating = 0,
      filter = true,
      afterCall}) async {
    if (filter) AppDialogUtils.dialogLoading();

    await ServiceReposiotry()
        .getProviderListFilter(zipCode,
            subServiceId: selectedServiceId,
            hourly: hourly,
            quotation: quotation,
            start_slot: start_slot,
            end_slot: end_slot,
            rating: rating)
        .then((ProviderListResponse? response) {
      if (response != null) {
        Get.back();
        if (filter) AppDialogUtils.dismiss();
        if (response.error) {
          AppDialogUtils.errorDialog(response.message.toString());
        } else {
          providerData.value = response.providerListData;
          providerListData(response.providerListData.data);
          providerListData.refresh();
          if (afterCall != null) {
            afterCall();
          }

          Get.replace(ProviderList());
          // Get.to(ProviderList.new,
          //     fullscreenDialog: true, transition: Transition.upToDown);
        }
      } else {
        Get.back();
        if (filter) AppDialogUtils.dismiss();
      }
    });
  }

  void getProviderList(selectedServiceId, placeid) async {
    providerListData.clear();
    try {
      await ServiceReposiotry()
          .getProviderList(placeId: placeid, subServiceId: selectedServiceId)
          .then((ProviderListResponse response) {
        if (response != null) {
          Get.back();
          if (response.message == "No provider found") {
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
                "${response.message.toLowerCase() == "No provider found" ? "Provider List ${response.message}" : "Backend Server error"}");
          } else {
            providerData(response.providerListData);
            providerListData(response.providerListData.data);

            providerListData.refresh();
            Get.to(() => ProviderList(),
                transition: Transition.upToDown,
                duration: Duration(milliseconds: 500));
          }
        }
      });
    } catch (exception) {
      print("exception $exception");
    }
  }

  getPostalCode(data) {
    var list = data;
    // (data['result']['address_components'] as List<dynamic>)[7]['types'][0];
    for (int index = 0; index < list.length; index++) {
      AddressComponents components = list[index];
      String type = components.types[0];
      if (type.contains("postal_code_suffix") || type.contains("postal_code")) {
        zipCode(list[index].longName);
        return list[index].longName;
      }
    }
    return "n/a";
  }

  void searchZipCode(String zipCode,
      {pageSize, upDate, subId, cityId, countryId}) async {
    pageSize = pageSize ?? 1;
    try {
      ZipSearchResponse response = await ServiceReposiotry().searchZipCode(
        zipCode.toString(),
        pageSize,
        subId: subId,
        cityId: cityId,
        countryId: countryId,
      );
      if (!response.error) {
        print("zip List");
        zipCodeData(response.zipSearchData);
        if (pageSize != 1) {
          zipCodeList.addAll(response.zipSearchData.zipSearchList);
          if (upDate != null) {
            upDate();
          }
        } else {
          zipCodeList(response.zipSearchData.zipSearchList);
        }
      }
    } catch (exception) {
      print("exception $exception");
    }
  }

  void searchPlace(String value) {
    ServiceReposiotry()
        .searchPlaceByZip(value)
        .then((PostalCodeResponse? value) {
      locationList.clear();
      if (value != null) {
        locationList.addAll(value.results);
        locationList.refresh();
      }
    });
  }

  String selectedUI = "filter";
  updateSelctedUI(String value) {
    selectedUI = value;
    update();
  }

  String selectedFilter = "morning";

  updateSlotFilter(String value) {
    selectedFilter = value;
    selectedFilterSlotIndex = -1;
    updateSelectedFilterSlot(value);
    update();
  }

  updateSelectedFilter(String value) {
    selectedFilter = value;

    update();
  }

  int selectedFilterSlotIndex = -1;
  updateSelectedFilterSlotIndex(int i) {
    selectedFilterSlotIndex = i;
    update();
  }

  List<String> selectedFilterSlot = <String>[
    "6AM - 7AM",
    "7AM - 8AM",
    "8AM - 9AM",
    "9AM - 10AM",
    "10AM - 11AM",
    "11AM - 12PM",
  ];
  String filterselectedSlot = "morning";
  updateSelectedFilterSlot(String value) {
    selectedFilterSlot.assignAll(slots[value]);
    update();
  }

  Map<String, dynamic> slots = {
    "morning": <String>[
      "6AM - 7AM",
      "7AM - 8AM",
      "8AM - 9AM",
      "9AM - 10AM",
      "10AM - 11AM",
      "11AM - 12PM",
    ],
    "afternoon": <String>[
      "12PM - 1PM",
      "1PM - 2PM",
      "2PM - 3PM",
      "3PM - 4PM",
      "4PM - 5PM",
    ],
    "evening": <String>[
      "5PM - 6PM",
      "6PM - 7PM",
      "7PM - 8PM",
      "8PM - 9PM",
      "9PM - 10PM",
    ],
    "night": <String>[
      "10PM - 11PM",
      "11PM - 12AM",
      "1AM - 2PM",
      "2AM - 3PM",
      "3AM - 4PM",
      "4AM - 5PM",
      "5AM - 6PM",
    ]
  };
}
