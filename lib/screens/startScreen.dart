import 'package:application_1/App_Routes/app_routes.dart';

import 'package:application_1/components/buttons-management/part_of_file/part.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nb_utils/nb_utils.dart';

bool flagBuild = kDebugMode || kProfileMode;

class StartScreen extends StatefulWidget {
  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  int count = 0;
  int upperCounter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            100.height,
            SvgPicture.asset(
              "assets/user_assets/svg/intro.svg",
              width: Get.width,
            ),
            Column(
              children: [
                12.height,
                const Padding(
                  padding: EdgeInsets.only(left: 24),
                  child: Text(
                    "Find professionals for pretty much anything",
                    style: TextStyle(
                        fontSize: 32,
                        color: Color(0xff151415),
                        fontWeight: FontWeight.w700),
                  ),
                ),
                18.height,
                const Padding(
                  padding: EdgeInsets.only(left: 24),
                  child: Text(
                    "We help you connect to verified and professional service providers.",
                    style: TextStyle(
                        fontSize: 20,
                        color: Color(0xff555555),
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ],
            ),
            20.height,
            Column(
              children: [
                FarenowButton(
                    title: "Sign up",
                    onPressed: () {
                      // Get.toNamed(AppRoutes.SIGNUP);
                      Get.toNamed("/signin");
                    },
                    type: BUTTONTYPE.rectangular),
                FarenowButton(
                    title: "Login",
                    onPressed: () {
                      Get.toNamed(AppRoutes.LOGIN);
                    },
                    type: BUTTONTYPE.outline)
              ],
            ),
            12.height,
            // Expanded(
            //     flex: 6,
            //     child: Container(
            //       child: Stack(
            //         children: [
            //           // Container(
            //           //   alignment: Alignment.topRight,
            //           //   child: Image(
            //           //     alignment: Alignment.topRight,
            //           //     width: w * 284 / 360,
            //           //     height: h * 281 / 800,
            //           //     image:
            //           //         AssetImage("assets/image 2x/fS upper pic.png"),
            //           //   ),
            //           // ),
            //           // Positioned(
            //           //   left: w * 0.1,
            //           //   top: w * 0.4,
            //           //   child: ConstrainedBox(
            //           //       constraints: BoxConstraints(minHeight: h * 0.2),
            //           //       child: InkWell(
            //           //         onTap: () async {
            //           //           if (flagBuild) {
            //           //             count += 1;
            //           //             if (count % 7 == 0) {
            //           //               String url = await SharedRefrence()
            //           //                   .getString(key: "URL");
            //           //               if (url.isNotEmpty) {
            //           //                 baseUrl = url;
            //           //               }
            //           //               Get.dialog(ChangeBaseurlDialog(),
            //           //                   barrierDismissible: false);
            //           //             }
            //           //           }
            //           //         },
            //           //         child: Container(
            //           //           width: w * 310 / 360,
            //           //           child: Text(
            //           //             "Find local professionals for pretty much anything.",
            //           //             style: TextStyle(
            //           //                 fontSize: 24,
            //           //                 fontWeight: FontWeight.bold),
            //           //           ),
            //           //         ),
            //           //       )),
            //           // ),
            //         ],
            //       ),
            //     )),
            // Expanded(
            //     flex: 0,
            //     child: Container(
            //       child: Column(
            //         children: [
            //           GestureDetector(
            //             onTap: () async {
            //               if (flagBuild) {
            //                 upperCounter += 1;
            //                 if (upperCounter % 5 == 0) {
            //                   String paymentKey = await SharedRefrence()
            //                       .getString(key: "publishKey");
            //                   if (paymentKey.isNotEmpty) {
            //                     publishKey = paymentKey;
            //                   }
            //                   Get.dialog(ChangePublishKeyDialog(),
            //                       barrierDismissible: false);
            //                 }
            //               }
            //             },
            //             child: Center(
            //               child: Container(
            //                 alignment: Alignment.center,
            //                 child: Text(
            //                   "Have you used FareNow before?",
            //                   style: TextStyle(
            //                       fontSize: 16,
            //                       fontWeight: FontWeight.normal,
            //                       color: Colors.black26),
            //                 ),
            //               ),
            //             ),
            //           ),
            //           BuildSizedBox(h * 0.05),
            //           Padding(
            //             padding: const EdgeInsets.symmetric(horizontal: 25),
            //             child: TextButton(
            //               onPressed: () {
            //                 Get.toNamed(AppRoutes.SIGNUP);
            //               },
            //               child: Container(
            //                 width: w,
            //                 height: 47,
            //                 decoration: BoxDecoration(
            //                     color: AppColors.blue,
            //                     borderRadius: BorderRadius.circular(8)),
            //                 alignment: Alignment.center,
            //                 child: Text(
            //                   "It's my first time!",
            //                   style: TextStyle(
            //                       color: AppColors.white,
            //                       fontSize: 16,
            //                       fontWeight: FontWeight.normal),
            //                 ),
            //               ),
            //             ),
            //           ),
            //           Padding(
            //             padding: const EdgeInsets.symmetric(horizontal: 25),
            //             child: TextButton(
            //               style: ButtonStyle(),
            //               onPressed: () {
            //                 Get.toNamed(AppRoutes.LOGIN);
            //               },
            //               child: Container(
            //                 decoration: BoxDecoration(
            //                     color: AppColors.grey,
            //                     borderRadius: BorderRadius.circular(8)),
            //                 alignment: Alignment.center,
            //                 width: w,
            //                 height: 47,
            //                 child: Text(
            //                   "I've used before",
            //                   style: TextStyle(
            //                       color: Colors.black54,
            //                       fontSize: 16,
            //                       fontWeight: FontWeight.normal),
            //                 ),
            //               ),
            //             ),
            //           ),
            //         ],
            //       ),
            //     )),
            // Expanded(
            //     flex: 0,
            //     child: Container(
            //         width: w / 1.16,
            //         height: 104,
            //         child: Column(
            //             mainAxisAlignment: MainAxisAlignment.center,
            //             crossAxisAlignment: CrossAxisAlignment.end,
            //             children: [
            //               Container(
            //                 alignment: Alignment.centerLeft,
            //                 width: w,
            //                 child: Text(
            //                   "Are you vendor or Professional?",
            //                   style: TextStyle(
            //                       fontSize: 16,
            //                       fontWeight: FontWeight.normal,
            //                       color: Colors.black),
            //                 ),
            //               ),
            //               // GestureDetector(
            //               //   onTap: () {},
            //               //   child: Container(
            //               //     alignment: Alignment.centerLeft,
            //               //     width: w,
            //               //     child: Text(
            //               //       "Donwlodad the app for pro",
            //               //       style: TextStyle(
            //               //           fontSize: 16,
            //               //           fontWeight: FontWeight.normal,
            //               //           color: AppColors.blue),
            //               //     ),
            //               //   ),
            //               // )
            //             ]))),
          ],
        ),
      ),
    );
  }
}
