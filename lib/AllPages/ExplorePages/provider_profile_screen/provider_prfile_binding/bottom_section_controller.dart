import 'package:application_1/AllPages/ExplorePages/provider_profile_screen/provider_profile/export_file.dart';

class BottomSectionController extends GetxController {
  String messageLabel = "Chat Request";
  updateMessageLable(String lable) {
    messageLabel = lable;
    update();
  }
}
