class CompleteAndOngoingServices {
  CompleteAndOngoingServices({
    this.error,
    this.message,
    this.data,
    this.links,
    this.meta,
  });

  var error;
  var message;
  var data;
  var links;
  var meta;

  factory CompleteAndOngoingServices.fromJson(Map<String, dynamic> json) =>
      CompleteAndOngoingServices(
        error: json["error"] == null ? null : json["error"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null
            ? null
            : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        links: json["links"] == null ? null : Links.fromJson(json["links"]),
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "error": error == null ? null : error,
        "message": message == null ? null : message,
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
        "links": links == null ? null : links.toJson(),
        "meta": meta == null ? null : meta.toJson(),
      };
}

class Datum {
  Datum(
      {this.id,
      this.userId,
      this.subServiceId,
      this.address,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.providerId,
      this.quotationInfoId,
      this.hours,
      this.isQuotation,
      this.directContact,
      this.isReplied,
      this.isCompleted,
      this.workedHours,
      this.workingStatus,
      this.subService,
      this.paymentStatus,
      this.paidAmount,
      this.payableAmount,
      this.type,
      this.requestInfos,
      this.quotationInfo,
      this.workedTimes,
      this.providerProfile});

  var id;
  var userId;
  var subServiceId;
  var address;
  var status;
  var createdAt;
  var updatedAt;
  var providerId;
  var quotationInfoId;
  var hours;
  var isQuotation;
  var directContact;
  var isReplied;
  var isCompleted;
  var workedHours;
  var workingStatus;
  var subService;
  var paymentStatus;
  var paidAmount;
  var payableAmount;
  var type;
  var requestInfos;
  var quotationInfo;
  var workedTimes;
  var providerProfile;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"] == null ? null : json["id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        subServiceId:
            json["sub_service_id"] == null ? null : json["sub_service_id"],
        address: json["address"] == null ? null : json["address"],
        status: json["status"] == null ? null : json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        providerId: json["provider_id"] == null ? null : json["provider_id"],
        quotationInfoId: json["quotation_info_id"] == null
            ? null
            : json["quotation_info_id"],
        hours: json["hours"],
        isQuotation: json["is_quotation"] == null ? null : json["is_quotation"],
        directContact:
            json["direct_contact"] == null ? null : json["direct_contact"],
        isReplied: json["is_replied"] == null ? null : json["is_replied"],
        isCompleted: json["is_completed"] == null ? null : json["is_completed"],
        workedHours: json["worked_hours"] == null ? null : json["worked_hours"],
        workingStatus:
            json["working_status"] == null ? null : json["working_status"],
        subService: json["sub_service"] == null ? null : json["sub_service"],
        paymentStatus: json["payment_status"],
        paidAmount: json["paid_amount"],
        payableAmount: json["payable_amount"],
        type: json["type"],
        requestInfos: json["request_infos"] == null
            ? null
            : List<RequestInfo>.from(
                json["request_infos"].map((x) => RequestInfo.fromJson(x))),
        quotationInfo: json["quotation_info"] == null
            ? null
            : QuotationInfo.fromJson(json["quotation_info"]),
        workedTimes: json["worked_times"] == null
            ? null
            : List<WorkedTime>.from(
                json["worked_times"].map((x) => WorkedTime.fromJson(x))),
        providerProfile: json["provider"] == null
            ? null
            : Provider.fromJson(json["provider"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "user_id": userId == null ? null : userId,
        "sub_service_id": subServiceId == null ? null : subServiceId,
        "address": address == null ? null : address,
        "status": status == null ? null : status,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "provider_id": providerId == null ? null : providerId,
        "quotation_info_id": quotationInfoId == null ? null : quotationInfoId,
        "hours": hours,
        "is_quotation": isQuotation == null ? null : isQuotation,
        "direct_contact": directContact == null ? null : directContact,
        "is_replied": isReplied == null ? null : isReplied,
        "is_completed": isCompleted == null ? null : isCompleted,
        "worked_hours": workedHours == null ? null : workedHours,
        "working_status": workingStatus == null ? null : workingStatus,
        "sub_service": subService == null ? null : subService,
        "payment_status": paymentStatus,
        "paid_amount": paidAmount,
        "payable_amount": payableAmount,
        "type": type,
        "request_infos": requestInfos == null
            ? null
            : List<dynamic>.from(requestInfos.map((x) => x.toJson())),
        "quotation_info": quotationInfo == null ? null : quotationInfo.toJson(),
        "worked_times": workedTimes == null
            ? null
            : List<dynamic>.from(workedTimes.map((x) => x.toJson())),
      };
}

class QuotationInfo {
  QuotationInfo({
    this.id,
    this.vehicleTypeId,
    this.detail,
    this.reply,
    this.duration,
    this.price,
    this.phone,
    this.email,
    this.name,
    this.fromAddress,
    this.startLat,
    this.startLng,
    this.toAddress,
    this.endLat,
    this.endLng,
    this.date,
    this.createdAt,
    this.updatedAt,
  });

