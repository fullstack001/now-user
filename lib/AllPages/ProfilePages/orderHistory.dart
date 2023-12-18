import 'package:application_1/screens/exploreScreen.dart';
import 'package:application_1/utils/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'orderhistoryListview.dart';

class OrderHistory extends StatelessWidget {
  const OrderHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_back,
            size: 24,
            color: AppColors.blue,
          ),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, size) {
          return ConstrainedBox(
            constraints: BoxConstraints(minHeight: size.maxHeight),
            child: Column(
              children: [
                Expanded(
                  flex: 4,
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(15),
                          alignment: Alignment.centerLeft,
                          child: Container(
                            child: Text("My Order History",
                                overflow: TextOverflow.visible,
                                style: TextStyle(
                                    color: AppColors.black,
                                    fontSize: 36,
                                    fontWeight: FontWeight.w600)),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(15),
                          alignment: Alignment.centerLeft,
                          child: Container(
                            child: Text(
                                "Checkout for your order history for both:",
                                overflow: TextOverflow.visible,
                                style: TextStyle(
                                    color: AppColors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400)),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          width: size.maxWidth * 0.898,
                          height: size.maxHeight * 0.5,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Get.to(OrderHistoryListView(
                                      viewType: "grocery",
                                      viewTitle: "Grocery History"));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Container(
                                    width: size.maxWidth * 0.445,
                                    height: size.maxWidth * 0.473,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6),
                                        gradient: LinearGradient(
                                            begin: FractionalOffset.center,
                                            end: FractionalOffset.bottomCenter,
                                            colors: [
                                              Color(0xff48A6E8),
                                              Color(0xff1B80F5),
                                            ])),
                                    child: Stack(
                                      children: [
                                        Opacity(
                                          opacity: 0.2,
                                          child: ClipPath(
                                            child: Container(
                                              height: size.maxHeight * 0.5,
                                              color: Colors.white60,
                                            ),
                                            clipper: CustomClipPath(),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.center,
                                          child: Padding(
                                            padding: const EdgeInsets.all(2),
                                            child: Container(
                                              width: size.maxWidth * 0.3,
                                              height: size.maxWidth * 0.3,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: AssetImage(
                                                          "assets/image 2x/foodBox.png"))),
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                "Grocery Delivery",
                                                style: TextStyle(
                                                    color: AppColors.white,
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              SizedBox(
                                                height: size.maxHeight * 0.02,
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.to(OrderHistoryListView(
                                      viewType: "food",
                                      viewTitle: "Food History"));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Container(
                                    width: size.maxWidth * 0.445,
                                    height: size.maxWidth * 0.473,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6),
                                        gradient: LinearGradient(
                                            begin: FractionalOffset.center,
                                            end: FractionalOffset.bottomCenter,
                                            colors: [
                                              Color(0xff3A4050),
                                              Color(0xff343A4A),
                                            ])),
                                    child: Stack(
                                      children: [
                                        Opacity(
                                          opacity: 0.2,
                                          child: ClipPath(
                                            child: Container(
                                              height: size.maxWidth * 0.5,
                                              color: Colors.white60,
                                            ),
                                            clipper: CustomClipPath(),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.center,
                                          child: Padding(
                                            padding: const EdgeInsets.all(2),
                                            child: Container(
                                              width: size.maxWidth * 0.4,
                                              height: size.maxWidth * 0.4,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: AssetImage(
                                                          "assets/image 2x/foodpng.png"))),
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.center,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                "Food Delivery",
                                                style: TextStyle(
                                                    color: AppColors.white,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                              SizedBox(
                                                height: size.maxHeight * 0.02,
                                              )
                                            ],
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
                      )
                    ],
                  ),
                ),
                Expanded(flex: 6, child: SizedBox())
              ],
            ),
          );
        },
      ),
    );
  }
}
