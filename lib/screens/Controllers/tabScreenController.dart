import 'package:application_1/AllPages/MessagePages/message.dart';
import 'package:application_1/AllPages/ProfilePages/Profile.dart';
import 'package:application_1/AllPages/ProjectPages/project.dart';
import 'package:get/get.dart';

import '../exploreScreen.dart';

class TabScreenController extends GetxController {
  //TODO bottom tab index

  List _list = [ExploreScreen(), Projects(), Messages(), Profile()];

  List get tabList => _list;

  final RxInt _currentIndex = 0.obs;
  int get currentIndex => _currentIndex.value;

  void setTabIndex(int val) {
    _currentIndex(val);
    _currentIndex.refresh();
    update();
  }

//TODO  project header Tab

  final RxInt _projectCurrentIndex = 0.obs;
  int get projectHeaderTabIndex => _projectCurrentIndex.value;
  void setProjectTabIndex(int i) {
    _projectCurrentIndex(i);
    update();
  }
}
