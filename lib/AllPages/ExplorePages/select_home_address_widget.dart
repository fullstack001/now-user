import 'package:application_1/AllPages/ExplorePages/Controllers/profile_controller.dart';
import 'package:application_1/AllPages/ExplorePages/service_quotation_screen.dart';
import 'package:application_1/AllPages/ExplorePages/service_timing/chose_package_or_not.dart';
import 'package:application_1/AllPages/introPages/intro_controller.dart';
import 'package:application_1/AllPages/payment/stripe.dart';
import 'package:application_1/AllPages/save_address_controller.dart';
import 'package:application_1/components/buttons-management/part_of_file/part.dart';
import 'package:application_1/components/buttons-management/style_model.dart';
import 'package:application_1/resources/Api_Services/services.dart';
import 'package:application_1/utils/AppColors.dart';
import 'package:application_1/utils/app_dialog_utils.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../remote_model/service_questions/service_question_questions.dart';

class SelectHomeAddressWidget extends StatefulWidget {
  final home;
  final orderId;
  final quotation;

  SelectHomeAddressWidget(
      {Key? key, this.home, this.orderId, this.quotation = false})
      : super(key: key);

  @override
  _SelectHomeAddressWidgetState createState() =>
      _SelectHomeAddressWidgetState();
}

class _SelectHomeAddressWidgetState extends State<SelectHomeAddressWidget> {
  var addressController = TextEditingController();
  final IntroController _controller = Get.find();
  ProfileScreenController _profileScreenController = Get.find();
  SaveAddressController _addressController = Get.put(SaveAddressController());
  var addressControllerEdit = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (_controller.selectedAddress.value.isNotEmpty) {
      addressController.text = _controller.selectedAddress.value;
    }
    return Scaffold(
        backgroundColor: const Color(0xffE0E0E0).withOpacity(0.5),
        appBar: AppBar(
          backgroundColor: white,
          elevation: 0,
          iconTheme:
              IconTheme.of(context).copyWith(color: const Color(0xffBDBDBD)),
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Get.back();
            },
          ),
          actions: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  "3  of 4",
                  style: TextStyle(
                      color: AppColors.solidBlue,
                      fontSize: 20,
                      fontWeight: FontWeight.w400),
                ),
              ),
            )
          ],
        ),
        body: Obx(() => widget.quotation
            ? Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Container(
                            alignment: Alignment.topLeft,
                            height: 30,
                            child: const Text(
                              "Where is your home?",
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.w500),
                            ),
                          ),
                          12.height,
                          TextField(
                            controller: addressController,
                            onChanged: (value) async {
                              _controller.address(value);
                              if (value.isEmpty) {
                                _controller.predictionResults.clear();
                                var empty = [];
                                _controller.address(value);
                                _controller.predictionResults(empty);
                                return;
                              } else {
                                Future.delayed(const Duration(seconds: 1))
                                    .then((valu) async {
                                  var result = await Services()
                                      .searchPlaceByZip(value)
                                      .then((value) {
                                    if (value != null) {
                                      print("$value");
                                      _controller
                                          .predictionResults(value.predictions);
                                    }
                                  });
                                });
                              }
                            },
                            decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.location_on_outlined,
                                  color: AppColors.darkBlue,
                                ),
                                hintText: "Your Address here...",
                                fillColor: Colors.white,
                                filled: true,
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide(
                                      color: AppColors.darkBlue, width: 1),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: const BorderSide(
                                      color: Colors.red, width: 1),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: const BorderSide(
                                      color: Colors.black26, width: 1),
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide(
                                        color: AppColors.darkBlue, width: 1)),
                                hintStyle:
                                    const TextStyle(color: Colors.black26)),
                          ),
                          22.height,
                          _controller.address.isEmpty
                              ? Container()
                              : Container(
                                  // color: redColor,
                                  width: double.infinity,
                                  height: 50,
                                  alignment: Alignment.topCenter,
                                  child: ListView.builder(
                                    itemCount: _controller
                                        .predictionResults.value.length,
                                    itemBuilder: (context, index) {
                                      if (_controller.address.isEmpty) {}
                                      return InkWell(
                                        onTap: () async {
                                          Get.focusScope!.unfocus();
                                          print(
                                              "${_controller.predictionResults.value[index].description}");
                                          _controller.selectedAddress(
                                              _controller.predictionResults
                                                  .value[index].description);

                                          _controller.predictionResults.clear();
                                          var empty = [];
                                          _controller.predictionResults(empty);
                                          setState(() {});
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.only(
                                              top: 2, bottom: 8),
                                          child: Text(
                                            "${_controller.predictionResults.value[index].description}",
                                            style:
                                                const TextStyle(fontSize: 16),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                        ],
                      ),
                      Row(
                        children: [
                          widget.quotation
                              ? Container()
                              : Flexible(
                                  child: FarenowButton(
                                      style: FarenowButtonStyleModel(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 6)),
                                      title: "Previous",
                                      onPressed: () {},
                                      type: BUTTONTYPE.action),
                                ),
                          Flexible(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 6),
                              child: InkWell(
                                onTap: () {
                                  Get.focusScope!.unfocus();
                                  if (_controller
                                      .selectedAddress.value.isEmpty) {
                                    Get.defaultDialog(
                                        title: "Alert",
                                        content: const Text(
                                          "Address field required",
                                        ),
                                        confirm: MaterialButton(
                                          onPressed: () {
                                            Get.back();
                                          },
                                          child: const Text("Okay"),
                                        ));
                                    return;
                                  }
                                  // _controller.selectedAddress(addressController.text);
                                  Map body = <String, dynamic>{
                                    "address": _controller.selectedAddress.value
                                  };
                                  bool home = widget.home ?? false;

                                  List<ServiceQuestionQuestions> question =
                                      _controller
                                          .resp.value.serviceQuestionQuestions
                                          .cast<ServiceQuestionQuestions>();
                                  Map questions = <String, dynamic>{};
                                  List<String> optionList = <String>[];
                                  int indexOfQuestion = -1;
                                  if (!home) {
                                    for (int index = 0;
                                        index < (question).length;
                                        index++) {
                                      optionList = [];
                                      for (int qIndex = 0;
                                          qIndex <
                                              question[index]
                                                  .serviceQuestionOptions
                                                  .length;
                                          qIndex++) {
                                        if (question[index]
                                            .serviceQuestionOptions[qIndex]
                                            .selected) {
                                          optionList.add(question[index]
                                              .serviceQuestionOptions[qIndex]
                                              .id
                                              .toString());
                                          indexOfQuestion = question[index].id;
                                        }
                                      }
                                      if (indexOfQuestion > -1) {
                                        List<String> _optionList = <String>[];
                                        _optionList.assignAll(optionList);
                                        questions[
                                                "question_${indexOfQuestion.toString()}"] =
                                            _optionList;
                                        print(questions);
                                      }
                                    }

                                    body["questions"] = questions;

                                    body["provider_id"] =
                                        _profileScreenController
                                            .providerId.value
                                            .toString();
                                    // if (_profileScreenController
                                    //     .selectedDates.isNotEmpty) {
                                    //   body["slots"] =
                                    //       "${_profileScreenController.selectedDates.value[0].id}";
                                    // }

                                    body["hours"] = _profileScreenController
                                        .time
                                        .toString();
                                  }

                                  print(body.toString());

                                  if (_profileScreenController.selectedProvider
                                          .value.providerProfile.hourlyRate ==
                                      null) {
                                    body["is_hourly"] = false;
                                    Get.to(ServiceQuotationScreen(
                                        home: widget.home,
                                        orderId: widget.orderId));
                                  } else {
                                    // Get.to(ServiceQuotationScreen());
                                    body["is_hourly"] = true;
                                    if (_profileScreenController
                                        .selectedTimeSlot.value.isNotEmpty) {
                                      body["book_time_slots"] =
                                          _profileScreenController
                                              .selectedTimeSlot.value;
                                    }
                                    body["date"] = _profileScreenController
                                        .selectedDate.value;
                                    print(body);
                                    _addressController.createCheckOutData();
                                    _addressController.getCreditCard(
                                        onResponseGet: () async {
                                      _addressController.getAddress(
                                          flag: true,
                                          onResponseGet: () {
                                            AppDialogUtils.dismiss();
                                            Get.to(ChossePackageOrNot(
                                              body: body,
                                            ));
                                            // Get.to(() => StripeModel(
                                            //       body: body,
                                            //       hide: true,
                                            //       onPageChange: (value) {},
                                            //     ));
                                          });
                                    });
                                  }
                                },
                                child: Container(
                                  width: Get.width,
                                  height: 47,
                                  decoration: BoxDecoration(
                                      color: AppColors.solidBlue,
                                      borderRadius: BorderRadius.circular(12)),
                                  alignment: Alignment.center,
                                  child: Text(
                                    _profileScreenController
                                                .selectedProvider
                                                .value
                                                .providerProfile
                                                .hourlyRate ==
                                            null
                                        ? "Get Quotation"
                                        : "Next",
                                    style: const TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ]),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 18, vertical: 0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 12),
                        child: Column(children: [
                          Container(
                            height: 30,
                            child: const Text(
                              "Where is your home?",
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.w700),
                            ),
                          ),
                          22.height,
                          TextField(
                            controller: addressController,
                            onChanged: (value) async {
                              _controller.address(value);
                              if (value.isEmpty) {
                                _controller.predictionResults.clear();
                                var empty = [];
                                _controller.address(value);
                                _controller.predictionResults(empty);
                                return;
                              } else {
                                var result = await Services()
                                    .searchPlaceByZip(value)
                                    .then((value) {
                                  if (value != null) {
                                    print("$value");
                                    _controller
                                        .predictionResults(value.predictions);
                                  }
                                });

                                // Future.delayed(Duration(seconds: 1))
                                //     .then((valu) async {

                                // });
                              }
                            },
                            decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  icon: const Icon(
                                    Icons.close,
                                    color: Color(0xff555555),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      addressController.text = "";
                                      _controller.selectedAddress.value = "";
                                    });
                                  },
                                ),
                                prefixIcon: Icon(
                                  Icons.location_on_outlined,
                                  color: AppColors.darkBlue,
                                ),
                                hintText: "Your Address here...",
                                fillColor: Colors.white,
                                filled: true,
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide(
                                      color: AppColors.darkBlue, width: 1),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: const BorderSide(
                                      color: Colors.grey, width: 1),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: const BorderSide(
                                      color: Colors.black26, width: 1),
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide(
                                        color: AppColors.darkBlue, width: 1)),
                                hintStyle:
                                    const TextStyle(color: Colors.black26)),
                          ),
                          22.height,
                          _controller.address.isEmpty
                              ? Container()
                              : Container(
                                  width: double.infinity,
                                  height: 120,
                                  alignment: Alignment.topCenter,
                                  child: ListView.builder(
                                    itemCount: _controller
                                        .predictionResults.value.length,
                                    itemBuilder: (context, index) {
                                      if (_controller.address.isEmpty) {}
                                      return InkWell(
                                        onTap: () async {
                                          Get.focusScope!.unfocus();
                                          print(
                                              "${_controller.predictionResults.value[index].description}");
                                          _controller.selectedAddress(
                                              _controller.predictionResults
                                                  .value[index].description);

                                          _controller.predictionResults.clear();
                                          var empty = [];
                                          _controller.predictionResults(empty);
                                          _controller.address.value = "";
                                          setState(() {});
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.only(
                                              top: 2, bottom: 8),
                                          child: Text(
                                            "${_controller.predictionResults.value[index].description}",
                                            style:
                                                const TextStyle(fontSize: 16),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                          Row(
                            children: [
                              widget.quotation
                                  ? Container()
                                  : Flexible(
                                      child: FarenowButton(
                                          style: FarenowButtonStyleModel(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 6)),
                                          title: "Previous",
                                          onPressed: () {
                                            Get.back();
                                          },
                                          type: BUTTONTYPE.action),
                                    ),
                              Flexible(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 6),
                                  child: InkWell(
                                    onTap: () {
                                      Get.focusScope!.unfocus();
                                      if (_controller
                                          .selectedAddress.value.isEmpty) {
                                        Get.defaultDialog(
                                            title: "Alert",
                                            content: const Text(
                                              "Address field required",
                                            ),
                                            confirm: MaterialButton(
                                              onPressed: () {
                                                Get.back();
                                              },
                                              child: const Text("Okay"),
                                            ));
                                        return;
                                      }
                                      // _controller.selectedAddress(addressController.text);
                                      Map body = <String, dynamic>{
                                        "address":
                                            _controller.selectedAddress.value
                                      };
                                      bool home = widget.home ?? false;

                                      List<ServiceQuestionQuestions> question =
                                          _controller.resp.value
                                              .serviceQuestionQuestions
                                              .cast<ServiceQuestionQuestions>();
                                      Map questions = <String, dynamic>{};
                                      List<String> optionList = <String>[];
                                      int indexOfQuestion = -1;
                                      if (!home) {
                                        for (int index = 0;
                                            index < (question).length;
                                            index++) {
                                          optionList = [];
                                          for (int qIndex = 0;
                                              qIndex <
                                                  question[index]
                                                      .serviceQuestionOptions
                                                      .length;
                                              qIndex++) {
                                            if (question[index]
                                                .serviceQuestionOptions[qIndex]
                                                .selected) {
                                              optionList.add(question[index]
                                                  .serviceQuestionOptions[
                                                      qIndex]
                                                  .id
                                                  .toString());
                                              indexOfQuestion =
                                                  question[index].id;
                                            }
                                          }
                                          if (indexOfQuestion > -1) {
                                            List<String> _optionList =
                                                <String>[];
                                            _optionList.assignAll(optionList);
                                            questions[
                                                    "question_${indexOfQuestion.toString()}"] =
                                                _optionList;
                                            print(questions);
                                          }
                                        }

                                        body["questions"] = questions;

                                        body["provider_id"] =
                                            _profileScreenController
                                                .providerId.value
                                                .toString();
                                        // if (_profileScreenController
                                        //     .selectedDates.isNotEmpty) {
                                        //   body["slots"] =
                                        //       "${_profileScreenController.selectedDates.value[0].id}";
                                        // }

                                        body["hours"] = _profileScreenController
                                            .time
                                            .toString();
                                      }

                                      print(body.toString());

                                      if (_profileScreenController
                                              .selectedProvider
                                              .value
                                              .providerProfile
                                              .hourlyRate ==
                                          null) {
                                        body["is_hourly"] = false;
                                        Get.to(ServiceQuotationScreen(
                                            home: widget.home,
                                            orderId: widget.orderId));
                                      } else {
                                        // Get.to(ServiceQuotationScreen());
                                        body["is_hourly"] = true;
                                        if (_profileScreenController
                                            .selectedTimeSlot
                                            .value
                                            .isNotEmpty) {
                                          body["book_time_slots"] =
                                              _profileScreenController
                                                  .selectedTimeSlot.value;
                                        }
                                        body["date"] = _profileScreenController
                                            .selectedDate.value;
                                        print(body);
                                        _addressController.createCheckOutData();
                                        _addressController.getCreditCard(
                                            onResponseGet: () async {
                                          _addressController.getAddress(
                                              flag: true,
                                              onResponseGet: () {
                                                AppDialogUtils.dismiss();
                                                Get.to(ChossePackageOrNot(
                                                  body: body,
                                                ));
                                                // Get.to(() => StripeModel(
                                                //       body: body,
                                                //       hide: true,
                                                //       onPageChange: (value) {},
                                                //     ));
                                              });
                                        });
                                      }
                                    },
                                    child: Container(
                                      width: Get.width,
                                      height: 47,
                                      decoration: BoxDecoration(
                                          color: AppColors.solidBlue,
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      alignment: Alignment.center,
                                      child: Text(
                                        _profileScreenController
                                                    .selectedProvider
                                                    .value
                                                    .providerProfile
                                                    .hourlyRate ==
                                                null
                                            ? "Get Quotation"
                                            : "Next",
                                        style: const TextStyle(
                                            fontSize: 18,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ]),
                      ),
                    ),
                  )
                ],
              )));
  }
}
