/// body : "abc"
/// title : "abc"
/// provider_id : "12"

class NotificationResponseData {
  String? body;
  String? title;
  String? providerId;
  String? receiverId;
  String? type;
  String? serviceRequestId;
  bool? show;
  String? payable;
  String? hours;
  String? paidAmount;
  String? workedHours;

  NotificationResponseData(
      {this.body,
      this.title,
      this.providerId,
      this.show,
      this.type,
      this.serviceRequestId,
      this.payable,
      this.paidAmount,
      this.hours,
      this.receiverId,
      this.workedHours});

  NotificationResponseData.fromJson(Map<String, dynamic> json) {
    body = json["body"] ?? "";

    title = json["title"] ?? "";
    receiverId = json["receiver_id"] ?? "";
    providerId = json["provider_id"] ?? "";
    type = json["type"] ?? "";
    show = json["show"] ?? false;
    serviceRequestId = json["service_request_id"] ?? "";
    payable = json["payable"] ?? "";
    hours = json["hours"] ?? "";
    workedHours = json["workedHours"] ?? "";
    paidAmount = json["paidAmount"] ?? "";
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["body"] = body ?? "";
    map["receiver_id"] = receiverId ?? "";
    map["show"] = show ?? "";
    map["title"] = title ?? "";
    map["provider_id"] = providerId ?? "";
    map["type"] = type ?? "";
    map["service_request_id"] = serviceRequestId ?? "";
    map["payable"] = payable ?? "";
    map["hours"] = hours ?? "";
    map["paidAmount"] = paidAmount ?? "";
    map["workedHours"] = workedHours ?? "";
    return map;
  }
}