  var id;
  dynamic vehicleTypeId;
  var detail;
  dynamic reply;
  dynamic duration;
  dynamic price;
  dynamic phone;
  dynamic email;
  dynamic name;
  dynamic fromAddress;
  dynamic startLat;
  dynamic startLng;
  dynamic toAddress;
  dynamic endLat;
  dynamic endLng;
  dynamic date;
  var createdAt;
  var updatedAt;

  factory QuotationInfo.fromJson(Map<String, dynamic> json) => QuotationInfo(
        id: json["id"] == null ? null : json["id"],
        vehicleTypeId: json["vehicle_type_id"],
        detail: json["detail"] == null ? null : json["detail"],
        reply: json["reply"],
        duration: json["duration"],
        price: json["price"],
        phone: json["phone"],
        email: json["email"],
        name: json["name"],
        fromAddress: json["from_address"],
        startLat: json["start_lat"],
        startLng: json["start_lng"],
        toAddress: json["to_address"],
        endLat: json["end_lat"],
        endLng: json["end_lng"],
        date: json["date"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "vehicle_type_id": vehicleTypeId,
        "detail": detail == null ? null : detail,
        "reply": reply,
        "duration": duration,
        "price": price,
        "phone": phone,
        "email": email,
        "name": name,
        "from_address": fromAddress,
        "start_lat": startLat,
        "start_lng": startLng,
        "to_address": toAddress,
        "end_lat": endLat,
        "end_lng": endLng,
        "date": date,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
      };
}

class RequestInfo {
  RequestInfo({
    this.id,
    this.serviceRequestId,
    this.questionId,
    this.optionId,
    this.question,
    this.option,
  });

  var id;
  var serviceRequestId;
  var questionId;
  var optionId;
  var question;
  var option;

