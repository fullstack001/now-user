class CreditCardData {
  var id;
  var object;
  dynamic addressCity;
  dynamic addressCountry;
  dynamic addressLine1;
  dynamic addressLine1Check;
  dynamic addressLine2;
  dynamic addressState;
  dynamic addressZip;
  dynamic addressZipCheck;
  var brand;
  var country;
  var customer;
  var cvcCheck;
  dynamic dynamicLast4;
  var expMonth;
  var expYear;
  var fingerprint;
  var funding;
  var last4;
  var metadata;
  dynamic name;
  dynamic tokenizationMethod;

  CreditCardData(
      {this.id,
      this.object,
      this.addressCity,
      this.addressCountry,
      this.addressLine1,
      this.addressLine1Check,
      this.addressLine2,
      this.addressState,
      this.addressZip,
      this.addressZipCheck,
      this.brand,
      this.country,
      this.customer,
      this.cvcCheck,
      this.dynamicLast4,
      this.expMonth,
      this.expYear,
      this.fingerprint,
      this.funding,
      this.last4,
      this.metadata,
      this.name,
      this.tokenizationMethod});

  CreditCardData.fromJson(dynamic json) {
    id = json["id"];
    object = json["object"];
    addressCity = json["address_city"];
    addressCountry = json["address_country"];
    addressLine1 = json["address_line1"];
    addressLine1Check = json["address_line1_check"];
    addressLine2 = json["address_line2"];
    addressState = json["address_state"];
    addressZip = json["address_zip"];
    addressZipCheck = json["address_zip_check"];
    brand = json["brand"];
    country = json["country"];
    customer = json["customer"];
    cvcCheck = json["cvc_check"];
    dynamicLast4 = json["dynamic_last4"];
    expMonth = json["exp_month"];
    expYear = json["exp_year"];
    fingerprint = json["fingerprint"];
    funding = json["funding"];
    last4 = json["last4"];

    name = json["name"];
    tokenizationMethod = json["tokenization_method"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["object"] = object;
    map["address_city"] = addressCity;
    map["address_country"] = addressCountry;
    map["address_line1"] = addressLine1;
    map["address_line1_check"] = addressLine1Check;
    map["address_line2"] = addressLine2;
    map["address_state"] = addressState;
    map["address_zip"] = addressZip;
    map["address_zip_check"] = addressZipCheck;
    map["brand"] = brand;
    map["country"] = country;
    map["customer"] = customer;
    map["cvc_check"] = cvcCheck;
    map["dynamic_last4"] = dynamicLast4;
    map["exp_month"] = expMonth;
    map["exp_year"] = expYear;
    map["fingerprint"] = fingerprint;
    map["funding"] = funding;
    map["last4"] = last4;
    if (metadata != null) {
      map["metadata"] = metadata.map((v) => v.toJson()).toList();
    }
    map["name"] = name;
    map["tokenization_method"] = tokenizationMethod;
    return map;
  }
}
