import 'package:application_1/AllPages/ExplorePages/service_question_widget.dart';
import 'package:application_1/AllPages/ProjectPages/controller/home_screen_controller.dart';
import 'package:application_1/AllPages/moving/model/booking_model.dart';
import 'package:application_1/remote_model/service_questions/service_question_data.dart';
import 'package:application_1/screens/exploreScreen.dart';
import 'package:application_1/utils/api_utils.dart';
import 'package:application_1/utils/widgest_utills.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../AllPages/ExplorePages/Controllers/providerListController.dart';

class FilterItem extends StatelessWidget {
  var filterList;
  HomeScreenController controller;
  var introController;
  var dashboardController;
  var mainServices;
  var providerListController;

  FilterItem({
    Key? key,
    this.filterList,
    required this.controller,
    required this.dashboardController,
    required this.introController,
    required this.mainServices,
    required this.providerListController,
  }) : super(key: key);
  ProviderListController _providerListController = Get.find();
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: filterList.length,
        itemBuilder: (context, index) {
          return ListTile(
            onFocusChange: (v) {
              print("ehoo");
            },
            onTap: () {
              print("${filterList.length}");
              String serviceName = getServiceName(
                  filterList[index].serviceId, controller, mainServices);
              controller.getCountryList();
              print("Selected service ${filterList[index].id}");
              dashboardController.bookingData(BookingModel());
              dashboardController.bookingMap = <String, dynamic>{};
              if (serviceName.toLowerCase() == 'moving' ||
                  serviceName.toLowerCase().contains("moving")) {
                dashboardController.hideArrow(false);
                introController.selectedServiceId = filterList[index].id;
                dashboardController.getVehicleList();
              } else {
                introController.address("");
                introController.zipCode("");
                introController.address("");
                introController.selectedService("${filterList[index].name}");
                introController.selectedServiceId = filterList[index].id;
                introController.resp(ServiceQuestionData());

                getQuestions(filterList[index].id);
                _providerListController.filterList.clear();
                queryFocus.unfocus();
                queryController.text = "";
              }
            },
            leading: filterList[index].image.isEmpty
                ? Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: const DecorationImage(
                            image: AssetImage(
                                "assets/images/service_placeholder.png"),
                            fit: BoxFit.cover)))
                : cacheNetworkImage(
                    imageUrl: ApiUtills.imageBaseUrl + filterList[index].image,
                    // imageHeight: 110,
                    // imageWidth: 100,
                    placeHolder: 'assets/images/service_placeholder.png',
                    radius: double.parse("10"),
                  ),
            title: Text(
              filterList[index].name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          );
        });
    // return (

    //   children: [
    //     for (int index = 0; index < filterList.length; index++)

    //   ],
    // );
  }

  String getServiceName(
      serviceId, HomeScreenController controller, mainServices) {
    for (int index = 0; index < mainServices.length; index++) {
      if (mainServices.value[index].id == serviceId) {
        return mainServices.value[index].name;
      }
    }
    return "";
  }

  void getQuestions(int id) {
    providerListController.getQuestions(id, onResponse: (value) {
      Get.to(ServiceQuestionWidget(), arguments: value);
    });
  }
}
