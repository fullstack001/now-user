import 'dart:convert';

import 'package:application_1/AllPages/introPages/intro_controller.dart';
import 'package:application_1/AllPages/introPages/questionPages/PageModels.dart';
import 'package:application_1/AllPages/introPages/questionPages/models/button_selection_model.dart';
import 'package:application_1/components/buttons-management/enum/button_type.dart';
import 'package:application_1/components/buttons-management/farenow_button.dart';
import 'package:application_1/components/buttons-management/style_model.dart';
import 'package:application_1/remote_model/service_questions/service_question_data.dart';
import 'package:application_1/remote_model/service_questions/service_question_questions.dart';
import 'package:application_1/utils/AppColors.dart';
import 'package:application_1/utils/api_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:preload_page_view/preload_page_view.dart';

import '../../utils/widgest_utills.dart';

class ServiceQuestionWidget extends StatefulWidget {
  ServiceQuestionWidget({Key? key}) : super(key: key);

  @override
  _ServiceQuestionWidgetState createState() => _ServiceQuestionWidgetState();
}

class _ServiceQuestionWidgetState extends State<ServiceQuestionWidget> {
  QuestionPageModels models = QuestionPageModels();

  String zipCode = "";

  final IntroController _controller = Get.find();

  PreloadPageController scrollController = PreloadPageController();

  final pageController = PageController(initialPage: 0);

  int currentIndex = 0;

  Map<String, bool> selectedCheckbox = {};

  List<Widget> questionPage = [];

  String label = "arrow";
  int valueAdded = 0;

  List<Widget> page = [
    QuestionPageModels().buildpage(),
    QuestionPageModels().buildpage1(),
    QuestionPageModels().buildpage2(),
    QuestionPageModels().buildpage3()
  ];

