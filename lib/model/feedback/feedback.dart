class FeedBack {
  var id;
  var userId;
  var providerId;
  var serviceRequestId;
  var comment;
  var rating;
  var createdAt;
  var updatedAt;

  var firstName;
  var lastName;
  var image;

  FeedBack({
    this.id,
    this.userId,
    this.providerId,
    this.serviceRequestId,
    this.comment,
    this.rating,
    this.createdAt,
    this.updatedAt,
    this.lastName,
    this.firstName,
    this.image,
  });

  FeedBack.fromJson(dynamic json) {
    if (json['user'] != null) {
      firstName = json['user']["first_name"];
      lastName = json['user']["last_name"];
      image = json['user']["image"];
    }
    id = json["id"];
    userId = json["user_id"];
    providerId = json["provider_id"];
    serviceRequestId = json["service_request_id"];
    comment = json["comment"];
    rating = json["rating"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["user_id"] = userId;
    map["provider_id"] = providerId;
    map["service_request_id"] = serviceRequestId;
    map["comment"] = comment;
    map["rating"] = rating;
    map["created_at"] = createdAt;
    map["updated_at"] = updatedAt;
    return map;
  }
}
