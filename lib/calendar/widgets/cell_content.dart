// Copyright 2019 Aleksander Woźniak
// SPDX-License-Identifier: Apache-2.0

import 'package:application_1/AllPages/ExplorePages/Controllers/profile_controller.dart';
import 'package:application_1/model/service_response/time_slots.dart';
import 'package:application_1/remote_model/provider_list/provider_profile_detail_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';

import '../customization/calendar_builders.dart';
import '../customization/calendar_style.dart';

class CellContent extends StatelessWidget {
  final block;
  final day;
  final focusedDay;
  final isTodayHighlighted;
  final isToday;
  final isSelected;
  final isRangeStart;
  final isRangeEnd;
  final isWithinRange;
  final isOutside;
  final isDisabled;
  final isHoliday;
  final isWeekend;
  final calendarStyle;
  final calendarBuilders;
  final isPartiallyBlock;
  final isFullBlock;
  final isBooked;

  const CellContent(
      {Key? key,
      this.day,
      this.focusedDay,
      this.calendarStyle,
      this.calendarBuilders,
      this.isTodayHighlighted,
      this.isToday,
      this.isSelected,
      this.isBooked,
      this.isRangeStart,
      this.isRangeEnd,
      this.isWithinRange,
      this.isOutside,
      this.isDisabled,
      this.isHoliday,
      this.isWeekend,
      this.isPartiallyBlock,
      this.isFullBlock,
      this.block = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget cell =
        calendarBuilders.prioritizedBuilder?.call(context, day, focusedDay);

    if (cell != null) {
      return cell;
    }

    final text = '${day.day}';
    final margin = calendarStyle.cellMargin;
    final duration = const Duration(milliseconds: 250);

    if (isDisabled) {
      cell = calendarBuilders.disabledBuilder?.call(context, day, focusedDay) ??
          AnimatedContainer(
            duration: duration,
            margin: margin,
            decoration: calendarStyle.disabledDecoration,
            alignment: Alignment.center,
            child: Text(text, style: TextStyle(color: Colors.black26)),
          );
    } else if (isFullBlock) {
      cell = calendarBuilders.disabledBuilder?.call(context, day, focusedDay) ??
          AnimatedContainer(
            duration: duration,
            margin: margin,
            decoration:
                BoxDecoration(color: Color(0xffEC766D), shape: BoxShape.circle),
            alignment: Alignment.center,
            child: Text(text,
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                    decoration: TextDecoration.lineThrough)),
          );
    } else if (isBooked) {
      cell = calendarBuilders.disabledBuilder?.call(context, day, focusedDay) ??
          AnimatedContainer(
            duration: duration,
            margin: margin,
            decoration:
                BoxDecoration(color: Color(0xff00B181), shape: BoxShape.circle),
            alignment: Alignment.center,
            child:
                Text(text, style: TextStyle(fontSize: 12, color: Colors.white)),
          );
    } else if (isPartiallyBlock) {
      cell = calendarBuilders.disabledBuilder?.call(context, day, focusedDay) ??
          AnimatedContainer(
            duration: duration,
            margin: margin,
            decoration: BoxDecoration(color: yellow, shape: BoxShape.circle),
            alignment: Alignment.center,
            child: Text(text, style: TextStyle(color: Colors.black54)),
          );
    } else if (isSelected) {
      cell = calendarBuilders.selectedBuilder?.call(context, day, focusedDay) ??
          AnimatedContainer(
            duration: duration,
            margin: margin,
            decoration: calendarStyle.selectedDecoration,
            // decoration: BoxDecoration(color: Colors.yellow),
            alignment: Alignment.center,
            child: Text(text, style: calendarStyle.selectedTextStyle),
          );
    } else if (isRangeStart) {
      cell =
          calendarBuilders.rangeStartBuilder?.call(context, day, focusedDay) ??
              AnimatedContainer(
                duration: duration,
                margin: margin,
                decoration: calendarStyle.rangeStartDecoration,
                alignment: Alignment.center,
                child: Text(text, style: calendarStyle.rangeStartTextStyle),
              );
    } else if (isRangeEnd) {
      cell = calendarBuilders.rangeEndBuilder?.call(context, day, focusedDay) ??
          AnimatedContainer(
            duration: duration,
            margin: margin,
            decoration: calendarStyle.rangeEndDecoration,
            alignment: Alignment.center,
            child: Text(text, style: calendarStyle.rangeEndTextStyle),
          );
    } else if (isToday && isTodayHighlighted) {
      cell = calendarBuilders.todayBuilder?.call(context, day, focusedDay) ??
          AnimatedContainer(
            duration: duration,
            margin: margin,
            // decoration: selectedDate(day),
            decoration: calendarStyle.selectedDecoration,
            alignment: Alignment.center,
            child: Text(
              text,
              // style: checkSelectedTextStyle(day)
              style: calendarStyle.todayTextStyle,
            ),
          );
    } else if (isHoliday) {
      cell = calendarBuilders.holidayBuilder?.call(context, day, focusedDay) ??
          AnimatedContainer(
            duration: duration,
            margin: margin,
            decoration: calendarStyle.holidayDecoration,
            alignment: Alignment.center,
            child: Text(text, style: calendarStyle.holidayTextStyle),
          );
    } else if (isWithinRange) {
      cell =
          calendarBuilders.withinRangeBuilder?.call(context, day, focusedDay) ??
              AnimatedContainer(
                duration: duration,
                margin: margin,
                decoration: calendarStyle.withinRangeDecoration,
                alignment: Alignment.center,
                child: Text(text, style: calendarStyle.withinRangeTextStyle),
              );
    } else if (isOutside) {
      cell = calendarBuilders.outsideBuilder?.call(context, day, focusedDay) ??
          AnimatedContainer(
            duration: duration,
            margin: margin,
            decoration: calendarStyle.outsideDecoration,
            alignment: Alignment.center,
            child: Text(text, style: calendarStyle.outsideTextStyle),
          );
    } else {
      cell = calendarBuilders.defaultBuilder?.call(context, day, focusedDay) ??
          AnimatedContainer(
            duration: duration,
            margin: margin,
            // decoration: checkDate(day),
            decoration: calendarStyle.disabledDecoration,
            // decoration: isWeekend
            //     ? calendarStyle.weekendDecoration
            //     : calendarStyle.defaultDecoration,
            alignment: Alignment.center,
            child: Text(
              text,
              style: calendarStyle.disabledTextStyle,
              // style: checkTextStyle(day),
              // style: isWeekend
              //     ? calendarStyle.weekendTextStyle
              //     : calendarStyle.defaultTextStyle,
            ),
          );
    }

    return cell;
  }

