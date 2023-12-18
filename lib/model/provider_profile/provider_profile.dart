import 'package:application_1/model/calender_events/time_slots.dart';


/// id : 10
/// provider_id : 48
/// year : "2021"
/// month : "8"
/// date : "13"
/// created_at : "2021-08-11T09:45:18.000000Z"
/// updated_at : "2021-08-11T09:45:18.000000Z"
/// time_slots : [{"id":33,"provider_schedule_id":10,"start":"12:00","end":"12:00","created_at":"2021-08-11T09:45:18.000000Z","updated_at":"2021-08-11T09:45:18.000000Z"},{"id":34,"provider_schedule_id":10,"start":"21:00","end":"21:00","created_at":"2021-08-11T09:45:18.000000Z","updated_at":"2021-08-11T09:45:18.000000Z"},{"id":35,"provider_schedule_id":10,"start":"20:00","end":"20:00","created_at":"2021-08-11T09:45:18.000000Z","updated_at":"2021-08-11T09:45:18.000000Z"}]

class ProviderProfile {
  var id;
  var providerId;
  var year;
  var month;
  var date;
  // String createdAt;
  // String updatedAt;
  var timeSlots;

  ProviderProfile({
      this.id, 
      this.providerId, 
      this.year, 
      this.month, 
      this.date, 
      // this.createdAt,
      // this.updatedAt,
      this.timeSlots});

  ProviderProfile.fromJson(dynamic json) {
    id = json["id"];
    providerId = json["provider_id"];
    year = json["year"];
    month = json["month"];
    date = json["date"];
    // createdAt = json["created_at"];
    // updatedAt = json["updated_at"];
    if (json["time_slots"] != null) {
      timeSlots = [];
      json["time_slots"].forEach((v) {
        timeSlots.add(TimeSlots.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["provider_id"] = providerId;
    map["year"] = year;
    map["month"] = month;
    map["date"] = date;
    // map["created_at"] = createdAt;
    // map["updated_at"] = updatedAt;
    if (timeSlots != null) {
      map["time_slots"] = timeSlots.map((v) => v.toJson()).toList();
    }
    return map;
  }

}