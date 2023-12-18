import 'package:application_1/AllPages/introPages/intro_controller.dart';
import 'package:application_1/AllPages/moving/controllers/dashboard_controller.dart';
import 'package:application_1/model/location_detail/location_detail_response.dart';
import 'package:application_1/model/prediction/predictions.dart';
import 'package:application_1/model/zip_search/zip_search_list.dart';
import 'package:application_1/model/zip_search/zip_search_response.dart';
import 'package:application_1/resources/repositories/service_repository.dart';
import 'package:application_1/utils/api_utils.dart';
import 'package:application_1/utils/app_dialog_utils.dart';
import 'package:application_1/widgets/custom_container.dart';
import 'package:application_1/widgets/text_with_icon.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchAddressScreen extends StatelessWidget {
  var onAddressSelect;
  var zipCode;

  SearchAddressScreen({this.onAddressSelect, this.zipCode});
  IntroController _introController = Get.find();
  DashboardController _dashboardController = Get.find();

  @override
  Widget build(BuildContext context) {
    bool zip = zipCode ?? false;
    return Scaffold(
      backgroundColor: const Color(0xffE5E5E5).withOpacity(0.5),
      body: SafeArea(
        child: Column(
          children: [
            CustomContainer(
              allRadius: 0,
              width: Get.width,
              height: 45,
              paddingLeft: 12,
              color: Colors.white,
              child: Row(
                children: [
                  Container(
                    child: InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: const Icon(Icons.arrow_back)),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Text(
                    zip ? "Select Zipcode" : "Select Address",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
            zip
                ? CustomContainer(
                    width: Get.width,
                    height: 45,
                    color: Colors.white,
                    marginTop: 12,
                    marginLeft: 24,
                    marginRight: 24,
                    allRadius: 12,
                    shadowColor: Colors.black45.withOpacity(0.5),
                    shadowSpreadRadius: 2,
                    shadowBlurRadius: 6,
                    shadowOffsetX: 3,
                    shadowOffsetY: 3,
                    paddingLeft: 12,
                    paddingRight: 12,
                    child: TextField(
                      decoration: const InputDecoration(
                        hintText: "Enter zipcode",
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent)),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                      ),
                      onChanged: (value) async {
                        if (value.isEmpty) {
                          _dashboardController.zipCodes.clear();
                          _dashboardController.zipCodes.refresh();
                        } else {
                          if (value.length >= 1) {
                            ZipSearchResponse response =
                                await ServiceReposiotry().searchZipCode(
                                    value.toString(), 2,
                                    moving: true,
                                    subId: _dashboardController
                                        .bookingMap['vehicle_type_id']);
                            if (response.message.toString().toLowerCase() ==
                                "not found") {
                              alertDialog(
                                  content: "Provider not exist on this zipcode",
                                  title: "Alert",
                                  confirm: MaterialButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: const Text("Okay"),
                                  ));
                            } else {
                              _dashboardController.zipCodes(
                                  response.zipSearchData.zipSearchList);
                            }
                            print(response.toJson().toString());
                          }
                        }
                      },
                    ),
                  )
                : CustomContainer(
                    width: Get.width,
                    height: 45,
                    color: Colors.white,
                    marginTop: 12,
                    marginLeft: 24,
                    marginRight: 24,
                    allRadius: 12,
                    shadowColor: Colors.black45.withOpacity(0.5),
                    shadowSpreadRadius: 2,
                    shadowBlurRadius: 6,
                    shadowOffsetX: 3,
                    shadowOffsetY: 3,
                    paddingLeft: 12,
                    paddingRight: 12,
                    child: TextField(
                      decoration: const InputDecoration(
                        hintText: "Enter your address",
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent)),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                      ),
                      onChanged: (value) {
                        if (value.isEmpty) {
                          _dashboardController.predictionResult.clear();
                          _dashboardController.predictionResult.refresh();
                        } else {
                          _dashboardController.searchAddress(value);
                        }
                      },
                    ),
                  ),
            Expanded(
              child: Obx(
                () => zip
                    ? ListView.builder(
                        itemCount: _dashboardController.zipCodes.length,
                        itemBuilder: (BuildContext context, int index) {
                          ZipSearchList value =
                              _dashboardController.zipCodes.value[index];
                          return TextWithIcon(
                            width: Get.width,
                            marginLeft: 24,
                            containerClick: () {
                              onAddressSelect("abc", "latLng", value.code);
                              Get.back();
                            },
                            marginTop: index == 0 ? 12 : 6,
                            marginBottom: index ==
                                    _dashboardController.zipCodes.length - 1
                                ? 12
                                : 0,
                            marginRight: 24,
                            alignment: MainAxisAlignment.start,
                            title: "${value.code}",
                            paddingAll: 6,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          );
                        },
                      )
                    : ListView.builder(
                        itemCount: _dashboardController.predictionResult.length,
                        itemBuilder: (BuildContext context, int index) {
                          Predictions value =
                              _dashboardController.predictionResult[index];
                          return TextWithIcon(
                            containerClick: () async {
                              Get.focusScope!.unfocus();
                              String request =
                                  "https://maps.googleapis.com/maps/api/place/details/json?placeid=${value.placeId}&key=${ApiUtills.mapKey}";
                              Dio dio = Dio();
                              var response = await dio.post(request);
                              print("");
                              AppDialogUtils.dialogLoading();
                              LocationDetailResponse detail =
                                  LocationDetailResponse.fromJson(
                                      response.data);
                              String latLng =
                                  "${detail.result.geometry.location.lat},${detail.result.geometry.location.lng}";
                              print("OK");
                              onAddressSelect(
                                  value.description, latLng, "1002");
                              AppDialogUtils.dismiss();
                              Get.back();
                            },
                            marginLeft: 24,
                            marginTop: index == 0 ? 24 : 16,
                            marginBottom: index ==
                                    _dashboardController
                                            .predictionResult.length -
                                        1
                                ? 12
                                : 0,
                            marginRight: 24,
                            flex: 1,
                            fontSize: 14,
                            width: Get.width,
                            alignment: MainAxisAlignment.start,
                            title: value.description,
                          );
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
