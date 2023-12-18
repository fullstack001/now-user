import 'package:application_1/remote_model/provider_list/provider_profile_detail_model.dart';
import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../../utils/AppColors.dart';

class PackageView extends StatefulWidget {
  List<PackagePlans> data;
  PackageView({required this.data});

  @override
  State<PackageView> createState() => _PackageViewState();
}

class _PackageViewState extends State<PackageView> {
  CarouselController _carouselController = CarouselController();
  updataIndex(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return widget.data.length == 0
        ? Container()
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    // height: 300,
                    padding: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                    child: CarouselSlider.builder(
                        itemCount: widget.data.length,
                        carouselController: _carouselController,
                        itemBuilder: (BuildContext context, int index,
                            int pageViewIndex) {
                          PackagePlans _data = widget.data[index];
                          return Card(
                            color: index.isEven
                                ? AppColors.solidBlue
                                : Colors.white.withOpacity(0.97),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18)),
                            elevation: 4,
                            child: Container(
                              width: Get.width * 0.9,
                              alignment: Alignment.centerLeft,
                              // height: Get.width * 0.9,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 18, vertical: 16),
                              child: FittedBox(
                                child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Card(
                                            // color: AppColors.solidBlue,
                                            elevation: 2,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12)),
                                            child: Container(
                                              padding: const EdgeInsets.all(10),
                                              width: 60,
                                              height: 60,
                                              child: SvgPicture.asset(
                                                "assets/user_assets/svg/subscription_icon.svg",
                                              ),
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
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              Row(
                                                children: [
                                                  Text("${_data.off}%",
                                                      style: TextStyle(
                                                          color: index.isEven
                                                              ? white
                                                              : Color(
                                                                  0xff151415),
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w700)),
                                                  Text(" discount",
                                                      style: TextStyle(
                                                          color: index.isEven
                                                              ? white
                                                              : Color(
                                                                  0xff757575),
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
                                        width: Get.width * 0.7,
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.check,
                                                color: index.isEven
                                                    ? white
                                                    : greenColor,
                                              ),
                                              10.width,
                                              Text("${_data.type}",
                                                  style: TextStyle(
                                                      color: index.isEven
                                                          ? white
                                                          : Color(0xff757575),
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400)),
                                            ],
                                          ),
                                          8.height,
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.check,
                                                color: index.isEven
                                                    ? white
                                                    : greenColor,
                                              ),
                                              10.width,
                                              Text("${_data.duration}",
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
                                      ),
                                      20.height,
                                    ]),
                              ),
                            ),
                          );
                        },
                        // carouselController: buttonCarouselController,
                        options: CarouselOptions(
                          height: Get.height * 0.3,
                          aspectRatio: 16 / 9,
                          viewportFraction: 1,
                          initialPage: 0,
                          enableInfiniteScroll: false,
                          reverse: false,
                          autoPlay: false,
                          autoPlayInterval: Duration(seconds: 3),
                          autoPlayAnimationDuration:
                              Duration(milliseconds: 800),
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
                  if (widget.data.length > 0)
                    Container(
                      alignment: Alignment.topCenter,
                      width: Get.width,
                      height: 30,
                      child: CarouselIndicator(
                        activeColor: AppColors.solidBlue,
                        width: 10,
                        height: 10,
                        color: Colors.blue.shade100,
                        count: widget.data.length,
                        index: _currentIndex,
                      ),
                    )
                ],
              ),
            ),
          );
  }
}
