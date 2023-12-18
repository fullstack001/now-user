class AddressData {
  AddressData({
    this.id,
    this.userId,
    this.type,
    this.address,
    this.flatNo,
    this.zipCode,
    this.createdAt,
    this.updatedAt,
  });

  AddressData.fromJson(dynamic json) {
    id = json['id'];
    userId = json['user_id'];
    type = json['type'];
    address = json['address'];
    flatNo = json['flat_no'];
    zipCode = json['zip_code'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  var id;
  var userId;
  var type;
  var address;
  var flatNo;
  var zipCode;
  var createdAt;
  var updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['user_id'] = userId;
    map['type'] = type;
    map['address'] = address;
    map['flat_no'] = flatNo;
    map['zip_code'] = zipCode;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }
}
