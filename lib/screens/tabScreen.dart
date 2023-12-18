import 'package:application_1/screens/Controllers/tabScreenController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../AllPages/ProjectPages/controller/home_screen_controller.dart';
import '../utils/AppColors.dart';

class TabsScreen extends StatelessWidget {
  // Color tabColor = Color(0xffBDBDBD);
  Color tabColor = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TabScreenController>(
        init: TabScreenController(),
        builder: (provider) {
          return WillPopScope(
            onWillPop: () async {
              return true;
            },
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              body: provider.tabList[provider.currentIndex],
              bottomNavigationBar: LayoutBuilder(
                builder: (context, state) {
                  return ConstrainedBox(
                    constraints: const BoxConstraints(minHeight: 20),
                    child: SizedBox(
                        width: state.maxWidth,
                        child: BottomNavigationBar(
                          type: BottomNavigationBarType.fixed,
                          currentIndex: provider.currentIndex,
                          backgroundColor: Colors.white,
                          selectedItemColor: AppColors.solidBlue,
                          unselectedItemColor: Colors.grey,
                          selectedFontSize: 12,
                          selectedLabelStyle: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w400),
                          unselectedLabelStyle: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w400),
                          unselectedFontSize: 12,
                          onTap: (index) {
                            if (index == 0) {
                              provider.setTabIndex(0);
                            }
                            // BottomNavigation.currentScreen = NotificationsScreen();
                            else if (index == 1) {
                              provider.setTabIndex(1);
                            } else if (index == 2) {
                              provider.setTabIndex(2);
                            }
                            // BottomNavigation.currentScreen = InboxScreen();
                            else if (index == 3) {
                              provider.setTabIndex(3);
                            }
                          },
                          items: [
                            BottomNavigationBarItem(
                              label: 'Home',
                              icon: SvgPicture.asset(
                                "assets/user_assets/svg/home_tab.svg",
                                color: provider.currentIndex == 0
                                    ? AppColors.solidBlue
                                    : null,
                              ),
                            ),
                            BottomNavigationBarItem(
                              label: 'Projects',
                              icon: SvgPicture.asset(
                                "assets/user_assets/svg/projects.svg",
                                color: provider.currentIndex == 1
                                    ? AppColors.solidBlue
                                    : null,
                              ),
                            ),
                            BottomNavigationBarItem(
                              label: 'Messages',
                              icon: SvgPicture.asset(
                                "assets/user_assets/svg/message.svg",
                                color: provider.currentIndex == 2
                                    ? AppColors.solidBlue
                                    : null,
                              ),
                            ),
                            BottomNavigationBarItem(
                              label: 'Profile',
                              icon: SvgPicture.asset(
                                "assets/user_assets/svg/user.svg",
                                color: provider.currentIndex == 3
                                    ? AppColors.solidBlue
                                    : null,
                              ),
                            ),
                          ],
                        )
                        /* Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                provider.setTabIndex(0);
                              },
                              child: Container(
                                child: Image(
                                  color: provider.currentIndex == 0
                                      ? Colors.blue
                                      : tabColor,
                                  width: 24,
                                  height: 24,
                                  image:
                                      AssetImage("assets/image 1.5x/home.png"),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                provider.setTabIndex(1);
                              },
                              child: Container(
                                child: Image(
                                  color: provider.currentIndex == 1
                                      ? Colors.blue
                                      : tabColor,
                                  image: AssetImage(
                                      "assets/image 1.5x/cashbook.png"),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                provider.setTabIndex(2);
                              },
                              child: Container(
                                child: Image(
                                  color: provider.currentIndex == 2
                                      ? Colors.blue
                                      : tabColor,
                                  image: AssetImage(
                                    "assets/image 1.5x/stock.png",
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                provider.setTabIndex(3);
                              },
                              child: Container(
                                child: Image(
                                  image: AssetImage(
                                      "assets/image 1.5x/calculator.png"),
                                  color: provider.currentIndex == 3
                                      ? Colors.blue
                                      : tabColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),*/
                        ),
                  );
                },
              ),
            ),
          );
        });
  }
}
