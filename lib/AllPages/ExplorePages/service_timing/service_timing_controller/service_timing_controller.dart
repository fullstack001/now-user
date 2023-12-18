import 'package:application_1/AllPages/ExplorePages/provider_profile_screen/provider_profile/export_file.dart';
import 'package:intl/intl.dart';

import '../../../../model/calender_events/time_slots.dart';
import '../../Controllers/profile_controller.dart';
import 'package:nb_utils/nb_utils.dart';

class ServiceTimingController extends GetxController {
  int counter = 0;
  DateTime firstDay = DateTime.now();
  List<int> selectedButtonIndex = [];
  bool isTaped = false;

  List<TimeSlots> timeSlots = [];
  // List<Schedule> timeList = [];
  var timeList = [];
  String selected = "Morning";
  updateSlot(String value) {
    selectedSlot = slots[value.toLowerCase()] ?? <String>[];
    selected = value;
    update();
  }

  List<String> selectedSlot = [];

  Map<String, dynamic> selectedIndexSlots = {
    "morning": [],
    "afternoon": [],
    "evening": [],
    "night": []
  };
  List<String> blockIndexSlots = [];
  @override
  void onInit() {
    // selectedSlot = slots["morning"];

    // timeList = getDates(
    //     year: DateTime.now().year,
    //     month: DateTime.now().month,
    //     date: DateTime.now().day,
    //     fullDate: DateTime.now());
    super.onInit();
  }

  List<int> morning = [];
  List<int> afternoon = [];
  List<int> evening = [];
  List<int> night = [];
  updateselectedIndexSlots(String key, int index, bool value) {
    if (value) {
      if (key.toLowerCase() == "morning") {
        morning.add(index);
        selectedIndexSlots[key.toLowerCase()] = morning;
      }
      if (key.toLowerCase() == "afternoon") {
        afternoon.add(index);
        selectedIndexSlots[key.toLowerCase()] = afternoon;
      }
      if (key.toLowerCase() == "evening") {
        evening.add(index);
        selectedIndexSlots[key.toLowerCase()] = evening;
      }
      if (key.toLowerCase() == "night") {
        night.add(index);
        selectedIndexSlots[key.toLowerCase()] = night;
      }
      print(selectedIndexSlots);
    } else {
      if (key.toLowerCase() == "morning") {
        morning.remove(index);
        selectedIndexSlots[key.toLowerCase()] = morning;
      }
      if (key.toLowerCase() == "afternoon") {
        afternoon.remove(index);
        selectedIndexSlots[key.toLowerCase()] = afternoon;
      }
      if (key.toLowerCase() == "evening") {
        evening.remove(index);
        selectedIndexSlots[key.toLowerCase()] = evening;
      }
      if (key.toLowerCase() == "night") {
        night.remove(index);
        selectedIndexSlots[key.toLowerCase()] = night;
      }
      print(selectedIndexSlots);
    }
    update();
  }

  Map<String, dynamic> slots = {
    "morning": <String>[],
    "afternoon": <String>[],
    "evening": <String>[],
    "night": <String>[]
  };

  setSlots(DateTime day, BuildContext context) {
    selectedIndexSlots["morning"] = [];
    selectedIndexSlots["afternoon"] = [];
    selectedIndexSlots["evening"] = [];
    selectedIndexSlots["night"] = [];
    slots["morning"] = <String>[];
    slots["afternoon"] = <String>[];
    slots["evening"] = <String>[];
    slots["night"] = <String>[];
    morning.clear();
    afternoon.clear();
    evening.clear();
    night.clear();
    blockIndexSlots.clear();
    List<String> _morning = [];
    List<String> _afternoon = [];
    List<String> _evening = [];
    List<String> _night = [];
    selected = "Morning";
    ProfileScreenController cont = Get.find();
    List<Schedule> providerTimeslotsData =
        cont.providerProfileDetails.value.data.provider.schedules ?? [];
    List<BlockedSlot> providerBlockSlots =
        cont.providerProfileDetails.value.data.provider.blockedSlots ?? [];

    for (var i = 00; i < providerTimeslotsData.length; i++) {
      if (providerTimeslotsData[i].day == DateFormat.EEEE().format(day)) {
        if (!checkInBlockSlot(providerBlockSlots, day)) {
          for (var h = int.parse(providerTimeslotsData[i]
                  .fromTime
                  .toString()
                  .splitBefore(":"));
              h <
                  int.parse(providerTimeslotsData[i]
                      .toTime
                      .toString()
                      .splitBefore(":"));
              h++) {
            String _time =
                "${TimeOfDay(hour: h < 24 ? h : 0, minute: 0).hourOfPeriod}${TimeOfDay(hour: h < 24 ? h : 0, minute: 0).period.name.toUpperCase()} - ${TimeOfDay(hour: h < 24 ? h + 1 : 0, minute: 0).hourOfPeriod}${TimeOfDay(hour: h < 24 ? h + 1 : 0, minute: 0).period.name.toUpperCase()}";

            if (checkGreeting(h) == 1) {
              _morning.add(_time);
              slots["morning"] = _morning;
            }
            if (checkGreeting(h) == 2) {
              _afternoon.add(_time);
              slots["afternoon"] = _afternoon;
            }
            if (checkGreeting(h) == 3) {
              _evening.add(_time);
              slots["evening"] = _evening;
            }
            if (checkGreeting(h) == 4) {
              _night.add(_time);
              slots["night"] = _night;
            }
            updateSlot(selected);
          }
        }
      }
    }

    print(slots);
    update();
  }

