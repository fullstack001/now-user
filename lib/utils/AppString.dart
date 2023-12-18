import 'dart:io';

import 'package:application_1/model/active_orders_resp/active_orders_data.dart';
import 'package:application_1/model/inbox/inbox_data.dart';
import 'package:application_1/utils/date_time_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

abstract class AppString {
  static const BASEURL = "";
}

Future<MultipartFile> getMultiPart(File image) async {
  var file = await MultipartFile.fromFile(image.path, filename: image.path);
  return file;
}

FormData getFormData(body) {
  return FormData.fromMap(body);
}

void setSelection(TextEditingController controller) {
  controller.selection = TextSelection(
      baseOffset: controller.text.length, extentOffset: controller.text.length);
}

String checkSince(ActiveOrdersData value) {
  DateTime update = DateTimeUtils().convertString(value.updatedAt);
  String since = DateTimeUtils().checkSince(update);
  return since;
}

String lastMessage(InboxData value) {
  int senderLastUpdateTime = 0;
  int receiverLastUpdateTime = 0;

  if (value.senderMessage != null) {
    DateTime update =
        DateTimeUtils().convertString(value.senderMessage.updatedAt);
    String since = DateTimeUtils().checkSince(update);
    print("sender time: $since");
    senderLastUpdateTime = timeInMinutes(update);
  }
  if (value.receiverMessage == null && value.senderMessage == null) {
    return "";
  }
  if (value.senderMessage == null) {
    return value.receiverMessage.message;
  }
  if (value.receiverMessage == null) {
    return value.senderMessage.message;
  }
  if (value.receiverMessage != null) {
    DateTime update =
        DateTimeUtils().convertString(value.receiverMessage.updatedAt);
    String since = DateTimeUtils().checkSince(update);
    print("sender time: $since");
    receiverLastUpdateTime = timeInMinutes(update);
  }
  if (senderLastUpdateTime == 0) {
    return value.receiverMessage.message;
  }
  if (receiverLastUpdateTime == 0) {
    return value.senderMessage.message;
  }
  if (senderLastUpdateTime < receiverLastUpdateTime) {
    return value.senderMessage.message;
  }

  return value.receiverMessage.message;
}

int timeInMinutes(DateTime update) {
  final startTime = DateTime(2020, 02, 20, 10, 30);
  final currentTime = DateTime.now();

  final diff_dy = currentTime.difference(update).inDays;
  final diff_hr = currentTime.difference(update).inHours;
  final diff_mn = currentTime.difference(update).inMinutes;
  final diffSc = currentTime.difference(update).inSeconds;

  print(diff_dy);
  print(diff_hr);
  print(diff_mn);
  print(diffSc);
  return diffSc;
}

String getImagePath(ActiveOrdersData value) {
  return "";
}

String lastMessageTime(InboxData value) {
  int senderLastUpdateTime = 0;
  int receiverLastUpdateTime = 0;

  if (value.senderMessage != null) {
    DateTime update = DateTimeUtils().convertStringWoT(
        value.senderMessage.updatedAt ?? DateTime.now().toString());
    String since = DateTimeUtils().checkSince(update);
    print("sender time: $since");
    senderLastUpdateTime = timeInMinutes(update);
  }
  if (value.receiverMessage != null) {
    DateTime update = DateTimeUtils().convertStringWoT(
        value.receiverMessage.updatedAt ?? DateTime.now().toString());
    String since = DateTimeUtils().checkSince(update);
    print("sender time: $since");
    receiverLastUpdateTime = timeInMinutes(update);
  }
  if (value.receiverMessage == null && value.senderMessage == null) {
    return value.updatedAt ?? DateTime.now().toString();
  }
  if (value.senderMessage == null) {
    return value.receiverMessage.updatedAt;
  }
  if (value.receiverMessage == null) {
    return value.senderMessage.updatedAt;
  }
  if (senderLastUpdateTime == 0) {
    return value.receiverMessage.updatedAt;
  }
  if (receiverLastUpdateTime == 0) {
    return value.senderMessage.updatedAt;
  }
  if (senderLastUpdateTime < receiverLastUpdateTime) {
    return value.senderMessage.updatedAt;
  }

  return value.receiverMessage.updatedAt;
}
