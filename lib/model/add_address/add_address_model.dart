class AddAddressModel {
  AddAddressModel({
    this.type,
    this.address,
    this.flatNo,
    this.zipCode,
  });

  AddAddressModel.fromJson(dynamic json) {
    type = json['type'];
    address = json['address'];
    flatNo = json['flat_no'];
    zipCode = json['zip_code'];
  }
  var type;
  var address;
  var flatNo;
  var zipCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = type;
    map['address'] = address;
    map['flat_no'] = flatNo;
    map['zip_code'] = zipCode;
    return map;
  }
}
