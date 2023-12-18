import 'package:application_1/AllPages/moving/controllers/dashboard_controller.dart';
import 'package:application_1/AllPages/moving/screes/booking_moving_request_screen.dart';
import 'package:application_1/AllPages/moving/screes/google_map_view.dart';
import 'package:application_1/utils/AppColors.dart';
import 'package:application_1/utils/api_utils.dart';
import 'package:application_1/utils/widgest_utills.dart';
import 'package:application_1/widgets/custom_container.dart';
import 'package:application_1/widgets/rating_start.dart';
import 'package:application_1/widgets/text_with_icon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../remote_model/provider_list/provider_list_response_model.dart';

enum filter { BASIC, PREMIUM, RATING, ALL }

class DriversListScreen extends StatefulWidget {
  @override
  State<DriversListScreen> createState() => _DriversListScreenState();
}

class _DriversListScreenState extends State<DriversListScreen> {
  DashboardController _dashboardController = Get.find();

  var filerList = [];

  var selectedFilter = filter.ALL;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          var value = _dashboardController.filterClick.value;
          if (selectedFilter == filter.ALL) {
            filerList = _dashboardController.driverData.value.providerListData;
          } else if (selectedFilter == filter.BASIC) {
            List list = _dashboardController.driverData.value.providerListData;
            filerList = list
                .where((element) =>
                    element.accountType.toString().toLowerCase() == "basic")
                .toList();
          } else if (selectedFilter == filter.PREMIUM) {
            List list = _dashboardController.driverData.value.providerListData;
            filerList = list
                .where((element) =>
                    element.accountType.toString().toLowerCase() ==
                    filter.PREMIUM.name.toLowerCase())
                .toList();
          } else if (selectedFilter == filter.PREMIUM) {
            List list = _dashboardController.driverData.value.providerListData;
            filerList = list
                .where((element) =>
                    element.accountType.toString().toLowerCase() ==
                    filter.PREMIUM.name.toLowerCase())
                .toList();
          } else if (selectedFilter == filter.RATING) {
            filerList = _dashboardController.driverData.value.providerListData;
            filerList.sort(
                (a, b) => a.rating.toString().compareTo(b.rating.toString()));
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomContainer(
                  height: 50,
                  width: Get.width,
                  color: Colors.white,
                  child: Column(
                    children: [
                      CustomContainer(
                          height: 44,
                          width: Get.width,
                          color: Colors.white,
                          marginLeft: 24,
                          marginRight: 24,
                          child: Row(
                            children: [
                              Expanded(
                                child: TextWithIcon(
                                  title: "Your Providers",
                                  allRadius: 24,
                                  height: 90,
                                  alignment: MainAxisAlignment.start,
                                  bgColor: Colors.transparent,
                                  icon: Icon(Icons.arrow_back),
                                  fontSize: 18,
                                  fontColor: Colors.black,
                                  fontWeight: FontWeight.w700,
                                  onTap: () {
                                    Get.back();
                                  },
                                ),
                              ),
                              // ),
                              // Icon(
                              //   Icons.clear,
                              //   color: Colors.grey[400],
                              // )
                            ],
                          )),
                      // CustomContainer(
                      //   height: 1,
                      //   width: Get.width,
                      //   marginLeft: 24,
                      //   marginRight: 24,
                      //   color: Colors.grey[300],
                      // ),
                      // CustomContainer(
                      //     height: 44,
                      //     width: Get.width,
                      //     paddingLeft: 24,
                      //     alignment: Alignment.centerLeft,
                      //     child: Row(
                      //       crossAxisAlignment: CrossAxisAlignment.center,
                      //       children: [
                      //         TextWithIcon(
                      //             title: "Profession",
                      //             fontSize: 16,
                      //             allRadius: 24,
                      //             height: 44,
                      //             marginTop: 6,
                      //             marginBottom: 6,
                      //             paddingLeft: 12,
                      //             paddingRight: 12,
                      //             bgColor: AppColors.appBlue,
                      //             fontColor: Colors.white),
                      //         SizedBox(
                      //           width: 12,
                      //         ),
                      //         TextWithIcon(
                      //             title: "4.5",
                      //             allRadius: 24,
                      //             height: 44,
                      //             marginTop: 6,
                      //             marginBottom: 6,
                      //             paddingLeft: 12,
                      //             paddingRight: 12,
                      //             icon: Icon(
                      //               Icons.star,
                      //               color: Color(0xff757575),
                      //             ),
                      //             fontSize: 16,
                      //             fontColor: Color(0xff757575)),
                      //         SizedBox(
                      //           width: 12,
                      //         ),
                      //         TextWithIcon(
                      //             title: "Filter",
                      //             allRadius: 24,
                      //             height: 44,
                      //             marginTop: 6,
                      //             marginBottom: 6,
                      //             paddingLeft: 12,
                      //             paddingRight: 12,
                      //             icon: Icon(
                      //               Icons.filter_alt,
                      //               color: Color(0xff757575),
                      //             ),
                      //             fontSize: 16,
                      //             width: 100,
                      //             fontColor: Color(0xff757575))
                      //       ],
                      //     ))
                    ],
                  )),
              Expanded(
                child: Container(
                  width: Get.width,
                  color: Color(0xffE5E5E5).withOpacity(0.5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          TextWithIcon(
                            width: 100,
                            marginLeft: 24,
                            marginTop: 15,
                            marginBottom: 14,
                            containerAlignment: Alignment.topLeft,
                            title: "Best Match",
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            bgColor: Colors.transparent,
                          ),
                          Expanded(
                              child: SizedBox(
                            width: 12,
                          )),
                          Container(
                            height: Get.height * 0.1,
                            color: AppColors.grey,
                            child: PopupMenuButton(
                                onSelected: filterClick,
                                child: Icon(
                                  Icons.filter_alt_outlined,
                                  size: 28,
                                ),
                                itemBuilder: (context) => [
                                      PopupMenuItem(
                                        value: filter.BASIC.index,
                                        child: Row(
                                          children: [
                                            Text(
                                              "${filter.BASIC.name.toString().capitalizeFirst}",
                                              style: TextStyle(
                                                  fontSize: 15.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                      PopupMenuItem(
                                        value: filter.PREMIUM.index,
                                        child: Row(
                                          children: [
                                            Text(
                                              "${filter.PREMIUM.name.toString().capitalizeFirst}",
                                              style: TextStyle(
                                                  fontSize: 15.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                      PopupMenuItem(
                                        value: filter.RATING.index,
                                        child: Row(
                                          children: [
                                            Text(
                                              "${filter.RATING.name.toString().capitalizeFirst}",
                                              style: TextStyle(
                                                  fontSize: 15.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                      PopupMenuItem(
                                        value: filter.ALL.index,
                                        child: Row(
                                          children: [
                                            Text(
                                              "${filter.ALL.name.toString().capitalizeFirst}",
                                              style: TextStyle(
                                                  fontSize: 15.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ]),
                          ),
                          SizedBox(
                            width: 16,
                          )
                        ],
                      ),
                      Expanded(
                          child: ListView.builder(
                        itemCount: filerList.length,
                        itemBuilder: (BuildContext context, int index) {
                          ProviderListData value = filerList[index];
                          return driverListItem(index, value);
                        },
                      ))
                    ],
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget driverListItem(index, ProviderListData value) {
    return CustomContainer(
        width: Get.width,
        height: 160,
        marginBottom: 12,
        marginLeft: 24,
        marginRight: 24,
        allRadius: 12,
        marginTop: index == 0 ? 6 : 0,
        shadowColor: Colors.black.withOpacity(0.5),
        shadowSpreadRadius: 1,
        shadowBlurRadius: 8,
        shadowOffsetX: 2,
        shadowOffsetY: 4,
        color: Colors.white,
        child: Column(
          children: [
            CustomContainer(
                width: Get.width,
                height: 90,
                marginTop: 15,
                marginLeft: 15,
                marginRight: 15,
                child: Row(
                  children: [
                    ClipOval(
                      child: cacheNetworkImage(
                          imageWidth: 72,
                          imageHeight: 72,
                          imageUrl: "${ApiUtills.imageBaseUrl}${value.image}",
                          placeHolder:
                              "assets/images/img_profile_place_holder.jpg"),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: TextWithIcon(
                                height: 17,
                                alignment: MainAxisAlignment.start,
                                bgColor: Colors.transparent,
                                marginLeft: 0,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                title: "${getDriverName(value)}",
                              ),
                            ),
                            // Icon(
                            //   Icons.bookmark_border,
                            //   color: Color(0xffBDBDBD),
                            // )
                          ],
                          crossAxisAlignment: CrossAxisAlignment.center,
                        ),
                        // TextWithIcon(
                        //   title: "179 Jobs Completed",
                        //   width: Get.width,
                        //   bgColor: Colors.transparent,
                        //   marginLeft: 0,
                        //   fontColor: Color(0xffBDBDBD),
                        //   height: 12,
                        //   alignment: MainAxisAlignment.start,
                        // ),
                        SizedBox(
                          height: 4,
                        ),
                        RatingStar(
                          size: 18,
                          rating: double.parse((value.rating ?? 0).toString()),
                          color: AppColors.appGreen,
                        )
                      ],
                    ))
                  ],
                )),
            CustomContainer(
                width: Get.width,
                marginLeft: 24,
                marginRight: 24,
                child: Row(
                  children: [
                    Expanded(
                      child: TextWithIcon(
                        icon: Icon(
                          Icons.location_on,
                          size: 18,
                          color: Color(0xffBDBDBD),
                        ),
                        alignment: MainAxisAlignment.start,
                        width: Get.width,
                        bgColor: Colors.transparent,
                        title: "${value.providerProfile.city}",
                        fontColor: Color(0xffBDBDBD),
                      ),
                    ),
                    CustomContainer(
                        height: 30,
                        allRadius: 12,
                        alignment: Alignment.center,
                        onTap: () {
                          print("Get Quote");

                          originLatitude = double.parse(
                              _dashboardController.bookingData.value.startLat!);
// Starting point longitude
                          originLongitude = double.parse(
                              _dashboardController.bookingData.value.startLng!);
// Destination latitude
                          destLatitude = double.parse(
                              _dashboardController.bookingData.value.endLat!);
// Destination Longitude
                          destLongitude = double.parse(
                              _dashboardController.bookingData.value.endLng!);

                          _dashboardController.setData(
                              key: "provider_id", data: value.id.toString());
                          Get.to(() => BookingMovingRequestScreen());
                        },
                        child: TextWithIcon(
                          title: "GET QUOTE",
                          paddingRight: 12,
                          height: 30,
                          paddingLeft: 12,
                          containerAlignment: Alignment.center,
                          bgColor: Colors.transparent,
                          fontWeight: FontWeight.w700,
                          fontColor: Colors.white,
                        ),
                        gradientColor: [Color(0xffA2D6F3), Color(0xff1B80F5)])
                  ],
                ))
          ],
        ));
  }

  getDriverName(ProviderListData value) {
    return "${value.firstName} ${value.lastName}";
  }

  filterClick(value) {
    print("abc");
    if (value == filter.BASIC.index) {
      selectedFilter = filter.BASIC;
      refresh();
    } else if (value == filter.PREMIUM.index) {
      selectedFilter = filter.PREMIUM;
      refresh();
    } else if (value == filter.RATING.index) {
      selectedFilter = filter.RATING;
      refresh();
    } else if (value == filter.ALL.index) {
      selectedFilter = filter.ALL;
      refresh();
    }
  }

  refresh() {
    setState(() {});
    _dashboardController.filterClick(true);
    _dashboardController.filterClick.refresh();
  }
}
