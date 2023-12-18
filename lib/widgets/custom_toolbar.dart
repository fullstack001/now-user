import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomToolbar extends StatelessWidget {
  final title;
  final leading;
  final trailing;

  CustomToolbar({Key? key, this.title, this.leading, this.trailing})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: 64,
      color: Colors.white,
      child: Row(
        children: [
          leading ?? getEmptyButton(),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              width: 100,
              height: 64,
              child: Text(
                title ?? "",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          trailing ?? getEmptyButton(),
        ],
      ),
    );
  }

  getEmptyButton() {
    return Container(
      height: 64,
      child: IconButton(
        onPressed: () {},
        icon: Icon(
          Icons.arrow_back,
          color: Colors.transparent,
          size: 25,
        ),
      ),
    );
  }
}
