import 'dart:async';

import 'package:application_1/AllPages/RegisteraionPages/Controllers/RegistrationController.dart';
import 'package:application_1/components/buttons-management/enum/button_type.dart';
import 'package:application_1/components/buttons-management/farenow_button.dart';
import 'package:application_1/resources/repositories/service_repository.dart';
import 'package:application_1/utils/AppColors.dart';
import 'package:application_1/utils/app_dialog_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../App_Routes/app_routes.dart';
import '../../custom_package/pin_code_fields/part_of_import.dart';

class PinCodeVerificationScreen extends StatefulWidget {
  final String phoneNumber;
  var forgetPassword;
  final isPhone;

  PinCodeVerificationScreen(this.phoneNumber,
      {this.forgetPassword = false, this.isPhone = false});

  @override
  _PinCodeVerificationScreenState createState() =>
      _PinCodeVerificationScreenState();
}

class _PinCodeVerificationScreenState extends State<PinCodeVerificationScreen> {
  TextEditingController textEditingController = TextEditingController();

  // ..text = "123456";

  // ignore: close_sinks
  var errorController;

  final RegistrationController _registrationController = Get.find();

  bool hasError = false;
  String currentText = "";
  final formKey = GlobalKey<FormState>();

  var otpNode = FocusNode();

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();

    // if (GetPlatform.isIOS) {
    //   otpNode = GetFocusNodeOverlay(
    //       child: TopKeyboardUtil(
    //     DoneButtonIos(
    //       label: 'Done',
    //       onSubmitted: () => Get.focusScope!.unfocus(),
    //       platforms: ['android', 'ios'],
    //     ),
    //   ));
    // }

