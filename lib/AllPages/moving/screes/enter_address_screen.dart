import 'package:application_1/AllPages/moving/controllers/dashboard_controller.dart';
import 'package:application_1/AllPages/moving/screes/search_address_screen.dart';
import 'package:application_1/utils/AppColors.dart';
import 'package:application_1/utils/date_time_utils.dart';
import 'package:application_1/widgets/custom_container.dart';
import 'package:application_1/widgets/text_with_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class EnterAddressScreen extends StatelessWidget {
  final obBackClick;

  EnterAddressScreen({this.obBackClick});

  DashboardController _dashboardController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: Get.height,
      child: Obx(() => ListView(
            children: [
              CustomContainer(
                allRadius: 0,
                width: Get.width,
                marginTop: 12,
                color: Colors.transparent,
                paddingLeft: 12,
                child: Row(
                  children: [
                    Container(
                      child: InkWell(
                        onTap: () {
                          obBackClick(0);
                        },
                        child: Icon(
                          Icons.arrow_back,
                          color: AppColors.appBlue,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Text(
                      "Select Your Moving Location",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 74,
              ),
              CustomContainer(
                width: Get.width,
                height: 180,
                marginLeft: 24,
                marginRight: 24,
                child: SvgPicture.asset(
                  "assets/icons/ic_address_placeholer.svg",
                  width: Get.width,
                ),
              ),
              SizedBox(
                height: 16,
              ),
              CustomContainer(
                  width: Get.width,
                  color: Color(0xffB8C6F2),
                  allRadius: 0,
                  marginLeft: 24,
                  marginRight: 24,
                  paddingLeft: 24,
                  paddingRight: 24,
                  gradientColor: [Color(0xff9C6CBEEC), Color(0xff3394E6)],
                  child: Column(
                    children: [
                      SizedBox(
                        height: 43,
                      ),
                      addressField(
                          title: " Moving From",
                          hint:
                              "${_dashboardController.bookingData.value.movingFrom == null ? "Start Address" : _dashboardController.bookingData.value.movingFrom}",
                          onTap: () {
                            _dashboardController.predictionResult.clear();
                            Get.to(() => SearchAddressScreen(
                                  onAddressSelect: (address, latLng, zipCode) {
                                    print("$address\n$latLng");
                                    _dashboardController.setData(
                                        key: "from_address", data: address);
                                    _dashboardController.fromError(false);
                                    var latlng = latLng.toString().split(",");
                                    _dashboardController.setData(
                                        key: "start_lat",
                                        data: latlng[0].toString().trim());
                                    _dashboardController.setData(
                                        key: "start_lng",
                                        data: latlng[1].toString().trim());
                                  },
                                ));
                          },
                          onChange: (value) {}),
                      if (_dashboardController.fromError.value) errorText(),
                      SizedBox(
                        height: 18,
                      ),
                      addressField(
                          title: "Moving To",
                          hint:
                              "${_dashboardController.bookingData.value.movingTo == null ? "End Address" : _dashboardController.bookingData.value.movingTo}",
                          onTap: () {
                            _dashboardController.predictionResult.clear();
                            Get.to(() => SearchAddressScreen(
                                  onAddressSelect: (address, latLng, zipCode) {
                                    print("$address\n$latLng");
                                    _dashboardController.setData(
                                        key: "to_address", data: address);
                                    var latlng = latLng.toString().split(",");
                                    _dashboardController.toError(false);
                                    _dashboardController.setData(
                                        key: "end_lat",
                                        data: latlng[0].toString().trim());
                                    _dashboardController.setData(
                                        key: "end_lng",
                                        data: latlng[1].toString().trim());
                                  },
                                ));
                          }),
                      if (_dashboardController.toError.value) errorText(),
                      SizedBox(
                        height: 18,
                      ),
                      addressField(
                          title: "Zip code",
                          hint:
                              "${_dashboardController.bookingData.value.zipCode == null ? "Zip code" : _dashboardController.bookingData.value.zipCode}",
                          onTap: () {
                            _dashboardController.zipCodes.clear();
                            _dashboardController.zipCodes.refresh();
                            Get.to(() => SearchAddressScreen(
                                  onAddressSelect: (address, latLng, zipCode) {
                                    print("$address\n$zipCode");
                                    _dashboardController.zipCodeError(false);
                                    _dashboardController.setData(
                                        key: "zip_code", data: zipCode);
                                  },
                                  zipCode: true,
                                ));
                          }),
                      if (_dashboardController.zipCodeError.value) errorText(),
                      SizedBox(
                        height: 18,
                      ),
                      addressField(
                        title: "Move Date",
                        hint: _dashboardController.selectedDate.value.isEmpty
                            ? "Select moving date"
                            : _dashboardController.selectedDate.value,
                        trailingIcon: SvgPicture.asset(
                          "assets/icons/ic_calendar.svg",
                        ),
                        onTap: () async {
                          DateTime now = DateTime.now();

                          final DateTime? picked = await showDatePicker(
                              context: context,
                              initialDate: now,
                              firstDate: DateTime(now.year, now.month, now.day),
                              lastDate: DateTime(2030, 12, 31));
                          _dashboardController.movingDateError(false);
                          print("Press $picked");
                          if (picked != null) {
                            String date = DateTimeUtils()
                                .parseDateTime(picked, "yyyy-MM-dd");
                            print("Press $date");
                            _dashboardController.setData(
                                key: "date", data: date);
                            _dashboardController.setDate(date);
                          }
                        },
                      ),
                      if (_dashboardController.movingDateError.value)
                        errorText(),
                      SizedBox(
                        height: 24,
                      ),
                    ],
                  )),
              SizedBox(
                height: 24,
              ),
              CustomContainer(
                  onTap: () {
                    Get.focusScope!.unfocus();
                    if (_dashboardController.bookingData.value.movingFrom ==
                        null) {
                      _dashboardController.fromError(true);
                      return;
                    } else {
                      _dashboardController.fromError(false);
                    }
                    if (_dashboardController.bookingData.value.movingTo ==
                        null) {
                      _dashboardController.toError(true);
                      return;
                    } else {
                      _dashboardController.toError(false);
                    }
                    if (_dashboardController.bookingData.value.zipCode ==
                        null) {
                      _dashboardController.zipCodeError(true);
                      return;
                    } else {
                      _dashboardController.zipCodeError(false);
                    }
                    if (_dashboardController.bookingData.value.movingDate ==
                        null) {
                      _dashboardController.movingDateError(true);
                      return;
                    } else {
                      _dashboardController.movingDateError(false);
                    }

                    String code =
                        _dashboardController.bookingData.value.zipCode ?? "";
                    if (code.isNotEmpty) {
                      _dashboardController.getDriverList(code.toString(),
                          _dashboardController.bookingData.value.vehicleId);
                    }
                  },
                  width: Get.width,
                  height: 45,
                  color: AppColors.appBlue,
                  allRadius: 12,
                  marginLeft: 24,
                  marginRight: 24,
                  shadowColor: Colors.black.withOpacity(0.25),
                  shadowOffsetY: 3,
                  shadowSpreadRadius: 2,
                  shadowBlurRadius: 3,
                  shadowOffsetX: 1,
                  paddingLeft: 12,
                  paddingRight: 12,
                  child: Text(
                    "Get Providers",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  )),
              SizedBox(
                height: 24,
              ),
            ],
          )),
    );
  }

  addressField({ title,  hint, trailingIcon, onChange, onTap}) {
    return InkWell(
      onTap: onTap == null ? null : onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomContainer(
            height: 32,
            alignment: Alignment.topLeft,
            color: Colors.transparent,
            width: Get.width,
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 2,
          ),
          CustomContainer(
              width: Get.width,
              height: 45,
              color: Colors.white,
              allRadius: 12,
              shadowColor: Colors.black.withOpacity(0.25),
              shadowOffsetY: 3,
              shadowSpreadRadius: 2,
              shadowBlurRadius: 3,
              shadowOffsetX: 1,
              paddingLeft: 12,
              paddingRight: 12,
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      child: Text(
                        hint,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  if (trailingIcon != null)
                    CustomContainer(
                      color: Colors.transparent,
                      width: 40,
                      height: 60,
                      child: trailingIcon,
                    )
                ],
              ))
        ],
      ),
    );
  }

  errorText() {
    return TextWithIcon(
      title: "field required",
      marginTop: 6,
      fontColor: Colors.red,
    );
  }
}
