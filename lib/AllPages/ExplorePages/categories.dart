import 'dart:convert';

import 'package:application_1/AllPages/ExplorePages/Controllers/providerListController.dart';
import 'package:application_1/AllPages/ExplorePages/service_question_widget.dart';
import 'package:application_1/AllPages/introPages/intro_controller.dart';
import 'package:application_1/AllPages/introPages/questionPages/PageModels.dart';
import 'package:application_1/remote_model/main_services/main_services_data.dart';
import 'package:application_1/remote_model/main_services/sub_services.dart';
import 'package:application_1/remote_model/service_questions/service_question_data.dart';
import 'package:application_1/utils/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Categories extends StatefulWidget {
  Categories({Key? key}) : super(key: key);

  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  ProviderListController _providerListController = Get.find();
  IntroController _introController = Get.find();
  Color black = AppColors.black;

  Color white = AppColors.white;

  Color grey = AppColors.grey;

  Color blue = AppColors.blue;

  Color green = AppColors.green;

  MainServicesData? value;

  @override
  Widget build(BuildContext context) {
    if (value == null) {
      value = MainServicesData.fromJson(json.decode(Get.arguments));
    }
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            backgroundColor: white,
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                Icons.close,
                size: 22,
                color: blue,
              ),
            ),
          ),
          body: LayoutBuilder(
            builder: (context, size) {
              print(size.maxWidth);
              print(size.maxHeight);
              return ConstrainedBox(
                constraints: BoxConstraints(minHeight: size.maxHeight),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: ConstrainedBox(
                          constraints: BoxConstraints(minHeight: 48),
                          child: Card(
                            elevation: 2.2,
                            child: Container(
                              width: size.maxWidth,
                              height: 48,
                              child: TextFormField(
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.search,
                                      color: Colors.black38,
                                    ),
                                    filled: true,
                                    hintText: value!.name,
                                    hintStyle: TextStyle(
                                      height: 3,
                                      color: Colors.black38,
                                    ),
                                    fillColor: Colors.white10,
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none)),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          alignment: Alignment.centerLeft,
                          width: size.maxWidth,
                          height: 40,
                          color: Colors.transparent,
                          child: Container(
                            height: 25,
                            child: Text(
                              value!.name,
                              style: Theme.of(context).textTheme.headline6,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 10,
                        child: Container(
                          // width: size.maxWidth,
                          // height: size.maxHeight * 0.3,
                          child: ListView.builder(
                            itemCount: value!.subServices.length,
                            itemBuilder: (context, index) {
                              SubServices _subServices =
                                  value!.subServices[index];
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: Container(
                                  width: size.maxWidth,
                                  height: size.maxHeight * 0.223,
                                  child: Row(
                                    children: [
                                      Expanded(
                                          flex: 5,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    fit: BoxFit.fill,
                                                    image: AssetImage(
                                                        "assets/image 2x/handy.png"))),
                                          )),
                                      Expanded(
                                          flex: 7,
                                          child: Container(
                                            padding: EdgeInsets.only(
                                                left: 18, right: 12),
                                            alignment: Alignment.center,
                                            color: Colors.blue,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  _subServices.name,
                                                  style: TextStyle(
                                                      color: white,
                                                      fontSize: 18),
                                                ),
                                                MaterialButton(
                                                    textColor: blue,
                                                    color: white,
                                                    height: 23,
                                                    shape: StadiumBorder(),
                                                    child: Container(
                                                      width: size.maxWidth *
                                                          140 /
                                                          360,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Expanded(
                                                            flex: 10,
                                                            child: Text(
                                                              'Book Now',
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 1,
                                                            child: Icon(
                                                              Icons
                                                                  .arrow_forward_outlined,
                                                              color: blue,
                                                              size: 12,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    onPressed: () {
                                                      // Get.to(SubCategories());
                                                      controller.address("");
                                                      _introController
                                                          .zipCode("");
                                                      _introController
                                                          .address("");

                                                      _introController.resp(
                                                          ServiceQuestionData());
                                                      getQuestions(
                                                          _subServices.id);
                                                    })
                                              ],
                                            ),
                                          )),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          )),
    );
  }

  void getQuestions(int id) {
    _providerListController.getQuestions(id, onResponse: (value) {
      Get.to(ServiceQuestionWidget(), arguments: value);
    });
  }
}
