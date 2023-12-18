import 'package:flutter/foundation.dart';
import 'package:nb_utils/nb_utils.dart';

import '../components/buttons-management/part_of_file/part.dart';
import '../components/buttons-management/style_model.dart';
import '../components/text_fields/farenow_text_field.dart';
import '../utils/AppColors.dart';
import 'RegisteraionPages/Controllers/RegistrationController.dart';

class ForgetPasswordScreen extends StatefulWidget {
  @override
  _ForgetPasswordScreenState createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  TextEditingController _email = TextEditingController();
  bool _appear = false;
  final _formKey = GlobalKey<FormState>();
  double numberHeight = 47;

  final RegistrationController _registrationController =
      Get.put(RegistrationController());

  var mobileNode = FocusNode();
  // String countryCode = "+1";
  String numberError = "";
  bool isPhone = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double w = size.width;
    double h = size.height;
    if (kDebugMode) {
      // _email.text = "3008383978";
    }
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        iconTheme: IconTheme.of(context).copyWith(color: black),
        backgroundColor: white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: IntrinsicHeight(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 4,
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          width: Get.width,
                          height: 92,
                          child: Text(
                            "Forgot Password",
                            style: TextStyle(
                                color: AppColors.black,
                                fontSize: 36,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          width: w,
                          child: const Text(
                            "Enter your email or phone number to reset your account password.",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.black),
                          ),
                        ),
                        19.height,
                        FarenowTextField(
                          hint: "Enter Email",
                          label: "Email Address",
                          type: TextInputType.emailAddress,
                          controller: _email,
                          inputAction: TextInputAction.done,
                          onSubmit: (v) {
                            if (isPhone) {
                              // FocusScope.of(context).unfocus();
                              // if (!_formKey.currentState!.validate()) {
                              //   return;
                              // }
                              // String number =
                              //     countryCode + _email.text.toString().trim();
                              // print(number);

                              // if (_email.text.isNotEmpty) {
                              //   _registrationController.forgetPassword(number,
                              //       isPhone: isPhone);
                              // } else {
                              //   numberError = "Field Required";
                              //   setState(() {});
                              // }
                            } else {
                              FocusScope.of(context).unfocus();
                              if (!_formKey.currentState!.validate()) {
                                return;
                              }

                              _registrationController.forgetPassword(
                                  _email.text.trim(),
                                  isPhone: isPhone);
                            }
                          },
                        ),
                        if (numberError.isNotEmpty)
                          Container(
                            margin: EdgeInsets.only(top: 8),
                            child: Text(
                              numberError,
                              style: TextStyle(color: Colors.red),
                            ),
                            width: Get.width,
                          ),
                        SizedBox(height: 20),
                        // GestureDetector(
                        //   onTap: () {
                        //     FocusScope.of(context).unfocus();
                        //     if (!_formKey.currentState!.validate()) {
                        //       return;
                        //     }
                        //     String number = countryCode + _email.text.toString();
                        //     print(number);
                        //     _controller.forgetPassword(
                        //       number,
                        //     );
                        //     // Get.to(PinCodeVerificationScreen("123456"));
                        //   },
                        //   child: Container(
                        //     decoration: BoxDecoration(
                        //         color: _appear ? AppColors.green : AppColors.grey,
                        //         borderRadius: BorderRadius.circular(8)),
                        //     alignment: Alignment.center,
                        //     width: w,
                        //     height: 47,
                        //     child: Text(
                        //       "Reset Password",
                        //       style: TextStyle(
                        //           color:
                        //               _appear ? AppColors.white : AppColors.black,
                        //           fontSize: 20),
                        //     ),
                        //   ),
                        // ),
                        FarenowButton(
                            style: FarenowButtonStyleModel(
                                padding: EdgeInsets.zero),
                            title: "Submit",
                            onPressed: () {
                              if (isPhone) {
                                // FocusScope.of(context).unfocus();
                                // if (!_formKey.currentState!.validate()) {
                                //   return;
                                // }
                                // String number =
                                //     countryCode + _email.text.toString().trim();
                                // print(number);

                                // if (_email.text.isNotEmpty) {
                                //   _registrationController.forgetPassword(number,
                                //       isPhone: isPhone);
                                // } else {
                                //   numberError = "Field Required";
                                //   setState(() {});
                                // }
                              } else {
                                FocusScope.of(context).unfocus();
                                if (!_formKey.currentState!.validate()) {
                                  return;
                                }

                                _registrationController.forgetPassword(
                                    _email.text.trim(),
                                    isPhone: isPhone);
                              }
                            },
                            type: BUTTONTYPE.rectangular),
                        10.height,
                        // Row(
                        //   children: [
                        //     const Text(
                        //       "Reset with registered",
                        //       style: TextStyle(
                        //           color: Color(0xff555555),
                        //           fontSize: 16,
                        //           fontWeight: FontWeight.w400),
                        //     ),
                        //     TextButton(
                        //         onPressed: () {
                        //           setState(() {
                        //             isPhone = !isPhone;
                        //           });
                        //         },
                        //         child: Text(
                        //           !isPhone ? "Phone Number" : "Email",
                        //           style: TextStyle(
                        //               color: Color(0xff0068E1),
                        //               fontSize: 16,
                        //               fontWeight: FontWeight.w400),
                        //         ))
                        //   ],
                        // )
                      ],
                    ),
                  ),
                  // Expanded(
                  //   child: Container(
                  //       width: w / 1.16,
                  //       height: h * 0.186,
                  //       child: Column(
                  //           mainAxisAlignment: MainAxisAlignment.end,
                  //           crossAxisAlignment: CrossAxisAlignment.end,
                  //           children: [
                  //             Container(
                  //               alignment: Alignment.centerLeft,
                  //               width: w,
                  //               child: Text(
                  //                 "By tapping Continue with Facebook or Continue with Google, you agree to the",
                  //                 style: TextStyle(
                  //                     fontSize: 14,
                  //                     fontWeight: FontWeight.normal,
                  //                     color: Colors.black),
                  //               ),
                  //             ),
                  //             SizedBox(
                  //               height: 10,
                  //             ),
                  //             GestureDetector(
                  //               child: InkWell(
                  //                 onTap: () async {
                  //                   var canLaunch = await canLaunchUrl(Uri.parse(
                  //                       "https://www.farenow.com/page/Policy"));
                  //                   if (!await launchUrl(Uri.parse(
                  //                       "https://www.farenow.com/page/Policy"))) {
                  //                     throw 'Could not launch https://www.farenow.com/page/Policy';
                  //                   }
                  //                 },
                  //                 child: Container(
                  //                   alignment: Alignment.centerLeft,
                  //                   width: w,
                  //                   child: Text(
                  //                     "Terms of Use and Privacy",
                  //                     style: TextStyle(
                  //                         fontSize: 14,
                  //                         fontWeight: FontWeight.normal,
                  //                         color: AppColors.blue),
                  //                   ),
                  //                 ),
                  //               ),
                  //             ),

                  //           ])),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
    // return Scaffold(
    //   body: SingleChildScrollView(
    //     child: IntrinsicHeight(
    //       child: Form(
    //         key: _formKey,
    //         child: Column(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           children: [
    //             Expanded(
    //               flex: 4,
    //               child: Container(
    //                 width: w,
    //                 height: h * 0.75,
    //                 alignment: Alignment.bottomCenter,
    //                 child: Container(
    //                   width: w * 0.86,
    //                   height: h * 560 / 800,
    //                   child: Column(
    //                     children: [
    //                       Container(
    //                         width: w,
    //                         height: h * 0.08,
    //                         alignment: Alignment.centerLeft,
    //                         child: IconButton(
    //                           onPressed: () {
    //                             Get.back();
    //                           },
    //                           icon: Icon(
    //                             Icons.arrow_back,
    //                             size: 25,
    //                             color: AppColors.black,
    //                           ),
    //                         ),
    //                       ),
    //                       BuildSizedBox(0),
    //                       Container(
    //                         alignment: Alignment.center,
    //                         width: w * 0.863,
    //                         child: Text(
    //                           "Forgot Password",
    //                           style: TextStyle(
    //                               color: AppColors.black,
    //                               fontSize: 38,
    //                               fontWeight: FontWeight.bold),
    //                         ),
    //                       ),
    //                       BuildSizedBox(20),
    //                       Container(
    //                         width: Get.width,
    //                         height: 55,
    //                         color: Color(0xffF3F4F4),
    //                         child: Row(
    //                           children: [
    //                             Container(
    //                               height: 55,
    //                               color: Color(0xffF3F4F4),
    //                               child: Row(
    //                                 children: [
    //                                   Container(
    //                                     alignment: Alignment.center,
    //                                     child: Text(countryCode),
    //                                     // child: CountryCodePicker(
    //                                     //   onChanged: (value) {
    //                                     //     countryCode =
    //                                     //         value.dialCode!.toString();
    //                                     //     print("$countryCode");
    //                                     //   },
    //                                     //   dialogSize: Size(Get.width * 0.9,
    //                                     //       Get.height * 0.35),
    //                                     //   initialSelection: 'US',
    //                                     //   countryFilter: ["US", "PK", "NG"],
    //                                     //   showFlag: false,
    //                                     //   showCountryOnly: false,
    //                                     //   showOnlyCountryWhenClosed: false,
    //                                     //   alignLeft: true,
    //                                     // ),
    //                                     width: 77,
    //                                   ),
    //                                   Container(
    //                                     height: 30,
    //                                     width: 1,
    //                                     color: Colors.grey.shade400,
    //                                   ),
    //                                 ],
    //                               ),
    //                             ),
    //                             Expanded(
    //                                 child: Container(
    //                               width: Get.width,
    //                               height: 55,
    //                               child: TextFormField(
    //                                 focusNode: mobileNode,
    //                                 onFieldSubmitted: (value) {
    //                                   Get.focusScope!.unfocus();
    //                                 },
    //                                 controller: _email,
    //                                 keyboardType: TextInputType.phone,
    //                                 decoration: InputDecoration(
    //                                   border: OutlineInputBorder(
    //                                       borderSide: BorderSide.none),
    //                                   fillColor: Color(0xffF3F4F4),
    //                                   filled: true,
    //                                   hintText: numberPlaceHolder,
    //                                   hintStyle: TextStyle(
    //                                       color: Colors.grey.shade700),
    //                                 ),
    //                               ),
    //                             ))
    //                           ],
    //                         ),
    //                       ),
    //                       if (numberError.isNotEmpty)
    //                         Container(
    //                           margin: EdgeInsets.only(top: 8),
    //                           child: Text(
    //                             numberError,
    //                             style: TextStyle(color: Colors.red),
    //                           ),
    //                           width: Get.width,
    //                         ),
    //                       BuildSizedBox(20),
    //                       GestureDetector(
    //                         onTap: () {
    //                           FocusScope.of(context).unfocus();
    //                           if (!_formKey.currentState!.validate()) {
    //                             return;
    //                           }
    //                           String number =
    //                               countryCode + _email.text.toString();
    //                           print(number);
    //                           _registrationController.forgetPassword(
    //                             number,
    //                           );
    //                           // Get.to(PinCodeVerificationScreen("123456"));
    //                         },
    //                         child: Container(
    //                           decoration: BoxDecoration(
    //                               color: _appear
    //                                   ? AppColors.green
    //                                   : AppColors.grey,
    //                               borderRadius: BorderRadius.circular(8)),
    //                           alignment: Alignment.center,
    //                           width: w,
    //                           height: 47,
    //                           child: Text(
    //                             "Reset Password",
    //                             style: TextStyle(
    //                                 color: _appear
    //                                     ? AppColors.white
    //                                     : AppColors.black,
    //                                 fontSize: 20),
    //                           ),
    //                         ),
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //               ),
    //             ),
    //             Expanded(
    //               child: Container(
    //                   width: w / 1.16,
    //                   height: h * 0.186,
    //                   child: Column(
    //                       mainAxisAlignment: MainAxisAlignment.end,
    //                       crossAxisAlignment: CrossAxisAlignment.end,
    //                       children: [
    //                         Container(
    //                           alignment: Alignment.centerLeft,
    //                           width: w,
    //                           child: Text(
    //                             "By tapping Continue with Facebook or Continue with Google, you agree to the",
    //                             style: TextStyle(
    //                                 fontSize: 14,
    //                                 fontWeight: FontWeight.normal,
    //                                 color: Colors.black),
    //                           ),
    //                         ),
    //                         BuildSizedBox(10),
    //                         GestureDetector(
    //                           child: Container(
    //                             alignment: Alignment.centerLeft,
    //                             width: w,
    //                             child: Text(
    //                               "Terms of Use and Privacy",
    //                               style: TextStyle(
    //                                   fontSize: 14,
    //                                   fontWeight: FontWeight.normal,
    //                                   color: AppColors.blue),
    //                             ),
    //                           ),
    //                         ),
    //                         BuildSizedBox(10),
    //                       ])),
    //             ),
    //           ],
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}
