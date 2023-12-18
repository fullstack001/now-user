// To parse this JSON data, do
//
//     final providerProfileCompleteDetail = providerProfileCompleteDetailFromJson(jsonString);

import 'dart:convert';

ProviderProfileCompleteDetail providerProfileCompleteDetailFromJson(
        String str) =>
    ProviderProfileCompleteDetail.fromJson(json.decode(str));

String providerProfileCompleteDetailToJson(
        ProviderProfileCompleteDetail data) =>
    json.encode(data.toJson());

class ProviderProfileCompleteDetail {
  ProviderProfileCompleteDetail({
    this.error,
    this.message,
    this.data,
  });

  var error;
  var message;
  var data;

  factory ProviderProfileCompleteDetail.fromJson(Map<String, dynamic> json) =>
      ProviderProfileCompleteDetail(
        error: json["error"] == null ? null : json["error"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null
            ? null
            : ProviderCompleteDetailData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "error": error == null ? null : error,
        "message": message == null ? null : message,
        "data": data == null ? null : data.toJson(),
      };
}

class ProviderCompleteDetailData {
  ProviderCompleteDetailData({
    this.provider,
  });

  var provider;

  factory ProviderCompleteDetailData.fromJson(Map<String, dynamic> json) =>
      ProviderCompleteDetailData(
        provider: json["provider"] == null
            ? null
            : ProviderCompleteDetail.fromJson(json["provider"]),
      );

  Map<String, dynamic> toJson() => {
        "provider": provider == null ? null : provider.toJson(),
      };
}

class ProviderCompleteDetail {
  ProviderCompleteDetail(
      {this.id,
      this.firstName,
      this.lastName,
      this.email,
      this.phone,
      this.image,
      this.rating,
      this.providerType,
      this.accountType,
      this.bio,
      this.verifiedAt,
      this.serviceType,
      this.userFeedbacksCount,
      this.providerServiceRequestsCount,
      this.workedHours,
      this.providerProfile,
      this.schedules,
      this.blockedSlots,
      this.portfolios,
      this.providerServices,
      this.packagePlans,
      this.paymentMethods});

  var id;
  var firstName;
  var lastName;
  var email;
  var phone;
  var image;
  var rating;
  var providerType;
  var accountType;
  var bio;
  var verifiedAt;
  var serviceType;
  var userFeedbacksCount;
  var providerServiceRequestsCount;
  var workedHours;
  var providerProfile;
  var schedules;
  var blockedSlots;
  var portfolios;
  var providerServices;
  var packagePlans;
  var paymentMethods;

