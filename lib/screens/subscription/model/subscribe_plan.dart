// To parse this JSON data, do
//
//     final subscribePlans = subscribePlansFromJson(jsonString);

import 'dart:convert';

SubscribePlans subscribePlansFromJson(String str) =>
    SubscribePlans.fromJson(json.decode(str));

String subscribePlansToJson(SubscribePlans data) => json.encode(data.toJson());

class SubscribePlans {
  SubscribePlans({
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

  factory SubscribePlans.fromJson(Map<String, dynamic> json) => SubscribePlans(
        error: json["error"] == null ? null : json["error"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null
            ? null
            : List<SubscribeData>.from(
                json["data"].map((x) => SubscribeData.fromJson(x))),
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

class SubscribeData {
  SubscribeData({
    this.id,
    this.userId,
    this.planId,
    this.serviceRequestId,
    this.type,
    this.duration,
    this.off,
    this.startDate,
    this.endDate,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.plan,
    this.subscriptionHistories,
    this.serviceRequest,
  });

  var id;
  var userId;
  var planId;
  var serviceRequestId;
  var type;
  var duration;
  var off;
  var startDate;
  var endDate;
  var status;
  var createdAt;
  var updatedAt;
  var deletedAt;
  var plan;
  var subscriptionHistories;
  var serviceRequest;

  factory SubscribeData.fromJson(Map<String, dynamic> json) => SubscribeData(
        id: json["id"] == null ? null : json["id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        planId: json["plan_id"] == null ? null : json["plan_id"],
        serviceRequestId: json["service_request_id"] == null
            ? null
            : json["service_request_id"],
        type: json["type"] == null ? null : json["type"],
        duration: json["duration"] == null ? null : json["duration"],
        off: json["off"] == null ? null : json["off"],
        startDate: json["start_date"] == null
            ? null
            : DateTime.parse(json["start_date"]),
        endDate:
            json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
        status: json["status"] == null ? null : json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        plan: json["plan"] == null ? null : Plan.fromJson(json["plan"]),
        subscriptionHistories: json["subscription_histories"] == null
            ? null
            : List<SubscriptionHistory>.from(json["subscription_histories"]
                .map((x) => SubscriptionHistory.fromJson(x))),
        serviceRequest: json["service_request"] == null
            ? null
            : ServiceRequest.fromJson(json["service_request"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "user_id": userId == null ? null : userId,
        "plan_id": planId == null ? null : planId,
        "service_request_id":
            serviceRequestId == null ? null : serviceRequestId,
        "type": type == null ? null : type,
        "duration": duration == null ? null : duration,
        "off": off == null ? null : off,
        "start_date": startDate == null
            ? null
            : "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
        "end_date": endDate == null
            ? null
            : "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
        "status": status == null ? null : status,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
        "plan": plan == null ? null : plan.toJson(),
        "subscription_histories": subscriptionHistories == null
            ? null
            : List<dynamic>.from(subscriptionHistories.map((x) => x.toJson())),
        "service_request":
            serviceRequest == null ? null : serviceRequest.toJson(),
      };
}

class Plan {
  Plan({
    this.id,
    this.title,
    this.description,
  });

  var id;
  var title;
  var description;

  factory Plan.fromJson(Map<String, dynamic> json) => Plan(
        id: json["id"] == null ? null : json["id"],
        title: json["title"] == null ? null : json["title"],
        description: json["description"] == null ? null : json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "title": title == null ? null : title,
        "description": description == null ? null : description,
      };
}

class ServiceRequest {
  ServiceRequest({
    this.id,
    this.providerId,
    this.subServiceId,
    this.isCompleted,
    this.workingStatus,
    this.status,
    this.requestedSubService,
  });

  var id;
  var providerId;
  var subServiceId;
  var isCompleted;
  var workingStatus;
  var status;
  var requestedSubService;

  factory ServiceRequest.fromJson(Map<String, dynamic> json) => ServiceRequest(
        id: json["id"] == null ? null : json["id"],
        providerId: json["provider_id"] == null ? null : json["provider_id"],
        subServiceId:
            json["sub_service_id"] == null ? null : json["sub_service_id"],
        isCompleted: json["is_completed"] == null ? null : json["is_completed"],
        workingStatus: json["working_status"],
        status: json["status"] == null ? null : json["status"],
        requestedSubService: json["requested_sub_service"] == null
            ? null
            : RequestedSubService.fromJson(json["requested_sub_service"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "provider_id": providerId == null ? null : providerId,
        "sub_service_id": subServiceId == null ? null : subServiceId,
        "is_completed": isCompleted == null ? null : isCompleted,
        "working_status": workingStatus,
        "status": status == null ? null : status,
        "requested_sub_service":
            requestedSubService == null ? null : requestedSubService.toJson(),
      };
}

class RequestedSubService {
  RequestedSubService({
    this.id,
    this.name,
  });

  var id;
  var name;

  factory RequestedSubService.fromJson(Map<String, dynamic> json) =>
      RequestedSubService(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
      };
}

class SubscriptionHistory {
  SubscriptionHistory({
    this.id,
    this.providersSubscriptionId,
    this.serviceRequestId,
    this.transactionId,
    this.deductionDate,
    this.discount,
    this.status,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  var id;
  var providersSubscriptionId;
  var serviceRequestId;
  var transactionId;
  var deductionDate;
  var discount;
  var status;
  var description;
  var createdAt;
  var updatedAt;
  var deletedAt;

  factory SubscriptionHistory.fromJson(Map<String, dynamic> json) =>
      SubscriptionHistory(
        id: json["id"] == null ? null : json["id"],
        providersSubscriptionId: json["providers_subscription_id"] == null
            ? null
            : json["providers_subscription_id"],
        serviceRequestId: json["service_request_id"] == null
            ? null
            : json["service_request_id"],
        transactionId:
            json["transaction_id"] == null ? null : json["transaction_id"],
        deductionDate: json["deduction_date"] == null
            ? null
            : DateTime.parse(json["deduction_date"]),
        discount: json["discount"] == null ? null : json["discount"],
        status: json["status"] == null ? null : json["status"],
        description: json["description"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "providers_subscription_id":
            providersSubscriptionId == null ? null : providersSubscriptionId,
        "service_request_id":
            serviceRequestId == null ? null : serviceRequestId,
        "transaction_id": transactionId == null ? null : transactionId,
        "deduction_date": deductionDate == null
            ? null
            : "${deductionDate.year.toString().padLeft(4, '0')}-${deductionDate.month.toString().padLeft(2, '0')}-${deductionDate.day.toString().padLeft(2, '0')}",
        "discount": discount == null ? null : discount,
        "status": status == null ? null : status,
        "description": description,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
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
  var prev;
  var next;

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
