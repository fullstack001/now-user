import 'package:application_1/AllPages/ExplorePages/Controllers/profile_controller.dart';
import 'package:application_1/AllPages/ProjectPages/controller/home_screen_controller.dart';
import 'package:application_1/screens/Controllers/tabScreenController.dart';
import 'package:application_1/utils/project_widget.dart';
import 'package:application_1/widgets/data_not_available_widget.dart';
import 'package:application_1/widgets/project_header_widget.dart';
import 'package:application_1/widgets/view_rendering.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laravel_echo/laravel_echo.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../RegisteraionPages/Controllers/RegistrationController.dart';

class Projects extends StatefulWidget {
  @override
  _ProjectsState createState() => _ProjectsState();
}

class _ProjectsState extends State<Projects> {
  Color blue = Colors.blue;

  Color white = Colors.white;

  HomeScreenController _homeScreenController = Get.find();

  ProfileScreenController _screenController = Get.find();
  RegistrationController _registrationController = Get.find();
  TabScreenController _tabScreenController = Get.find();
  String selectedTab = "accepted";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    HomeScreenController _homeScreenControlle = Get.find();
    _homeScreenControlle.getAvailableJobs(flag: true);
    Echo echo = Echo({
      'broadcaster': 'socket.io',
      'client': IO.io,
      "host": 'https://api.farenow.com',
    });
    echo.socket.on('connect', (_) {
      print('connected');
    });
    print(_registrationController.userData.value.id);
    echo
        .channel('alert-to-${_registrationController.userData.value.id}')
        .listen('AlertEvent', (e) {
      print(e);
      _homeScreenControlle.getAvailableJobs(flag: true);
    });
  }

  PageController _pageController = PageController();

  bool availAble = true;

  List<Widget> pages = [];

  @override
  Widget build(BuildContext context) {
    // _homeScreenController.getAvailableJobs(
    //     flag: checkEmpty(_homeScreenController));
    return Scaffold(
        appBar: AppBar(
          backgroundColor: white,
          elevation: 0,
          bottom: PreferredSize(
            preferredSize: Size(0, 0),
            child: ProjectHeaderWidget(
              currentIndex: _tabScreenController.projectHeaderTabIndex,
              onIndexChange: (value) {
                // currentIndex = value;
                _tabScreenController.setProjectTabIndex(value);
                _pageController
                    .jumpToPage(_tabScreenController.projectHeaderTabIndex);
                setState(() {});
              },
            ),
          ),
        ),
        body: Obx(
          () => Column(
            children: [
              // ProjectHeaderWidget(
              //   currentIndex: currentIndex,
              //   onIndexChange: (value) {
              //     currentIndex = value;
              //     _pageController.jumpToPage(currentIndex);
              //     setState(() {});
              //   },
              // ),
              // Container(
              //   height: 2,
              //   width: Get.width,
              //   color: Color(0xfE0E0E0),
              // ),
              // SizedBox(
              //   height: 8,
              // ),
              Expanded(
                flex: 1,
                child: Container(
                  height: Get.height,
                  color: Color(0xffF5F5F5),
                  child: PageView(
                    controller: _pageController,
                    children: buildWidgets(),
                    onPageChanged: (index) {
                      _tabScreenController.setProjectTabIndex(index);
                      setState(() {});
                    },
                  ),
                ),
              )
            ],
          ),
        ));
  }

  check(data) {
    if (data.status.toLowerCase() != "accepted") {
      return false;
    }
    if (data.status.toLowerCase() != "rejected") {
      return false;
    }

    return true;
  }

  getWidgets(List<dynamic> value) {
    List<Widget> list = [];
    list.add(DataNotAvailableWidget());
    list.add(DataNotAvailableWidget());
    list.add(DataNotAvailableWidget());
    list.add(DataNotAvailableWidget());
    if (value.isEmpty) {
      list.add(DataNotAvailableWidget());
      list.add(DataNotAvailableWidget());
      list.add(DataNotAvailableWidget());
      list.add(DataNotAvailableWidget());
      return list;
    }
    for (int index = 0; index < value.length; index++) {
      list[index] = (value[index] as Widget);
    }

    return list;
  }

  checkEmpty(HomeScreenController homeScreenController) {
    if (_homeScreenController.availableJos.value.serviceListData == null) {
      return false;
    }
    return _homeScreenController.availableJos.value.serviceListData.isNotEmpty;
  }

  buildWidgets() {
    var pagez = getPages(_homeScreenController.availableJos.value,
        _homeScreenController, _screenController, tabSelected: selectedTab,
        tabUpDate: (value) {
      selectedTab = value;
      setState(() {});
    });
    var pageViews = ViewRendering().getWidgetList(
        _tabScreenController.projectHeaderTabIndex,
        _homeScreenController,
        _screenController,
        tabSelected: selectedTab, tabUpDate: (value) {
      selectedTab = value;
      setState(() {});
    });
    return getWidgets(pageViews ?? []);
  }
}
