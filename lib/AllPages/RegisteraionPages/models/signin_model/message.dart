/// phone : "The phone has already been taken."

class Message {
  String? phone;

  Message({this.phone});

  Message.fromJson(dynamic json) {
    phone = json["email"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["phone"] = phone;
    return map;
  }
}
