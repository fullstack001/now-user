import 'package:application_1/AllPages/ExplorePages/service_timing/service_timing_controller/hour_selected_screens.dart';
import 'package:application_1/AllPages/ExplorePages/service_timing/service_timing_controller/service_timing_controller.dart';

import 'package:application_1/AllPages/introPages/intro_controller.dart';
import 'package:application_1/calendar/customization/calendar_style.dart';
import 'package:application_1/calendar/customization/days_of_week_style.dart';
import 'package:application_1/calendar/customization/header_style.dart';
import 'package:application_1/calendar/table_calendar.dart';
import 'package:application_1/model/calender_events/time_slots.dart';
import 'package:application_1/utils/AppColors.dart';
import 'package:application_1/utils/api_utils.dart';
import 'package:application_1/utils/app_dialog_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';

import '../Controllers/profile_controller.dart';
import '../select_home_address_widget.dart';

class NewServiceTimings extends StatefulWidget {
  final home;
  final orderId;

  NewServiceTimings({Key? key, this.home, this.orderId}) : super(key: key);

  @override
  _NewServiceTimingsState createState() => _NewServiceTimingsState();
}

class _NewServiceTimingsState extends State<NewServiceTimings> {
  ProfileScreenController _profileScreenController = Get.find();
  IntroController _controller = Get.find();
  @override
  Widget build(BuildContext context) {
    // timeList = getDates();
    return GetBuilder<ServiceTimingController>(
        init: ServiceTimingController(),
        builder: (controller) {
          if (controller.counter == 0) {
            controller.setSlots(controller.firstDay, context);
            controller.counter++;
          }
          return Scaffold(
            backgroundColor: Colors.grey.shade100,
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: const Text(
                "Service Timings",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              leading: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                  size: 25,
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: Column(
                children: [
                  Flexible(
                    flex: 9,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: ListView(
                        children: [
                          Container(
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  "Select service date & time",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 26),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Provider preferred time 10:00AM to 04:00 PM",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 20,
                                      color: Colors.black54),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Card(
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 4),
                                child: TableCalendar(
                                  block: false,
                                  rowHeight: 33,
                                  daysOfWeekStyle: DaysOfWeekStyle(
                                      decoration: const BoxDecoration(),
                                      weekdayStyle:
                                          TextStyle(color: AppColors.darkBlue),
                                      weekendStyle:
                                          TextStyle(color: AppColors.darkBlue)),
                                  calendarStyle: CalendarStyle(
                                      canMarkersOverflow: true,
                                      outsideDaysVisible: true,
                                      isTodayHighlighted: true,
                                      markersAutoAligned: true,
                                      // todayDecoration: BoxDecoration(
                                      //     color: AppColors.darkBlue,
                                      //     shape: BoxShape.circle,
                                      //     border: Border.all(
                                      //         color: AppColors.darkBlue, width: 1)),
                                      withinRangeDecoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              color: Colors.black, width: 1)),
                                      weekendDecoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              color: Colors.black, width: 1)),
                                      rangeStartDecoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              color: Colors.black, width: 1)),
                                      rangeEndDecoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              color: Colors.black, width: 1)),
                                      outsideDecoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              color: Colors.black, width: 1)),
                                      holidayDecoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              color: Colors.black, width: 1)),
                                      disabledDecoration: const BoxDecoration(),
                                      disabledTextStyle: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400),
                                      defaultDecoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              color: Colors.black, width: 1)),
                                      cellMargin: const EdgeInsets.all(5),
                                      markerDecoration: BoxDecoration(
                                          color: Colors.black,
                                          border: Border.all(
                                              color: Colors.black, width: 1))),
                                  firstDay: DateTime.now(),
                                  lastDay: DateTime.utc(2030, 3, 14),
                                  // availableCalendarFormats: {
                                  //   CalendarFormat.month: "June",
                                  // },
                                  focusedDay: controller.firstDay,
                                  currentDay: controller.firstDay,
                                  headerStyle: HeaderStyle(
                                    decoration: const BoxDecoration(),
                                    formatButtonVisible: false,
                                    titleCentered: true,
                                    rightChevronIcon: Container(
                                      padding: const EdgeInsets.only(left: 4),
                                      alignment: Alignment.center,
                                      width: 32,
                                      height: 32,
                                      decoration: BoxDecoration(
                                          color: Colors.grey.shade200,
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: Icon(
                                        Icons.arrow_forward_ios,
                                        color: AppColors.darkBlue,
                                        size: 12,
                                      ),
                                    ),
                                    leftChevronIcon: Container(
                                      padding: const EdgeInsets.only(left: 4),
                                      alignment: Alignment.center,
                                      width: 32,
                                      height: 32,
                                      decoration: BoxDecoration(
                                          color: Colors.grey.shade200,
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: Icon(
                                        Icons.arrow_back_ios,
                                        color: AppColors.darkBlue,
                                        size: 12,
                                      ),
                                    ),
                                    formatButtonDecoration:
                                        const BoxDecoration(),
                                    formatButtonPadding:
                                        const EdgeInsets.all(06),
                                    formatButtonShowsNext: false,
                                  ),
                                  onDaySelected: (v, vh) {
                                    setState(() {
                                      int days =
                                          (DateTime.now().difference(v)).inDays;
                                      controller.firstDay = v;

                                      // if (days <= 0) {
                                      //   controller.timeList =
                                      //       controller.getDates(
                                      //           year: controller.firstDay.year,
                                      //           month:
                                      //               controller.firstDay.month,
                                      //           date: controller.firstDay.day,
                                      //           fullDate: controller.firstDay);
                                      //   controller.selectedButtonIndex.clear();
                                      // }

                                      controller.setSlots(v, context);
                                      setState(() {});
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                          Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 4, vertical: 8),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Flexible(
                                        flex: 3,
                                        child: Container(
                                          alignment: Alignment.centerLeft,
                                          child: const Padding(
                                            padding: EdgeInsets.only(left: 10),
                                            child: Text(
                                              "Select time slot",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 20),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        flex: 2,
                                        child: Card(
                                          elevation: 2,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12)),
                                          color: Colors.grey.shade200,
                                          child: FittedBox(
                                            child: DropdownButton<String>(
                                              dropdownColor: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              elevation: 2,
                                              hint: const Text("Select item"),
                                              underline: Container(),
                                              value: controller.selected,
                                              icon: Container(
                                                padding: const EdgeInsets.only(
                                                    right: 12),
                                                child: const Icon(
                                                  Icons
                                                      .keyboard_arrow_down_rounded,
                                                  size: 32,
                                                ),
                                              ),
                                              onChanged: (String? value) {
                                                // switch (value!.toLowerCase()) {
                                                //   case 'morning':
                                                //     controller.selectedSlot =
                                                //         controller.slots[value.toLowerCase()];
                                                //     break;
                                                //   case 'evening':
                                                //     controller.selectedSlot =
                                                //         controller.evening;
                                                //     break;
                                                //   case 'afternoon':
                                                //     controller.selectedSlot =
                                                //         controller.afternoon;
                                                //     break;
                                                //   default:
                                                // }
                                                // setState(() {
                                                controller.updateSlot(value!);
                                                _profileScreenController.time =
                                                    value;

                                                // });
                                              },
                                              items: [
                                                "Morning",
                                                "Afternoon",
                                                "Evening",
                                                "Night"
                                              ].map((String user) {
                                                return DropdownMenuItem<String>(
                                                  value: user,
                                                  child: Row(
                                                    children: <Widget>[
                                                      const SizedBox(
                                                        width: 20,
                                                      ),
                                                      Text(
                                                        user,
                                                        style: const TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 16),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              }).toList(),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 24,
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  GetBuilder<ServiceTimingController>(
                                      init: ServiceTimingController(),
                                      builder: (controller) {
                                        return Wrap(
                                          children: List.generate(
                                              controller.selectedSlot.length,
                                              (index) => checkBlockIndex(
                                                      controller, index)
                                                  ? GestureDetector(
                                                      onTap: () {
                                                        print(controller
                                                            .selected);

                                                        // if (existIndex(
                                                        //     index,
                                                        //     controller,
                                                        //     controller
                                                        //             .selectedIndexSlots[
                                                        //         controller.selected
                                                        //             .toLowerCase()])) {
                                                        //   controller
                                                        //       .updateselectedIndexSlots(
                                                        //           controller.selected
                                                        //               .toLowerCase(),
                                                        //           index,
                                                        //           false);
                                                        // } else {
                                                        //   controller
                                                        //       .updateselectedIndexSlots(
                                                        //           controller.selected
                                                        //               .toLowerCase(),
                                                        //           index,
                                                        //           true);
                                                        // }
                                                      },
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 4,
                                                                vertical: 3),
                                                        child: Container(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal: 8,
                                                                  vertical: 6),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: const Color(
                                                                0xffE0E0E0),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                          ),
                                                          child: Text(
                                                            "${controller.selectedSlot[index]}",
                                                            style: const TextStyle(
                                                                fontSize: 14,
                                                                color: Color(
                                                                    0xffBDBDBD)),
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  : GestureDetector(
                                                      onTap: () {
                                                        print(controller
                                                            .selected);

                                                        if (existIndex(
                                                            index,
                                                            controller,
                                                            controller
                                                                    .selectedIndexSlots[
                                                                controller
                                                                    .selected
                                                                    .toLowerCase()])) {
                                                          controller
                                                              .updateselectedIndexSlots(
                                                                  controller
                                                                      .selected
                                                                      .toLowerCase(),
                                                                  index,
                                                                  false);
                                                        } else {
                                                          controller
                                                              .updateselectedIndexSlots(
                                                                  controller
                                                                      .selected
                                                                      .toLowerCase(),
                                                                  index,
                                                                  true);
                                                        }
                                                      },
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 4,
                                                                vertical: 3),
                                                        child: Container(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal: 8,
                                                                  vertical: 6),
                                                          decoration: BoxDecoration(
                                                              color: existIndex(
                                                                      index,
                                                                      controller,
                                                                      controller.selectedIndexSlots[controller
                                                                          .selected
                                                                          .toLowerCase()])
                                                                  ? AppColors
                                                                      .solidBlue
                                                                  : white,
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                      8),
                                                              border: Border.all(
                                                                  width: 1,
                                                                  color: existIndex(
                                                                          index,
                                                                          controller,
                                                                          controller
                                                                              .selectedIndexSlots[controller.selected.toLowerCase()])
                                                                      ? AppColors.solidBlue
                                                                      : const Color(0xffE0E0E0))),
                                                          child: Text(
                                                            "${controller.selectedSlot[index]}",
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                color: existIndex(
                                                                        index,
                                                                        controller,
                                                                        controller.selectedIndexSlots[controller
                                                                            .selected
                                                                            .toLowerCase()])
                                                                    ? white
                                                                    : black),
                                                          ),
                                                        ),
                                                      ),
                                                    )),
                                        );
                                      })
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                      flex: 1,
                      child: Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: MaterialButton(
                            onPressed: () {
                              List<String> _slots = [
                                "morning",
                                "afternoon",
                                "evening",
                                "night"
                              ];

                              _controller.address("");
                              _controller.selectedAddress.value = "";
                              _profileScreenController.selectedTimeSlot.clear();
                              _profileScreenController.selectedDate.value =
                                  DateFormat("yyyy-MM-dd")
                                      .format(controller.firstDay)
                                      .toString();
                              print(controller.slots);
                              print(controller.selectedIndexSlots);
                              // for (var i = 0; i < _slots.length; i++) {
                              //   print(_slots[i]);
                              //   for (var h = 0;
                              //       h < controller.slots[_slots[i]].length;
                              //       h++) {
                              //     print(controller
                              //         .selectedIndexSlots[_slots[h]].length);
                              //     for (var j = 0;
                              //         j <
                              //             controller
                              //                 .selectedIndexSlots[_slots[h]]
                              //                 .length;
                              //         j++) {
                              //       print(controller.slots[_slots[i]][controller
                              //           .selectedIndexSlots[_slots[h]][j]]);
                              //       print("ok $j");
                              //     }
                              //   }
                              // }
                              List<String> _allSelectedSlots = [];
                              for (var i = 0; i < _slots.length; i++) {
                                for (var j = 0;
                                    j <
                                        controller.selectedIndexSlots[_slots[i]]
                                            .length;
                                    j++) {
                                  _allSelectedSlots.add(
                                      controller.slots[_slots[i]][controller
                                          .selectedIndexSlots[_slots[i]][j]]);
                                }
                              }

                              if (_allSelectedSlots.length != 0) {
                                _profileScreenController.time =
                                    _allSelectedSlots.length;
                              }

                              for (var i = 0;
                                  i < _allSelectedSlots.length;
                                  i++) {
                                String startTime = convetTo24Format(
                                    _allSelectedSlots[i]
                                        .splitBefore("-")
                                        .trim());

                                String endTime = convetTo24Format(
                                    _allSelectedSlots[i]
                                        .splitAfter("-")
                                        .trim());

                                _profileScreenController.selectedTimeSlot.add({
                                  "start": "$startTime:00",
                                  "end": "$endTime:00"
                                });
                              }
                              if (_allSelectedSlots.length > 0) {
                                Get.to(HourSeletionScreen(
                                  home: widget.home,
                                  orderId: widget.orderId,
                                ));
                              } else {
                                AppDialogUtils.errorDialog(
                                    "Choose slot please");
                              }
                            },
                            color: AppColors.darkBlue,
                            textColor: Colors.white,
                            minWidth: MediaQuery.of(context).size.width * 0.8,
                            height: 47,
                            shape: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(18)),
                            child: const Text(
                              "Next",
                              style: TextStyle(fontSize: 18),
                            ),
                          )))
                ],
              ),
            ),
          );
        });
  }

  // List<String> getTimes() {
  //   List<String> times = [];
  //   timeList.sort((a, b) => a.start.compareTo(b.start));
  //   for (int index = 0; index < timeList.length; index++) {
  //     times.add(timeList[index].start);
  //   }
  //   return times;
  // }

  static bool exist(String time, List<TimeSlots> timeSlots) {
    for (int index = 0; index < timeSlots.length; index++) {
      if (timeSlots[index].start == time) {
        return true;
      }
    }
    return false;
  }

  bool existIndex(int index, ServiceTimingController control, dynamic value) {
    if (value != null) {
      for (var i = 0; i < value.length; i++) {
        if (value[i] == index) {
          return true;
        }
      }
    }
    return false;
  }

  bool checkBlockIndex(ServiceTimingController controller, int index) {
    print(controller.blockIndexSlots);

    if (controller.blockIndexSlots.isNotEmpty) {
      for (var h = 0; h < controller.blockIndexSlots.length; h++) {
        if (controller.selectedSlot[index] == controller.blockIndexSlots[h]) {
          return true;
        }
      }
    }
    return false;
  }

  // bool existTime(var start, controller) {
  //   if (_profileScreenController.selectedDates.isEmpty) {
  //     return false;
  //   }

  //   for (int index = 0;
  //       index < _profileScreenController.selectedDates.length;
  //       index++) {
  //     if (_profileScreenController.selectedDates.value[index].start ==
  //         start.start) {
  //       if (_profileScreenController.selectedDates.value[index].createdAt ==
  //           start.createdAt) {
  //         if (_profileScreenController.selectedDates.value[index].date ==
  //                 controller.firstDay.day.toString() &&
  //             _profileScreenController.selectedDates.value[index].month ==
  //                 controller.firstDay.month.toString() &&
  //             _profileScreenController.selectedDates.value[index].year ==
  //                 controller.firstDay.year.toString()) {
  //           return true;
  //         }
  //         return false;
  //       }
  //       return false;
  //     }
  //   }

  //   return false;
  // }

  String convetTo24Format(String value) {
    if (value.toUpperCase().contains("AM".toUpperCase())) {
      if (value.numericOnly().toInt() < 12) {
        if (value.numericOnly().toInt() < 10) {
          return "0${value.numericOnly()}";
        } else {
          return value.numericOnly();
        }
      } else {
        return "00";
      }
    }
    if (value.toUpperCase().contains("PM".toUpperCase())) {
      if (value.numericOnly().toInt() < 12) {
        return (value.numericOnly().toInt() + 12).toString();
      } else {
        return "12";
      }
    }
    return "";
  }
}
