import 'dart:io';

import 'package:application_1/AllPages/ExplorePages/Controllers/profile_controller.dart';
import 'package:application_1/AllPages/RegisteraionPages/Controllers/RegistrationController.dart';
import 'package:application_1/AllPages/introPages/intro_controller.dart';
import 'package:application_1/screens/Controllers/tabScreenController.dart';
import 'package:application_1/utils/AppColors.dart';
import 'package:application_1/utils/app_dialog_utils.dart';
import 'package:application_1/utils/image_picker.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:fdottedline/fdottedline.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../App_Routes/app_routes.dart';
import '../../components/celebrate_screen/celebrate.dart';
// import '../../keyboard_overlay/keyboard_overlay.dart';

class ServiceQuotationScreen extends StatefulWidget {
  final home;
  final orderId;

  ServiceQuotationScreen({
    Key? key,
    this.home,
    this.orderId,
  }) : super(key: key);

  @override
  _ServiceQuotationScreenState createState() => _ServiceQuotationScreenState();
}

class _ServiceQuotationScreenState extends State<ServiceQuotationScreen> {
  final RegistrationController _screenController = Get.find();
  final IntroController _controller = Get.find();
  ProfileScreenController _profileScreenController = Get.find();
  TabScreenController tabScreenController = Get.put(TabScreenController());
  final _formKey = new GlobalKey<FormState>();

  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var emailNameController = TextEditingController();
  var phoneNameController = TextEditingController();
  var addressNameController = TextEditingController();
  var descriptionNameController = TextEditingController();
  bool firstInit = false;

  List<File> imageList = [];

  var firstNode = FocusNode();
  var lastNode = FocusNode();
  var addressNode = FocusNode();
  var dioNode = FocusNode();

  @override
  void initState() {
    // setDoneButton();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (imageList.isEmpty) {
      imageList.add(File("null"));
    }
    if (!firstInit) {
      firstInit = true;
      firstNameController.text = firstNameController.text.isEmpty
          ? _screenController.userData.value.firstName
          : firstNameController.text;

      lastNameController.text = lastNameController.text.isEmpty
          ? _screenController.userData.value.lastName
          : lastNameController.text;

      emailNameController.text = emailNameController.text.isEmpty
          ? _screenController.userData.value.email
          : emailNameController.text;

      phoneNameController.text = phoneNameController.text.isEmpty
          ? _screenController.userData.value.phone
          : phoneNameController.text;

      addressNameController.text = addressNameController.text.isEmpty
          ? _controller.selectedAddress.value
          : addressNameController.text;
    }

