import 'package:application_1/AllPages/ExplorePages/image_perview_screen.dart';
import 'package:application_1/AllPages/ExplorePages/service_timings_widget.dart';
import 'package:application_1/AllPages/RegisteraionPages/Controllers/RegistrationController.dart';
import 'package:application_1/AllPages/chat/chat_request_widget.dart';
import 'package:application_1/AllPages/chat/chat_screen.dart';
import 'package:application_1/App_Routes/app_routes.dart';
import 'package:application_1/model/feedback/feedback.dart';
import 'package:application_1/reuseableWidgets/reuseblueButton.dart';
import 'package:application_1/utils/AppColors.dart';
import 'package:application_1/utils/api_utils.dart';
import 'package:application_1/utils/app_dialog_utils.dart';
import 'package:application_1/utils/widgest_utills.dart';
import 'package:application_1/widgets/custom_container.dart';
import 'package:application_1/widgets/rating_start.dart';
import 'package:application_1/widgets/text_with_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../remote_model/provider_list/provider_list_response_model.dart';

class ProviderProfile extends StatefulWidget {
  final data;

  ProviderProfile({
    Key? key,
    this.data,
  }) : super(key: key);

  @override
  _ProviderProfileState createState() => _ProviderProfileState();
}

class _ProviderProfileState extends State<ProviderProfile> {
  Color black = AppColors.black;

  Color white = AppColors.white;

  Color grey = AppColors.grey;

  Color blue = AppColors.blue;

  Color green = AppColors.green;

  final RegistrationController _registrationController = Get.find();

