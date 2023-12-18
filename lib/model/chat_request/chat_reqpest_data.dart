import 'chat_reqpest_message.dart';
import 'service_request.dart';

/// service_request : {"user_id":140,"provider_id":139,"is_quotation":true,"direct_contact":true,"updated_at":"2021-09-14T06:31:02.000000Z","created_at":"2021-09-14T06:31:02.000000Z","id":217}
/// chat_reqpest_message : {"service_request_id":217,"sender_id":140,"receiver_id":139,"message":12345667,"updated_at":"2021-09-14T06:31:02.000000Z","created_at":"2021-09-14T06:31:02.000000Z","id":183}

class ChatReqpestData {
  var serviceRequest;
  var chatReqpestMessage;

  ChatReqpestData({this.serviceRequest, this.chatReqpestMessage});

  ChatReqpestData.fromJson(dynamic json) {
    serviceRequest = json["service_request"] != null
        ? ServiceRequest.fromJson(json["service_request"])
        : null;
    chatReqpestMessage = json["message"] != null
        ? ChatReqpestMessage.fromJson(json["message"])
        : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (serviceRequest != null) {
      map["service_request"] = serviceRequest?.toJson();
    }
    if (chatReqpestMessage != null) {
      map["message"] = chatReqpestMessage?.toJson();
    }
    return map;
  }
}
