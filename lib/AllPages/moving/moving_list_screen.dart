import 'package:application_1/AllPages/ProjectPages/controller/home_screen_controller.dart';
import 'package:application_1/AllPages/moving/moving_detail_screen.dart';
import 'package:application_1/AllPages/moving/screes/google_map_view.dart';
import 'package:application_1/model/service_response/service_list_data.dart';
import 'package:application_1/utils/AppColors.dart';
import 'package:application_1/utils/date_time_utils.dart';
import 'package:application_1/utils/project_widget.dart';
import 'package:application_1/utils/widgest_utills.dart';
import 'package:application_1/widgets/custom_container.dart';
import 'package:application_1/widgets/custom_toolbar.dart';
import 'package:application_1/widgets/data_not_available_widget.dart';
import 'package:application_1/widgets/text_with_icon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MovingListScreen extends StatelessWidget {
  HomeScreenController _screenController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 50,
        flexibleSpace: CustomToolbar(
          title: "Moving History",
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back,
              size: 25,
              color: Colors.blue,
            ),
          ),
        ),
      ),
      body: CustomContainer(
        height: Get.height,
        width: Get.width,
        child: Obx(() => Column(
              children: [
                _screenController.complete.value.isEmpty
                    ? Expanded(
                        child: TextWithIcon(
                        width: Get.width,
                        height: Get.height,
                        fontSize: 20,
                        title: "Data not available",
                      ))
                    : Expanded(
                        child: _screenController.complete.value.isEmpty
                            ? CustomContainer(
                                height: 100,
                                width: Get.width,
                                child: DataNotAvailableWidget(),
                              )
                            : CustomContainer(
                                height: 100,
                                width: Get.width,
                                child: getHistoryList(
                                    _screenController.complete.value),
                              ),
                      )
              ],
            )),
      ),
    ));
  }

  getHistoryList(List<dynamic> value) {
    int size = value.length;
    return ListView(
      children: [
        for (int index = 0; index < size; index++)
          historyItem(index, value[index], size),
      ],
    );
  }

  workTime(createdAt) {
    DateTime dateTime = DateTimeUtils().convertStringWoT(createdAt);
    String time =
        DateTimeUtils().parseDateTime(dateTime, "dd/MM/yyyy  HH:mm aa");
    return time;
  }

  historyItem(int index, obj, size) {
    ServiceListData value = obj;
    bool visi = (value.type ?? "").toLowerCase() == "moving_request";
    return !visi
        ? emptyContainer()
        : value.provider.id == null
            ? emptyContainer()
            : CustomContainer(
                width: Get.width,
                onTap: () {
                  // Starting point latitude
                  originLatitude =
                      double.parse(value.movingQuotationInfo.startLat);
// Starting point longitude
                  originLongitude =
                      double.parse(value.movingQuotationInfo.startLng);
// Destination latitude
                  destLatitude = double.parse(value.movingQuotationInfo.endLat);
// Destination Longitude
                  destLongitude =
                      double.parse(value.movingQuotationInfo.endLng);

                  Get.to(() => MovingDetailScreen(
                        data: value,
                      ));
                },
                marginLeft: 24,
                marginRight: 24,
                visibility: visi,
                marginTop: index == 0 ? 0 : 16,
                marginBottom: index == size - 1 ? 12 : 0,
                color: Colors.white,
                shadowColor: Colors.black.withOpacity(0.5),
                shadowBlurRadius: 4,
                allRadius: 12,
                shadowSpreadRadius: 2,
                shadowOffsetY: 6,
                paddingRight: 16,
                paddingLeft: 16,
                paddingTop: 8,
                paddingBottom: 8,
                shadowOffsetX: 6,
                child: Column(
                  children: [
                    TextWithIcon(
                      title: getUserName(value.provider),
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                    TextWithIcon(
                      marginTop: 6,
                      icon: Icon(
                        Icons.watch_later_sharp,
                        color: Colors.grey[400],
                      ),
                      title: "${workTime(value.createdAt)}",
                      fontSize: 16,
                    ),
                    TextWithIcon(
                      marginTop: 6,
                      maxLine: 1,
                      alignment: MainAxisAlignment.start,
                      width: Get.width,
                      flex: 1,
                      icon: Icon(
                        Icons.location_on,
                        color: Colors.grey[400],
                      ),
                      title: "${value.movingQuotationInfo.fromAddress}",
                      fontSize: 16,
                    ),
                    TextWithIcon(
                      marginTop: 6,
                      maxLine: 1,
                      flex: 1,
                      alignment: MainAxisAlignment.start,
                      width: Get.width,
                      icon: Icon(
                        Icons.location_on,
                        color: Colors.grey[400],
                      ),
                      title: "${value.movingQuotationInfo.toAddress}",
                      fontSize: 16,
                    ),
                    Container(
                      width: Get.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          TextWithIcon(
                            width: 120,
                            paddingRight: 12,
                            paddingLeft: 12,
                            allRadius: 12,
                            paddingTop: 4,
                            paddingBottom: 4,
                            fontSize: 14,
                            marginTop: 12,
                            marginBottom: 12,
                            fontColor: Colors.white,
                            title: "${getStatus(value)}",
                            bgColor: AppColors.appGreen,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );
  }

  getStatus(ServiceListData value) {
    if (value.isCompleted == 1) {
      return "Completed";
    }
    return "";
  }
}
