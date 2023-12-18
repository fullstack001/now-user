import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TestPage extends StatefulWidget {
  TestPage({Key? key}) : super(key: key);

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: 500,
          width: Get.width,
          color: Colors.cyan,
          child: Column(
            children: [
              for(int index=0;index<10;index)
                Container(
                  width: Get.width,
                  color: Colors.white,
                  child: Text("$index"),
                )
            ],
          ),
        ),
      ),
    );
  }
}