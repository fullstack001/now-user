import 'data.dart';

class AddressList {
  AddressList({
    this.error,
    this.data,
    this.message,
  });

  AddressList.fromJson(dynamic json) {
    if (json['error'] != null) {
      error = json['error'];
    }
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data.add(AddressData.fromJson(v));
      });
    }
    message = json['message'];
  }

  var error;
  var data;
  var message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = error;
    if (data != null) {
      map['data'] = data.map((v) => v.toJson()).toList();
    }
    map['message'] = message;
    return map;
  }
}
