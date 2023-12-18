/// id : 3
/// first_name : "user"
/// last_name : "user"
/// email : "user2@site.com"
/// email_verified_at : null
/// phone : "+923008383978"
/// zip_code : "23423"
/// role : "USER"
/// status : "ACTIVE"
/// created_at : "2021-07-07T09:37:44.000000Z"
/// updated_at : "2021-07-07T09:37:44.000000Z"
/// phone_verification : 0
/// spend_each_month : null
/// provider_type : "Individual"

class UserData {
  var id;
  var firstName;
  var lastName;
  var email;
  dynamic emailVerifiedAt;
  var phone;
  var zipCode;
  var role;
  var status;
  var createdAt;
  var updatedAt;
  var phoneVerification;
  dynamic spendEachMonth;
  var providerType;
  var image;
  var bio;
  var service_type;
  var rating;
  var verifiedAt;

  UserData(
      {this.id,
      this.firstName,
      this.lastName,
      this.email,
      this.emailVerifiedAt,
      this.phone,
      this.zipCode,
      this.role,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.phoneVerification,
      this.spendEachMonth,
      this.providerType,
      this.image,
      this.bio,
      this.rating,
      this.verifiedAt});

  UserData.fromJson(dynamic json) {
    id = json["id"];
    firstName = json["first_name"];
    lastName = json["last_name"];
    email = json["email"];
    emailVerifiedAt = json["email_verified_at"];
    phone = json["phone"];
    zipCode = json["zip_code"];
    role = json["role"];
    status = json["status"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
    phoneVerification = json["phone_verification"];
    spendEachMonth = json["spend_each_month"];
    providerType = json["provider_type"];
    image = json["image"];
    bio = json["bio"];
    rating = json["rating"];
    verifiedAt = json["verfied_at"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["first_name"] = firstName;
    map["last_name"] = lastName;
    map["email"] = email;
    map["email_verified_at"] = emailVerifiedAt;
    map["phone"] = phone;
    map["zip_code"] = zipCode;
    map["role"] = role;
    map["status"] = status;
    map["created_at"] = createdAt;
    map["updated_at"] = updatedAt;
    map["rating"] = rating;
    map["phone_verification"] = phoneVerification;
    map["spend_each_month"] = spendEachMonth;
    map["provider_type"] = providerType;
    map["image"] = image;
    map["bio"] = bio;
    return map;
  }
}
