import 'dart:convert';
import 'dart:io';

import 'package:application_1/components/buttons-management/part_of_file/part.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'package:application_1/AllPages/RegisteraionPages/models/otp_verification/otp_verification_reponse.dart';
import 'package:application_1/AllPages/RegisteraionPages/models/signin_model/sign_response.dart';
import 'package:application_1/AllPages/RegisteraionPages/models/user_signup_model/user_signup_response.dart';
import 'package:application_1/All_Refrences/shared_refrence.dart';
import 'package:application_1/model/active_orders_resp/active_orders_response.dart';
import 'package:application_1/model/add_address/address_list.dart';
import 'package:application_1/model/add_address/data.dart';
import 'package:application_1/model/card/credit_card_model.dart';
import 'package:application_1/model/chat/user_chat_response.dart';
import 'package:application_1/model/chat_request/chat_reqpest_response.dart';
import 'package:application_1/model/feedback/feedback_response.dart';
import 'package:application_1/model/order_status/order_status_response.dart';
import 'package:application_1/model/postal_code/Postal_code_response.dart';
import 'package:application_1/model/provider_time_slots/provider_timeslots_response.dart';
import 'package:application_1/model/service_response/service_response.dart';
import 'package:application_1/model/vehicle_list/vehicle_response.dart';
import 'package:application_1/model/zip_search/zip_search_response.dart';
import 'package:application_1/remote_model/country/Country_list_model.dart';
import 'package:application_1/remote_model/main_services/main_services_response.dart';
import 'package:application_1/remote_model/provider_list/complete_and_ongoing_model.dart';
import 'package:application_1/remote_model/provider_list/feedback_reviews_list_model.dart';
import 'package:application_1/remote_model/provider_list/provider_list_response_model.dart';
import 'package:application_1/remote_model/provider_list/provider_profile_detail_model.dart';
import 'package:application_1/remote_model/service_questions/service_question_questions.dart';
import 'package:application_1/remote_model/service_questions/service_question_response.dart';
import 'package:application_1/screens/subscription/model/subscribe_plan.dart';
import 'package:application_1/utils/AppString.dart';
import 'package:application_1/utils/api_utils.dart';
import 'package:application_1/utils/app_dialog_utils.dart';
import 'package:http/retry.dart';

class ServiceReposiotry {
  Map<String, String> requestHeaders = {
    // 'Content-type': 'application/json',
    // 'Accept': 'application/json',
  };
  static var client = GetHttpClient(baseUrl: baseUrl);

  Uri setUrl(String url) {
    return Uri.parse(baseUrl + url);
  }

  Future<http.Response?> getFarenowRequest(url, {headers}) async {
    var farenowHttpClient = RetryClient(http.Client());
    http.Response response;
    try {
      if (headers == null) {
        response = await farenowHttpClient.get(setUrl(url));
      } else {
        response = await farenowHttpClient.get(setUrl(url), headers: headers);
      }
      return response;
    } catch (e) {
      if (kDebugMode) {
        Get.rawSnackbar(
            message: "USER Exception form API GET method $url ${e.toString()}",
            duration: const Duration(seconds: 3));
      }
      debugPrint(e.toString());
      ServiceReposiotry()
          .logApi("USER Exception Form API GET method $url ${e.toString()}");

      return null;
    } finally {
      farenowHttpClient.close();
    }
  }

  Future<http.Response?> postFarenowRequest(url,
      {body, headers, encodeBody}) async {
    var farenowHttpClient = RetryClient(http.Client());
    http.Response response;
    try {
      if (headers == null) {
        response =
            await farenowHttpClient.post(setUrl(url), body: encodeBody ?? body);
      } else {
        response = await farenowHttpClient.post(setUrl(url),
            body: encodeBody ?? body, headers: headers);
      }
      return response;
    } catch (e) {
      if (kDebugMode) {
        Get.rawSnackbar(
            message: "USER Exception form API POST method ${e.toString()}",
            duration: const Duration(seconds: 3));
      }

      debugPrint(e.toString());
      ServiceReposiotry()
          .logApi("USER Exception form API POST method $url ${e.toString()}");
      return null;
    } finally {
      farenowHttpClient.close();
    }
  }

