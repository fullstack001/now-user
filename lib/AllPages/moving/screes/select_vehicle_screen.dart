import 'package:application_1/AllPages/moving/controllers/dashboard_controller.dart';
import 'package:application_1/model/vehicle_list/vehicle_data.dart';
import 'package:application_1/utils/AppColors.dart';
import 'package:application_1/utils/api_utils.dart';
import 'package:application_1/utils/widgest_utills.dart';
import 'package:application_1/widgets/custom_container.dart';
import 'package:application_1/widgets/service_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SelectVehicleScreen extends StatelessWidget {
  DashboardController _dashboardController = Get.find();

  @override
  Widget build(BuildContext context) {
    if (_dashboardController.dashboardList.length.isOdd) {
      _dashboardController.dashboardList.value.add(VehicleData());
    }
    return Container(
      width: Get.width,
      height: Get.height,
      color: Colors.white,
      child: Obx(() => Column(
            children: [
              CustomContainer(
                allRadius: 0,
                marginTop: 12,
                width: Get.width,
                paddingRight: 12,
                paddingLeft: 12,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      child: Icon(
                        Icons.arrow_back,
                        size: 32,
                      ),
                      onTap: () {
                        Get.back();
                      },
                    )
                  ],
                ),
              ),
              CustomContainer(
                allRadius: 0,
                width: Get.width,
                paddingLeft: 12,
                child: Row(
                  children: [
                    Container(
                      child: Image(
                        image: AssetImage("assets/images/img_finger_tap.png"),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Text(
                      "Select Vehicle",
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(12),
                  width: Get.width,
                  height: Get.height,
                  child: gridViews(
                      columnSpan: 2,
                      itemCount: _dashboardController.dashboardList.length,
                      flex: 1,
                      builder: (index, span) {
                        VehicleData value =
                            _dashboardController.dashboardList.value[index];
                        return gridItem(index, value);
                      }),
                ),
              )
            ],
          )),
    );
  }

  Widget gridItem(index, VehicleData value) {
    return value.id == null
        ? emptyContainer()
        : CustomContainer(
            onTap: () {
              _dashboardController.setDashboardSelected(index);
              _dashboardController.setData(
                  key: "vehicle_type_id", data: value.id.toString());
            },
            marginRight: index.isOdd ? 0 : 12,
            marginLeft: index.isEven ? 0 : 12,
            marginBottom: 24,
            height: 140,
            width: 10,
            allRadius: 14,
            color: Colors.white,
            borderColor: !(value.selected ?? false) ? null : AppColors.appGreen,
            borderWidth: 4,
            shadowColor: Colors.black.withOpacity(0.5),
            shadowOffsetY: 3,
            shadowOffsetX: 3,
            shadowBlurRadius: 4,
            shadowSpreadRadius: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                value.image == null
                    ? SvgPicture.asset("assets/icons/ic_van.svg")
                    : cacheNetworkImage(
                        fit: BoxFit.fill,
                        imageWidth: 140,
                        imageHeight: 80,
                        imageUrl: "${ApiUtills.imageBaseUrl + value.image}",
                      ),
                SizedBox(
                  height: 24,
                ),
                Text(
                  value.title,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                )
              ],
            ),
          );
  }
}
