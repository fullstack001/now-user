import 'package:application_1/utils/AppColors.dart';
import 'package:flutter/material.dart';

class ButtonWithIcon extends StatelessWidget {
  final onTap;

  ButtonWithIcon({Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        onTap();
      },
      child: Row(
        children: [
          Text(
            "See More",
            style: TextStyle(color: AppColors.appBlue),
          ),
          SizedBox(
            width: 4,
          ),
          Icon(
            Icons.arrow_forward_ios,
            color: AppColors.appBlue,
            size: 16,
          )
        ],
      ),
    );
  }
}
