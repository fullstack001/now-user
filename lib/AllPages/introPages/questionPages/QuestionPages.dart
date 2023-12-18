import 'package:application_1/AllPages/introPages/intro_controller.dart';
import 'package:application_1/AllPages/introPages/questionPages/models/button_selection_model.dart';
import 'package:application_1/All_Refrences/shared_refrence.dart';
import 'package:application_1/screens/Bindings/mainPageBinding.dart';
import 'package:application_1/utils/AppColors.dart';
import 'package:application_1/widgets/text_with_icon.dart';
import 'package:application_1/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:preload_page_view/preload_page_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'PageModels.dart';

class Question1 extends StatefulWidget {
  Question1({Key? key}) : super(key: key);

  @override
  _Question1State createState() => _Question1State();
}

class _Question1State extends State<Question1> {
  QuestionPageModels models = QuestionPageModels();

  final IntroController _controller = Get.find();

  PreloadPageController scrollController = PreloadPageController();

  final pageController = PageController(initialPage: 0);

  int currentIndex = 0;

  List<Widget> page = [
    QuestionPageModels().buildpage(),
    QuestionPageModels().buildpage1(),
    QuestionPageModels().buildpage2(),
    QuestionPageModels().buildpage4()
  ];

  @override
  void initState() {
    Future.delayed(Duration(seconds: 5)).then((value) async {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setBool("intro", true);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        top: true,
        child: Container(
          height: Get.height,
          child: Column(
            children: [
              Expanded(
                  child: PageView(
                // physics: NeverScrollableScrollPhysics(),
                onPageChanged: (value) {
                  currentIndex = value;
                  setState(() {});
                },
                controller: pageController,
                children: [
                  QuestionPageModels().buildpage(),
                  QuestionPageModels().buildpage1(),
                  QuestionPageModels().buildpage2(),
                  QuestionPageModels().buildpage4()
                ],
              )),
              Container(
                width: Get.width,
                height: 60,
                color: Colors.blue,
                child: Row(
                  children: [
                    Expanded(
                        child: TextWithIcon(
                      containerClick: () {
                        // SharedRefrence().saveString(key: "intro", data: "yes");
                        SharedRefrence().setIntro(true);
                        Get.offAll(Wrapper(), binding: MainPageBinding());
                      },
                      title: "Skip",
                      height: 60,
                      fontSize: 17,
                      marginLeft: 12,
                      fontColor: Colors.white,
                    )),
                    for (int index = 0; index < 4; index++)
                      Container(
                        margin: EdgeInsets.all(3),
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                            color: index == currentIndex
                                ? Colors.white
                                : AppColors.grey.withOpacity(0.5),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                      ),
                    Expanded(
                        child: SizedBox(
                      width: 19,
                      child: InkWell(
                        onTap: () {
                          if (currentIndex != 3) {
                            currentIndex += 1;
                            pageController.jumpToPage(currentIndex);
                          } else {
                            // SharedRefrence()
                            //     .saveString(key: "intro", data: "yes");
                            SharedRefrence().setIntro(true);
                            Get.offAll(Wrapper(), binding: MainPageBinding());
                          }
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 24),
                          alignment: Alignment.centerRight,
                          child: currentIndex == 3
                              ? Text(
                                  "Done",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                )
                              : Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.white,
                                ),
                        ),
                      ),
                    )),
                  ],
                ),
              )
            ],
          ),
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
}
