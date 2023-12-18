import 'package:application_1/utils/AppColors.dart';
import 'package:flutter/material.dart';

class ReuseableRatingButton extends StatelessWidget {
  var w, h;
  var txt;
  var onTap;
  ReuseableRatingButton({this.w, this.h, this.txt, this.onTap});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.red, borderRadius: BorderRadius.circular(15)),
      width: w * 0.202,
      height: w * 0.08,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(
            Icons.star,
            color: Colors.white,
            size: 15,
          ),
          Text(
            txt.toString(),
            style: TextStyle(fontSize: 14, color: AppColors.white),
          ),
        ],
      ),
    );
  }
}
