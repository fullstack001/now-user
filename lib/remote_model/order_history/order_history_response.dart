import 'order_history_data.dart';
import 'links.dart';
import 'meta.dart';

class OrderHistoryResponse {
  OrderHistoryResponse({
    this.error,
    this.orderHistoryData,
    this.message,
    this.links,
    this.meta,
  });

  OrderHistoryResponse.fromJson(dynamic json) {
    error = json['error'];
    if (json['data'] != null) {
      orderHistoryData = [];
      json['data'].forEach((v) {
        orderHistoryData.add(OrderHistoryData.fromJson(v));
      });
    }
    message = json['message'];
    links = json['links'] != null ? Links.fromJson(json['links']) : null;
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }
  var error;
  var orderHistoryData;
  var message;
  var links;
  var meta;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = error;
    if (orderHistoryData != null) {
      map['order_history_data'] =
          orderHistoryData.map((v) => v.toJson()).toList();
    }
    map['message'] = message;
    if (links != null) {
      map['links'] = links.toJson();
    }
    if (meta != null) {
      map['meta'] = meta.toJson();
    }
    return map;
  }
}
