import 'provider_schedule.dart';

/// id : 1
/// provider_schedule_id : 1
/// start : "00"
/// end : "01"
/// created_at : "2021-08-10T13:16:00.000000Z"
/// updated_at : "2021-08-10T13:16:00.000000Z"
/// provider_schedule : {"id":1,"provider_id":48,"year":"2021","month":"1","date":"5","created_at":"2021-08-10T13:16:00.000000Z","updated_at":"2021-08-10T13:16:00.000000Z"}
/// service_requests : []

class ProviderTimeslotsData {
  var id;
  var providerScheduleId;
  var start;
  var end;
  var createdAt;
  var updatedAt;
  var providerSchedule;
  var serviceRequests;

  ProviderTimeslotsData({
      this.id, 
      this.providerScheduleId, 
      this.start, 
      this.end, 
      this.createdAt, 
      this.updatedAt, 
      this.providerSchedule, 
      this.serviceRequests});

  ProviderTimeslotsData.fromJson(dynamic json) {
    id = json["id"];
    providerScheduleId = json["provider_schedule_id"];
    start = json["start"];
    end = json["end"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
    providerSchedule = json["provider_schedule"] != null ? ProviderSchedule.fromJson(json["provider_schedule"]) : null;

  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["provider_schedule_id"] = providerScheduleId;
    map["start"] = start;
    map["end"] = end;
    map["created_at"] = createdAt;
    map["updated_at"] = updatedAt;
    if (providerSchedule != null) {
      map["provider_schedule"] = providerSchedule.toJson();
    }
    if (serviceRequests != null) {
      map["service_requests"] = serviceRequests.map((v) => v.toJson()).toList();
    }
    return map;
  }

}