  bool checkInBlockSlot(List<BlockedSlot> providerBlockSlots, DateTime day) {
    if (providerBlockSlots.isNotEmpty) {
      print(providerBlockSlots);
      for (var i = 0; i < providerBlockSlots.length; i++) {
        if (providerBlockSlots[i].date.day == day.day &&
            providerBlockSlots[i].date.year == day.year &&
            providerBlockSlots[i].date.month == day.month) {
          for (var h = int.parse(
                  providerBlockSlots[i].fromTime.toString().splitBefore(":"));
              h <=
                  int.parse(
                      providerBlockSlots[i].toTime.toString().splitBefore(":"));
              h++) {
            print(h);
            blockIndexSlots.add(
                "${TimeOfDay(hour: h < 24 ? h : 0, minute: 0).hourOfPeriod}${TimeOfDay(hour: h < 24 ? h : 0, minute: 0).period.name.toUpperCase()} - ${TimeOfDay(hour: h < 24 ? h + 1 : 0, minute: 0).hourOfPeriod}${TimeOfDay(hour: h < 24 ? h + 1 : 0, minute: 0).period.name.toUpperCase()}");
          }
          return false;
        }
      }
    }
    return false;
  }

// List<TimeSlots>
  getDates({month, year, date, fullDate}) {
    print(DateFormat('EEEE').format(DateTime.now()));
    ProfileScreenController cont = Get.find();
    // DateTime now = new DateTime.now();
    List<ServiceAndBlockSlots> serviceAndBlockSlo = [];
    var timeSlots = cont.checkSlot(
        date: date, year: year, month: month, fullDate: fullDate);
    // .cast<TimeSlots>();

    // if (timeSlots.isNotEmpty) {
    //   for (int index = 0; index < timeSlots.length; index++) {
    //     timeSlots[index].date = date.toString();
    //     timeSlots[index].year = year.toString();
    //     timeSlots[index].month = month.toString();
    //   }
    // }
    // timeList.sort((a, b) => a.start.compareTo(b.start));
    // return timeSlots;
  }

  int checkGreeting(int h) {
    switch (h) {
      case 0:
        return 4;
      case 1:
        return 4;
      case 2:
        return 4;
      case 3:
        return 4;
      case 4:
        return 4;
      case 5:
        return 4;
      case 6:
        return 1;
      case 7:
        return 1;
      case 8:
        return 1;
      case 9:
        return 1;
      case 10:
        return 1;
      case 11:
        return 1;
      case 12:
        return 2;
      case 13:
        return 2;
      case 14:
        return 2;
      case 15:
        return 2;
      case 16:
        return 2;
      case 17:
        return 2;
      case 18:
        return 3;
      case 19:
        return 3;
      case 20:
        return 3;
      case 21:
        return 3;
      case 22:
        return 3;
      case 23:
        return 3;
      case 0:
        return 3;
      default:
        return 5;
    }
  }
}

class ServiceAndBlockSlots {
  String? fromTime;
  String? toTime;
  String? date;
  bool? block;
  int providerId;
  String? day;

  ServiceAndBlockSlots(
      {this.fromTime,
      this.toTime,
      this.block,
      this.date,
      this.day,
      required this.providerId});
}