  Future signin() async => await signin();

  Future signup() async => await signup();

  Future<SignResponse?> otp(String number) async {
    try {
      Map<String, dynamic> mapbody = <String, dynamic>{"email": number};

      http.Response? response =
          await postFarenowRequest(ApiUtills.userOtp, body: mapbody);

      if (response != null) {
        SignResponse? parseData;
        var body = jsonDecode(response.body);
        if (body['error'] != null) {
          if (body['error']) {
            parseData = SignResponse.fromError(body);
          } else {
            parseData = SignResponse.fromJson(body);
          }
        }

        return parseData;
      }
      return null;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future userDetails() async => userDetails();

  Future<OtpVerificationResponse?> otpVerify(String otp, String userNumber,
      {bool forgetPassword = false}) async {
    Map<String, dynamic> mapbody = <String, dynamic>{
      "email": userNumber,
      "otp": otp,
      "for_password": "$forgetPassword"
    };
    try {
      http.Response? response =
          await postFarenowRequest(ApiUtills.verifyOtp, body: mapbody);
      if (response != null) {
        OtpVerificationResponse parseData =
            OtpVerificationResponse.fromJson(jsonDecode(response.body));

        return parseData;
      }
      return null;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<UserSignupResponse?> signUpUser(
      Map<String, dynamic> mapbody, edit, id) async {
    try {
      String filter = ApiUtills.userSignup;
      Map<String, String> mapHeader = {};
      if (edit) {
        String token =
            await SharedRefrence().getString(key: ApiUtills.authToken);

        mapHeader['Authorization'] = token;

        filter = ApiUtills.profileUpdate + id.toString();
      }
      http.Response? response =
          await postFarenowRequest(filter, body: mapbody, headers: mapHeader);
      if (response != null) {
        var body = jsonDecode(response.body);
        UserSignupResponse parseData;
        if (body['error']) {
          parseData = UserSignupResponse.errorJson(body);
        } else {
          if (edit) {
            parseData = UserSignupResponse.userProfile(body);
          } else {
            parseData = UserSignupResponse.fromJson(body);
          }
        }

        return parseData;
      }
      return null;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<UserSignupResponse?> login(Map<String, dynamic> _body) async {
    try {
      String filter = ApiUtills.login;
      String url = baseUrl + filter;
      print("API:" + url);
      // var response = await client.post(filter, body: _body);
      http.Response? response = await postFarenowRequest(filter, body: _body);
      if (response != null) {
        if (response.body == null) {
          return login(_body);
        }
        // print("login response ${response.body}");
        UserSignupResponse parseData;
        var body = jsonDecode(response.body);
        if (body['error']) {
          if (body['message'].runtimeType == String) {
            parseData = UserSignupResponse.fromJson(body);
          } else {
            parseData = UserSignupResponse.errorJson(body);
          }
        } else {
          parseData = UserSignupResponse.fromJson(body);
        }
        // if (response.body['error']) {
        //   if (response.body['message'].runtimeType == String) {
        //     parseData = UserSignupResponse.fromJson(response.body);
        //   } else {
        //     parseData = UserSignupResponse.errorJson(response.body);
        //   }
        // } else {
        //   parseData = UserSignupResponse.fromJson(response.body);
        // }

        return parseData;
      }
      return null;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<MainServicesResponse?> getMainServices() async {
    // String filter = ApiUtills.mainServices;
    // String url = baseUrl + filter;
    // print("API:" + url);

    // var response = await getRequest(filter);
    try {
      http.Response? response = await getFarenowRequest(ApiUtills.mainServices);

      if (response != null) {
        MainServicesResponse parseData;

        parseData = MainServicesResponse.fromJson(jsonDecode(response.body));

        print("main service response ${response.body}");
        return parseData;
      }
      return null;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<ServiceQuestionResponse> getQuestions(int id) async {
    String filter = ApiUtills.serviceQuestions + id.toString();
    String url = baseUrl + filter;
    print("API:" + url);

    var response = await client.get(filter);
    print(response.body);
    // UserSignupResponse parseData = UserSignupResponse.fromJson(response.body);
    ServiceQuestionResponse parseData;

    parseData = ServiceQuestionResponse.fromJson(response.body);

    print("main service response ${response.body}");
    return parseData;
  }

  Future<ProviderListResponse?> getProviderListFilter(zipCode,
      {moving = false,
      vId,
      cityId,
      countryId,
      subServiceId,
      hourly,
      quotation,
      start_slot,
      end_slot,
      rating}) async {
    // String filter = ApiUtills.providerList + "?zipCode=4545";
    try {
      String filter = ApiUtills.providerList + "?zipCode=$zipCode";

      if (subServiceId != null) {
        filter = filter + "&subService=$subServiceId";
      }
      if (hourly) {
        filter = filter + "&hourly=true";
      }

      if (quotation) {
        filter = filter + "&quotation=true";
      }
      if (0 < rating) {
        filter = filter + "&rating=$rating";
      }
      if (start_slot != "" && end_slot != "") {
        String _date =
            DateFormat("yyyy-M-dd").format(DateTime.now()).toString();

        filter = filter + "&slot[0]=$start_slot&slot[1]=$end_slot&date=$_date";
      }

      if (moving) {
        //&vehicle_type_id=$vId
        filter =
            "user/provider/list?zipCode=${zipCode.toString().replaceAll(" ", "%20")}&service_type=MOVING&vehicle_type_id=$vId";
      }
      http.Response? response = await getFarenowRequest(filter);
      if (response != null) {
        ProviderListResponse parseData;

        parseData = ProviderListResponse.fromJson(jsonDecode(response.body));

        return parseData;
      } else {
        return null;
      }
    } catch (e) {
      print(e.toString());
      ServiceReposiotry().logApi(e.toString());
      return ProviderListResponse(
          error: true, message: "Exception from Ui ${e.toString()}");
    }
  }

  // Future<ProviderTimeslotsResponse> getServiceTimmings(
  //     String authToken, String id) async {
  //   // var re = await scheduleTimes(authToken);
  //   String filter = ApiUtills.timmings + id;
  //   String url = baseUrl + filter;
  //   requestHeaders['Authorization'] = authToken;
  //   print(" API:" + url);
  //   print(" Bearer Token :" + authToken);
  //   var response = await client.get(
  //     filter,
  //     headers: requestHeaders,
  //   );
  //   ProviderTimeslotsResponse parseData;
  //   var resp = json.encode(response.body);
  //   parseData = ProviderTimeslotsResponse.fromJson(response.body);

  //   print("body ${response.bodyString}");
  //   return parseData;
  // }

  Future<FeedbackReviewsList?> getProviderProfileReviews(id) async {
    String filter = "user/feedback?provider_id=$id";

    try {
      http.Response? response = await getFarenowRequest(filter);
      if (response != null) {
        FeedbackReviewsList parseData;
        parseData = FeedbackReviewsList.fromJson(jsonDecode(response.body));

        return parseData;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<CompleteAndOngoingServices?> getCompleteAndOngoingServices(
      {id}) async {
    String filter = "user/service-request?provider_id=$id";

    try {
      http.Response? response = await getFarenowRequest(filter);
      if (response != null) {
        CompleteAndOngoingServices parseData;
        parseData =
            CompleteAndOngoingServices.fromJson(jsonDecode(response.body));

        return parseData;
      }
      return null;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<ProviderProfileCompleteDetail?> getProviderProfileData(
      String authToken, String id) async {
    String filter = "user/provider/$id";
    try {
      requestHeaders['Authorization'] = authToken;
      http.Response? response =
          await getFarenowRequest(filter, headers: requestHeaders);
      if (response != null) {
        ProviderProfileCompleteDetail parseData;
        parseData =
            ProviderProfileCompleteDetail.fromJson(jsonDecode(response.body));
        return parseData;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<ProviderTimeslotsResponse> bookNow(String authToken, body,
      {home, orderId, imageList}) async {
    Dio dio = Dio();

    var multiPartList = [];
    if ((imageList ?? []).length > 1) {
      for (int index = 0; index < imageList.length; index++) {
        if (imageList[index].path != "null") {
          var file = await getMultiPart(imageList[index]);
          multiPartList.add(file);
        }
      }
    }
    bool isHome = home ?? false;
    json.encode(body);
    String filter = ApiUtills.bookNow;
    if (isHome) {
      filter = "user/services/update-service-request/${orderId.toString()}";
    }
    String url = baseUrl + filter;
    requestHeaders['Authorization'] = "$authToken";

    ProviderTimeslotsResponse parseData;
    if (multiPartList.isNotEmpty) {
      body["is_hourly"] = 0;
      body['images[]'] = multiPartList;
      var formData = getFormData(body);

      Options options = Options();
      options.headers = {'Authorization': authToken};

      var respons = await dio.post(url, data: formData, options: options);

      parseData = ProviderTimeslotsResponse.fromJson(respons.data);

      return parseData;
    }

    var res = await client.post(filter, headers: requestHeaders, body: body);

    parseData = ProviderTimeslotsResponse.fromJson(res.body);

    return parseData;
  }

  Future<ServiceResponse?> getAvailableJobs(String authToken) async {
    try {
      String filter = ApiUtills.orders;

      requestHeaders['Authorization'] = "$authToken";

      http.Response? response =
          await getFarenowRequest(filter, headers: requestHeaders);

      if (response != null) {
        ServiceResponse parseData;

        parseData = ServiceResponse.fromJson(jsonDecode(response.body));

        return parseData;
      }
      return null;
    } catch (e) {
      print(e.toString());
      return ServiceResponse(error: true);
    }
  }

  Future<dynamic> updateStatus(String authToken, int id, String status) async {
    String filter = ApiUtills.orderStatus + id.toString();
    requestHeaders['Authorization'] = authToken;
    Map<String, dynamic> body = <String, dynamic>{
      "status": status,
    };
    http.Response? response =
        await postFarenowRequest(filter, body: body, headers: requestHeaders);
    if (response != null) {
      return response.body;
    }
    return null;
  }

  Future<String?> uploadImage({imag}) async {
    try {
      String filter = ApiUtills.profileImage;
      String url = baseUrl + filter;
      Dio dio = Dio();
      var multiPrt = await getMultiPart(imag);
      Map body = <String, dynamic>{"image": multiPrt};
      var formData = getFormData(body);
      var response = await dio.post(url, data: formData);
      var imagePath;
      if (!response.data['error'] && response.data['message'] == 'OK') {
        imagePath = response.data['data'];
      }
      return imagePath;
    } catch (e) {
      return null;
    }
  }

  Future<ZipSearchResponse> searchZipCode(
    String zipCode,
    pageSize, {
    moving = false,
    subId,
    cityId,
    countryId,
  }) async {
    // String filter = "user/services/zip-code?zipCode=$zipCode";
    //To-Do
    print("moving $moving");
    String filter = ApiUtills.searchZipCodes +
        zipCode +
        "&page=1&sub_service_id=$subId&city=$cityId&country=$countryId";
    // if (moving != null) {
    //   filter = "user/provider/list?zipCode=$zipCode&service_type=MOVING";
    // }
    if (moving) {
      filter =
          ApiUtills.searchZipCodes + zipCode + "&page=1&vehicle_type_id=$subId";
    }
    String url = baseUrl + filter;
    print(" API:" + url);
    var response = await client.get(filter);
    ZipSearchResponse parseData;
    var resp = json.encode(response.body);
    parseData = ZipSearchResponse.fromJson(response.body);

    print("body ${response.bodyString}");
    return parseData;
  }

  getQuestionsObj(List<ServiceQuestionQuestions> question) {
    String questionString = "";
    for (int index = 0; index < question.length; index++) {
      String qt =
          "\"question_${index + 1}\":${question[index].id}${question.length > 1 ? "," : ""}";
      questionString = questionString + qt;
    }
    String result = "{${questionString.trim()}}";
    return result;
  }

  Future<UserSignupResponse?> getUserProfile(int id) async {
    String filter = ApiUtills.userProfile + id.toString();

    try {
      http.Response? response = await getFarenowRequest(filter);
      if (response != null) {
        var body = jsonDecode(response.body);
        UserSignupResponse parseData;
        if (body['error']) {
          parseData = UserSignupResponse.errorJson(body);
        } else {
          parseData = UserSignupResponse.userProfile(body);
        }

        return parseData;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  uploadToken(String token, String authToken, platform) async {
    String filter = ApiUtills.deviceToken;

    debugPrint("Token $authToken");
    Map<String, dynamic> _body = <String, dynamic>{
      "device_token": "$token",
      "os_platform": "$platform",
    };
    await postFarenowRequest(filter,
        body: _body, headers: {"Authorization": authToken});
  }

  sendMessage(body, {authToken, count = 0}) async {
    String filter = ApiUtills.messageSent;
    String url = baseUrl + filter;
    requestHeaders["Authorization"] = authToken;
    http.Response? response =
        await postFarenowRequest(filter, body: body, headers: requestHeaders);

    if (count == 2) {
      return;
    }
    // if (response != null) {
    //   count += 1;
    //   return await sendMessage(authToken: authToken, body);
    // }
  }

  Future<ActiveOrdersResponse?> getInboxList({authToken}) async {
    String filter = "user/message/active-order-chat";

    try {
      requestHeaders['Authorization'] = authToken;

      http.Response? response =
          await getFarenowRequest(filter, headers: requestHeaders);
      if (response != null) {
        ActiveOrdersResponse parseData =
            ActiveOrdersResponse.fromJson(jsonDecode(response.body));
        return parseData;
      }
      return null;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<UserChatResponse?> getUserChat({authToken, id, page, orderId}) async {
    String filter = "user/message/chat/$id?service_request_id=$orderId";

    if (page != null) {
      filter = filter + "?page=$page";
    }

    try {
      requestHeaders['Authorization'] = authToken;

      http.Response? response =
          await getFarenowRequest(filter, headers: requestHeaders);

      if (response != null) {
        UserChatResponse parseData =
            UserChatResponse.fromJson(jsonDecode(response.body));
        return parseData;
      }
      return null;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<ChatReqpestResponse?> sendChatRequest(
      String authToken, body, List<ServiceQuestionQuestions> question) async {
    String filter = "user/services/direct-contact";

    await getToken();
    try {
      requestHeaders['Content-type'] = "application/json";
      http.Response? response = await postFarenowRequest(filter,
          encodeBody: json.encode(body), headers: requestHeaders);
      if (response != null) {
        ChatReqpestResponse parseData =
            ChatReqpestResponse.fromJson(jsonDecode(response.body));
        return parseData;
      }
      return null;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<bool> checkDues(String authToken) async {
    String filter = "user/transaction/payable";
    String url = baseUrl + filter;
    print(" API:" + url);
    requestHeaders['Authorization'] = authToken;
    var response = await client.get(filter, headers: requestHeaders);
    bool flag = false;

    if (response.body['error']) {
      if (response.body['message'] != "don't any dues") {
        flag = true;
      }
    }

    return flag;
  }

  Future<dynamic> sendFeedback({authToken, body}) async {
    String filter = "user/feedback/create";

    requestHeaders['Authorization'] = authToken;

    var response =
        await client.post(filter, headers: requestHeaders, body: body);
    return response;
  }

  Future<dynamic> getFeedback({authToken, id}) async {
    try {
      String filter = "user/provider/$id";

      String url = baseUrl + filter;

      requestHeaders['Authorization'] = authToken;

      http.Response? response =
          await getFarenowRequest(filter, headers: requestHeaders);
      if (response != null) {
        var json = jsonDecode(response.body);
        FeedbackResponse feed = FeedbackResponse.fromJson(json['data']);
        return feed.feedback;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  payDueAmount(String authToken, Map<dynamic, dynamic> body) async {
    String filter = "user/transaction/payable-amount";

    String url = baseUrl + filter;
    print(" API:" + url);
    requestHeaders['Authorization'] = authToken;
    print("Token $authToken");
    print(" API:" + url);
    var response =
        await client.post(filter, headers: requestHeaders, body: body);
    return response.body;
  }

  Future<dynamic> cancelRequest(String authToken, String id) async {
    String filter = "user/order/cancel/$id";

    String url = baseUrl + filter;
    print(" API:" + url);
    requestHeaders['Authorization'] = authToken;
    print("Token $authToken");
    print(" API:" + url);
    var response = await client.get(filter, headers: requestHeaders);
    return response.body;
  }

  Future<VehicleResponse> getVheicleList() async {
    String filter = "user/vehicle/types";
    String url = baseUrl + filter;
    var response = await client.get(filter, headers: requestHeaders);
    VehicleResponse parseData = VehicleResponse.fromJson(response.body);

    return parseData;
  }

  Future<dynamic> bookDriver(Map body, String authToken) async {
    String filter = "user/order/move-request";

    String url = baseUrl + filter;

    requestHeaders['Authorization'] = authToken;
    print("Token $authToken");
    print(" API:" + url);
    var response =
        await client.post(filter, headers: requestHeaders, body: body);
    return response.body['message'] == "OK" ? true : false;
  }

  Future<dynamic> saveCard(String tokenId) async {
    try {
      await getToken();
      String filter = "user/card/store";
      Map<String, dynamic> body = <String, dynamic>{
        "token": tokenId,
      };

      http.Response? response =
          await postFarenowRequest(filter, body: body, headers: requestHeaders);

      if (response != null) {
        return jsonDecode(response.body);
      }

      return null;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<CreditCardModel?> getCards() async {
    try {
      await getToken();
      String filter = "user/card";

      http.Response? response =
          await getFarenowRequest(filter, headers: requestHeaders);

      if (response != null) {
        CreditCardModel model =
            CreditCardModel.fromJson(jsonDecode(response.body));

        return model;
      }
      return null;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  getToken() async {
    String authToken =
        await SharedRefrence().getString(key: ApiUtills.authToken);
    requestHeaders['Authorization'] = authToken;
    print("$authToken");
  }

  Future<dynamic> postRequest(String filter, Map body) async {
    await getToken();
    String url = baseUrl + filter;
    json.encode(body);
    print(url);
    var response =
        await client.post(filter, headers: requestHeaders, body: body);
    if (response.body == null) {
      return await postRequest(filter, body);
    }
    return response;
  }

  Future<dynamic> getRequest(String filter, {count = 0}) async {
    await getToken();
    String url = baseUrl + filter;
    print(url);
    var response = await client.get(filter, headers: requestHeaders);
    if (count == 2) {
      return;
    }
    count += 1;
    if (response.body == null) {
      return await getRequest(filter, count: count);
    }
    return response;
  }

  Future<AddressData> saveAddress(Map<String, dynamic> body) async {
    String filter = "user/address/store";
    var response = await postRequest(filter, body);
    AddressData parseData = AddressData.fromJson(response.body['data']);
    return parseData;
  }

  Future<AddressList> getAddress() async {
    String filter = "user/address";
    var response = await getRequest(filter);

    AddressList parseData = AddressList.fromJson(response.body);

    return parseData;
  }

  Future<dynamic> createOrder(body) async {
    String filter = "user/order/create";
    var response = await postRequest(filter, body);
    return response.body;
  }

  Future<bool> deleteCard({id}) async {
    String filter = "user/card/delete/$id";
    var response = await deleteRequest(filter);

    if (!response.body["error"] && response.body["message"] == "OK") {
      return true;
    }

    return false;
  }

  Future<bool> deleteAddress({id}) async {
    String filter = "user/address/delete/$id";
    var response = await deleteRequest(filter);

    if (!response.body["error"] &&
        response.body["message"].toString().toLowerCase() ==
            "Address deleted successfully".toLowerCase()) {
      return true;
    }

    return false;
  }

  deleteRequest(String filter, {count}) async {
    await getToken();
    String url = baseUrl + filter;
    print(url);
    var response = await client.delete(filter, headers: requestHeaders);
    if (count == 2) {
      count = count + 1;
      return;
    }
    if (response.body == null) {
      return await getRequest(filter);
    }
    return response;
  }

  Future<OrderStatusResponse> getOrderStatus(String authToken, id) async {
    String filter = "user/order/worked-status";

    Map body = <String, dynamic>{"service_request_id": id};
    String url = baseUrl + filter;
    print(" API:" + url);
    requestHeaders['Authorization'] = authToken;
    print("Token $authToken");
    print(" API:" + url);
    var response =
        await client.post(filter, headers: requestHeaders, body: body);
    print("result ${response.bodyString}");
    OrderStatusResponse parseData = OrderStatusResponse.fromJson(response.body);
    return parseData;
  }

  Future<bool> userAvailable(String id) async {
    String filter = "is-user/$id";
    print("${baseUrl}$filter");
    var response = await getRequest(filter);
    if (!response.body['error'] && response.body['message'] == "User found") {
      return true;
    }
    return false;
  }

  Future<CountryListModel?> getCountryList() async {
    try {
      String filter = "user/services/countries";
      print("${baseUrl}$filter");
      http.Response? response = await getFarenowRequest(filter);

      if (response != null) {
        CountryListModel parseData =
            CountryListModel.fromJson(jsonDecode(response.body));
        return parseData;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<dynamic> forgetPassword({body}) async {
    String filter = "user/forgot-password";
    print("${baseUrl}$filter");

    var response = await postRequest(filter, body);
    print(response.body);
    return response.body;
  }

  Future<dynamic> changePassword(
      String password, String confirmPassword, number, token,
      {isPhone = false}) async {
    String filter = "user/change-password";
    print("${baseUrl}$filter");
    Map<String, dynamic> body;

    body = {
      "token": token,
      "email": number,
      "password": password,
      "password_confirmation": confirmPassword,
    };

    var response = await postRequest(filter, body);
    return response.body;
  }

  Future<UserSignupResponse> socialLogin(String provider, body) async {
    String filter = "user/login/$provider/callback";

    var response = await postRequest(filter, body);

    print("${response.bodyString}");
    UserSignupResponse parseData;
    if (response.statusCode == 200 && response.body['message'] == "success") {
      parseData = UserSignupResponse.fromJson(response.body);
    } else {
      parseData = UserSignupResponse.fromJson(response.body);
    }
    return parseData;
  }

  Future<PostalCodeResponse?> searchPlaceByZip(String query) async {
    String places =
        "https://maps.googleapis.com/maps/api/geocode/json?address=$query&key=${ApiUtills.mapKey}";
    var searchClient = RetryClient(http.Client());
    try {
      http.Response response = await searchClient.post(Uri.parse(places));
      PostalCodeResponse parse =
          PostalCodeResponse.fromJson(jsonDecode(response.body));
      return parse;
    } catch (e) {
      return null;
    } finally {
      searchClient.close();
    }
  }

  Future<SubscribePlans> getSubscribePackage({authToken}) async {
    String filter = "user/plan";

    String url = baseUrl + filter;
    print(" API:" + url);
    requestHeaders['Authorization'] = authToken;
    print("Token $authToken");
    print(" API:" + url);
    var response = await client.get(filter, headers: requestHeaders);
    if (response.body == null) {
      return await getSubscribePackage(authToken: authToken);
    }
    SubscribePlans result = SubscribePlans.fromJson(response.body);
    return result;
  }

  resendotp(String email) async {
    // client.baseUrl = baseUrl;
    Map _body = <String, dynamic>{"email": email};
    String url = baseUrl + "user/resend-otp";

    print("OTP API:" + url);
    var response = await http.post(
        Uri.parse("https://api.farenow.com/api/user/resend-otp"),
        body: _body);
    print("${response.body}");
    var result = jsonDecode(response.body);
    if (result["error"] != null) {
      if (result['error']) {
        AppDialogUtils.errorDialog(result["message"]);
      } else {
        AppDialogUtils.successDialog(result["message"]);
      }
    }
    AppDialogUtils.dismiss();
  }

  Future<String?> deletePackagePlan({id, authToken}) async {
    try {
      String filter = "user/plan/cancel/$id";

      String url = baseUrl + filter;

      requestHeaders['Authorization'] = authToken;
      http.Response? response =
          await getFarenowRequest(filter, headers: requestHeaders);
      if (response != null) {
        return response.body;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  void logApi(String exception) async {
    final body = "User ${GetPlatform.isAndroid ? "Android" : "IOS"}";

    final error = {"file_name": "user provider", "message": exception};

    await http.post(
      Uri.parse(
          "https://api.farenow.com/api/logs?mobile_type=$body&errors[]=$error"),
    );
  }

  Future<ProviderListResponse> getProviderList(
      {moving = false,
      vId,
      cityId,
      countryId,
      subServiceId,
      placeId,
      zipCode}) async {
    String filter;
    if (placeId == null) {
      filter = ApiUtills.providerList + "?zipCode=$zipCode";
    } else {
      filter = ApiUtills.providerList + "?place_id=$placeId";
    }

    if (subServiceId != null) {
      filter = filter + "&sub_service=$subServiceId";
    }

    // if (moving) {
    //   //&vehicle_type_id=$vId
    //   filter =
    //       "user/provider/list?zipCode=${zipCode.toString().replaceAll(" ", "%20")}&service_type=MOVING&vehicle_type_id=$vId";
    // }
    String url = baseUrl + filter;
    print("API:" + url);
    var response = await client.get(filter);

    ProviderListResponse parseData;
    if (response.body == null) {
      await getProviderList(
        // zipCode,
        subServiceId: subServiceId,
        moving: moving,
        vId: vId,
        cityId: cityId,
        countryId: countryId,
      );
    }
    parseData = ProviderListResponse.fromJson(response.body);

    return parseData;
  }
}
/*
var quest = getQuestionsObj(question);
    json.encode(body);
    var formData1 = getFormDataGet(body);
    // body["questions"] = "{\"question_1\":10,\"question_2\":2}";
    body["questions"] = quest.toString().replaceAll(",}", "}");
    var formData = getFormData(body);
    // var response =
    //     await client.post(filter, headers: requestHeaders, body: formData);

    Dio dio = Dio();
    Options options = Options();
    options.headers = {'Authorization': authToken};

    ProviderTimeslotsResponse parseData;
    var response = await dio.post(url, options: options, data: formData);
    var resp = json.encode(response.data);



 */