  factory ProviderCompleteDetail.fromJson(Map<String, dynamic> json) =>
      ProviderCompleteDetail(
        id: json["id"] == null ? null : json["id"],
        firstName: json["first_name"] == null ? null : json["first_name"],
        lastName: json["last_name"] == null ? null : json["last_name"],
        email: json["email"] == null ? null : json["email"],
        phone: json["phone"] == null ? null : json["phone"],
        image: json["image"] == null ? null : json["image"],
        rating: json["rating"] == null ? null : json["rating"],
        providerType:
            json["provider_type"] == null ? null : json["provider_type"],
        accountType: json["account_type"] == null ? null : json["account_type"],
        bio: json["bio"] == null ? null : json["bio"],
        verifiedAt: json["verified_at"] == null
            ? null
            : DateTime.parse(json["verified_at"]),
        serviceType: json["service_type"] == null ? null : json["service_type"],
        userFeedbacksCount: json["user_feedbacks_count"] == null
            ? null
            : json["user_feedbacks_count"],
        providerServiceRequestsCount:
            json["provider_service_requests_count"] == null
                ? null
                : json["provider_service_requests_count"],
        workedHours: json["worked_hours"],
        providerProfile: json["provider_profile"] == null
            ? null
            : ProviderProfileData.fromJson(json["provider_profile"]),
        schedules: json["schedules"] == null
            ? null
            : List<Schedule>.from(
                json["schedules"].map((x) => Schedule.fromJson(x))),
        blockedSlots: json["blocked_slots"] == null
            ? null
            : List<BlockedSlot>.from(
                json["blocked_slots"].map((x) => BlockedSlot.fromJson(x))),
        portfolios: json["portfolios"] == null
            ? null
            : List<Portfolio>.from(
                json["portfolios"].map((x) => Portfolio.fromJson(x))),
        providerServices: json["provider_services"] == null
            ? null
            : List<ProviderService>.from(json["provider_services"]
                .map((x) => ProviderService.fromJson(x))),
        packagePlans: json["plans"] == null
            ? null
            : List<PackagePlans>.from(
                json["plans"].map((x) => PackagePlans.fromJson(x))),
        paymentMethods: json["payment_methods"] == null
            ? null
            : List<PaymentMethod>.from(
                json["payment_methods"].map((x) => PaymentMethod.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "first_name": firstName == null ? null : firstName,
        "last_name": lastName == null ? null : lastName,
        "email": email == null ? null : email,
        "phone": phone == null ? null : phone,
        "image": image == null ? null : image,
        "rating": rating == null ? null : rating,
        "provider_type": providerType == null ? null : providerType,
        "account_type": accountType == null ? null : accountType,
        "bio": bio == null ? null : bio,
        "verified_at": verifiedAt == null ? null : verifiedAt.toIso8601String(),
        "service_type": serviceType == null ? null : serviceType,
        "user_feedbacks_count":
            userFeedbacksCount == null ? null : userFeedbacksCount,
        "provider_service_requests_count": providerServiceRequestsCount == null
            ? null
            : providerServiceRequestsCount,
        "worked_hours": workedHours,
        "provider_profile":
            providerProfile == null ? null : providerProfile.toJson(),
        "schedules": schedules == null
            ? null
            : List<dynamic>.from(schedules.map((x) => x.toJson())),
        "blocked_slots": blockedSlots == null
            ? null
            : List<dynamic>.from(blockedSlots.map((x) => x.toJson())),
        "portfolios": portfolios == null
            ? null
            : List<dynamic>.from(portfolios.map((x) => x.toJson())),
        "provider_services": providerServices == null
            ? null
            : List<dynamic>.from(providerServices.map((x) => x.toJson())),
      };
}

class BlockedSlot {
  BlockedSlot({
    this.id,
    this.providerId,
    this.date,
    this.fromTime,
    this.toTime,
  });

  var id;
  var providerId;
  var date;
  var fromTime;
  var toTime;

  factory BlockedSlot.fromJson(Map<String, dynamic> json) => BlockedSlot(
        id: json["id"] == null ? null : json["id"],
        providerId: json["provider_id"] == null ? null : json["provider_id"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        fromTime: json["from_time"] == null ? null : json["from_time"],
        toTime: json["to_time"] == null ? null : json["to_time"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "provider_id": providerId == null ? null : providerId,
        "date": date == null
            ? null
            : "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "from_time": fromTime == null ? null : fromTime,
        "to_time": toTime == null ? null : toTime,
      };
}

class Portfolio {
  Portfolio({
    this.id,
    this.providerId,
    this.image,
    this.description,
  });

  var id;
  var providerId;
  var image;
  var description;

  factory Portfolio.fromJson(Map<String, dynamic> json) => Portfolio(
        id: json["id"] == null ? null : json["id"],
        providerId: json["provider_id"] == null ? null : json["provider_id"],
        image: json["image"] == null ? null : json["image"],
        description: json["description"] == null ? null : json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "provider_id": providerId == null ? null : providerId,
        "image": image == null ? null : image,
        "description": description == null ? null : description,
      };
}

class ProviderProfileData {
  ProviderProfileData({
    this.id,
    this.providerId,
    this.businessName,
    this.city,
    this.hourlyRate,
    this.totalEarn,
  });

  var id;
  var providerId;
  var businessName;
  var city;
  var hourlyRate;
  var totalEarn;

  factory ProviderProfileData.fromJson(Map<String, dynamic> json) =>
      ProviderProfileData(
        id: json["id"] == null ? null : json["id"],
        providerId: json["provider_id"] == null ? null : json["provider_id"],
        businessName:
            json["business_name"] == null ? null : json["business_name"],
        city: json["city"] == null ? null : json["city"],
        hourlyRate: json["hourly_rate"],
        totalEarn: json["total_earn"] == null ? null : json["total_earn"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "provider_id": providerId == null ? null : providerId,
        "business_name": businessName == null ? null : businessName,
        "city": city == null ? null : city,
        "hourly_rate": hourlyRate,
        "total_earn": totalEarn == null ? null : totalEarn,
      };
}

class ProviderService {
  ProviderService({
    this.id,
    this.providerId,
    this.subServiceId,
    this.status,
    this.subService,
  });

  var id;
  var providerId;
  var subServiceId;
  var status;
  var subService;

  factory ProviderService.fromJson(Map<String, dynamic> json) =>
      ProviderService(
        id: json["id"] == null ? null : json["id"],
        providerId: json["provider_id"] == null ? null : json["provider_id"],
        subServiceId:
            json["sub_service_id"] == null ? null : json["sub_service_id"],
        status: json["status"] == null ? null : json["status"],
        subService: json["sub_service"] == null
            ? null
            : SubService.fromJson(json["sub_service"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "provider_id": providerId == null ? null : providerId,
        "sub_service_id": subServiceId == null ? null : subServiceId,
        "status": status == null ? null : status,
        "sub_service": subService == null ? null : subService.toJson(),
      };
}

class SubService {
  SubService({
    this.id,
    this.name,
  });

  var id;
  var name;

  factory SubService.fromJson(Map<String, dynamic> json) => SubService(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
      };
}

class Schedule {
  Schedule({
    this.id,
    this.providerId,
    this.day,
    this.fromTime,
    this.toTime,
    this.isCustom,
  });

  var id;
  var providerId;
  var day;
  var fromTime;
  var toTime;
  var isCustom;

  factory Schedule.fromJson(Map<String, dynamic> json) => Schedule(
        id: json["id"] == null ? null : json["id"],
        providerId: json["provider_id"] == null ? null : json["provider_id"],
        day: json["day"] == null ? null : json["day"],
        fromTime: json["from_time"] == null ? null : json["from_time"],
        toTime: json["to_time"] == null ? null : json["to_time"],
        isCustom: json["is_custom"] == null ? null : json["is_custom"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "provider_id": providerId == null ? null : providerId,
        "day": day == null ? null : day,
        "from_time": fromTime == null ? null : fromTime,
        "to_time": toTime == null ? null : toTime,
        "is_custom": isCustom == null ? null : isCustom,
      };
}

class PackagePlans {
  PackagePlans({
    this.id,
    this.providerId,
    this.title,
    this.price,
    this.type,
    this.duration,
    this.off,
    this.description,
  });

  var id;
  var providerId;
  var title;
  var price;
  var type;
  var duration;
  var off;
  var description;

  factory PackagePlans.fromJson(Map<String, dynamic> json) => PackagePlans(
        id: json["id"] == null ? null : json["id"],
        providerId: json["provider_id"] == null ? null : json["provider_id"],
        title: json["title"] == null ? null : json["title"],
        price: json["price"] == null ? null : json["price"],
        type: json["type"] == null ? null : json["type"],
        duration: json["duration"] == null ? null : json["duration"],
        off: json["off"] == null ? null : json["off"],
        description: json["description"] == null ? null : json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "provider_id": providerId == null ? null : providerId,
        "title": title == null ? null : title,
        "price": price == null ? null : price,
        "type": type == null ? null : type,
        "duration": duration == null ? null : duration,
        "off": off == null ? null : off,
        "description": description == null ? null : description,
      };
}

class PaymentMethod {
  PaymentMethod({
    this.id,
    this.name,
    this.icon,
  });

  var id;
  var name;
  var icon;

  factory PaymentMethod.fromJson(Map<String, dynamic> json) => PaymentMethod(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        icon: json["icon"] == null ? null : json["icon"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "icon": icon == null ? null : icon,
      };
}
