import 'chat_reqpest_data.dart';

/// error : false
/// message : "success"
/// chat_reqpest_data : {"service_request":{"user_id":140,"provider_id":139,"is_quotation":true,"direct_contact":true,"updated_at":"2021-09-14T06:31:02.000000Z","created_at":"2021-09-14T06:31:02.000000Z","id":217},"chat_reqpest_message":{"service_request_id":217,"sender_id":140,"receiver_id":139,"message":12345667,"updated_at":"2021-09-14T06:31:02.000000Z","created_at":"2021-09-14T06:31:02.000000Z","id":183}}

class ChatReqpestResponse {
  var error;
  var message;
  var chatReqpestData;

  ChatReqpestResponse({this.error, this.message, this.chatReqpestData});

  ChatReqpestResponse.fromJson(dynamic json) {
    error = json["error"];
    message = json["message"];
    chatReqpestData =
        json["data"] != null ? ChatReqpestData.fromJson(json["data"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["error"] = error;
    map["message"] = message;
    if (chatReqpestData != null) {
      map["data"] = chatReqpestData?.toJson();
    }
    return map;
  }
}