    if (!kReleaseMode) {
      descriptionNameController.text =
          "A quick brown fox jump over the lazy dog";
    }
    return Scaffold(
        appBar: AppBar(
          elevation: 2,
          backgroundColor: Colors.white,
          title: const Text(
            "Get Quotation Form",
            style: TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 25,
            ),
          ),
        ),
        body: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Flexible(
                flex: 9,
                child: ListView(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    //first name
                    getLabel("Firs Name"),
                    getTextField(
                      controller: firstNameController,
                    ),
                    //last name
                    getLabel("Last Name"),
                    getTextField(
                      controller: lastNameController,
                    ),
                    //email
                    getLabel("Email"),
                    getTextField(
                      controller: emailNameController,
                    ),
                    //phone
                    getLabel("Phone Number"),
                    getTextField(
                      readOnly: false,
                      controller: phoneNameController,
                    ),

                    //address
                    getLabel("Address"),
                    getTextField(
                      controller: addressNameController,
                    ),
                    getLabel("Description"),
                    getTextField(
                        controller: descriptionNameController,
                        maxLines: 8,
                        readOnly: false),

                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 22, vertical: 12),
                      child: FDottedLine(
                        color: AppColors.darkBlue,
                        strokeWidth: 1.0,
                        dottedLength: 10.0,
                        space: 6.0,
                        corner: FDottedLineCorner.all(10),
                        child: Container(
                          color: Colors.white,
                          width: Get.width,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 22, vertical: 12),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    "Attachment",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black87),
                                  ),
                                  Text(
                                    " (optional)",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black45),
                                  ),
                                ],
                              ),
                              imageList.length > 1
                                  ? Wrap(
                                      alignment: WrapAlignment.start,
                                      crossAxisAlignment:
                                          WrapCrossAlignment.start,
                                      children: [
                                        for (int index = 0;
                                            index < imageList.length;
                                            index++)
                                          Container(
                                            margin: const EdgeInsets.only(
                                                right: 0, bottom: 12),
                                            padding: const EdgeInsets.all(7),
                                            width: checkPath(imageList[index])
                                                ? 0
                                                : 75,
                                            height: checkPath(imageList[index])
                                                ? 0
                                                : 75,
                                            child: selectedImageView(
                                                checkPath(imageList[index])
                                                    ? null
                                                    : Image.file(
                                                        imageList[index]),
                                                index: index, onTap: () {
                                              Get.defaultDialog(
                                                title: "Alert",
                                                content: const Text(
                                                    "Do you want to remove this?"),
                                                confirm: MaterialButton(
                                                  onPressed: () {
                                                    Get.back();
                                                    if (!exist(imageList)) {
                                                      imageList
                                                          .add(File("null"));
                                                    }
                                                    imageList.removeAt(index);
                                                    setState(() {});
                                                  },
                                                  child: const Text("Yes"),
                                                ),
                                                cancel: MaterialButton(
                                                  onPressed: () {
                                                    Get.back();
                                                  },
                                                  child: const Text("No"),
                                                ),
                                              );
                                            },
                                                cross: checkPath(
                                                    imageList[index])),
                                          ),
                                      ],
                                    )
                                  : Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8),
                                      child: const Text(
                                        "Upload your item phots here",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300,
                                            color: Colors.black45),
                                      ),
                                    ),
                              Container(
                                width: Get.width * 0.3,
                                height: 34,
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade100,
                                    borderRadius: BorderRadius.circular(30)),
                                child: MaterialButton(
                                  shape: const StadiumBorder(),
                                  onPressed: () {
                                    ImagePickerDialog(
                                        context: context,
                                        imageSelect: (value) {
                                          print(value.path);
                                          imageList.add(value);
                                          if (imageList.length <= 5) {
                                            imageList.add(File("null"));
                                          }
                                          setState(() {});
                                        }).showPicker(context);
                                  },
                                  child: FittedBox(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Icon(
                                          Icons.add,
                                          size: 18,
                                          color: AppColors.darkBlue,
                                        ),
                                        const SizedBox(
                                          width: 12,
                                        ),
                                        Text(
                                          "Upload File",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: AppColors.darkBlue),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18)),
                    color: AppColors.darkBlue,
                    onPressed: () async {
                      Get.focusScope!.unfocus();
                      if (!_formKey.currentState!.validate()) {
                        return;
                      }

                      Map body = <String, dynamic>{
                        "address": addressNameController.text
                      };

                      String questions = "";
                      bool home = widget.home ?? false;
                      if (!home) {
                        questions = getQuestionOptionFormat(
                            _controller.resp.value.serviceQuestionQuestions);
                        body["questions"] = "${{questions}}";

                        body["provider_id"] =
                            _profileScreenController.providerId.value;
                        // body["slots"] = [
                        //   "${_profileScreenController.selectedDates.value[0].id}"
                        // ];

                        if (_profileScreenController.time == null) {
                          body["hour"] = _profileScreenController.time ?? "0";
                        }
                      }

                      body["is_hourly"] = "0";
                      if (descriptionNameController.text.isNotEmpty) {
                        body['detail'] = descriptionNameController.text;
                      }
                      if (firstNameController.text.isNotEmpty) {
                        body["first_name"] = firstNameController.text;
                      }
                      if (firstNameController.text.isNotEmpty) {
                        body["last_name"] = firstNameController.text;
                      }
                      if (emailNameController.text.isNotEmpty) {
                        body["email"] = emailNameController.text;
                      }
                      if (phoneNameController.text.isNotEmpty) {
                        body["phone"] = phoneNameController.text;
                      }
                      print(body.toString());
                      _profileScreenController.count = 0;
                      _profileScreenController.bookNow(
                          body: body,
                          question: questions,
                          home: widget.home,
                          imageList: imageList,
                          orderId: widget.orderId,
                          onsubmit: () {
                            Get.to(CelebrateScreen(
                              imageUrl: "assets/user_assets/svg/celebrate.svg",
                              buttonText: 'Done',
                              detail:
                                  'Your form have been submitted successfully',
                              onTap: () {
                                Get.offNamedUntil(
                                    AppRoutes.TABSCREEN, (route) => false);
                              },
                              successMsg: 'Quotation Submitted',
                            ));
                          },
                          tabScreenController: tabScreenController);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: 57,
                      child: const Text(
                        "Submit",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }

  Container getTextField(
      {TextEditingController? controller,
      int? maxLines,
      bool? readOnly = true}) {
    return Container(
      width: Get.width,
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 6),
      child: TextFormField(
        readOnly: readOnly!,
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.black26, width: 1)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.black26, width: 1)),
            fillColor: AppColors.white,
            filled: true,
            contentPadding: const EdgeInsets.all(12)),
      ),
    );
  }

  Container getLabel(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 6),
      width: Get.width,
      child: Text(
        "$label",
        style: const TextStyle(
            fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black87),
      ),
    );
  }

  checkPath(File imageList) {
    if (imageList.path != 'null') {
      return false;
    }
    return true;
  }

  bool exist(List<File> imageList) {
    for (int index = 0; index < imageList.length; index++) {
      if (imageList[index].path == "null") return true;
    }
    return false;
  }

  // void setDoneButton() {
  //   if (GetPlatform.isIOS) {
  //     firstNode = GetFocusNodeOverlay(
  //         child: TopKeyboardUtil(
  //       DoneButtonIos(
  //         label: 'Done',
  //         onSubmitted: () => Get.focusScope!.unfocus(),
  //         platforms: ['android', 'ios'],
  //       ),
  //     ));
  //     lastNode = GetFocusNodeOverlay(
  //         child: TopKeyboardUtil(
  //       DoneButtonIos(
  //         label: 'Done',
  //         onSubmitted: () => Get.focusScope!.unfocus(),
  //         platforms: ['android', 'ios'],
  //       ),
  //     ));
  //     addressNode = GetFocusNodeOverlay(
  //         child: TopKeyboardUtil(
  //       DoneButtonIos(
  //         label: 'Done',
  //         onSubmitted: () => Get.focusScope!.unfocus(),
  //         platforms: ['android', 'ios'],
  //       ),
  //     ));
  //     dioNode = GetFocusNodeOverlay(
  //         child: TopKeyboardUtil(
  //       DoneButtonIos(
  //         label: 'Done',
  //         onSubmitted: () => Get.focusScope!.unfocus(),
  //         platforms: ['android', 'ios'],
  //       ),
  //     ));
  //   }
  // }
}