    super.initState();
  }

  @override
  void dispose() {
    errorController.close();

    super.dispose();
  }

  // snackBar Widget
  snackBar(String message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // initState();
    Size size = MediaQuery.of(context).size;
    double w = size.width;
    double h = size.height;
    String userNumber = _registrationController.numberStr.value;
    if (widget.forgetPassword) {
      userNumber = widget.phoneNumber;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0,
        iconTheme: IconTheme.of(context).copyWith(color: black),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    width: w,
                    child: FittedBox(
                      child: Text(
                        "Enter OTP".toUpperCase(),
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 36,
                            fontWeight: FontWeight.w700),
                      ),
                    )),
                const SizedBox(
                  height: 15,
                ),
                Container(
                    alignment: Alignment.center,
                    width: w,
                    child: Text(
                      "We have sent a verification code to your email at ${userNumber.substring(0, 2)}******@${userNumber.splitAfter("@")}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color(0xff555555),
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    )),
                const SizedBox(
                  height: 20,
                ),
                Form(
                  key: formKey,
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 30),
                      child: PinCodeTextField(
                        obscuringCharacter: '●e',
                        focusNode: otpNode,
                        textStyle:
                            const TextStyle(color: Colors.white, fontSize: 29),
                        appContext: context,
                        pastedTextStyle: TextStyle(
                          color: Colors.green.shade600,
                          fontWeight: FontWeight.bold,
                        ),
                        length: 4,
                        obscureText: false,
                        blinkWhenObscuring: true,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        animationType: AnimationType.fade,
                        pinTheme: PinTheme(
                          // errorBorderColor: Colors.redAccent,

                          borderRadius: BorderRadius.circular(13),
                          borderWidth: 1,
                          shape: PinCodeFieldShape.box,
                          activeColor: AppColors.solidBlue,
                          selectedColor: AppColors.solidBlue,
                          inactiveColor: const Color(0xffBDBDBD),
                          inactiveFillColor: white,
                          selectedFillColor: AppColors.solidBlue,
                          fieldHeight: 70,
                          fieldWidth: 70,
                          activeFillColor: hasError
                              ? AppColors.solidBlue
                              : AppColors.solidBlue,
                        ),
                        cursorColor: Colors.white,
                        animationDuration: const Duration(milliseconds: 300),
                        enableActiveFill: true,
                        errorAnimationController: errorController,
                        controller: textEditingController,
                        keyboardType: TextInputType.number,
                        boxShadows: const [
                          BoxShadow(
                            offset: Offset(0, 1),
                            color: Colors.black12,
                            blurRadius: 10,
                          )
                        ],
                        onCompleted: (v) {
                          print("Completed");
                        },
                        onChanged: (value) {
                          print(value);
                          setState(() {
                            currentText = value;
                          });
                        },
                        beforeTextPaste: (text) {
                          print("Allowing to paste $text");
                          //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                          //but you can show anything you want here, like your pop up saying wrong paste format or etc
                          return true;
                        },
                      )),
                ),
                // FarenowButton(
                //     title: "Resend Code",
                //     onPressed: () {},
                //     type: BUTTONTYPE.text),

                hasError
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          child: Text(
                            hasError
                                ? "*Please fill up all the cells properly"
                                : "",
                            style: const TextStyle(
                                color: Colors.red,
                                fontSize: 12,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      )
                    : Container(),
                5.height,
                Align(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () async {
                        if (widget.phoneNumber.length > 0) {
                          AppDialogUtils.dialogLoading();
                          await ServiceReposiotry().resendotp(userNumber);
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        // width: 100,
                        height: 40,
                        child: Text(
                          "Resend Code",
                          style: TextStyle(
                              color: AppColors.solidBlue,
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    )),
              ],
            ),
            FarenowButton(
                title: "Submit",
                onPressed: () {
                  formKey.currentState!.validate();
                  // conditions for validating

                  if (currentText.length != 4 || currentText == "") {
                    errorController.add(ErrorAnimationType
                        .shake); // Triggering error shake animation
                    setState(() {
                      hasError = true;
                    });
                  } else {
                    Future.delayed(Duration(milliseconds: 100))
                        .then((value) async {
                      String otp = textEditingController.text.toString();
                      bool verified = await _registrationController.verifyOtp(
                          otp, userNumber, widget.forgetPassword);
                      // Get.to(Details());
                    });
                    setState(
                      () {
                        hasError = false;

                        // snackBar("OTP Verified!!");
                        // Get.off(Details());
                      },
                    );
                  }
                },
                type: BUTTONTYPE.rectangular),
            const SizedBox(
              height: 20,
            ),
            Container(
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have an account?",
                    style: TextStyle(
                        color: Color(0xff151415),
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes.LOGIN);
                    },
                    child: const Text(
                      " Login",
                      style: TextStyle(
                          color: AppColors.solidBlue,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
    // return Scaffold(
    //   backgroundColor: Colors.white,
    //   body: SingleChildScrollView(
    //     child: Container(
    //       padding: EdgeInsets.symmetric(vertical: 10),
    //       height: h,
    //       width: w,
    //       child: Column(
    //         children: [
    //           Column(
    //             children: <Widget>[
    //               SizedBox(height: 30),
    //               Container(
    //                 width: w * 0.863,
    //                 alignment: Alignment.bottomLeft,
    //                 child: IconButton(
    //                   onPressed: () {
    //                     Get.back();
    //                   },
    //                   icon: Icon(
    //                     Icons.arrow_back,
    //                     color: AppColors.black,
    //                   ),
    //                 ),
    //               ),
    //               SizedBox(height: 30),
    //               FittedBox(
    //                 fit: BoxFit.cover,
    //                 child: Container(
    //                   alignment: Alignment.center,
    //                   width: w * 0.863,
    //                   height: h / 5,
    //                   child: Text(
    //                     "Please enter OTP Code",
    //                     style: TextStyle(
    //                         color: AppColors.black,
    //                         fontSize: 30,
    //                         fontWeight: FontWeight.bold),
    //                   ),
    //                 ),
    //               ),
    //               SizedBox(
    //                 height: 10,
    //               ),
    //               Form(
    //                 key: formKey,
    //                 child: Padding(
    //                     padding: const EdgeInsets.symmetric(
    //                         vertical: 8.0, horizontal: 30),
    //                     child: PinCodeTextField(
    //                       textStyle:
    //                           TextStyle(color: AppColors.white, fontSize: 29),

    //                       focusNode: otpNode,
    //                       appContext: context,
    //                       pastedTextStyle: TextStyle(
    //                         color: Colors.green.shade600,
    //                         fontWeight: FontWeight.bold,
    //                       ),

    //                       length: 4,
    //                       obscureText: false,

    //                       // obscuringWidget: Text(
    //                       //   "*",
    //                       //   style: TextStyle(fontSize: 29),
    //                       // ),
    //                       blinkWhenObscuring: true,
    //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                       animationType: AnimationType.fade,
    //                       validator: (v) {
    //                         if (v!.length < 3) {
    //                           return null;
    //                         } else {
    //                           return null;
    //                         }
    //                       },
    //                       pinTheme: PinTheme(
    //                         shape: PinCodeFieldShape.circle,
    //                         activeColor: AppColors.blue,
    //                         inactiveColor: AppColors.blue,
    //                         inactiveFillColor: Colors.blue,
    //                         fieldHeight: w * 0.2,
    //                         fieldWidth: w * 0.2,
    //                         activeFillColor:
    //                             hasError ? Colors.blue : Colors.blue,
    //                       ),
    //                       cursorColor: Colors.black,
    //                       animationDuration: Duration(milliseconds: 300),
    //                       enableActiveFill: true,
    //                       errorAnimationController: errorController,
    //                       controller: textEditingController,
    //                       keyboardType: TextInputType.number,
    //                       boxShadows: [
    //                         BoxShadow(
    //                           offset: Offset(0, 1),
    //                           color: Colors.black12,
    //                           blurRadius: 10,
    //                         )
    //                       ],
    //                       onCompleted: (v) {
    //                         print("Completed");
    //                       },
    //                       // onTap: () {
    //                       //   print("Pressed");
    //                       // },
    //                       onChanged: (value) {
    //                         print(value);
    //                         setState(() {
    //                           currentText = value;
    //                         });
    //                       },
    //                       beforeTextPaste: (text) {
    //                         print("Allowing to paste $text");
    //                         //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
    //                         //but you can show anything you want here, like your pop up saying wrong paste format or etc
    //                         return true;
    //                       },
    //                     )),
    //               ),
    //               Padding(
    //                 padding: const EdgeInsets.symmetric(horizontal: 30.0),
    //                 child: Text(
    //                   hasError ? "*Please fill up all the cells properly" : "",
    //                   style: TextStyle(
    //                       color: Colors.red,
    //                       fontSize: 12,
    //                       fontWeight: FontWeight.w400),
    //                 ),
    //               ),
    //               SizedBox(
    //                 height: 20,
    //               ),
    //               Column(
    //                 mainAxisAlignment: MainAxisAlignment.center,
    //                 children: [
    //                   Text("Didn't you receive any code? ",
    //                       style: TextStyle(
    //                           color: Colors.black45,
    //                           fontSize: 18,
    //                           fontWeight: FontWeight.w300)),
    //                   TextButton(
    // onPressed: () => snackBar("OTP resend!!"),
    //                       child: Text(
    //                         "RESEND NEW CODE",
    //                         style: TextStyle(
    //                             color: AppColors.blue,
    //                             fontWeight: FontWeight.bold,
    //                             fontSize: 18),
    //                       ))
    //                 ],
    //               ),
    //               SizedBox(
    //                 height: 14,
    //               ),
    //             ],
    //           ),
    //           Expanded(
    //               child: SizedBox(
    //             height: 30,
    //           )),
    //           Padding(
    //             padding: const EdgeInsets.all(8.0),
    //             child: Container(
    //               width: w * 0.863,
    //               height: 47,
    //               // margin:
    //               //     const EdgeInsets.symmetric(vertical: 16.0, horizontal: 30),
    //               child: ButtonTheme(
    //                 splashColor: Colors.yellow,
    //                 minWidth: w * 0.863,
    //                 height: 50,
    //                 child: TextButton(
    //                   onPressed: () {
    // formKey.currentState!.validate();
    // // conditions for validating

    // if (currentText.length != 4 || currentText == "") {
    //   errorController.add(ErrorAnimationType
    //       .shake); // Triggering error shake animation
    //   setState(() {
    //     hasError = true;
    //   });
    // } else {
    //   Future.delayed(Duration(milliseconds: 100))
    //       .then((value) async {
    //     String otp = textEditingController.text.toString();
    //     bool verified =
    //         await _registrationController.verifyOtp(
    //             otp, userNumber, widget.forgetPassword);
    //     // Get.to(Details());
    //   });
    //   setState(
    //     () {
    //       hasError = false;

    //       // snackBar("OTP Verified!!");
    //       // Get.off(Details());
    //     },
    //   );
    // }
    //                   },
    //                   child: Center(
    //                       child: Text(
    //                     "Next".toUpperCase(),
    //                     style: TextStyle(
    //                         color: Colors.white,
    //                         fontSize: 16,
    //                         fontWeight: FontWeight.bold),
    //                   )),
    //                 ),
    //               ),
    //               decoration: BoxDecoration(
    //                   color: AppColors.blue,
    //                   borderRadius: BorderRadius.circular(5),
    //                   boxShadow: [
    //                     BoxShadow(
    //                         color: Colors.blue.shade200,
    //                         offset: Offset(1, -2),
    //                         blurRadius: 5),
    //                     BoxShadow(
    //                         color: Colors.blue.shade200,
    //                         offset: Offset(-1, 2),
    //                         blurRadius: 5)
    //                   ]),
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}
