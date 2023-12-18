import 'package:application_1/utils/AppColors.dart';
import 'package:flutter/material.dart';

class ReuseableBlueButton extends StatelessWidget {
  var w, h;
  var text;
  var onTap;
  var bgColor;
  var fontColor;

  ReuseableBlueButton({
    this.w,
    this.h,
    this.text,
    this.onTap,
    this.bgColor,
    this.fontColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: bgColor ?? AppColors.appGreen,
        ),
        width: w * 0.918,
        height: h * 0.059,
        child: Center(
            child: Text(
          text.toString(),
          style: TextStyle(
              color: fontColor ?? AppColors.white,
              fontSize: 16,
              fontWeight: FontWeight.normal),
        )),
      ),
    );
  }
}
