import 'dart:convert';

import 'package:application_1/AllPages/ExplorePages/shopMenu.dart';
import 'package:application_1/All_Refrences/shared_refrence.dart';
import 'package:application_1/App_Routes/app_routes.dart';
import 'package:application_1/resources/repositories/service_repository.dart';
import 'package:application_1/utils/api_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/num_extensions.dart';

class SplashScreen extends StatefulWidget {
  static const String id = 'splashScreen';

  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var introValue;

  @override
  void initState() {
    1.delay().then((value) async {
      String route = await checkToken();

      3.delay().then((value) {
        Get.offNamedUntil(route, (route) => false);
      });
    });
    super.initState();
  }

  Future<String> checkToken() async {
    // String authToken =
    //     await SharedRefrence().getString(key: ApiUtills.authToken);
    String userData = await SharedRefrence().getString(key: ApiUtills.userData);
    String into = await SharedRefrence().getBool(key: 'intro');
    into = into.isEmpty ? "no" : into;
    String authToken = "";
    if (userData.isNotEmpty) {
      var data = json.decode(userData);
      var resp = await ServiceReposiotry()
          .userAvailable(data['data']['user']['id'].toString());
      introValue = resp ? true : false;
      print(authToken);
    }
    if (into == "no") {
      return AppRoutes.INTRO;
    }
    return AppRoutes.WRAPPER;
    // return authToken.isNotEmpty ? BottomNavigation.id : SignupOrLoginScreen.id;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Center(
          child: FittedBox(
              child: Image.asset(
        'assets/user_assets/png/user_logo.png',
        width: Get.width * 0.65,
        height: Get.width * 0.65,
      ))),
    );
  }
}
