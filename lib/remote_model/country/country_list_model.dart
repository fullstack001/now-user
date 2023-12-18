
import 'country_data.dart';

class CountryListModel {
  CountryListModel({
      this.error, 
      this.message, 
      this.data,});

  CountryListModel.fromJson(dynamic json) {
    error = json['error'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(CountryData.fromJson(v));
      });
    }
  }
  bool? error;
  String? message;
  List<CountryData>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = error;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}