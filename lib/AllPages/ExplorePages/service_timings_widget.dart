import 'package:application_1/AllPages/ExplorePages/select_home_address_widget.dart';
import 'package:application_1/AllPages/introPages/intro_controller.dart';
import 'package:application_1/calendar/customization/calendar_style.dart';
import 'package:application_1/calendar/customization/header_style.dart';
import 'package:application_1/calendar/table_calendar.dart';
import 'package:application_1/model/calender_events/time_slots.dart';
import 'package:application_1/widgets/service_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Controllers/profile_controller.dart';

class ServiceTimings extends StatefulWidget {
  final home;
  final orderId;

  ServiceTimings({Key? key, this.home, this.orderId}) : super(key: key);

  @override
  _ServiceTimingsState createState() => _ServiceTimingsState();
}

class _ServiceTimingsState extends State<ServiceTimings> {
  DateTime _firstDay = DateTime.now();
  List<int> _selectedButtonIndex = [];
  bool isTaped = false;
  List<TimeSlots> timeSlots = [];
  List<TimeSlots> timeList = [];
  String selected = "1 Hour";
  ProfileScreenController _profileScreenController = Get.find();
  IntroController _controller = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    timeList = getDates(
        year: DateTime.now().year,
        month: DateTime.now().month,
        date: DateTime.now().day);
  }

  List<TimeSlots> getDates({month, year, date}) {
    ProfileScreenController cont = Get.find();
    DateTime now = new DateTime.now();

    timeSlots =
        cont.checkSlot(date: date, year: year, month: month).cast<TimeSlots>();

    if (timeSlots.isNotEmpty) {
      for (int index = 0; index < timeSlots.length; index++) {
        timeSlots[index].date = date.toString();
        timeSlots[index].year = year.toString();
        timeSlots[index].month = month.toString();
      }
    }
    timeList.sort((a, b) => a.start.compareTo(b.start));
    return timeSlots.toList();
  }

  @override
  Widget build(BuildContext context) {
    // timeList = getDates();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Service Timings",
          style: TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 25,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                "Select  Available Date",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            TableCalendar(
              rowHeight: 36,
              calendarStyle: CalendarStyle(
                  canMarkersOverflow: true,
                  outsideDaysVisible: true,
                  isTodayHighlighted: true,
                  markersAutoAligned: true,
                  todayDecoration: BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.blue, width: 1)),
                  withinRangeDecoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black, width: 1)),
                  weekendDecoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black, width: 1)),
                  rangeStartDecoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black, width: 1)),
                  rangeEndDecoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black, width: 1)),
                  outsideDecoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black, width: 1)),
                  holidayDecoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black, width: 1)),
                  disabledDecoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black, width: 1)),
                  defaultDecoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black, width: 1)),
                  cellMargin: EdgeInsets.all(5),
                  markerDecoration: BoxDecoration(
                      color: Colors.red,
                      border: Border.all(color: Colors.black, width: 1))),
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              // availableCalendarFormats: {
              //   CalendarFormat.month: "June",
              // },
              focusedDay: _firstDay,
              currentDay: _firstDay,
              headerStyle: HeaderStyle(
                decoration: BoxDecoration(),
                formatButtonVisible: false,
                titleCentered: true,
                formatButtonDecoration: BoxDecoration(),
                formatButtonPadding: EdgeInsets.all(6),
                formatButtonShowsNext: false,
              ),
              onDaySelected: (v, vh) {
                setState(() {
                  int days = (DateTime.now().difference(v)).inDays;
                  _firstDay = v;
                  if (days <= 0) {
                    timeList = getDates(
                        year: _firstDay.year,
                        month: _firstDay.month,
                        date: _firstDay.day);
                    _selectedButtonIndex.clear();
                  }
                  setState(() {});
                });
              },
            ),
            Expanded(
                child: Container(
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Work duration",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                        ),
                      ),
                      DropdownButton<String>(
                        hint: Text("Select item"),
                        underline: Container(),
                        value: selected,
                        onChanged: (String? value) {
                          setState(() {
                            selected = value!;
                            _profileScreenController.time = value;
                            print(_profileScreenController.time);
                          });
                        },
                        items: [
                          "1 Hour",
                          "2 Hour",
                          "3 Hour",
                          "4 Hour",
                          "5 Hour",
                          "6 Hour",
                          "7 Hour",
                          "8 Hour",
                          "9 Hour",
                          "10 Hour",
                        ].map((String user) {
                          return DropdownMenuItem<String>(
                            value: user,
                            child: Row(
                              children: <Widget>[
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  user,
                                  style: TextStyle(color: Colors.black),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                      SizedBox(
                        width: 24,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                      flex: 0,
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Select Available Time",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: gridViews(
                      columnSpan: 4,
                      itemCount: timeList.length,
                      builder: (int index, int span) {
                        timeList.sort((a, b) => a.start.compareTo(b.start));
                        return GestureDetector(
                          onTap: () {
                            print("${timeList[index].start}");
                            isTaped = true;
                            _profileScreenController.selectedDates.value
                                .clear();
                            if (!existTime(timeList[index])) {
                              _profileScreenController.selectedDates.value
                                  .add(timeList[index]);
                              print(":");
                            }

                            setState(() {});
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: (Get.width - 35) / span,
                            padding: EdgeInsets.all(0),
                            child: Card(
                              elevation: 4,
                              child: Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(6),
                                width: Get.width / span,
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(6)),
                                  color: existTime(timeList[index])
                                      ? Colors.blue
                                      : Colors.white,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      timeList[index].start,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: existTime(timeList[index])
                                            ? Colors.white70
                                            : Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    /*ListView(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        child: GroupButton(
                          selectedButtons: _selectedButtonIndex,
                          borderRadius: BorderRadius.circular(5),
                          selectedColor: Colors.blue,
                          isRadio: false,
                          spacing: 8,
                          crossGroupAlignment: CrossGroupAlignment.center,
                          onSelected: (index, isSelected) {
                            setState(() {
                              _selectedButtonIndex.add(index);
                            });
                          },
                          buttons: getTimes(),
                        ),
                      ),
                    ],
                  )*/
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                      flex: 0,
                      child: Container(
                          height: 40,
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: MaterialButton(
                            onPressed: () {
                              _controller.address("");
                              _controller.selectedAddress.value = "";
                              Get.to(SelectHomeAddressWidget(
                                  home: widget.home, orderId: widget.orderId));
                            },
                            color: Colors.green,
                            textColor: Colors.white,
                            minWidth: MediaQuery.of(context).size.width * 0.8,
                            height: 47,
                            shape: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(8)),
                            child: Text(
                              "Next",
                              style: TextStyle(fontSize: 16),
                            ),
                          )))
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }

  List<String> getTimes() {
    List<String> times = [];
    timeList.sort((a, b) => a.start.compareTo(b.start));
    for (int index = 0; index < timeList.length; index++) {
      times.add(timeList[index].start);
    }
    return times;
  }

  static bool exist(String time, List<TimeSlots> timeSlots) {
    for (int index = 0; index < timeSlots.length; index++) {
      if (timeSlots[index].start == time) {
        return true;
      }
    }
    return false;
  }

  bool existTime(var start) {
    if (_profileScreenController.selectedDates.isEmpty) {
      return false;
    }

    for (int index = 0;
        index < _profileScreenController.selectedDates.length;
        index++) {
      if (_profileScreenController.selectedDates.value[index].start ==
          start.start) {
        if (_profileScreenController.selectedDates.value[index].createdAt ==
            start.createdAt) {
          if (_profileScreenController.selectedDates.value[index].date ==
                  _firstDay.day.toString() &&
              _profileScreenController.selectedDates.value[index].month ==
                  _firstDay.month.toString() &&
              _profileScreenController.selectedDates.value[index].year ==
                  _firstDay.year.toString()) {
            return true;
          }
          return false;
        }
        return false;
      }
    }

    return false;
  }
}