  factory RequestInfo.fromJson(Map<String, dynamic> json) => RequestInfo(
        id: json["id"] == null ? null : json["id"],
        serviceRequestId: json["service_request_id"] == null
            ? null
            : json["service_request_id"],
        questionId: json["question_id"] == null ? null : json["question_id"],
        optionId: json["option_id"] == null ? null : json["option_id"],
        question: json["question"] == null
            ? null
            : Question.fromJson(json["question"]),
        option: json["option"] == null ? null : Option.fromJson(json["option"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "service_request_id":
            serviceRequestId == null ? null : serviceRequestId,
        "question_id": questionId == null ? null : questionId,
        "option_id": optionId == null ? null : optionId,
        "question": question == null ? null : question.toJson(),
        "option": option == null ? null : option.toJson(),
      };
}

class Option {
  Option({
    this.id,
    this.option,
  });

  var id;
  var option;

  factory Option.fromJson(Map<String, dynamic> json) => Option(
        id: json["id"] == null ? null : json["id"],
        option: json["option"] == null ? null : json["option"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "option": option == null ? null : option,
      };
}

class Question {
  Question({
    this.id,
    this.question,
  });

  var id;
  var question;

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        id: json["id"] == null ? null : json["id"],
        question: json["question"] == null ? null : json["question"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "question": question == null ? null : question,
      };
}

class WorkedTime {
  WorkedTime({
    this.id,
    this.serviceRequestId,
    this.isPaused,
    this.startAt,
    this.endAt,
    this.createdAt,
    this.updatedAt,
  });

  var id;
  var serviceRequestId;
  var isPaused;
  var startAt;
  var endAt;
  var createdAt;
  var updatedAt;

  factory WorkedTime.fromJson(Map<String, dynamic> json) => WorkedTime(
        id: json["id"] == null ? null : json["id"],
        serviceRequestId: json["service_request_id"] == null
            ? null
            : json["service_request_id"],
        isPaused: json["is_paused"] == null ? null : json["is_paused"],
        startAt:
            json["start_at"] == null ? null : DateTime.parse(json["start_at"]),
        endAt: json["end_at"] == null ? null : DateTime.parse(json["end_at"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "service_request_id":
            serviceRequestId == null ? null : serviceRequestId,
        "is_paused": isPaused == null ? null : isPaused,
        "start_at": startAt == null ? null : startAt.toIso8601String(),
        "end_at": endAt == null ? null : endAt.toIso8601String(),
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
      };
}

class Links {
  Links({
    this.first,
    this.last,
    this.prev,
    this.next,
  });

  var first;
  var last;
  dynamic prev;
  dynamic next;

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        first: json["first"] == null ? null : json["first"],
        last: json["last"] == null ? null : json["last"],
        prev: json["prev"],
        next: json["next"],
      );

  Map<String, dynamic> toJson() => {
        "first": first == null ? null : first,
        "last": last == null ? null : last,
        "prev": prev,
        "next": next,
      };
}

class Meta {
  Meta({
    this.currentPage,
    this.from,
    this.lastPage,
    this.path,
    this.perPage,
    this.to,
    this.total,
  });

  var currentPage;
  var from;
  var lastPage;
  var path;
  var perPage;
  var to;
  var total;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        currentPage: json["current_page"] == null ? null : json["current_page"],
        from: json["from"] == null ? null : json["from"],
        lastPage: json["last_page"] == null ? null : json["last_page"],
        path: json["path"] == null ? null : json["path"],
        perPage: json["per_page"] == null ? null : json["per_page"],
        to: json["to"] == null ? null : json["to"],
        total: json["total"] == null ? null : json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage == null ? null : currentPage,
        "from": from == null ? null : from,
        "last_page": lastPage == null ? null : lastPage,
        "path": path == null ? null : path,
        "per_page": perPage == null ? null : perPage,
        "to": to == null ? null : to,
        "total": total == null ? null : total,
      };
}

class Provider {
  Provider({
    this.id,
    this.firstName,
    this.lastName,
    this.providerProfile,
  });

  var id;
  var firstName;
  var lastName;
  var providerProfile;

  factory Provider.fromJson(Map<String, dynamic> json) => Provider(
        id: json["id"] == null ? null : json["id"],
        firstName: json["first_name"] == null ? null : json["first_name"],
        lastName: json["last_name"] == null ? null : json["last_name"],
        providerProfile: json["provider_profile"] == null
            ? null
            : ProviderProfileClass.fromJson(json["provider_profile"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "first_name": firstName == null ? null : firstName,
        "last_name": lastName == null ? null : lastName,
        "provider_profile":
            providerProfile == null ? null : providerProfile.toJson(),
      };
}

class ProviderProfileClass {
  ProviderProfileClass({
    this.id,
    this.providerId,
    this.hourlyRate,
  });

  var id;
  var providerId;
  var hourlyRate;

  factory ProviderProfileClass.fromJson(Map<String, dynamic> json) =>
      ProviderProfileClass(
        id: json["id"] == null ? null : json["id"],
        providerId: json["provider_id"] == null ? null : json["provider_id"],
        hourlyRate: json["hourly_rate"] == null ? null : json["hourly_rate"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "provider_id": providerId == null ? null : providerId,
        "hourly_rate": hourlyRate == null ? null : hourlyRate,
      };
}
