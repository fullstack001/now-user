import 'dart:convert';

import 'package:application_1/AllPages/RegisteraionPages/models/signin_model/sign_response.dart';
import 'package:application_1/model/prediction/prediction_respnse.dart';
import 'package:application_1/utils/api_utils.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:http/retry.dart';

class Services {
  static var client = RetryClient(http.Client());

  Future signin() async {
    return null;
  }

  Future signup() async {
    return null;
  }

  Future<dynamic> otp(String number) async {
    var _body = FormData.fromMap({'phone': number});

    String url = baseUrl + ApiUtills.userOtp;
    var response = await client.post(Uri.parse(url), body: _body);

    return null;
  }

  Future<PredictionResponse?> searchPlaceByZip(String query) async {
    String places =
        "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$query&key=${ApiUtills.mapKey}&sessiontoken=1234567890";

    var searchClient = RetryClient(http.Client());
    try {
      http.Response response = await searchClient.post(Uri.parse(places));
      PredictionResponse parse =
          PredictionResponse.fromJson(jsonDecode(response.body));

      return parse;
    } catch (e) {
      return null;
    } finally {
      searchClient.close();
    }
  }
}
