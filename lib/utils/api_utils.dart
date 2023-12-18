import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

bool chatOpen = false;

var shopType = "food_id";
String baseUrl = "https://api.farenow.com/api/";

class ApiUtills {
  // static final String imageBaseUrl = "https://api.farenow.com/";
  static final String imageBaseUrl = "https://api.farenow.com";

  static final String userOtp = "user/signup/email";
  static final String verifyOtp = "user/signup/email/verify";
  static final String userSignup = "user/signup";
  static final String login = "user/login";
  static final String mainServices = "user/get-menu";
  static final String serviceQuestions = "user/questions/";
  static final String providerList = "user/services/provider-list";
  static final String timmings = "user/services/provider-schedule/";

  static final String bookNow = "user/services/service-request";
  static final String orders = "user/order/list";
  static final String orderStatus = "user/order/status/";
  static String profileImage = 'user/profile-image';
  static String searchZipCodes = 'user/services/zip-code?zipCode=';
  static String userProfile = 'user/profile/';
  static String profileUpdate = 'user/update-profile/';
  static final String deviceToken = "user/device-token";
  static final String messageSent = "user/message/send";
  static final String inboxList = "user/message";
  static final String singleUserChat = "user/message/chat/";

  //shared preferences keys

  static final String userData = "user_date";
  static final String introData = "introData";
  static final String authToken = "authToken";

  //map keys
// final String mapKey = "AIzaSyA8qxfA7q_7adQ75SebuC2qgogFZ-I7FN8";
  static final String mapKey = "AIzaSyDM06VJYrW1xHW4F4zvL1Bt4lgcF7YgZ7U";
}

// String publishKey =
//     "pk_test_51JVYy7CiKsbMzZ4LLhJxG93Gzs85Vbet4WssQvrZQ69xlRdjzPZyAgtKjgbsgdaEyyamStfa1nlDNq0b3nKNxBBq00vXmoyr8R";
// String publicTestKey =
//     "pk_test_51JVYy7CiKsbMzZ4LLhJxG93Gzs85Vbet4WssQvrZQ69xlRdjzPZyAgtKjgbsgdaEyyamStfa1nlDNq0b3nKNxBBq00vXmoyr8R";
String publicTestKey = "pk_live_mePDN20Q0IGveSAXcs0UY9OL00rMI8gCdI";
String secretKey = "sk_test_IRu9dQ6ox09EjpiYxsS2dGkA00NLHP8ve1";
String merchantId = "test";
String paymentMode = "test";

TextStyle getStyle({fontSize, fontWeight, color}) {
  int size = fontSize ?? 14;
  return TextStyle(
    fontSize: size.toDouble(),
    fontWeight: fontWeight ?? FontWeight.normal,
    color: color ?? Colors.black,
  );
}

FormData formDataGet(Map<String, dynamic> body) {
  FormData data = FormData(body);
  return data;
}
