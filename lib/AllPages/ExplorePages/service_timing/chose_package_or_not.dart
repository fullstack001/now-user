import 'package:application_1/screens/subscription/package_plan_screens/all_plans.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../utils/AppColors.dart';
import '../../payment/stripe.dart';

class ChossePackageOrNot extends StatelessWidget {
  var body;
  ChossePackageOrNot({super.key, this.body});

  @override
  Widget build(BuildContext context) {
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
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                "4 of 4",
                style: TextStyle(
                    color: AppColors.solidBlue,
                    fontSize: 20,
                    fontWeight: FontWeight.w400),
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
        child: Column(children: [
          const Text(
            "Do you want to check out with Package Subscription Plan to automatically renew every 30 days?",
            textAlign: TextAlign.start,
            style: TextStyle(
                color: Color(0xff151415),
                fontSize: 20,
                fontWeight: FontWeight.w500),
          ),
          12.height,
          GestureDetector(
            onTap: () {
              Get.to(AllPlans(
                body: body,
              ));
            },
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14)),
              child: Container(
                width: double.infinity,
                height: 57,
                child: Row(children: [
                  16.width,
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color(0xffBDBDBD), width: 1),
                        borderRadius: BorderRadius.circular(90)),
                  ),
                  12.width,
                  const Text(
                    "Yes ( Package Subscription)",
                    style: TextStyle(
                        color: Color(0xff555555),
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  )
                ]),
              ),
            ),
          ),
          12.height,
          GestureDetector(
            onTap: () {
              Get.to(() => StripeModel(
                    body: body,
                    hide: true,
                    onPageChange: (value) {},
                  ));
            },
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14)),
              child: Container(
                width: double.infinity,
                height: 57,
                child: Row(children: [
                  16.width,
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color(0xffBDBDBD), width: 1),
                        borderRadius: BorderRadius.circular(90)),
                  ),
                  12.width,
                  const Text(
                    "No ( One-Off)",
                    style: TextStyle(
                        color: Color(0xff555555),
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  )
                ]),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
