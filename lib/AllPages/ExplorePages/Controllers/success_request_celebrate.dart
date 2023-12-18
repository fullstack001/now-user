import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/../App_Routes/app_routes.dart';
import '/../utils/AppColors.dart';

class SubscriptionSuccess extends StatefulWidget {
  @override
  State<SubscriptionSuccess> createState() => _SubscriptionSuccessState();
}

class _SubscriptionSuccessState extends State<SubscriptionSuccess> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Flexible(
              flex: 9,
              child: Container(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          width: double.infinity,
                          height: Get.width * 0.35,
                          child: Image(
                              image: AssetImage(
                                  'assets/profileImage/celebrate.png'))),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Subscription Success",
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: Colors.black),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: Text(
                          "Your package subscription was successfully",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.black54),
                        ),
                      ),
                    ]),
              )),
          Flexible(
              flex: 1,
              child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: MaterialButton(
                    onPressed: () {
                      Get.offNamedUntil(AppRoutes.TABSCREEN, (route) => false);
                    },
                    color: AppColors.darkBlue,
                    textColor: Colors.white,
                    minWidth: MediaQuery.of(context).size.width * 0.8,
                    height: 47,
                    shape: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(18)),
                    child: Text(
                      "Done",
                      style: TextStyle(fontSize: 18),
                    ),
                  ))),
        ],
      ),
    );
  }
}
