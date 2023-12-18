import 'package:application_1/AllPages/ExplorePages/shopMenu.dart';
import 'package:application_1/reuseableWidgets/reuseableSizedbox.dart';
import 'package:application_1/social_network.dart';
import 'package:application_1/utils/AppColors.dart';
import 'package:application_1/widgets/custom_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_login_buttons/social_login_buttons.dart';
import 'package:url_launcher/url_launcher.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    SocialNetwork _socialNetwork = Get.put(SocialNetwork());
    double w = size.width;

    return Scaffold(
      backgroundColor: white,
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              width: Get.width,
              height: Get.height,
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.bottomLeft,
                        width: w,
                        child: Text(
                          "Sign up.",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: AppColors.black,
                              fontSize: 38,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      BuildSizedBox(10),
                      Container(
                        alignment: Alignment.centerLeft,
                        width: w * 0.835,
                        height: 36,
                        child: const Text(
                          "Don't worry we don't share your contact info with professionals.",
                          style: TextStyle(
                              color: Colors.black45,
                              fontSize: 16,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                      BuildSizedBox(40),
                      // Container(
                      //   margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                      //   child: ButtonTheme(
                      //     height: 50,
                      //     child: TextButton(
                      //       onPressed: () {
                      //         _socialNetwork.facebookLogin();
                      //       },
                      //       child: Center(
                      //           child: Row(
                      //         mainAxisAlignment:
                      //             MainAxisAlignment.spaceAround,
                      //         children: [
                      //           Image(
                      //             image: AssetImage(
                      //                 "assets/images/facebook_logo.png"),
                      //           ),
                      //           Text(
                      //             "Sign Up with Facebook",
                      //             style: TextStyle(
                      //               color: Colors.white,
                      //               fontSize: 14,
                      //             ),
                      //           ),
                      //           SizedBox()
                      //         ],
                      //       )),
                      //     ),
                      //   ),
                      //   decoration: BoxDecoration(
                      //     color: Color(0xff3B5998),
                      //     borderRadius: BorderRadius.circular(5),
                      //   ),
                      // ),
                      SocialLoginButton(
                        text: "Sign Up with Facebook",
                        // backgroundColor: black,
                        buttonType: SocialLoginButtonType.facebook,
                        width: Get.width * 0.9,

                        borderRadius: 8,
                        onPressed: () {
                          _socialNetwork.facebookLogin();
                        },
                      ),
                      BuildSizedBox(10),
                      // Container(
                      //   height: 50,
                      //   margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      //   child: InkWell(
                      //     onTap: () {
                      //       _socialNetwork.googleLogin();
                      //     },
                      //     child: Container(
                      //       child: Center(
                      //           child: Row(
                      //         mainAxisAlignment:
                      //             MainAxisAlignment.spaceAround,
                      //         children: [
                      //           Container(
                      //             margin:
                      //                 EdgeInsets.only(top: 6, bottom: 6),
                      //             padding: EdgeInsets.all(4),
                      //             height: 50,
                      //             color: Colors.white,
                      //             child: Image(
                      //               image: AssetImage(
                      //                 "assets/images/img_google.png",
                      //               ),
                      //               height: 24,
                      //             ),
                      //           ),
                      //           Text(
                      //             "Sign Up with Google",
                      //             style: TextStyle(
                      //               color: Colors.white,
                      //               fontSize: 14,
                      //             ),
                      //           ),
                      //           SizedBox()
                      //         ],
                      //       )),
                      //       decoration: BoxDecoration(
                      //         color: Color(0xff4E8BFB),
                      //         borderRadius: BorderRadius.circular(5),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      SocialLoginButton(
                        text: "Sign Up with Google",
                        // backgroundColor: black,
                        buttonType: SocialLoginButtonType.google,
                        width: Get.width * 0.9,

                        borderRadius: 8,
                        onPressed: () {
                          _socialNetwork.googleLogin();
                        },
                      ),
                      if (GetPlatform.isIOS) BuildSizedBox(10),
                      if (GetPlatform.isIOS)
                        // Container(
                        //   height: 50,
                        //   margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        //   child: InkWell(
                        //     onTap: () {
                        //       _socialNetwork.appleLogin();
                        //     },
                        //     child: Container(
                        //       child: Center(
                        //           child: Row(
                        //         mainAxisAlignment:
                        //             MainAxisAlignment.spaceAround,
                        //         children: [
                        //           Container(
                        //             margin:
                        //                 EdgeInsets.only(top: 6, bottom: 6),
                        //             padding: EdgeInsets.all(4),
                        //             height: 50,
                        //             child: Image(
                        //               image: AssetImage(
                        //                 "assets/images/img_apple_logo.png",
                        //               ),
                        //               color: AppColors.white,
                        //               height: 24,
                        //             ),
                        //           ),
                        //           Text(
                        //             "Sign Up with Apple",
                        //             style: TextStyle(
                        //               color: Colors.white,
                        //               fontSize: 14,
                        //             ),
                        //           ),
                        //           SizedBox()
                        //         ],
                        //       )),
                        //       decoration: BoxDecoration(
                        //         color: Colors.black,
                        //         borderRadius: BorderRadius.circular(5),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        SocialLoginButton(
                          text: "Sign Up with Apple",
                          // backgroundColor: black,
                          buttonType: SocialLoginButtonType.appleBlack,
                          width: Get.width * 0.9,

                          borderRadius: 8,
                          onPressed: () {
                            _socialNetwork.appleLogin();
                          },
                        ),
                      BuildSizedBox(20),
                      GestureDetector(
                        onTap: () {
                          Get.offNamed("/signin");
                        },
                        child: CustomContainer(
                          color: const Color(0xffF3F4F4),
                          alignment: Alignment.centerLeft,
                          height: 50,
                          width: Get.width,
                          allRadius: 6,
                          child: Row(
                            children: const [
                              SizedBox(
                                width: 18,
                              ),
                              Icon(
                                Icons.phone,
                                color: Color(0xff757575),
                              ),
                              SizedBox(
                                width: 28,
                              ),
                              Expanded(
                                child: Text(
                                  "Sign up with phone number",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xff7B7D7E)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 0,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                  alignment: Alignment.bottomCenter,
                  width: w / 1.16,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          alignment: Alignment.bottomLeft,
                          width: w,
                          child: const Text(
                            "Are you vendor or Professional?",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: Colors.black),
                          ),
                        ),
                        BuildSizedBox(5),
                        Container(
                          alignment: Alignment.bottomLeft,
                          width: w,
                          child: Text(
                            "Donwlodad the app for pro",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: AppColors.blue),
                          ),
                        ),
                      ])),
            ),
          ),
        ],
      ),
    );
  }
}
