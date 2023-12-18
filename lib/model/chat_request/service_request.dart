/// user_id : 140
/// provider_id : 139
/// is_quotation : true
/// direct_contact : true
/// updated_at : "2021-09-14T06:31:02.000000Z"
/// created_at : "2021-09-14T06:31:02.000000Z"
/// id : 217

class ServiceRequest {
  var  userId;
  var  providerId;
  var  isQuotation;
  var  directContact;
  var  updatedAt;
  var  createdAt;
  var  id;

  ServiceRequest({
      this.userId, 
      this.providerId, 
      this.isQuotation, 
      this.directContact, 
      this.updatedAt, 
      this.createdAt, 
      this.id});

  ServiceRequest.fromJson(dynamic json) {
    userId = json["user_id"];
    providerId = json["provider_id"];
    isQuotation = json["is_quotation"];
    directContact = json["direct_contact"];
    updatedAt = json["updated_at"];
    createdAt = json["created_at"];
    id = json["id"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["user_id"] = userId;
    map["provider_id"] = providerId;
    map["is_quotation"] = isQuotation;
    map["direct_contact"] = directContact;
    map["updated_at"] = updatedAt;
    map["created_at"] = createdAt;
    map["id"] = id;
    return map;
  }

}