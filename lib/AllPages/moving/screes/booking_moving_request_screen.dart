import 'package:application_1/AllPages/introPages/intro_controller.dart';
import 'package:application_1/AllPages/moving/controllers/dashboard_controller.dart';
import 'package:application_1/AllPages/moving/screes/google_map_view.dart';
// import 'package:application_1/keyboard_overlay/keyboard_overlay.dart';
import 'package:application_1/utils/AppColors.dart';
import 'package:application_1/widgets/custom_container.dart';
import 'package:application_1/widgets/text_with_icon.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class BookingMovingRequestScreen extends StatefulWidget {
  @override
  State<BookingMovingRequestScreen> createState() =>
      _BookingMovingRequestScreenState();
}

class _BookingMovingRequestScreenState
    extends State<BookingMovingRequestScreen> {
  DashboardController _dashboardController = Get.find();

  final _formKey = new GlobalKey<FormState>();

  // PhoneNumber number = PhoneNumber(isoCode: 'US');
  var _phoneController = TextEditingController();

  var _nameController = TextEditingController();

  var _emailController = TextEditingController();

  var detailController = TextEditingController();

  bool validPhoneNumber = false;

  IntroController _introController = Get.find();

  var nameNode = FocusNode();

  var emailNode = FocusNode();

  var mobileNode = FocusNode();

  var descNode = FocusNode();

  // void setDoneButton() {
  //   if (GetPlatform.isIOS) {
  //     nameNode = GetFocusNodeOverlay(
  //         child: TopKeyboardUtil(
  //       DoneButtonIos(
  //         label: 'Done',
  //         onSubmitted: () => Get.focusScope!.unfocus(),
  //         platforms: ['android', 'ios'],
  //       ),
  //     ));
  //     emailNode = GetFocusNodeOverlay(
  //         child: TopKeyboardUtil(
  //       DoneButtonIos(
  //         label: 'Done',
  //         onSubmitted: () => Get.focusScope!.unfocus(),
  //         platforms: ['android', 'ios'],
  //       ),
  //     ));
  //     mobileNode = GetFocusNodeOverlay(
  //         child: TopKeyboardUtil(
  //       DoneButtonIos(
  //         label: 'Done',
  //         onSubmitted: () => Get.focusScope!.unfocus(),
  //         platforms: ['android', 'ios'],
  //       ),
  //     ));
  //     descNode = GetFocusNodeOverlay(
  //         child: TopKeyboardUtil(
  //       DoneButtonIos(
  //         label: 'Done',
  //         onSubmitted: () => Get.focusScope!.unfocus(),
  //         platforms: ['android', 'ios'],
  //       ),
  //     ));
  //   }
  // }

  @override
  void initState() {
    // setDoneButton();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (!kReleaseMode) {
      // _phoneController.text = "+923008383978";
      _nameController.text = "nouman";
      _emailController.text = "amin@gmail.com";
      detailController.text = "abc xyz";
    }
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextWithIcon(
                height: 56,
                width: Get.width,
                allRadius: 0,
                bgColor: Colors.white,
                alignment: MainAxisAlignment.start,
                fontSize: 20,
                fontWeight: FontWeight.w700,
                icon: Icon(
                  Icons.arrow_back,
                  color: AppColors.appBlue,
                ),
                onTap: () {
                  Get.back();
                },
                title: "Request Quote",
                paddingAll: 12,
              ),
              Expanded(
                child: Obx(
                  () => CustomContainer(
                    height: Get.height,
                    width: Get.width,
                    color: Color(0xffE5E5E5),
                    child: ListView(
                      children: [
                        CustomContainer(
                          width: Get.width,
                          marginRight: 15,
                          marginTop: 15,
                          paddingAll: 16,
                          marginLeft: 15,
                          color: Colors.white,
                          allRadius: 12,
                          child: Column(
                            children: [
                              TextWithIcon(
                                bgColor: Colors.transparent,
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                title: "Moving Address",
                              ),
                              CustomContainer(
                                width: Get.width,
                                marginTop: 12,
                                height: 250,
                                child: GoogleMapView(),
                              ),
                              TextWithIcon(
                                icon: SvgPicture.asset(
                                    "assets/icons/ic_navigation_arrow.svg"),
                                title: "Your current location (auto fetch)",
                                bgColor: Colors.transparent,
                                fontSize: 14,
                                marginLeft: 0,
                                marginTop: 12,
                                fontWeight: FontWeight.w700,
                              )
                            ],
                          ),
                        ),
                        CustomContainer(
                          width: Get.width,
                          marginTop: 15,
                          marginLeft: 15,
                          marginRight: 15,
                          paddingAll: 12,
                          allRadius: 16,
                          color: Colors.white,
                          child: Column(
                            children: [
                              TextWithIcon(
                                title: "Moving From",
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                              TextWithIcon(
                                title:
                                    "${_dashboardController.bookingData.value.movingFrom}",
                                marginTop: 4,
                                width: Get.width,
                                flex: 1,
                                fontSize: 14,
                                fontColor: AppColors.blue,
                                fontWeight: FontWeight.w700,
                              ),
                              TextWithIcon(
                                title: "Moving To",
                                fontSize: 16,
                                marginTop: 4,
                                fontWeight: FontWeight.w700,
                              ),
                              TextWithIcon(
                                title:
                                    "${_dashboardController.bookingData.value.movingTo}",
                                marginTop: 4,
                                width: Get.width,
                                flex: 1,
                                fontSize: 14,
                                fontColor: AppColors.blue,
                                fontWeight: FontWeight.w700,
                              ),
                              TextWithIcon(
                                title: "Moving Date",
                                fontSize: 16,
                                marginTop: 4,
                                maxLine: 1,
                                fontWeight: FontWeight.w700,
                              ),
                              TextWithIcon(
                                title:
                                    "${_dashboardController.bookingData.value.movingDate}",
                                fontSize: 14,
                                marginTop: 4,
                                fontWeight: FontWeight.w700,
                                fontColor: AppColors.blue,
                              ),
                              TextWithIcon(
                                title: "Zip Code",
                                fontSize: 16,
                                marginTop: 4,
                                maxLine: 1,
                                fontWeight: FontWeight.w700,
                              ),
                              TextWithIcon(
                                title:
                                    "${_dashboardController.bookingData.value.zipCode}",
                                fontSize: 14,
                                marginTop: 4,
                                fontWeight: FontWeight.w700,
                                fontColor: AppColors.blue,
                              ),
                            ],
                          ),
                        ),
                        TextWithIcon(
                          marginTop: 15,
                          width: Get.width,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          title: "Enter your Detail",
                        ),
                        CustomContainer(
                          width: Get.width,
                          color: Colors.white,
                          allRadius: 12,
                          shadowColor: Colors.black45.withOpacity(0.5),
                          shadowSpreadRadius: 2,
                          shadowBlurRadius: 6,
                          shadowOffsetX: 3,
                          marginTop: 12,
                          marginLeft: 12,
                          marginRight: 12,
                          shadowOffsetY: 3,
                          paddingLeft: 12,
                          paddingRight: 12,
                          child: TextFormField(
                            focusNode: nameNode,
                            onFieldSubmitted: (value) {
                              emailNode.requestFocus();
                            },
                            textInputAction: TextInputAction.next,
                            controller: _nameController,
                            decoration: InputDecoration(
                              hintText: "Name",
                              focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent)),
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                              ),
                              fillColor: Colors.green,
                              filled: false,
                              border: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                              ),
                            ),
                            onChanged: (value) async {},
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "field required";
                              }
                              return null;
                            },
                          ),
                        ),
                        CustomContainer(
                          width: Get.width,
                          color: Colors.white,
                          allRadius: 12,
                          shadowColor: Colors.black45.withOpacity(0.5),
                          shadowSpreadRadius: 2,
                          shadowBlurRadius: 6,
                          shadowOffsetX: 3,
                          marginTop: 12,
                          marginLeft: 12,
                          marginRight: 12,
                          shadowOffsetY: 3,
                          paddingLeft: 12,
                          paddingRight: 12,
                          child: TextFormField(
                            focusNode: emailNode,
                            onFieldSubmitted: (value) {
                              mobileNode.requestFocus();
                            },
                            textInputAction: TextInputAction.next,
                            controller: _emailController,
                            decoration: InputDecoration(
                              hintText: "Email Address",
                              focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent)),
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                              ),
                              border: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "field required";
                              } else if (!GetUtils.isEmail(value)) {
                                return "please enter valid email address";
                              }

                              return null;
                            },
                            onChanged: (value) async {},
                          ),
                        ),
                        CustomContainer(
                          width: Get.width,
                          color: Colors.white,
                          marginTop: 15,
                          marginLeft: 15,
                          allRadius: 12,
                          paddingLeft: 12,
                          marginRight: 15,
                          shadowColor: Colors.black.withOpacity(0.5),
                          shadowBlurRadius: 5,
                          shadowSpreadRadius: 1,
                          shadowOffsetY: 2,
                          shadowOffsetX: 1,
                          child: Row(
                            children: [
                              SizedBox(
                                width: 0,
                              ),
                              Expanded(
                                  child: CustomContainer(
                                width: Get.width,
                                color: Colors.white,
                                allRadius: 0,
                                marginRight: 12,
                                shadowOffsetY: 3,
                                paddingLeft: 4,
                                paddingRight: 12,
                                child: TextFormField(
                                  focusNode: mobileNode,
                                  onFieldSubmitted: (value) {
                                    descNode.requestFocus();
                                  },
                                  textInputAction: TextInputAction.next,
                                  controller: _phoneController,
                                  keyboardType: TextInputType.phone,
                                  decoration: InputDecoration(
                                    hintText: "+1 xx xxx xxxx",
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.transparent)),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.transparent),
                                    ),
                                    border: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.transparent),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "field required";
                                    } else if (!GetUtils.isPhoneNumber(value)) {
                                      return "please enter valid mobile number";
                                    }

                                    return null;
                                  },
                                  onChanged: (value) async {},
                                ),
                              )),
                            ],
                          ),
                        ),
                        CustomContainer(
                          width: Get.width,
                          height: 150,
                          color: Colors.white,
                          allRadius: 12,
                          shadowColor: Colors.black45.withOpacity(0.5),
                          shadowSpreadRadius: 2,
                          shadowBlurRadius: 6,
                          shadowOffsetX: 3,
                          marginTop: 12,
                          marginLeft: 12,
                          marginRight: 12,
                          shadowOffsetY: 3,
                          alignment: Alignment.topLeft,
                          paddingLeft: 12,
                          paddingRight: 12,
                          child: TextFormField(
                            focusNode: descNode,
                            onFieldSubmitted: (value) {
                              Get.focusScope!.unfocus();
                            },
                            textInputAction: TextInputAction.next,
                            controller: detailController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "field required";
                              }

                              return null;
                            },
                            maxLines: 10,
                            decoration: InputDecoration(
                              hintText: "Detail",
                              focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent)),
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                              ),
                              border: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                              ),
                            ),
                            onChanged: (value) async {},
                          ),
                        ),
                        TextWithIcon(
                          width: Get.width,
                          height: 45,
                          marginTop: 32,
                          marginBottom: 15,
                          marginLeft: 15,
                          marginRight: 15,
                          allRadius: 12,
                          bgColor: AppColors.appBlue,
                          title: "Submit",
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          fontColor: Colors.white,
                          containerClick: () {
                            Get.focusScope!.unfocus();
                            if (!_formKey.currentState!.validate()) {
                              return;
                            }
                            print("valid");
                            String name = _nameController.text.toString();
                            String email = _emailController.text.toString();
                            String phone = _phoneController.text.toString();
                            String detail = detailController.text.toString();
                            _dashboardController.setData(
                                key: "name", data: name);
                            _dashboardController.setData(
                                key: "phone", data: phone);
                            _dashboardController.setData(
                                key: "detail", data: detail);
                            _dashboardController.setData(
                                key: "email", data: email);

                            Map body =
                                _dashboardController.bookingData.value.toJson();
                            int id = _introController.selectedServiceId;
                            body["sub_service_id"] = id;
                            print("$body");
                            _dashboardController.bookDriver(body);
                          },
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
