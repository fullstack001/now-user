import 'package:get/get.dart';
import 'package:application_1/AllPages/ExplorePages/Controllers/profile_controller.dart';
import 'package:application_1/AllPages/ExplorePages/Controllers/providerListController.dart';
import 'package:application_1/AllPages/ProjectPages/controller/home_screen_controller.dart';
import 'package:application_1/AllPages/chat/chatt_controller.dart';
import 'package:application_1/AllPages/chat/message_controller.dart';
import 'package:application_1/AllPages/introPages/intro_controller.dart';
import 'package:application_1/AllPages/save_address_controller.dart';

import '../AllPages/RegisteraionPages/Controllers/RegistrationController.dart';
import '../AllPages/moving/controllers/dashboard_controller.dart';

class InitialAppBinding extends Bindings {
  @override
  void dependencies() {
    ChatController chatController = Get.put(ChatController());
    MessageController messageController = Get.put(MessageController());

    ProviderListController providerListController =
        Get.put(ProviderListController(flag: true));
    RegistrationController registrationController =
        Get.put(RegistrationController(getUser: true));
    IntroController introController = Get.put(IntroController());
    ProfileScreenController screenController =
        Get.put(ProfileScreenController());
    HomeScreenController homeScreenController =
        Get.put(HomeScreenController(flag: true));
    SaveAddressController saveAddressController =
        Get.put(SaveAddressController());
    DashboardController dashboardController = Get.put(DashboardController());
  }
}