  @override
  Widget build(BuildContext context) {
    if (_controller.resp.value.id == null) {
      _controller
          .resp(ServiceQuestionData.fromJson(json.decode(Get.arguments)));
    }

    questionPage = _controller.resp.value.serviceQuestionQuestions
        .map<Widget>((data) => GetWidgetPage(data))
        .toList();

    // questionPage = _controller.resp.value.serviceQuestionQuestions
    //     .map((e) => GetWidgetPage(e))
    //     .toList();
    questionPage.add(QuestionPageModels().buildpage3(
        title: "Enter your address",
        hint: "Enter your address",
        inApp: true,
        zipCode: zipCode,
        previous: () {
          setState(() {
            currentIndex = currentIndex - 1;

            pageController.animateToPage(currentIndex,
                duration: Duration(seconds: 1), curve: Curves.fastOutSlowIn);
          });
        },
        update: (val) {
          zipCode = val;
          // _controller.selectedZipCode(val);
          setState(() {});
        }));
    return WillPopScope(
      onWillPop: () async {
        Get.focusScope!.unfocus();
        _controller.visibleKeyboard(false);
        currentIndex--;
        pageController.jumpToPage(currentIndex);
        _controller.visibleKeyboard.refresh();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
            // title: Text(
            //   _controller.selectedService.value,
            //   style: TextStyle(
            //       color: black, fontWeight: FontWeight.w400, fontSize: 14),
            // ),
            backgroundColor: white,
            leading: IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                Get.back();
              },
            ),
            iconTheme: IconTheme.of(context).copyWith(color: black),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    "Step ${currentIndex + 1} of ${questionPage.length}",
                    style: TextStyle(
                        color: AppColors.solidBlue,
                        fontWeight: FontWeight.w400,
                        fontSize: 14),
                  ),
                ),
              )
            ]),
        backgroundColor: Color(0xffF5F5F5),
        body: Container(
          padding: EdgeInsets.all(4),
          height: Get.height,
          child: Column(
            children: [
              // SizedBox(
              //   height: 12,
              // ),
              Column(
                children: [
                  // Container(
                  //   margin: EdgeInsets.only(left: 16, right: 16),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       currentIndex > 0
                  //           ? InkWell(
                  //               onTap: () {
                  //                 setState(() {
                  //                   Get.focusScope!.unfocus();
                  //                   _controller.visibleKeyboard(false);
                  //                   currentIndex--;
                  //                   pageController.jumpToPage(currentIndex);
                  //                   _controller.visibleKeyboard.refresh();
                  //                 });
                  //               },
                  //               child: Icon(
                  //                 Icons.arrow_back,
                  //                 size: 28,
                  //                 color: Colors.black,
                  //               ),
                  //             )
                  //           : Container(),
                  //       if (currentIndex > -1)
                  //         Container(
                  //           alignment: Alignment.center,
                  //           height: 24,
                  //           child: Text(
                  //             _controller.selectedService.value,
                  //             style: TextStyle(
                  //                 fontWeight: FontWeight.normal, fontSize: 18),
                  //           ),
                  //         ),
                  //       Tooltip(
                  //         message: "Discard",
                  //         child: InkWell(
                  //           onTap: () {
                  //             Get.back();
                  //           },
                  //           child: Icon(
                  //             Icons.delete_sweep_rounded,
                  //             size: 28,
                  //             color: Colors.black38,
                  //           ),
                  //         ),
                  //       )
                  //     ],
                  //   ),
                  // ),

                  // SizedBox(
                  //   height: 20,
                  // )
                ],
              ),
              Expanded(
                  child: PageView(
                physics: NeverScrollableScrollPhysics(),
                onPageChanged: (value) {
                  print(value);
                  currentIndex = value;
                  check();
                  setState(() {});
                },
                controller: pageController,
                children: questionPage,
              )),
              // Obx(() => checkFlag(_controller.visibleKeyboard.value)
              //     ? emptyContainer()
              //     : Container(
              //         // width: Get.width * 0.4,
              //         // height: 70,
              //         padding: EdgeInsets.all(12),
              //         child: Container(
              //           child: currentIndex != questionPage.length - 1
              //               ? _controller
              //                           .resp
              //                           .value
              //                           .serviceQuestionQuestions[currentIndex]
              //                           .is_multiple ==
              //                       0
              //                   ? null
              //                   : Container(
              //                       width: Get.width,
              //                       // height: 47,
              //                       child: currentIndex !=
              //                               questionPage.length - 1
              //                           ? Row(
              //                               mainAxisAlignment:
              //                                   MainAxisAlignment.center,
              //                               children: [
              //                                 currentIndex != 0
              //                                     ? Flexible(
              //                                         child: FarenowButton(
              //                                         style:
              //                                             FarenowButtonStyleModel(
              //                                                 padding: EdgeInsets
              //                                                     .symmetric(
              //                                                         horizontal:
              //                                                             8)),
              //                                         title: "Previous",
              //                                         onPressed: () {
              //                                           if (label == "Done") {
              //                                             print("Hello");
              //                                             // if (zipCode.isEmpty) {
              //                                             //   Get.defaultDialog(
              //                                             //       title: "Alert",
              //                                             //       content: Text(
              //                                             //           "Please select valid Zipcode"),
              //                                             //       confirm: MaterialButton(
              //                                             //         onPressed: () {
              //                                             //           Get.back();
              //                                             //         },
              //                                             //         child: Text(
              //                                             //           "Okay",
              //                                             //           style: getStyle(fontSize: 16),
              //                                             //         ),
              //                                             //       ));

              //                                             //   return;
              //                                             // }
              //                                             // _controller.getProviderList(
              //                                             //   _controller.selectZipCode.value,
              //                                             //   _controller.selectedServiceId,
              //                                             // );
              //                                           } else {
              //                                             _controller
              //                                                 .selectZipCode
              //                                                 .value = "";
              //                                             _controller
              //                                                 .selectedAddrexx(
              //                                                     "");
              //                                             if (!checkError()) {
              //                                               // currentIndex = currentIndex + 1;
              //                                               // pageController.jumpToPage(currentIndex);
              //                                               Future.delayed(
              //                                                   Duration(
              //                                                       microseconds:
              //                                                           500),
              //                                                   () {
              //                                                 setState(() {
              //                                                   currentIndex =
              //                                                       currentIndex -
              //                                                           1;

              //                                                   pageController.animateToPage(
              //                                                       currentIndex,
              //                                                       duration: Duration(
              //                                                           seconds:
              //                                                               1),
              //                                                       curve: Curves
              //                                                           .fastOutSlowIn);
              //                                                 });
              //                                               });
              //                                               label = currentIndex !=
              //                                                       questionPage
              //                                                               .length -
              //                                                           1
              //                                                   ? "arrow"
              //                                                   : "Done";
              //                                               return;
              //                                             }
              //                                           }
              //                                         },
              //                                         type: BUTTONTYPE.outline,
              //                                       ))
              //                                     : Container(),
              //                                 Flexible(
              //                                   child: FarenowButton(
              //                                     style:
              //                                         FarenowButtonStyleModel(
              //                                             padding: EdgeInsets
              //                                                 .symmetric(
              //                                                     horizontal:
              //                                                         8)),
              //                                     title: currentIndex ==
              //                                             questionPage.length -
              //                                                 1
              //                                         ? "Done"
              //                                         : "Next",
              //                                     type: BUTTONTYPE.rectangular,
              //                                     onPressed: () {
              //                                       _controller.zipCodeList
              //                                           .clear();

              //                                       if (label == "Done") {
              //                                         print("Hello");
              //                                         // if (zipCode.isEmpty) {
              //                                         //   Get.defaultDialog(
              //                                         //       title: "Alert",
              //                                         //       content: Text(
              //                                         //           "Please select valid Zipcode"),
              //                                         //       confirm: MaterialButton(
              //                                         //         onPressed: () {
              //                                         //           Get.back();
              //                                         //         },
              //                                         //         child: Text(
              //                                         //           "Okay",
              //                                         //           style: getStyle(fontSize: 16),
              //                                         //         ),
              //                                         //       ));

              //                                         //   return;
              //                                         // }
              //                                         // _controller.getProviderList(
              //                                         //   _controller.selectZipCode.value,
              //                                         //   _controller.selectedServiceId,
              //                                         // );
              //                                       } else {
              //                                         _controller.selectZipCode
              //                                             .value = "";
              //                                         _controller
              //                                             .selectedAddrexx("");
              //                                         if (!checkError()) {
              //                                           // currentIndex = currentIndex + 1;
              //                                           // pageController.jumpToPage(currentIndex);
              //                                           Future.delayed(
              //                                               Duration(
              //                                                   microseconds:
              //                                                       500), () {
              //                                             setState(() {
              //                                               currentIndex =
              //                                                   currentIndex +
              //                                                       1;

              //                                               pageController.animateToPage(
              //                                                   currentIndex,
              //                                                   duration:
              //                                                       Duration(
              //                                                           seconds:
              //                                                               1),
              //                                                   curve: Curves
              //                                                       .fastOutSlowIn);
              //                                             });
              //                                           });
              //                                           label = currentIndex !=
              //                                                   questionPage
              //                                                           .length -
              //                                                       1
              //                                               ? "arrow"
              //                                               : "Done";
              //                                           return;
              //                                         }
              //                                       }
              //                                     },
              //                                   ),
              //                                 ),
              //                                 // Flexible(
              //                                 //   child: MaterialButton(
              //                                 //     shape: StadiumBorder(),
              //                                 //     color: Colors.blue,
              //                                 //     elevation: 5,
              //                                 //     onPressed: () {
              //                                 //       _controller.zipCodeList
              //                                 //           .clear();

              //                                 //       if (label == "Done") {
              //                                 //         print("Hello");
              //                                 //         // if (zipCode.isEmpty) {
              //                                 //         //   Get.defaultDialog(
              //                                 //         //       title: "Alert",
              //                                 //         //       content: Text(
              //                                 //         //           "Please select valid Zipcode"),
              //                                 //         //       confirm: MaterialButton(
              //                                 //         //         onPressed: () {
              //                                 //         //           Get.back();
              //                                 //         //         },
              //                                 //         //         child: Text(
              //                                 //         //           "Okay",
              //                                 //         //           style: getStyle(fontSize: 16),
              //                                 //         //         ),
              //                                 //         //       ));

              //                                 //         //   return;
              //                                 //         // }
              //                                 //         // _controller.getProviderList(
              //                                 //         //   _controller.selectZipCode.value,
              //                                 //         //   _controller.selectedServiceId,
              //                                 //         // );
              //                                 //       } else {
              //                                 //         _controller.selectZipCode
              //                                 //             .value = "";
              //                                 //         _controller
              //                                 //             .selectedAddrexx("");
              //                                 //         if (!checkError()) {
              //                                 //           // currentIndex = currentIndex + 1;
              //                                 //           // pageController.jumpToPage(currentIndex);
              //                                 //           Future.delayed(
              //                                 //               Duration(
              //                                 //                   microseconds:
              //                                 //                       500), () {
              //                                 //             setState(() {
              //                                 //               currentIndex =
              //                                 //                   currentIndex +
              //                                 //                       1;

              //                                 //               pageController.animateToPage(
              //                                 //                   currentIndex,
              //                                 //                   duration:
              //                                 //                       Duration(
              //                                 //                           seconds:
              //                                 //                               1),
              //                                 //                   curve: Curves
              //                                 //                       .fastOutSlowIn);
              //                                 //             });
              //                                 //           });
              //                                 //           label = currentIndex !=
              //                                 //                   questionPage
              //                                 //                           .length -
              //                                 //                       1
              //                                 //               ? "arrow"
              //                                 //               : "Done";
              //                                 //           return;
              //                                 //         }
              //                                 //       }
              //                                 //     },
              //                                 //     child: Container(
              //                                 //       margin: EdgeInsets.all(4),
              //                                 //       alignment: Alignment.center,
              //                                 //       child: currentIndex ==
              //                                 //               questionPage
              //                                 //                       .length -
              //                                 //                   1
              //                                 //           ? Text(
              //                                 //               "Done",
              //                                 //               style: TextStyle(
              //                                 //                   fontSize: 16,
              //                                 //                   color: Colors
              //                                 //                       .white),
              //                                 //             )
              //                                 //           : Text(
              //                                 //               "Next",
              //                                 //               style: TextStyle(
              //                                 //                   fontSize: 18,
              //                                 //                   color: AppColors
              //                                 //                       .white),
              //                                 //             ),
              //                                 //     ),
              //                                 //   ),
              //                                 // ),
              //                               ],
              //                             )
              //                           : Container(),
              //                     )
              //               : null,
              //         )
              //         //  Row(
              //         //   children: [
              //         //     Expanded(
              //         //         child: SizedBox(
              //         //       width: 19,
              //         //     )),
              //         //     for (int index = 0;
              //         //         index < questionPage.length;
              //         //         index++)
              //         //       Container(
              //         //         margin: EdgeInsets.all(3),
              //         //         width: 12,
              //         //         height: 12,
              //         //         decoration: BoxDecoration(
              //         //             color: index == currentIndex
              //         //                 ? Colors.white
              //         //                 : AppColors.grey.withOpacity(0.5),
              //         //             borderRadius:
              //         //                 BorderRadius.all(Radius.circular(10))),
              //         //       ),
              //         //     Expanded(
              //         //         child: SizedBox(
              //         //       width: 19,
              //         //       child: InkWell(
              //         //         onTap: () {
              //         //           _controller.zipCodeList.clear();

              //         //           if (label == "Done") {
              //         //             if (zipCode.isEmpty) {
              //         //               Get.defaultDialog(
              //         //                   title: "Alert",
              //         //                   content: Text(
              //         //                       "Please select valid Zipcode"),
              //         //                   confirm: MaterialButton(
              //         //                     onPressed: () {
              //         //                       Get.back();
              //         //                     },
              //         //                     child: Text(
              //         //                       "Okay",
              //         //                       style: getStyle(fontSize: 16),
              //         //                     ),
              //         //                   ));

              //         //               return;
              //         //             }
              //         //             _controller.getProviderList(
              //         //               _controller.selectZipCode.value,
              //         //               _controller.selectedServiceId,
              //         //             );
              //         //           } else {
              //         //             _controller.selectZipCode.value = "";
              //         //             _controller.selectedAddrexx("");
              //         //             if (!checkError()) {
              //         //               currentIndex = currentIndex + 1;
              //         //               pageController.jumpToPage(currentIndex);
              //         //               label = currentIndex !=
              //         //                       questionPage.length - 1
              //         //                   ? "arrow"
              //         //                   : "Done";
              //         //               return;
              //         //             }
              //         //           }
              //         //         },
              //         //         child: Container(
              //         //           margin: EdgeInsets.only(right: 24),
              //         //           alignment: Alignment.centerRight,
              //         //           child: currentIndex == questionPage.length - 1
              //         //               ? Text(
              //         //                   "Done",
              //         //                   style: TextStyle(
              //         //                       fontSize: 16,
              //         //                       color: Colors.white),
              //         //                 )
              //         //               : Row(
              //         //                   children: [
              //         //                     Expanded(
              //         //                         child: SizedBox(
              //         //                       width: 12,
              //         //                     )),
              //         //                     Text(
              //         //                       "Next",
              //         //                       style: TextStyle(
              //         //                           fontSize: 18,
              //         //                           color: AppColors.white),
              //         //                     ),
              //         //                     SizedBox(
              //         //                       width: 6,
              //         //                     ),
              //         //                     Icon(
              //         //                       Icons.arrow_forward_ios,
              //         //                       color: Colors.white,
              //         //                     ),
              //         //                   ],
              //         //                 ),
              //         //         ),
              //         //       ),
              //         //     )),

              //         //   ],
              //         // ),

              //         ))
            ],
          ),
        ),
        // IntroductionScreen(
        //   pages: [
        //     models.buildpage(),
        //     models.buildpage1(),
        //     models.buildpage2(),
        //     models.buildpage3()
        //   ],
        //   done: Icon(Icons.arrow_forward_ios),
        //   onDone: () {
        //     Get.offAllNamed(AppRoutes.WRAPPER);
        //     SharedRefrence().setIntro(true);
        //   },
        //   controlsPadding: EdgeInsets.all(6),
        //   controlsMargin: EdgeInsets.all(0),
        //   skipFlex: 1,
        //   dotsFlex: 3,
        //   nextFlex: 1,
        //   dotsDecorator:
        //       DotsDecorator(color: Colors.grey, activeColor: AppColors.white),
        //   dotsContainerDecorator: BoxDecoration(
        //     color: Colors.blue,
        //   ),
        //   showNextButton: true,
        //   scrollController: scrollController,
        //   nextColor: Colors.white,
        //   doneColor: AppColors.white,
        //   next: Icon(
        //     Icons.arrow_forward_ios,
        //   ),
        //   showSkipButton: false,
        //   skip: const Text("skip"),
        //   onSkip: () {
        //     SharedRefrence().setIntro(true);
        //     Get.offAllNamed(AppRoutes.WRAPPER);
        //   },
        //   onChange: (value) {
        //   },
        // ),
      ),
    );
  }

  bool checkSelected(List<ButtonSelectionModel> buttonModel) {
    for (int index = 0; index < buttonModel.length; index++) {
      if (buttonModel[index].selected!) {
        return true;
      }
    }

    return false;
  }

  Widget GetWidgetPage(ServiceQuestionQuestions resp) {
    return Container(
      alignment: Alignment.center,
      width: Get.width,
      height: Get.height,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    elevation: 5,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(children: [
                          Text(
                            resp.question,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.w700),
                          ),
                          22.height,
                          Container(
                              child: questionRadioButtons(
                                  resp.serviceQuestionOptions,
                                  resp.subServiceId,
                                  resp.is_multiple == 0 ? false : true)),
                          14.height,
                          Obx(() => checkFlag(_controller.visibleKeyboard.value)
                              ? emptyContainer()
                              : Container(
                                  // width: Get.width * 0.4,
                                  // height: 70,
                                  padding: EdgeInsets.all(12),
                                  child: Container(
                                    child: currentIndex !=
                                            questionPage.length - 1
                                        ? _controller
                                                    .resp
                                                    .value
                                                    .serviceQuestionQuestions[
                                                        currentIndex]
                                                    .is_multiple ==
                                                0
                                            ? null
                                            : Container(
                                                width: Get.width,
                                                // height: 47,
                                                child:
                                                    currentIndex !=
                                                            questionPage
                                                                    .length -
                                                                1
                                                        ? Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              currentIndex != 0
                                                                  ? Flexible(
                                                                      child:
                                                                          FarenowButton(
                                                                      style: FarenowButtonStyleModel(
                                                                          padding:
                                                                              EdgeInsets.symmetric(horizontal: 8)),
                                                                      title:
                                                                          "Previous",
                                                                      onPressed:
                                                                          () {
                                                                        if (currentIndex >
                                                                            0) {
                                                                          Future.delayed(
                                                                              Duration(microseconds: 500),
                                                                              () {
                                                                            setState(() {
                                                                              currentIndex = currentIndex - 1;

                                                                              pageController.animateToPage(currentIndex, duration: Duration(seconds: 1), curve: Curves.fastOutSlowIn);
                                                                            });
                                                                          });
                                                                        }
                                                                      },
                                                                      type: BUTTONTYPE
                                                                          .action,
                                                                    ))
                                                                  : Container(),
                                                              Flexible(
                                                                child:
                                                                    FarenowButton(
                                                                  style: FarenowButtonStyleModel(
                                                                      padding: EdgeInsets.symmetric(
                                                                          horizontal:
                                                                              5)),
                                                                  title: currentIndex ==
                                                                          questionPage.length -
                                                                              1
                                                                      ? "Done"
                                                                      : "Next",
                                                                  type: BUTTONTYPE
                                                                      .rectangular,
                                                                  onPressed:
                                                                      () {
                                                                    _controller
                                                                        .zipCodeList
                                                                        .clear();

                                                                    if (label ==
                                                                        "Done") {
                                                                      print(
                                                                          "Hello");
                                                                      // if (zipCode.isEmpty) {
                                                                      //   Get.defaultDialog(
                                                                      //       title: "Alert",
                                                                      //       content: Text(
                                                                      //           "Please select valid Zipcode"),
                                                                      //       confirm: MaterialButton(
                                                                      //         onPressed: () {
                                                                      //           Get.back();
                                                                      //         },
                                                                      //         child: Text(
                                                                      //           "Okay",
                                                                      //           style: getStyle(fontSize: 16),
                                                                      //         ),
                                                                      //       ));

                                                                      //   return;
                                                                      // }
                                                                      // _controller.getProviderList(
                                                                      //   _controller.selectZipCode.value,
                                                                      //   _controller.selectedServiceId,
                                                                      // );
                                                                    } else {
                                                                      _controller
                                                                          .selectZipCode
                                                                          .value = "";
                                                                      _controller
                                                                          .selectedAddrexx(
                                                                              "");
                                                                      if (!checkError()) {
                                                                        // currentIndex = currentIndex + 1;
                                                                        // pageController.jumpToPage(currentIndex);
                                                                        Future.delayed(
                                                                            Duration(microseconds: 500),
                                                                            () {
                                                                          setState(
                                                                              () {
                                                                            currentIndex =
                                                                                currentIndex + 1;

                                                                            pageController.animateToPage(currentIndex,
                                                                                duration: Duration(seconds: 1),
                                                                                curve: Curves.fastOutSlowIn);
                                                                          });
                                                                        });
                                                                        label = currentIndex !=
                                                                                questionPage.length - 1
                                                                            ? "arrow"
                                                                            : "Done";
                                                                        return;
                                                                      }
                                                                    }
                                                                  },
                                                                ),
                                                              ),
                                                            ],
                                                          )
                                                        : Container(),
                                              )
                                        : null,
                                  )))
                        ]),
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  questionRadioButtons(serviceQuestionOptions, int id, bool isMultiple) {
    return Column(
        children: List.generate(serviceQuestionOptions.length, (index) {
      return GestureDetector(
        onTap: () {
          print(index);
          if (isMultiple) {
            _controller.resp.value.serviceQuestionQuestions[currentIndex]
                    .serviceQuestionOptions[index].selected =
                !_controller.resp.value.serviceQuestionQuestions[currentIndex]
                    .serviceQuestionOptions[index].selected;
            setState(() {});
          } else {
            for (int optIndex = 0;
                optIndex <
                    _controller
                        .resp
                        .value
                        .serviceQuestionQuestions[currentIndex]
                        .serviceQuestionOptions
                        .length;
                optIndex++) {
              _controller.resp.value.serviceQuestionQuestions[currentIndex]
                  .serviceQuestionOptions[optIndex].selected = false;
            }
            _controller.resp.value.serviceQuestionQuestions[currentIndex]
                .serviceQuestionOptions[index].selected = true;

            Future.delayed(Duration(microseconds: 300), () {
              setState(() {
                currentIndex = currentIndex + 1;
                // pageController.jumpToPage(currentIndex);
                pageController.animateToPage(currentIndex,
                    duration: Duration(seconds: 1),
                    curve: Curves.fastOutSlowIn);
              });
            });
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: serviceQuestionOptions[index].selected
                    ? Border.all(color: AppColors.solidBlue, width: 1)
                    : Border.all(color: white)),
            padding: EdgeInsets.all(8),
            // margin: EdgeInsets.all(6),
            child: isMultiple
                ? Row(
                    children: [
                      // Icon(
                      //   serviceQuestionOptions[index].selected
                      //       ? Icons.check_box
                      //       : Icons.check_box_outline_blank,
                      //   color: serviceQuestionOptions[index].selected
                      //       ? Colors.blue
                      //       : Colors.black54,
                      //   size: 22,
                      // ),
                      Container(
                        width: 25,
                        height: 25,
                        decoration: BoxDecoration(
                            color: serviceQuestionOptions[index].selected
                                ? AppColors.solidBlue
                                : white,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(3),
                            border: Border.all(
                                color: serviceQuestionOptions[index].selected
                                    ? AppColors.solidBlue
                                    : Color(0xffBDBDBD),
                                width: 1)),
                        child: serviceQuestionOptions[index].selected
                            ? Icon(
                                Icons.check,
                                color: white,
                                size: 18,
                              )
                            : Container(),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Container(
                        width: Get.width * 0.5,
                        child: Marquee(
                          child: Text(serviceQuestionOptions[index].option,
                              style: getStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                  color: serviceQuestionOptions[index].selected
                                      ? AppColors.solidBlue
                                      : Color(0xff555555))),
                        ),
                      )
                    ],
                  )
                : Row(
                    children: [
                      Container(
                        width: 25,
                        height: 25,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: serviceQuestionOptions[index].selected
                                    ? AppColors.solidBlue
                                    : Color(0xffBDBDBD),
                                width: serviceQuestionOptions[index].selected
                                    ? 8
                                    : 1)),
                      ),
                      // Icon(
                      //   serviceQuestionOptions[index].selected
                      //       ? Icons.radio_button_checked
                      //       : Icons.radio_button_off,
                      //   color: serviceQuestionOptions[index].selected
                      //       ? Colors.blue
                      //       : Colors.black54,
                      //   size: 22,
                      // ),
                      SizedBox(
                        width: 12,
                      ),
                      Container(
                        width: Get.width * 0.55,
                        child: Marquee(
                          direction: Axis.horizontal,
                          textDirection: TextDirection.ltr,
                          child: Text(serviceQuestionOptions[index].option,
                              style: getStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                  color: serviceQuestionOptions[index].selected
                                      ? AppColors.solidBlue
                                      : Color(0xff555555))),
                        ),
                      )
                    ],
                  ),
          ),
        ),
      );
    }));
  }

  bool checkError() {
    int loop = currentIndex + 1;
    // if (_controller.resp.value.serviceQuestionQuestions[0].is_multiple == 0) {
    for (int index = 0; index < loop; index++) {
      bool flag = false;

      for (int optIndex = 0;
          optIndex <
              _controller.resp.value.serviceQuestionQuestions[index]
                  .serviceQuestionOptions.length;
          optIndex++) {
        if (_controller.resp.value.serviceQuestionQuestions[index]
            .serviceQuestionOptions[optIndex].selected) {
          flag = true;
          break;
        } else {
          flag = false;
        }
      }
      if (!flag) {
        currentIndex = index;
        pageController.jumpToPage(currentIndex);

        Get.defaultDialog(
            title: "Alert",
            confirm: MaterialButton(
              onPressed: () {
                Get.back();
              },
              child: Text(
                "Okay",
                style: getStyle(fontSize: 16),
              ),
            ),
            content: Text(
              "You didn't attempt this question\n ${_controller.resp.value.serviceQuestionQuestions[index].question} ",
              style: getStyle(fontSize: 16),
            ));

        return true;
      }
    }

    return false;
  }

  void check() {
    label = currentIndex != questionPage.length - 1 ? "arrow" : "Done";
    print(label);
  }

  checkFlag(bool value) {
    return value;
  }
}
