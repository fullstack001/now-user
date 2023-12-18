import 'package:application_1/All_Refrences/shared_refrence.dart';
import 'package:get/get.dart';

class MainPageController extends GetxController {
  var value = false.obs;
  SharedRefrence refrence = SharedRefrence();
  @override
  void onInit() async {
    super.onInit();
    value.value = await refrence.getSignIn();
    print("${value.value}");
  }
}
