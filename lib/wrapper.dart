import 'package:application_1/screens/Controllers/mainPageController.dart';
import 'package:application_1/screens/startScreen.dart';
import 'package:application_1/screens/tabScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Wrapper extends GetView<MainPageController> {
  Widget build(BuildContext context) {
    return Obx(() {
      return getScreen(controller);
    });
  }

  Widget getScreen(MainPageController controller) {
    //controller.value.value ? TabsScreen() : StartScreen()

    if (controller.value.value) {
      return TabsScreen();
    }
    return StartScreen();
  }
}
