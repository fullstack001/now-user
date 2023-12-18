import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class DataNotAvailableWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF5F5F5),
      body: Align(
        alignment: Alignment.topCenter,
        child: SvgPicture.asset(
          "assets/user_assets/svg/empty state card.svg",
          width: Get.width * 0.9,
        ),
      ),
    );
  }
}
