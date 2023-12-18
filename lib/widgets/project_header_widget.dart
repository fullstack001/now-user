import 'package:application_1/AllPages/ExplorePages/shopMenu.dart';
import 'package:application_1/AllPages/ProjectPages/controller/home_screen_controller.dart';
import 'package:application_1/utils/AppColors.dart';
import 'package:application_1/utils/project_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProjectHeaderWidget extends StatefulWidget {
  final currentIndex;
  final onIndexChange;

  ProjectHeaderWidget({
    Key? key,
    this.currentIndex,
    this.onIndexChange,
  }) : super(key: key);

  @override
  State<ProjectHeaderWidget> createState() => _ProjectHeaderWidgetState();
}

class _ProjectHeaderWidgetState extends State<ProjectHeaderWidget> {
  @override
  void dispose() {
    // TODO: implement dispose
    resetTabsFlags();
    flagTabs[0] = true;
    super.dispose();
  }

  @override
  initState() {
    super.initState();
  }

  HomeScreenController _homeScreenControlle = Get.find();
  @override
  Widget build(BuildContext context) {
    resetFlags();
    flags[widget.currentIndex] = true;
    return Container(
      width: Get.width,
      height: 46,
      color: white,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          InkWell(
            onTap: () {
              resetFlags();
              _homeScreenControlle.getAvailableJobs(flag: true);
              flags[0] = !flags[0];
              widget.onIndexChange(0);
            },
            child: Container(
              padding: EdgeInsets.only(left: 10),
              width: 100,
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      height: 40,
                      child: Text(
                        "Requested",
                        style: TextStyle(
                            color: flags[0]
                                ? AppColors.solidBlue
                                : Color(0xff757575),
                            fontSize: 16),
                      ),
                    ),
                  ),
                  Container(
                    height: 2,
                    color: flags[0] ? AppColors.solidBlue : Colors.transparent,
                  )
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              resetFlags();
              flags[1] = true;
              _homeScreenControlle.getAvailableJobs(flag: true);

              widget.onIndexChange(1);
            },
            child: Container(
              padding: EdgeInsets.only(left: 10),
              width: 100,
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      height: 40,
                      child: Text(
                        "Accepted",
                        style: TextStyle(
                            color: flags[1]
                                ? AppColors.solidBlue
                                : Color(0xff757575),
                            fontSize: 16),
                      ),
                    ),
                  ),
                  Container(
                    height: 2,
                    color: flags[1] ? AppColors.solidBlue : Colors.transparent,
                  )
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              resetFlags();
              flags[2] = !flags[2];
              _homeScreenControlle.getAvailableJobs(flag: true);
              widget.onIndexChange(2);
            },
            child: Container(
              padding: EdgeInsets.only(left: 10),
              width: 100,
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      height: 40,
                      child: Text(
                        "Rejected",
                        style: TextStyle(
                            color: flags[2]
                                ? AppColors.solidBlue
                                : Color(0xff757575),
                            fontSize: 16),
                      ),
                    ),
                  ),
                  Container(
                    height: 2,
                    color: flags[2] ? AppColors.solidBlue : Colors.transparent,
                  )
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              resetFlags();
              flags[3] = !flags[3];
              widget.onIndexChange(3);
              _homeScreenControlle.getAvailableJobs(flag: true);
            },
            child: Container(
              padding: EdgeInsets.only(left: 10),
              width: 70,
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      height: 40,
                      child: Text(
                        "Chat",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: flags[3]
                                ? AppColors.solidBlue
                                : Color(0xff757575),
                            fontSize: 16),
                      ),
                    ),
                  ),
                  Container(
                    height: 2,
                    color: flags[3] ? AppColors.solidBlue : Colors.transparent,
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            width: 10,
          )
        ],
      ),
    );
  }

  void resetFlags() {
    for (int index = 0; index < flags.length; index++) {
      flags[index] = false;
    }
  }
}
