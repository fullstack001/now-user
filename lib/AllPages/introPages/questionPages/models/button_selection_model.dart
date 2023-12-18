class ButtonSelectionModel {
  String? title;
  bool? selected;
  String? other;

  ButtonSelectionModel({this.title, this.selected});

  ButtonSelectionModel.fromJson(dynamic json) {
    title = json["title"];
    selected = json["selected"];
    other = json["other"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["title"] = title;
    map["selected"] = selected;
    map["other"] = other;
    return map;
  }
}
