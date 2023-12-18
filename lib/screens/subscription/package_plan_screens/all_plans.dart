import 'package:application_1/AllPages/ExplorePages/Controllers/profile_controller.dart';
import 'package:application_1/AllPages/ExplorePages/payment_screen/select_payment_method.dart';
import 'package:application_1/components/buttons-management/part_of_file/part.dart';
import 'package:application_1/components/buttons-management/style_model.dart';
import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../remote_model/provider_list/provider_profile_detail_model.dart';
import '../../../utils/AppColors.dart';

class AllPlans extends StatefulWidget {
  var body;
  AllPlans({super.key, this.body});

  @override
  State<AllPlans> createState() => _AllPlansState();
}

class _AllPlansState extends State<AllPlans> {
  CarouselController _carouselController = CarouselController();
  updataIndex(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  ProfileScreenController _profileController = Get.find();

  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    print(_profileController
        .providerProfileDetails.value.data.provider.packagePlans.length);
    return Scaffold(
      backgroundColor: Color(0xffE0E0E0).withOpacity(0.5),
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0,
        iconTheme: IconTheme.of(context).copyWith(color: black),
        title: Text(
          "Subscription & Packages",
          style: TextStyle(
              color: black, fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Choose a plan",
              style: TextStyle(
                  color: Color(0xff151415),
                  fontSize: 24,
                  fontWeight: FontWeight.w700),
            ),
            6.height,
            Text(
              "Select the offer that best suits your need",
              style: TextStyle(
                  color: black, fontSize: 14, fontWeight: FontWeight.w400),
            ),
            22.height,
            if (_profileController.providerProfileDetails.value.data.provider
                    .packagePlans.length <
                1)
              Container(
                height: Get.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                        "No Plan Available",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w700),
                      ),
                    )
                  ],
                ),
              ),
            if (_profileController.providerProfileDetails.value.data.provider
                    .packagePlans.length >
                0)
              Container(
                width: double.infinity,
                // height: 300,
                padding: EdgeInsets.symmetric(horizontal: 0, vertical: 12),
                child: CarouselSlider.builder(
                    itemCount: _profileController.providerProfileDetails.value
                        .data.provider.packagePlans.length,
                    carouselController: _carouselController,
                    itemBuilder:
                        (BuildContext context, int index, int pageViewIndex) {
                      PackagePlans _data = _profileController
                          .providerProfileDetails
                          .value
                          .data
                          .provider
                          .packagePlans[index];
                      return Card(
                        color: index.isEven
                            ? AppColors.solidBlue
                            : Colors.white.withOpacity(0.97),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18)),
                        elevation: 4,
                        child: Container(
                          width: Get.width * 0.9,
                          // height: Get.width * 0.9,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 18, vertical: 0),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                12.height,
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Card(
                                      elevation: 5,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: Container(
                                        padding: const EdgeInsets.all(10),
                                        width: 60,
                                        height: 60,
                                        child: SvgPicture.asset(
                                            "assets/user_assets/svg/subscription_icon.svg"),
                                      ),
                                    ),
                                    10.width,
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          _data.title.toString(),
                                          style: TextStyle(
                                              color: index.isEven
                                                  ? white
                                                  : Color(0xff151415),
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        4.height,
                                        Row(
                                          children: [
                                            Text("${_data.off}%",
                                                style: TextStyle(
                                                    color: index.isEven
                                                        ? white
                                                        : Color(0xff151415),
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w700)),
                                            Text(" discount",
                                                style: TextStyle(
                                                    color: index.isEven
                                                        ? white
                                                        : Color(0xff757575),
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w400)),
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                15.height,
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text("${_data.description}",
                                      style: TextStyle(
                                          color: index.isEven
                                              ? white
                                              : Color(0xff757575),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400)),
                                ),
                                25.height,
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.check,
                                          color:
                                              index.isEven ? white : greenColor,
                                        ),
                                        10.width,
                                        Text("${_data.type}",
                                            style: TextStyle(
                                                color: index.isEven
                                                    ? white
                                                    : Color(0xff757575),
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400)),
                                      ],
                                    ),
                                    8.height,
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.check,
                                          color:
                                              index.isEven ? white : greenColor,
                                        ),
                                        10.width,
                                        Text("${_data.duration}",
                                            style: TextStyle(
                                                color: index.isEven
                                                    ? white
                                                    : Color(0xff757575),
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400)),
                                      ],
                                    ),
                                    FarenowButton(
                                        style: FarenowButtonStyleModel(
                                            padding: EdgeInsets.only(top: 18)),
                                        title: "Get Started",
                                        onPressed: () {
                                          Get.to(SelectMethod(
                                              formService: true,
                                              body: widget.body));
                                        },
                                        type: index.isEven
                                            ? BUTTONTYPE.action
                                            : BUTTONTYPE.rectangular)
                                  ],
                                ),
                                20.height,
                              ]),
                        ),
                      );
                    },
                    // carouselController: buttonCarouselController,
                    options: CarouselOptions(
                      height: Get.height * 0.45,
                      // aspectRatio: 16 / 9,

                      viewportFraction: 1,
                      initialPage: 0,
                      enableInfiniteScroll: false,
                      reverse: false,
                      autoPlay: false,
                      autoPlayInterval: Duration(seconds: 3),
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,
                      scrollDirection: Axis.horizontal,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _currentIndex = index;
                        });
                      },
                    )),
              ),
            18.height,
            if (_profileController.providerProfileDetails.value.data.provider
                    .packagePlans.length >
                0)
              Container(
                alignment: Alignment.topCenter,
                width: Get.width,
                height: 30,
                child: CarouselIndicator(
                  activeColor: AppColors.solidBlue,
                  width: 10,
                  height: 10,
                  color: Colors.blue.shade100,
                  count: _profileController.providerProfileDetails.value.data
                      .provider.packagePlans.length,
                  index: _currentIndex,
                ),
              )
          ],
        ),
      ),
    );
  }
}
