import 'package:application_1/AllPages/ExplorePages/provider_profile_screen/provider_profile/export_file.dart';
import 'package:application_1/AllPages/ExplorePages/provider_profile_screen/provider_profile_controller/work_history_controller.dart';

import '../../../save_address_controller.dart';

class ProviderProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(WorkHistoryController.new);
    Get.lazyPut(SaveAddressController.new);
  }
}
