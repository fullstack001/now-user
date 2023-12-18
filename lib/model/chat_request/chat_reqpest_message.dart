/// service_request_id : 217
/// sender_id : 140
/// receiver_id : 139
/// message : 12345667
/// updated_at : "2021-09-14T06:31:02.000000Z"
/// created_at : "2021-09-14T06:31:02.000000Z"
/// id : 183

class ChatReqpestMessage {
  var serviceRequestId;
  var  senderId;
  var  receiverId;
  var  message;
  var  updatedAt;
  var  createdAt;
  var  id;

  ChatReqpestMessage({
      this.serviceRequestId, 
      this.senderId, 
      this.receiverId, 
      this.message, 
      this.updatedAt, 
      this.createdAt, 
      this.id});

  ChatReqpestMessage.fromJson(dynamic json) {
    serviceRequestId = json["service_request_id"];
    senderId = json["sender_id"];
    receiverId = json["receiver_id"];
    message = json["message"];
    updatedAt = json["updated_at"];
    createdAt = json["created_at"];
    id = json["id"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["service_request_id"] = serviceRequestId;
    map["sender_id"] = senderId;
    map["receiver_id"] = receiverId;
    map["message"] = message;
    map["updated_at"] = updatedAt;
    map["created_at"] = createdAt;
    map["id"] = id;
    return map;
  }

}