  getDates({month, year, date, fullDate}) {
    ProfileScreenController cont = Get.find();
    DateTime now = new DateTime.now();

    var _data = cont
        .checkSlot(date: date, year: year, month: month, fullDate: fullDate)
        .cast<ServiceAndBlockSlots>();

    if (_data.isNotEmpty) {
      return true;
    } else {
      return false;
    }

    // return true;
    // if (timeSlots.isNotEmpty) {
    //   for (int index = 0; index < timeSlots.length; index++) {
    //     timeSlots[index].date = date.toString();
    //     timeSlots[index].year = year.toString();
    //     timeSlots[index].month = month.toString();
    //   }
    // }
  }

  checkDate(DateTime day) {
    print(DateFormat('EEEE').format(day));
    bool flag = getDates(
        date: day.day, month: day.month, year: day.year, fullDate: day);
    int days = (DateTime.now().difference(day)).inDays;
    if (flag) {
      if (days <= 0) {
        return BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        );
      }

      return BoxDecoration(
          color: Colors.red,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.red, width: 1));
    }

    // if (days > 0) {
    return BoxDecoration(
      color: Colors.white,
      shape: BoxShape.circle,
    );
    // }

    // return BoxDecoration(
    //     color: Colors.white,
    //     shape: BoxShape.circle,
    //     border: Border.all(color: Colors.black));
  }

  checkSelectedTextStyle(DateTime day) {
    int days = (DateTime.now().difference(day)).inDays;

    bool flag = getDates(
        date: day.day, month: day.month, year: day.year, fullDate: day);

    if (flag) {
      // if (days > 0) {
      return TextStyle(
        decoration: block ? TextDecoration.lineThrough : null,
        color: Colors.white,
      );
      // }

    } else {
      // return TextStyle(
      //   color: Colors.black,
      // );
    }

    // if (days < 0) {
    // return TextStyle(color: Colors.black);
    // }

    // return TextStyle(
    //   color: Colors.black,
    // );
  }

  checkTextStyle(DateTime day) {
    int days = (DateTime.now().difference(day)).inDays;

    bool flag = getDates(
        date: day.day, month: day.month, year: day.year, fullDate: day);

    if (flag) {
      if (days <= 0) {
        return TextStyle(
          color: Colors.black,
        );
      }
      return TextStyle(
        color: Colors.white,
      );
    }

    return TextStyle(color: Colors.black26);

    // if (days < 0) {
    // return TextStyle(color: Color(0x60000000));
    // }

    // return TextStyle(
    //   color: Colors.black,
    // );
  }

  selectedDate(DateTime day) {
    int days = (DateTime.now().difference(day)).inDays;

    bool flag = getDates(
        date: day.day, month: day.month, year: day.year, fullDate: day);

    if (flag) {
      if (days <= 0) {
        return BoxDecoration(
          color: Colors.blue,
          shape: BoxShape.circle,
        );
      } else if (days > 0) {
        return BoxDecoration(
          color: Colors.grey,
          shape: BoxShape.circle,
        );
      }
    } else {
      return BoxDecoration(
        color: Colors.grey.shade100,
        shape: BoxShape.circle,
      );
    }
  }
}
