import 'package:application_1/AllPages/moving/controllers/dashboard_controller.dart';
import 'package:application_1/AllPages/moving/screes/enter_address_screen.dart';
import 'package:application_1/AllPages/moving/screes/select_vehicle_screen.dart';
import 'package:application_1/utils/AppColors.dart';
import 'package:application_1/utils/app_dialog_utils.dart';
import 'package:application_1/widgets/custom_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MovingDashboardScreen extends StatelessWidget {
  DashboardController _dashboardController = Get.put(DashboardController());

  PageController _pageController = PageController();
  int currentIndex = 0;

  obBackAction(index) {
    currentIndex = index;
    _dashboardController.setCurrentScreen(currentIndex);
    _pageController.jumpToPage(currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    if (_pageController == null) {
      _pageController = PageController();
    }
    return Scaffold(
      body: SafeArea(
        child: Obx(() => Column(
              children: [
                Expanded(
                  child: Container(
                    width: Get.width,
                    height: 100,
                    child: PageView(
                      controller: _pageController,
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        SelectVehicleScreen(),
                        EnterAddressScreen(
                          obBackClick: obBackAction,
                        ),
                      ],
                      onPageChanged: (index) {
                        currentIndex = index;
                        _dashboardController.setCurrentScreen(currentIndex);
                      },
                    ),
                  ),
                ),
                Container(
                  width: Get.width,
                  height: 45,
                  color: AppColors.appBlue,
                  child: Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      Container(
                        width: Get.width,
                        height: 45,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            for (int index = 0;
                                index <
                                    _dashboardController.screenSelected.length;
                                index++)
                              CustomContainer(
                                width: 12,
                                height: 12,
                                marginLeft: index == 0 ? 0 : 6,
                                allRadius: 12,
                                color:
                                    _dashboardController.screenSelected[index]
                                        ? Colors.white
                                        : Colors.white.withOpacity(0.3),
                              )
                          ],
                        ),
                      ),
                      if (!_dashboardController.hideArrow.value)
                        CustomContainer(
                          width: 50,
                          height: 80,
                          color: Colors.transparent,
                          onTap: () {
                            if (!_dashboardController.vehicleSelected()) {
                              alertDialog(
                                  title: "Alert",
                                  content: "Please select any vehicle",
                                  confirm: MaterialButton(
                                    child: Text(
                                      "Okay",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    onPressed: () {
                                      Get.back();
                                    },
                                  ));
                            } else {
                              currentIndex = 1;
                              _dashboardController
                                  .setCurrentScreen(currentIndex);
                              _pageController.jumpToPage(currentIndex);
                            }
                          },
                          child: Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                          ),
                        )
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }
}
