import 'package:application_1/widgets/text_with_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class IntroWidget extends StatelessWidget {
  final icon;
  final textTitle;
  final textContent;

  const IntroWidget({
    Key? key,
    this.icon,
    this.textContent,
    this.textTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          icon,
          width: 280,
          height: 260,
          fit: BoxFit.cover,
        ),
        TextWithIcon(
          width: Get.width,
          title: textTitle,
          fontSize: 30,
          marginTop: 24,
          fontWeight: FontWeight.w600,
        ),
        TextWithIcon(
          width: Get.width,
          title: textContent,
          textAlign: TextAlign.center,
          fontSize: 18,
          marginTop: 18,
        )
      ],
    );
  }
}
