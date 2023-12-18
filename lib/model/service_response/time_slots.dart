import 'pivot.dart';

/// id : 31
/// provider_schedule_id : 8
/// start : "19:00"
/// end : "19:00"
/// created_at : "2021-08-11T09:07:13.000000Z"
/// updated_at : "2021-08-11T09:07:13.000000Z"
/// pivot : {"service_request_id":17,"time_slot_id":31}

class TimeSlots {
  var id;
  var providerScheduleId;
  var start;
  var end;
  var createdAt;
  var updatedAt;
  var pivot;

  TimeSlots({
      this.id, 
      this.providerScheduleId, 
      this.start, 
      this.end, 
      this.createdAt, 
      this.updatedAt, 
      this.pivot});

  TimeSlots.fromJson(dynamic json) {
    id = json["id"];
    providerScheduleId = json["provider_schedule_id"];
    start = json["start"];
    end = json["end"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
    pivot = json["pivot"] != null ? Pivot.fromJson(json["pivot"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["provider_schedule_id"] = providerScheduleId;
    map["start"] = start;
    map["end"] = end;
    map["created_at"] = createdAt;
    map["updated_at"] = updatedAt;
    if (pivot != null) {
      map["pivot"] = pivot.toJson();
    }
    return map;
  }

}