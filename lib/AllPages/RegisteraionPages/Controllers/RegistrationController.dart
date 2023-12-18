import 'dart:convert';

import 'package:application_1/AllPages/RegisteraionPages/details.dart';
import 'package:application_1/AllPages/RegisteraionPages/models/otp_verification/otp_verification_reponse.dart';
import 'package:application_1/AllPages/RegisteraionPages/models/signin_model/sign_response.dart';
import 'package:application_1/AllPages/RegisteraionPages/models/user_signup_model/signup_errors_message.dart';
import 'package:application_1/AllPages/RegisteraionPages/models/user_signup_model/user_data.dart';
import 'package:application_1/AllPages/RegisteraionPages/models/user_signup_model/user_signup_response.dart';
import 'package:application_1/AllPages/RegisteraionPages/otp.dart';
import 'package:application_1/AllPages/payable_widget.dart';
import 'package:application_1/All_Refrences/shared_refrence.dart';
import 'package:application_1/App_Routes/app_routes.dart';
import 'package:application_1/components/celebrate_screen/celebrate.dart';
import 'package:application_1/resources/repositories/service_repository.dart';
import 'package:application_1/utils/api_utils.dart';
import 'package:application_1/utils/app_dialog_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../ExplorePages/service_timing/new_service_timing.dart';
import '../../change_password_screen.dart';

class RegistrationController extends GetxController {
  var verified = false.obs;
  var numberStr = "".obs;
  var userData = UserData().obs;
  var feedbacks = [].obs;
  var currentIndex = 0.obs;

  RegistrationController({getUser}) {
    bool flag = getUser ?? false;
    if (flag) {
      getUserData();
    }
  }

  void verifyNumber(String number) async {
    AppDialogUtils.dialogLoading();
    await ServiceReposiotry().otp(number).then((SignResponse? response) {
      AppDialogUtils.dismiss();
      if (response != null) {
        if (response.error!) {
          AppDialogUtils.errorDialog(response.message!.phone!);
        } else {
          numberStr(number);
          AppDialogUtils.successDialog(response.messageRes!);
          Future.delayed(const Duration(seconds: 1)).then((value) {
            Get.to(PinCodeVerificationScreen("123456"));
          });
        }
      }
    });
  }

  verifyOtp(String otp, String userNumber, bool flag, {isPhone}) async {
    AppDialogUtils.dialogLoading();

    await ServiceReposiotry()
        .otpVerify(
      otp,
      userNumber,
      forgetPassword: flag,
    )
        .then((OtpVerificationResponse? response) {
      AppDialogUtils.dismiss();
      if (response != null) {
        if (response.error!) {
          AppDialogUtils.errorDialog(response.message!);
        } else {
          Future.delayed(const Duration(seconds: 1)).then((value) {
            if (!flag) {
              Get.off(() => Details(), fullscreenDialog: true);
            } else {
              Get.to(() => ChangePasswordScreen(
                    token: response.token,
                    userNumber: userNumber,
                    isPhone: isPhone,
                  ));
            }
          });
        }
      }
    });
  }

  void signUpUser(Map<String, dynamic> body, {imag, edit, id}) async {
    bool profileEdit = edit ?? false;
    AppDialogUtils.dialogLoading();

    var imagePath;
    if (imag != null) {
      await ServiceReposiotry().uploadImage(imag: imag).then((imagePath) async {
        if (imagePath != null) {
          if (imagePath != null) {
            body['image'] = imagePath;
          }
        }
      });
    }
    await ServiceReposiotry()
        .signUpUser(body, profileEdit, id)
        .then((UserSignupResponse? response) {
      if (response != null) {
        AppDialogUtils.dismiss();
        if (response.error) {
          if (response.message.runtimeType == String) {
            AppDialogUtils.errorDialog(response.message);
          } else {
            AppDialogUtils.errorDialog(getErrorMessage(response.message));
          }
        } else {
          String userDataStr = json.encode(response.toJson());
          userData(response.userDataModel.userData);
          SharedRefrence()
              .saveString(key: ApiUtills.userData, data: userDataStr);
          if (profileEdit) {
            Get.back();
          } else {
            Get.to(CelebrateScreen(
                imageUrl: "assets/user_assets/svg/celebrate.svg",
                buttonText: "Login",
                onTap: () {
                  Get.toNamed(AppRoutes.LOGIN);
                },
                successMsg: "Account created",
                detail:
                    "Your account was created successfully. Login to access your account."));
          }
        }
      }
    });
    AppDialogUtils.dismiss();
  }

  String getErrorMessage(SignupErrorsMessage message) {
    if (message.firstName != null) {
      return message.firstName;
    } else if (message.lastName != null) {
      return message.lastName;
    } else if (message.email != null) {
      return message.email;
    } else if (message.phone != null) {
      return message.phone;
    } else if (message.email != null) {
      return message.email;
    } else if (message.password != null) {
      return message.password;
    } else if (message.userName != null) {
      return message.userName;
    } else if (message.image != null) {
      return message.image;
    } else if (message.bio != null) {
      return message.bio;
    }
    return "";
  }

