/// first_name : "The first name field is required."
/// last_name : "The last name field is required."
/// zip_code : "The zip code field is required."
/// email : "The email field is required."
/// password : "The password field is required."
/// phone : "The phone field is required."

class SignupErrorsMessage {
  var firstName;
  var lastName;
  var zipCode;
  var email;
  var password;
  var phone;
  var userName;
  var image;
  var bio;
  var rating;

  SignupErrorsMessage({
    this.firstName,
    this.lastName,
    this.zipCode,
    this.email,
    this.password,
    this.phone,
    this.userName,
    this.image,
    this.bio,
    this.rating,
  });

  SignupErrorsMessage.fromJson(dynamic json) {
    firstName = json["first_name"];
    lastName = json["last_name"];
    zipCode = json["zip_code"];
    email = json["email"];
    password = json["password"];
    phone = json["phone"];
    userName = json["user_name"];
    image = json["image"];
    bio = json["bio"];
    rating = json["rating"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["first_name"] = firstName;
    map["last_name"] = lastName;
    map["zip_code"] = zipCode;
    map["email"] = email;
    map["password"] = password;
    map["phone"] = phone;
    map["user_name"] = userName;
    map["image"] = image;
    map["rating"] = rating;
    map["bio"] = bio;
    return map;
  }
}
