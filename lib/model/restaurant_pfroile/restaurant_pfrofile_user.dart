class RestaurantProfileUser {
  var id;
  var firstName;
  var lastName;
  var email;
  dynamic emailVerifiedAt;
  var phone;
  dynamic zipCode;
  var role;
  var status;
  var createdAt;
  var updatedAt;
  var phoneVerification;
  dynamic spendEachMonth;
  var providerType;
  dynamic image;
  dynamic bio;
  var accountType;
  dynamic deviceToken;
  dynamic credit;
  dynamic stripeId;
  dynamic cardBrand;
  dynamic cardLastFour;
  dynamic trialEndsAt;
  dynamic rating;
  dynamic serviceType;

  RestaurantProfileUser({
      this.id, 
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
      this.accountType, 
      this.deviceToken, 
      this.credit, 
      this.stripeId, 
      this.cardBrand, 
      this.cardLastFour, 
      this.trialEndsAt, 
      this.rating, 
      this.serviceType});

  RestaurantProfileUser.fromJson(dynamic json) {
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
    accountType = json["account_type"];
    deviceToken = json["device_token"];
    credit = json["credit"];
    stripeId = json["stripe_id"];
    cardBrand = json["card_brand"];
    cardLastFour = json["card_last_four"];
    trialEndsAt = json["trial_ends_at"];
    rating = json["rating"];
    serviceType = json["service_type"];
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
    map["phone_verification"] = phoneVerification;
    map["spend_each_month"] = spendEachMonth;
    map["provider_type"] = providerType;
    map["image"] = image;
    map["bio"] = bio;
    map["account_type"] = accountType;
    map["device_token"] = deviceToken;
    map["credit"] = credit;
    map["stripe_id"] = stripeId;
    map["card_brand"] = cardBrand;
    map["card_last_four"] = cardLastFour;
    map["trial_ends_at"] = trialEndsAt;
    map["rating"] = rating;
    map["service_type"] = serviceType;
    return map;
  }

}