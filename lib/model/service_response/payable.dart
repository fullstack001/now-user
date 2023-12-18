class Payable {
  var id;
  dynamic providerId;
  var userId;
  dynamic paymentId;
  var amount;
  dynamic amountCaptured;
  var status;
  dynamic paymentMethod;
  var createdAt;
  var updatedAt;
  var serviceRequestId;
  dynamic isCredit;
  var isPayable;

  Payable({
      this.id, 
      this.providerId, 
      this.userId, 
      this.paymentId, 
      this.amount, 
      this.amountCaptured, 
      this.status, 
      this.paymentMethod, 
      this.createdAt, 
      this.updatedAt, 
      this.serviceRequestId, 
      this.isCredit, 
      this.isPayable});

  Payable.fromJson(dynamic json) {
    id = json["id"];
    providerId = json["provider_id"];
    userId = json["user_id"];
    paymentId = json["payment_id"];
    amount = json["amount"];
    amountCaptured = json["amount_captured"];
    status = json["status"];
    paymentMethod = json["payment_method"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
    serviceRequestId = json["service_request_id"];
    isCredit = json["is_credit"];
    isPayable = json["is_payable"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["provider_id"] = providerId;
    map["user_id"] = userId;
    map["payment_id"] = paymentId;
    map["amount"] = amount;
    map["amount_captured"] = amountCaptured;
    map["status"] = status;
    map["payment_method"] = paymentMethod;
    map["created_at"] = createdAt;
    map["updated_at"] = updatedAt;
    map["service_request_id"] = serviceRequestId;
    map["is_credit"] = isCredit;
    map["is_payable"] = isPayable;
    return map;
  }

}