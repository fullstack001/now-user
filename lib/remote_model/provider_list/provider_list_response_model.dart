// To parse this JSON data, do
//
//     final providerListResponse = providerListResponseFromJson(jsonString);

import 'dart:convert';

ProviderListResponse providerListResponseFromJson(String str) =>
    ProviderListResponse.fromJson(json.decode(str));

String providerListResponseToJson(ProviderListResponse data) =>
    json.encode(data.toJson());

class ProviderListResponse {
  ProviderListResponse({
    this.error,
    this.message,
    this.providerListData,
  });

  var error;
  var message;
  var providerListData;

  factory ProviderListResponse.fromJson(Map<String, dynamic> json) =>
      ProviderListResponse(
        error: json["error"] == null ? null : json["error"],
        message: json["message"] == null ? null : json["message"],
        providerListData:
            json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "error": error == null ? null : error,
        "message": message == null ? null : message,
        "data": providerListData == null ? null : providerListData.toJson(),
      };
}

class Data {
  Data({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  var currentPage;
  var data;
  var firstPageUrl;
  var from;
  var lastPage;
  var lastPageUrl;
  var nextPageUrl;
  var path;
  var perPage;
  var prevPageUrl;
  var to;
  var total;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        currentPage: json["current_page"] == null ? null : json["current_page"],
        data: json["data"] == null
            ? null
            : List<ProviderListData>.from(
                json["data"].map((x) => ProviderListData.fromJson(x))),
        firstPageUrl:
            json["first_page_url"] == null ? null : json["first_page_url"],
        from: json["from"] == null ? null : json["from"],
        lastPage: json["last_page"] == null ? null : json["last_page"],
        lastPageUrl:
            json["last_page_url"] == null ? null : json["last_page_url"],
        nextPageUrl: json["next_page_url"],
        path: json["path"] == null ? null : json["path"],
        perPage: json["per_page"] == null ? null : json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"] == null ? null : json["to"],
        total: json["total"] == null ? null : json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage == null ? null : currentPage,
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
        "first_page_url": firstPageUrl == null ? null : firstPageUrl,
        "from": from == null ? null : from,
        "last_page": lastPage == null ? null : lastPage,
        "last_page_url": lastPageUrl == null ? null : lastPageUrl,
        "next_page_url": nextPageUrl,
        "path": path == null ? null : path,
        "per_page": perPage == null ? null : perPage,
        "prev_page_url": prevPageUrl,
        "to": to == null ? null : to,
        "total": total == null ? null : total,
      };
}

class ProviderListData {
  ProviderListData({
    this.id,
    this.firstName,
    this.lastName,
    this.image,
    this.rating,
    this.providerType,
    this.accountType,
    this.bio,
    this.verifiedAt,
    this.serviceType,
    this.userFeedbacksCount,
    this.providerCompletedServiceRequestsCount,
    this.providerProfile,
  });

  var id;
  var firstName;
  var lastName;
  var image;
  var rating;
  var providerType;
  var accountType;
  var bio;
  var verifiedAt;
  var serviceType;
  var userFeedbacksCount;
  var providerCompletedServiceRequestsCount;
  var providerProfile;

  factory ProviderListData.fromJson(Map<String, dynamic> json) =>
      ProviderListData(
        id: json["id"] == null ? null : json["id"],
        firstName: json["first_name"] == null ? null : json["first_name"],
        lastName: json["last_name"] == null ? null : json["last_name"],
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
        providerCompletedServiceRequestsCount:
            json["provider_completed_service_requests_count"] == null
                ? null
                : json["provider_completed_service_requests_count"],
        providerProfile: json["provider_profile"] == null
            ? null
            : ProviderProfile.fromJson(json["provider_profile"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "first_name": firstName == null ? null : firstName,
        "last_name": lastName == null ? null : lastName,
        "image": image == null ? null : image,
        "rating": rating == null ? null : rating,
        "provider_type": providerType == null ? null : providerType,
        "account_type": accountType == null ? null : accountType,
        "bio": bio == null ? null : bio,
        "verified_at": verifiedAt == null ? null : verifiedAt.toIso8601String(),
        "service_type": serviceType == null ? null : serviceType,
        "user_feedbacks_count":
            userFeedbacksCount == null ? null : userFeedbacksCount,
        "provider_completed_service_requests_count":
            providerCompletedServiceRequestsCount == null
                ? null
                : providerCompletedServiceRequestsCount,
        "provider_profile":
            providerProfile == null ? null : providerProfile.toJson(),
      };
}

class ProviderProfile {
  ProviderProfile({
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

  factory ProviderProfile.fromJson(Map<String, dynamic> json) =>
      ProviderProfile(
        id: json["id"] == null ? null : json["id"],
        providerId: json["provider_id"] == null ? null : json["provider_id"],
        businessName:
            json["business_name"] == null ? null : json["business_name"],
        city: json["city"] == null ? null : json["city"],
        hourlyRate: json["hourly_rate"] == null ? null : json["hourly_rate"],
        totalEarn: json["total_earn"] == null ? null : json["total_earn"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "provider_id": providerId == null ? null : providerId,
        "business_name": businessName == null ? null : businessName,
        "city": city == null ? null : city,
        "hourly_rate": hourlyRate == null ? null : hourlyRate,
        "total_earn": totalEarn == null ? null : totalEarn,
      };
}
