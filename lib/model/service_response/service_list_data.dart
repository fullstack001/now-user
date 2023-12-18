import 'package:application_1/model/order_status/worked_times.dart';
import 'package:application_1/model/service_response/moving_quotation_info.dart';
import 'package:application_1/model/service_response/payable.dart';
import 'package:application_1/model/service_response/provider_model.dart';
import 'package:application_1/model/service_response/request_infos.dart';

import 'time_slots.dart';

/// id : 17
/// user_id : 59
/// address : "Garden Town, Lahore, Pakistan"
/// status : "ACCEPTED"
/// created_at : "2021-08-16T10:53:27.000000Z"
/// updated_at : "2021-08-16T10:55:35.000000Z"
/// provider_id : ""
/// provider : null
/// request_infos : [{"id":11,"service_request_id":17,"question_id":1,"option_id":11,"created_at":"2021-08-16T10:53:27.000000Z","updated_at":"2021-08-16T10:53:27.000000Z","detail":null,"reply":null,"duration":null,"price":null,"question":{"id":1,"sub_service_id":1,"question":"What is Room size","created_at":"2021-08-09T06:40:24.000000Z","updated_at":"2021-08-09T06:40:24.000000Z","sub_service":{"id":1,"service_id":1,"name":"Affordable Cleaning Service","status":1,"created_at":"2021-06-02T17:13:15.000000Z","updated_at":"2021-06-02T17:13:15.000000Z"}},"option":{"id":11,"question_id":1,"option":"20x20","created_at":"2021-08-09T07:14:00.000000Z","updated_at":"2021-08-09T07:14:00.000000Z"}},{"id":12,"service_request_id":17,"question_id":2,"option_id":3,"created_at":"2021-08-16T10:53:27.000000Z","updated_at":"2021-08-16T10:53:27.000000Z","detail":null,"reply":null,"duration":null,"price":null,"question":{"id":2,"sub_service_id":1,"question":"What is Room Type","created_at":"2021-08-09T06:43:05.000000Z","updated_at":"2021-08-09T06:43:05.000000Z","sub_service":{"id":1,"service_id":1,"name":"Affordable Cleaning Service","status":1,"created_at":"2021-06-02T17:13:15.000000Z","updated_at":"2021-06-02T17:13:15.000000Z"}},"option":{"id":3,"question_id":2,"option":"Quad","created_at":"2021-08-09T07:11:44.000000Z","updated_at":"2021-08-09T07:11:44.000000Z"}}]
/// time_slots : [{"id":31,"provider_schedule_id":8,"start":"19:00","end":"19:00","created_at":"2021-08-11T09:07:13.000000Z","updated_at":"2021-08-11T09:07:13.000000Z","pivot":{"service_request_id":17,"time_slot_id":31}}]

class ServiceListData {
  var id;
  var userId;
  var address;
  var status;
  var createdAt;
  var updatedAt;
  var providerId;
  var directContact;
  var isReplied;
  var workingStatus;
  var isCompleted;
  var seconds;
  var payable;
  var provider;
  var requestInfos;
  var timeSlots;
  var hourlyRate;
  var hours;
  var workedHours;
  var subService;
  var paymentStatus;
  var paidAmount;
  var payableAmount;
  var type;
  var isPaused = false;
  var workedTimes;
  var movingQuotationInfo;
  var userFeedback;
  var providerFeedback;

  // "worked_hours": null,
  // "working_status": null,
  // "sub_service": null,
  // "payment_status": null,
  // "paid_amount": null,
  // "payable_amount": null,

  ServiceListData({
    this.id,
    this.userId,
    this.address,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.providerId,
    this.provider,
    this.requestInfos,
    this.timeSlots,
    this.hourlyRate,
    this.directContact,
    this.isReplied,
    this.workingStatus,
    this.seconds,
    this.isCompleted,
    this.hours,
    this.subService,
    this.paidAmount,
    this.payableAmount,
    this.paymentStatus,
    this.workedHours,
    this.payable,
    this.type,
    this.movingQuotationInfo,
    this.workedTimes,
    this.userFeedback,
    this.providerFeedback,
  });

  ServiceListData.fromJson(dynamic json) {
    id = json["id"];
    userId = json["user_id"];
    if (json["worked_times"] != null) {
      workedTimes = [];
      json["worked_times"].forEach((v) {
        workedTimes.add(WorkedTimes.fromJson(v));
      });
    }
    address = json["address"];
    status = json["status"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
    providerId = json["provider_id"];
    directContact = json["direct_contact"];
    isReplied = json["is_replied"];
    workingStatus = json["working_status"];
    isCompleted = json["is_completed"];
    seconds = json["seconds"];
    type = json["type"];
    movingQuotationInfo = json["quotation_info"] != null
        ? MovingQuotationInfo.fromJson(json["quotation_info"])
        : null;

    hours = json["hours"];

    userFeedback = json["user_feeback"];
    providerFeedback = json["provider_feeback"];

    payable =
        json["payable"] == null ? null : Payable.fromJson(json["payable"]);
    provider = json["provider"] == null
        ? ProviderModel()
        : ProviderModel.fromJson(json["provider"]);
    if (json["request_infos"] != null) {
      requestInfos = [];
      json["request_infos"].forEach((v) {
        requestInfos.add(RequestInfos.fromJson(v));
      });
    }
    if (json["time_slots"] != null) {
      timeSlots = [];
      json["time_slots"].forEach((v) {
        timeSlots.add(TimeSlots.fromJson(v));
      });
    }
    if (json['provider'] != null) {
      if (json['provider']['provider_profile'] != null) {
        hourlyRate =
            json['provider']['provider_profile']['hourly_rate'] ?? "quotation";
      }
    }
    workedHours = json["worked_hours"];
    paymentStatus = json["payment_status"];
    paidAmount = json["paid_amount"];
    payableAmount = json["payable_amount"];
    subService = json["sub_service"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    if (workedTimes != null) {
      map["worked_times"] = workedTimes.map((v) => v.toJson()).toList();
    }
    map["direct_contact"] = directContact;
    map["user_id"] = userId;
    map["type"] = type;
    map["address"] = address;
    map["status"] = status;
    map["created_at"] = createdAt;
    map["updated_at"] = updatedAt;
    map["provider_id"] = providerId;
    map["provider"] = provider;
    map["is_replied"] = isReplied;
    map["seconds"] = seconds;
    map["working_status"] = workingStatus;
    map["is_completed"] = isCompleted;

    map["hours"] = hours;
    map["worked_hours"] = workedHours;
    map["payment_status"] = paymentStatus;
    map["paid_amount"] = paidAmount;
    map["payable_amount"] = payableAmount;
    map["sub_service"] = subService;
    if (payable != null) {
      map["payable"] = payable.toJson();
    }
    if (movingQuotationInfo != null) {
      map["quotation_info"] = movingQuotationInfo.toJson();
    }

    if (requestInfos != null) {
      map["request_infos"] = requestInfos.map((v) => v.toJson()).toList();
    }
    if (timeSlots != null) {
      map["time_slots"] = timeSlots.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
