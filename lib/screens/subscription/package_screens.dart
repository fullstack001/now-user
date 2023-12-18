import 'package:application_1/components/buttons-management/part_of_file/part.dart';
import 'package:application_1/components/buttons-management/style_model.dart';
import 'package:application_1/screens/subscription/model/subscribe_plan.dart';
import 'package:application_1/screens/subscription/package_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../../utils/AppColors.dart';

class PackageScreen extends StatefulWidget {
  const PackageScreen({Key? key}) : super(key: key);

  @override
  State<PackageScreen> createState() => _PackageScreenState();
}

class _PackageScreenState extends State<PackageScreen> {
  CarouselController buttonCarouselController = CarouselController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffCCCCCC).withOpacity(0.1),
      appBar: AppBar(
        iconTheme: IconTheme.of(context).copyWith(color: black),
        backgroundColor: white,
        elevation: 0,
        title: const Text(
          "Subscription & Packages",
          style: TextStyle(color: black, fontWeight: FontWeight.w400),
        ),
      ),
      body: GetBuilder<PackageController>(
          init: PackageController(),
          builder: (controller) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
              child: controller.subscribeplan == null
                  ? Container(
                      height: Get.height,
                      child: const Center(
                          child: Text(
                        "No Package Subscribe",
                        style: TextStyle(
                            color: Color(0xff555555),
                            fontWeight: FontWeight.w500,
                            fontSize: 22),
                      )),
                    )
                  : SingleChildScrollView(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: List.generate(
                              controller.subscribeplan.length, (index) {
                            SubscribeData _data =
                                controller.subscribeplan[index];
                            return _data.status == "CANCEL"
                                ? Container()
                                : Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18)),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 24, vertical: 12),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "${checkDate(_data.createdAt)}",
                                                style: const TextStyle(
                                                    color: AppColors.solidBlue,
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 16),
                                              ),
                                              const Text(
                                                "",
                                                style: TextStyle(
                                                    color: Color(0xff151415),
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 16),
                                              ),
                                            ],
                                          ),
                                          const Divider(),
                                          Text(
                                            "${_data.plan.title}",
                                            style: const TextStyle(
                                                color: Color(0xff151415),
                                                fontWeight: FontWeight.w700,
                                                fontSize: 16),
                                          ),
                                          5.height,
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                  "${checkDate(_data.startDate)} - "),
                                              Text(
                                                  "${checkDate(_data.endDate)}"),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              // Text("Service Provider:"),
                                              // Text("Godwin Benson"),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              // Text("Plan:"),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  // Text("Professional"),
                                                  // Text("0/month"),
                                                ],
                                              )
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Flexible(
                                                flex: 2,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const Text(
                                                        "Next billing date",
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xff151415),
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontSize: 16)),
                                                    3.height,
                                                    _data.subscriptionHistories
                                                            .isEmpty
                                                        ? Container()
                                                        : Text(checkDate(_data
                                                                .subscriptionHistories[
                                                                    0]
                                                                .deductionDate)
                                                            .toString()),
                                                  ],
                                                ),
                                              ),
                                              Flexible(
                                                child: FarenowButton(
                                                    style: FarenowButtonStyleModel(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 0,
                                                                vertical: 6)),
                                                    title: "Cancel",
                                                    onPressed: () {
                                                      Get.dialog(Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Card(
                                                            color: Colors.white,
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            55)),
                                                            child: Container(
                                                              width: Get.width *
                                                                  0.8,
                                                              height:
                                                                  Get.width *
                                                                      0.6,
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          24,
                                                                      vertical:
                                                                          24),
                                                              child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceEvenly,
                                                                  children: [
                                                                    Container(
                                                                      child:
                                                                          const Text(
                                                                        "Cancel Package",
                                                                        style: TextStyle(
                                                                            color: AppColors
                                                                                .solidBlue,
                                                                            fontSize:
                                                                                24,
                                                                            fontWeight:
                                                                                FontWeight.w500),
                                                                      ),
                                                                    ),
                                                                    12.height,
                                                                    Container(
                                                                      child:
                                                                          const Text(
                                                                        "This action will remove your subscription package from providers list. Click confirm to complete action.",
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        style: TextStyle(
                                                                            color: Color(
                                                                                0xff555555),
                                                                            fontSize:
                                                                                16,
                                                                            fontWeight:
                                                                                FontWeight.w400),
                                                                      ),
                                                                    ),
                                                                    12.height,
                                                                    Row(
                                                                      children: [
                                                                        Flexible(
                                                                            child:
                                                                                FarenowButton(
                                                                          style:
                                                                              FarenowButtonStyleModel(padding: const EdgeInsets.symmetric(horizontal: 6)),
                                                                          title:
                                                                              "Cancel",
                                                                          onPressed:
                                                                              () {
                                                                            Get.back();
                                                                          },
                                                                          type:
                                                                              BUTTONTYPE.action,
                                                                        )),
                                                                        Flexible(
                                                                            child:
                                                                                FarenowButton(
                                                                          style:
                                                                              FarenowButtonStyleModel(padding: const EdgeInsets.symmetric(horizontal: 6)),
                                                                          title:
                                                                              "Confirm",
                                                                          onPressed:
                                                                              () {
                                                                            controller.deletePackage(id: _data.id);
                                                                          },
                                                                          type:
                                                                              BUTTONTYPE.rectangular,
                                                                        )),
                                                                      ],
                                                                    )
                                                                  ]),
                                                            ),
                                                          )
                                                        ],
                                                      ));
                                                    },
                                                    type: BUTTONTYPE.action),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ));
                          })),
                    ),
            );
          }),
    );
  }

  String checkDate(DateTime createdAt) {
    String value = DateFormat("dd/MM/yyyy").format(createdAt).toString();
    return value;
  }
}
