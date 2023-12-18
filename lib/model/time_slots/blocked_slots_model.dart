// To parse this JSON data, do
//
//     final blockedSlots = blockedSlotsFromJson(jsonString);

import 'dart:convert';

BlockedSlots blockedSlotsFromJson(String str) =>
    BlockedSlots.fromJson(json.decode(str));

String blockedSlotsToJson(BlockedSlots data) => json.encode(data.toJson());

class BlockedSlots {
  BlockedSlots({
    this.blockedSlots,
  });

  var blockedSlots;

  factory BlockedSlots.fromJson(Map<String, dynamic> json) => BlockedSlots(
        blockedSlots: json["blocked_slots"] == null
            ? null
            : List<BlockedSlot>.from(
                json["blocked_slots"].map((x) => BlockedSlot.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "blocked_slots": blockedSlots == null
            ? null
            : List<dynamic>.from(blockedSlots.map((x) => x.toJson())),
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
