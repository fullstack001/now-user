class Links {
  var first;
  var last;
  dynamic prev;
  dynamic next;

  Links({
      this.first, 
      this.last, 
      this.prev, 
      this.next});

  Links.fromJson(dynamic json) {
    first = json["first"];
    last = json["last"];
    prev = json["prev"];
    next = json["next"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["first"] = first;
    map["last"] = last;
    map["prev"] = prev;
    map["next"] = next;
    return map;
  }

}