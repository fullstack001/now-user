import 'package:application_1/AllPages/ExplorePages/Controllers/providerListController.dart';
import 'package:application_1/AllPages/ExplorePages/service_question_widget.dart';
import 'package:application_1/AllPages/introPages/intro_controller.dart';
import 'package:application_1/AllPages/introPages/questionPages/PageModels.dart';
import 'package:application_1/AllPages/moving/controllers/dashboard_controller.dart';
import 'package:application_1/AllPages/moving/model/booking_model.dart';
import 'package:application_1/remote_model/main_services/sub_services.dart';
import 'package:application_1/remote_model/service_questions/service_question_data.dart';
import 'package:application_1/utils/AppColors.dart';
import 'package:application_1/utils/api_utils.dart';
import 'package:application_1/utils/widgest_utills.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../ProjectPages/controller/home_screen_controller.dart';

class SubServiceItem extends StatefulWidget {
  final index;
  final subService;
  final allServices;
  final imagewidth;
  final serviceHeader;

  SubServiceItem({
    Key? key,
    this.index,
    this.subService,
    this.serviceHeader,
    this.imagewidth,
    this.allServices,
  }) : super(key: key);

  @override
  State<SubServiceItem> createState() => _SubServiceItemState();
}

class _SubServiceItemState extends State<SubServiceItem> {
  Color white = AppColors.white;

  Color blue = AppColors.blue;

  ProviderListController _providerListController = Get.find();

  IntroController _introController = Get.find();

  DashboardController _dashboardController = Get.put(DashboardController());

  HomeScreenController _homeScreenControlle = Get.find();

  var images = [
    "assets/user_assets/png/user.png",
    "assets/user_assets/png/s2.jpeg",
    "assets/user_assets/png/s1.jpeg",
    "assets/image 2x/shopProfile.png"
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    images.shuffle();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Get.to(SubCategories());
        _homeScreenControlle.getCountryList();
        print("Selected service ${widget.subService.id}");
        _dashboardController.bookingData(BookingModel());
        _dashboardController.bookingMap = <String, dynamic>{};
        if (widget.allServices.name.toString().toLowerCase() == 'moving' ||
            widget.allServices.name
                .toString()
                .toLowerCase()
                .contains("moving")) {
          _dashboardController.hideArrow(false);
          _introController.selectedServiceId = widget.subService.id;
          _dashboardController.getVehicleList();
        } else {
          controller.address("");
          _introController.zipCode("");
          _introController.address("");
          _introController.selectedService("${widget.subService.name}");
          _introController.selectedServiceId = widget.subService.id;
          _introController.resp(ServiceQuestionData());
          getQuestions(widget.subService.id);
        }
      },
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: Get.width * 0.35,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: widget.subService.image.isEmpty
                  ? Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: const DecorationImage(
                              image: AssetImage(
                                  "assets/images/service_placeholder.png"),
                              fit: BoxFit.cover)))
                  : cacheNetworkImage(
                      imageUrl:
                          ApiUtills.imageBaseUrl + widget.subService.image,
                      imageHeight: 80,
                      imageWidth: widget.imagewidth,
                      placeHolder: 'assets/images/service_placeholder.png',
                      radius: 10,
                    ),
            ),
            const SizedBox(
              height: 6,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: FittedBox(
                fit: BoxFit.fitHeight,
                child: Text(
                  widget.subService.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Color(0xff151415),
                      fontSize: 16),
                ),
              ),
            ),
            8.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                widget.subService.totalProvider != 0
                    ? Flexible(
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.topRight,
                              child: Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                    // color: Colors.red,
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: AssetImage(images[0]))),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topCenter,
                              child: Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                    // color: Colors.green,
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: AssetImage(images[1]))),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                    // color: Colors.yellow,
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: AssetImage(images[2]))),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                      "assets/user_assets/png/user.png"))),
                        ),
                      ),
                Flexible(
                  flex: 2,
                  child: FittedBox(
                    child: Text(
                      "${widget.subService.totalProvider}+ Providers",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Color(0xff151415),
                          fontSize: 12),
                    ),
                  ),
                ),
              ],
            ),
            // 12.height
          ],
        ),
      ),
    );
  }

  void getQuestions(int id) {
    _providerListController.getQuestions(id, onResponse: (value) {
      Get.to(ServiceQuestionWidget(), arguments: value);
    });
  }
}
/*
Stack(
        children: [
          Opacity(
            opacity: 0.2,
            child: ClipPath(
              child: Container(
                height: w * 0.5,
                color: Colors.white60,
              ),
              clipper: CustomClipPath2(),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 1),
              child: Container(
                alignment: Alignment.centerLeft,
                width: w * 159 / 360,
                height: h * 156 / 800,
                // decoration: BoxDecoration(
                //     image: DecorationImage(
                //         fit: BoxFit.fill, image: AssetImage(image))),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "24/7",
                    style: TextStyle(
                        color: white,
                        fontSize: 22,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "Grocery Services",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                  MaterialButton(
                      textColor: blue,
                      color: white,
                      minWidth: w * 0.223,
                      height: 23,
                      shape: StadiumBorder(),
                      child: Container(
                        width: w * 145 / 360,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                                flex: 12,
                                child: Text(
                                  "serviceName",
                                  style: TextStyle(fontSize: 12),
                                )),
                            Expanded(
                              flex: 1,
                              child: Icon(
                                Icons.arrow_forward_outlined,
                                color: blue,
                                size: 12,
                              ),
                            )
                          ],
                        ),
                      ),
                      onPressed: () {
                        // if (resp.isNotEmpty) {
                        //   Get.to(Categories(),
                        //       arguments: resp,
                        //       transition: Transition.leftToRight,
                        //       fullscreenDialog: true);
                        // }
                      }),
                  BuildSizedBox(w * 0.03)
                ],
              ),
            ),
          )
        ],
      )
 */
