import 'package:application_1/components/buttons-management/part_of_file/part.dart';
import 'package:application_1/utils/AppColors.dart';
import 'package:application_1/utils/app_dialog_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../Controllers/profile_controller.dart';
import '../../select_home_address_widget.dart';

class HourSeletionScreen extends StatefulWidget {
  var home;
  var orderId;

  HourSeletionScreen({required this.home, required this.orderId});

  @override
  State<HourSeletionScreen> createState() => _HourSeletionScreenState();
}

class _HourSeletionScreenState extends State<HourSeletionScreen> {
  ProfileScreenController _profileScreenController = Get.find();
  int _selectedhour = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffE0E0E0).withOpacity(0.5),
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0,
        iconTheme:
            IconTheme.of(context).copyWith(color: const Color(0xffBDBDBD)),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Get.back();
          },
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                "2 of 4",
                style: TextStyle(
                    color: AppColors.solidBlue,
                    fontSize: 20,
                    fontWeight: FontWeight.w400),
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          SizedBox(
            height: Get.height * 0.1,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18)),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Column(children: [
                  Container(
                    alignment: Alignment.center,
                    child: const Text(
                      "Select service hour(s)",
                      style: TextStyle(
                          color: Color(0xff151415),
                          fontSize: 24,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  20.height,
                  Wrap(
                    alignment: WrapAlignment.center,
                    children: List.generate(
                        12,
                        (index) => GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedhour = index;
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 6),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 8),
                                  decoration: BoxDecoration(
                                      borderRadius: _selectedhour == index
                                          ? BorderRadius.circular(12)
                                          : null,
                                      border: _selectedhour == index
                                          ? Border.all(
                                              color: AppColors.solidBlue)
                                          : null),
                                  width: Get.width * 0.35,
                                  // height: 30,
                                  child: Row(children: [
                                    Container(
                                      width: 25,
                                      height: 25,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: _selectedhour == index
                                                  ? AppColors.solidBlue
                                                  : const Color(0xffBDBDBD),
                                              width: _selectedhour == index
                                                  ? 8
                                                  : 1),
                                          borderRadius:
                                              BorderRadius.circular(90)),
                                    ),
                                    12.width,
                                    Text(
                                      "${index + 1} hours",
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xff555555)),
                                    )
                                  ]),
                                ),
                              ),
                            )),
                  ),
                  FarenowButton(
                      title: "Next",
                      onPressed: () {
                        if (_selectedhour >= 0) {
                          _profileScreenController.time = _selectedhour + 1;
                          Get.to(SelectHomeAddressWidget(
                              home: widget.home, orderId: widget.orderId));
                        } else {
                          AppDialogUtils.errorDialog("Select hour please");
                        }
                      },
                      type: BUTTONTYPE.rectangular)
                ]),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