  String messageLabel = "Send Chat Request";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _registrationController.getFeedback(widget.data.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, size) {
            double w = size.maxWidth;
            double h = size.maxHeight;

            return ConstrainedBox(
              constraints: BoxConstraints(minHeight: size.maxHeight),
              child: CustomContainer(
                  width: Get.width,
                  height: Get.height,
                  child: Column(
                    children: [
                      Flexible(
                          flex: 0,
                          child: Column(
                            children: [
                              Flexible(
                                  flex: 0,
                                  child: Stack(
                                    children: [
                                      Container(
                                        width: w,
                                        height: h * 0.16,
                                        alignment: Alignment.topLeft,
                                        child: InkWell(
                                          onTap: () {
                                            Get.back();
                                          },
                                          child: Stack(
                                            children: [
                                              Image.asset(
                                                'assets/images/mapHeader.png',
                                                width: Get.width,
                                                fit: BoxFit.cover,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.bottomCenter,
                                        child: CustomContainer(
                                          marginTop: h * 0.10,
                                          width: Get.width,
                                          child: ClipOval(
                                            child: widget.data.image == null
                                                ? Image(
                                                    image: AssetImage(
                                                        'assets/images/img_profile_place_holder.jpg'),
                                                    height: 100,
                                                    width: 100,
                                                  )
                                                : cacheNetworkImage(
                                                    imageUrl:
                                                        "${ApiUtills.imageBaseUrl + widget.data.image}",
                                                    imageWidth: 80,
                                                    imageHeight: 80),
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          print("abc");
                                          Get.back();
                                        },
                                        icon: Icon(
                                          Icons.arrow_back_ios,
                                          color: Colors.black,
                                        ),
                                      )
                                    ],
                                  )),
                              Container(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      "${widget.data.firstName} ${widget.data.lastName}",
                                      style:
                                          Theme.of(context).textTheme.headline6,
                                    ),
                                    Container(
                                      width: Get.width * 0.8,
                                      child: Text(
                                        "${widget.data.bio}",
                                        maxLines: 2,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w300,
                                            fontSize: 14),
                                      ),
                                    ),
                                    RatingStar(
                                      size: 22,
                                      rating: double.parse(
                                          (widget.data.rating ?? 0).toString()),
                                      color: AppColors.appGreen,
                                    ),
                                    chatRequest(w, size),
                                  ],
                                ),
                              )
                            ],
                          )),
                      if (widget.data.portfolio != null)
                        if ((widget.data.portfolio.portfolioImages ?? [])
                            .isNotEmpty)
                          Column(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                alignment: Alignment.centerLeft,
                                width: size.maxWidth,
                                child: Text("Portfolio",
                                    style:
                                        Theme.of(context).textTheme.headline6),
                              ),
                              portfolioImages(widget.data.image),
                            ],
                          ),
                      Flexible(
                          flex: 5,
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                alignment: Alignment.centerLeft,
                                width: size.maxWidth,
                                child: Text("Review",
                                    style:
                                        Theme.of(context).textTheme.headline6),
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              Obx(() => Container(
                                  height: h * 0.23,
                                  alignment: _registrationController
                                          .feedbacks.value.isEmpty
                                      ? Alignment.center
                                      : Alignment.topCenter,
                                  child: _registrationController
                                          .feedbacks.value.isEmpty
                                      ? Container(
                                          child: Text(
                                          "No reviews",
                                          style: TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold),
                                        ))
                                      : reviewItem(size, h)))
                            ],
                          )),
                      Flexible(
                          flex: 1,
                          child: Container(
                            alignment: Alignment.center,
                            child: ReuseableBlueButton(
                              fontColor: widget.data.providerSchedulesCount == 0
                                  ? Colors.grey
                                  : null,
                              bgColor: widget.data.providerSchedulesCount == 0
                                  ? AppColors.grey
                                  : null,
                              w: size.maxWidth,
                              h: size.maxHeight,
                              text: widget.data.providerSchedulesCount == 0
                                  ? "Provider not available"
                                  : "Book this service provider",
                              onTap: () {
                                print("Book this service provider");
                                if (widget.data.providerSchedulesCount != 0) {
                                  if (widget.data.hourlyRate == null) {
                                    Get.to(ServiceTimings());
                                    return;
                                  }
                                  // Get.to(ServiceTimings());
                                  _registrationController.checkDues();
                                }
                                // Get.offNamed("/tabScreen");
                              },
                            ),
                          )),
                    ],
                  )),
            );
          },
        ),
      ),
    );
  }

  getName(ProviderListData data) {
    return "${data.firstName.capitalizeFirst} ${data.lastName.capitalizeFirst}";
  }

  reviewWidget(int index, FeedBack value, size, h) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(12),
      width: size.maxWidth,
      height: 150,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 0,
            child: ClipOval(
              child: CustomContainer(
                borderColor: AppColors.appBlue,
                borderWidth: 1,
                width: 80,
                paddingAll: 4,
                allRadius: 80,
                height: 80,
                child: ClipOval(
                  child: cacheNetworkImage(
                      imageHeight: 80,
                      imageWidth: 80,
                      imageUrl: ApiUtills.imageBaseUrl + (value.image ?? "")),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
              flex: 1,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        getUserName(value),
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: RatingStar(
                        size: 18,
                        rating: double.parse((value.rating ?? 0.0).toString()),
                        color: AppColors.appGreen,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    TextWithIcon(
                      width: Get.width,
                      title: value.comment,
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      maxLine: 3,
                      overFlow: TextOverflow.ellipsis,
                      flex: 1,
                    ),
                  ],
                ),
              )),
          SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }

  String getUserName(FeedBack value) {
    return "${value.firstName} ${value.lastName}";
  }

  portfolioImages(image) {
    return CustomContainer(
      width: Get.width,
      height: (Get.width / 5) + 12,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          for (int index = 0;
              index < widget.data.portfolio.portfolioImages.length;
              index++)
            CustomContainer(
                borderWidth: 1,
                paddingAll: 4,
                allRadius: Get.width / 5,
                borderColor: AppColors.appBlue,
                onTap: () {
                  _registrationController.currentIndex(index);
                  Get.dialog(ImagePerviewScreen(
                    data: widget.data.portfolio,
                  ));
                },
                marginTop: 12,
                marginLeft: index == 0 ? 12 : 6,
                marginRight:
                    index == (widget.data.portfolio.portfolioImages.length) - 1
                        ? 12
                        : 6,
                width: Get.width / 5,
                height: Get.width / 5,
                child: cacheNetworkImage(
                    imageUrl:
                        "${ApiUtills.imageBaseUrl}${widget.data.portfolio.portfolioImages[index].url}",
                    imageWidth: Get.width / 5,
                    imageHeight: Get.width / 5,
                    radius: Get.width / 5,
                    placeHolder: 'assets/images/img_gallery.png')

                // Image(
                //   image: AssetImage('assets/images/img_gallery.png'),
                //   color: Colors.grey[300],
                // ),
                )
        ],
      ),
    );
  }

  Widget reviewItem(size, h) {
    List<Widget> lists = [];
    for (int index = 0;
        index < _registrationController.feedbacks.length;
        index++) {
      FeedBack value = _registrationController.feedbacks[index];
      // var value;
      lists.add(CustomContainer(
        marginLeft: 24,
        marginRight: 24,
        width: Get.width,
        child: Card(
          child: reviewWidget(index, value, size, h),
        ),
      ));
    }
    return PageView(
      children: lists,
    );
  }

  chatRequest(w, size) {
    return Container(
      width: w,
      height: w * 0.167,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Container(
          //   width: size.maxWidth * 0.3,
          //   height: size.maxHeight * 0.05,
          //   alignment: Alignment.center,
          //   decoration: BoxDecoration(
          //       color: Colors.grey,
          //       borderRadius:
          //           BorderRadius.circular(8)),
          //   child: Text(
          //     "Call",
          //     style: TextStyle(
          //         color: white, fontSize: 18),
          //   ),
          // ),
          // SizedBox(
          //   width: 20,
          // ),
          InkWell(
            child: Container(
              height: size.maxHeight * 0.05,
              alignment: Alignment.center,
              padding: EdgeInsets.only(left: 24, right: 24),
              decoration: BoxDecoration(
                  color: widget.data.hourlyRate == null
                      ? AppColors.appGreen
                      : AppColors.grey,
                  borderRadius: BorderRadius.circular(8)),
              child: Text(
                "$messageLabel",
                style: TextStyle(
                    color: widget.data.hourlyRate == null
                        ? AppColors.white
                        : Color(0xff757575),
                    fontSize: 18),
              ),
            ),
            onTap: () {
              if (widget.data.hourlyRate == null) {
                if (messageLabel.toLowerCase() == "send chat request") {
                  Get.dialog(ChatRequestWidget(
                      providerId: widget.data.id.toString(),
                      onRequested: () {
                        messageLabel = "Request sent";
                        AppDialogUtils.successDialog(
                            "Chat request sent successfully");
                        setState(() {});
                        Get.offNamedUntil(
                            AppRoutes.TABSCREEN, (route) => false);
                      }));
                  // _profileScreenController.sendChatRequest();
                } else {
                  Get.to(ChatScreen(
                    receiverId: widget.data.id.toString(),
                    senderId: _registrationController.userData.value.id,
                    name: getName(widget.data),
                  ));
                }
              }
            },
          ),
        ],
      ),
    );
  }
}
