class PortFolioModel {
  PortFolioModel({
    this.id,
    this.providerId,
    this.url,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  PortFolioModel.fromJson(dynamic json) {
    id = json['id'];
    providerId = json['provider_id'];
    url = json['image'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  var id;
  var providerId;
  var url;
  var description;
  var createdAt;
  var updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['provider_id'] = providerId;
    map['image'] = url;
    map['description'] = description;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }
}