  void login(body, {context}) async {
    AppDialogUtils.dialogLoading();
    await ServiceReposiotry().login(body).then((UserSignupResponse? response) {
      if (response != null) {
        if (response.error) {
          if (response.messageStr == null) {
            AppDialogUtils.errorDialog(getErrorMessage(response.message));
          } else {
            AppDialogUtils.errorDialog(response.messageStr);
          }
        } else {
          AppDialogUtils.dismiss();
          String userDataStr = json.encode(response.toJson());
          userData(response.userDataModel.userData);
          SharedRefrence().setSignIn(true);
          SharedRefrence().saveString(
              key: ApiUtills.authToken, data: response.userDataModel.authToken);
          SharedRefrence()
              .saveString(key: ApiUtills.userData, data: userDataStr);
          Get.offAllNamed(AppRoutes.TABSCREEN);
        }
      }
    });
  }

  void getUserData() async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = await SharedRefrence().getString(key: ApiUtills.authToken);
    if (token.isNotEmpty) {
      String response = preferences.getString(ApiUtills.userData) ?? "";
      var data = json.decode(response);
      UserSignupResponse parseData = UserSignupResponse.fromJson(data);
      userData(parseData.userDataModel.userData);
    }
  }

  void getProfile(int id, {showLoading = false}) async {
    if (!showLoading) {
      AppDialogUtils.dialogLoading();
    }

    await ServiceReposiotry()
        .getUserProfile(id)
        .then((UserSignupResponse? response) {
      if (!showLoading) {
        AppDialogUtils.dismiss();
      }
      if (response != null) {
        if (response.error) {
          AppDialogUtils.errorDialog(getErrorMessage(response.message));
        } else {
          Future.delayed(Duration(microseconds: 200)).then((value) {
            String userDataStr = json.encode(response.toJson());
            userData(response.userDataModel.userData);
            SharedRefrence()
                .saveString(key: ApiUtills.userData, data: userDataStr);

            if (!showLoading) {
              Get.to(Details(edit: true));
            }
          });
        }
      }
    });
  }

  void checkDues() async {
    AppDialogUtils.dialogLoading();
    try {
      String authToken =
          await SharedRefrence().getString(key: ApiUtills.authToken);
      bool response = await ServiceReposiotry().checkDues(authToken);
      if (!response) {
        Get.to(NewServiceTimings(
          home: false,
        ));
      } else {
        alertDialog(
            title: "Alert",
            content: "Please pay your remaining dues before place new request",
            confirm: MaterialButton(
              onPressed: () {
                Get.back();
                // Get.to(PayableWidget());
              },
              child: Text("Okay"),
            ));
      }
      AppDialogUtils.dismiss();
    } catch (ex) {
      AppDialogUtils.dismiss();
      print("$ex");
    }
  }

  void getFeedback(int id) async {
    try {
      String authToken =
          await SharedRefrence().getString(key: ApiUtills.authToken);
      if (authToken.isNotEmpty) {
        List response = await ServiceReposiotry()
            .getFeedback(authToken: authToken, id: id.toString());
        feedbacks(response);
        feedbacks.refresh();
      }
    } catch (ex) {
      print("$ex");
    }
  }

  void forgetPassword(String number, {isPhone}) {
    AppDialogUtils.dialogLoading();
    Map<String, dynamic> body;
    if (isPhone) {
      body = {
        "email": number,
      };
    } else {
      body = {
        "email": number,
      };
    }
    try {
      ServiceReposiotry().forgetPassword(body: body).then((value) {
        AppDialogUtils.dismiss();
        if (value['message'] == "This email is not exist") {
          AppDialogUtils.errorDialog(value['message']);
        } else if (value['message'] == "Otp has been sent on your email.") {
          print("${value['message']}");
          String otp = value['opt'].toString();
          3.delay().then((val) {
            Get.to(() => PinCodeVerificationScreen(
                  number,
                  forgetPassword: true,
                  isPhone: isPhone,
                ));
            //   AppDialogUtils.dismiss();
            //   Get.defaultDialog(
            //       title: "OTP",
            //       content: Text("Your otp $otp"),
            //       confirm: MaterialButton(
            //         onPressed: () {
            //           Get.back();
            //         },
            //         child: Text("Okay"),
            //       ));
          });
        }
      }, onError: (e) {
        AppDialogUtils.dismiss();
      });
    } on Exception catch (e) {
      AppDialogUtils.dismiss();
    }
  }

  void changePassword(
      String password, String confirmPassword, userNumber, token,
      {isPhone}) {
    AppDialogUtils.dialogLoading();
    ServiceReposiotry()
        .changePassword(password, confirmPassword, userNumber, token,
            isPhone: isPhone)
        .then((value) {
      print("$value");
      if (value['message'] == "OK") {
        3.delay().then((value) {
          AppDialogUtils.dismiss();
          AppDialogUtils.successDialog("Password updated successfully");
          Get.offNamedUntil(AppRoutes.WRAPPER, (route) => false);
        });
      }
    });
  }

  void saveSocialData(UserSignupResponse value) {
    String userDataStr = json.encode(value.toJson());
    userData(value.userDataModel.userData);
    SharedRefrence().setSignIn(true);
    SharedRefrence().saveString(
        key: ApiUtills.authToken, data: value.userDataModel.authToken);
    SharedRefrence().saveString(key: ApiUtills.userData, data: userDataStr);
    AppDialogUtils.dismiss();
    // Get.to(
    //   () => Details(),
    //   arguments: value,
    // );
    Get.offAllNamed(AppRoutes.TABSCREEN);
  }
}
