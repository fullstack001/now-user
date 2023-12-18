import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../components/buttons-management/enum/button_type.dart';
import '../components/buttons-management/farenow_button.dart';
import '../components/buttons-management/style_model.dart';
import '../reuseableWidgets/reuseableSizedbox.dart';
import '../utils/AppColors.dart';
import 'ExplorePages/login_page.dart';
import 'RegisteraionPages/Controllers/RegistrationController.dart';

class ChangePasswordScreen extends StatefulWidget {
  final token;
  final userNumber;
  final isPhone;

  ChangePasswordScreen({Key? key, this.token, this.userNumber, this.isPhone})
      : super(key: key);

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  TextEditingController _password = TextEditingController();
  TextEditingController _confirmPassword = TextEditingController();
  bool _appear = false;
  final _formKey = new GlobalKey<FormState>();

  final RegistrationController _registrationController =
      Get.put(RegistrationController());

  double numberHeight = 47;
  double passwordHeight = 47;

  bool hidePassword = true;
  bool hidePasswordConfirm = true;

  double ConfirmNumberHeight = 47;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double w = size.width;
    double h = size.height;
    if (kDebugMode) {
      // _password.text = "Abc1234@";
      // _confirmPassword.text = "Abc1234@";
      // _password.text = "";
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
                  Container(
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      children: [
                        20.height,
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Forgot Password",
                            style: TextStyle(
                                color: AppColors.black,
                                fontSize: 38,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        10.height,
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Enter your email or phone number to reset your account password.",
                            style: TextStyle(
                                color: AppColors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        30.height,
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Password",
                            style: TextStyle(
                                color: AppColors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        10.height,
                        TextFormField(
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (value) {},
                          onEditingComplete: () {
                            FocusScope.of(context).nextFocus();
                          },
                          validator: (val) {
                            if (val!.isEmpty) {
                              setState(() {
                                numberHeight = 67;
                              });
                              return "Field Empty";
                            } else if (validNumber(val) != "valid") {
                              setState(() {
                                numberHeight = 97;
                              });
                              return validNumber(val);
                            } else {
                              setState(() {
                                numberHeight = 47;
                              });
                            }
                            return null;
                          },
                          controller: _password,
                          onChanged: (val) {
                            print(val);
                            if (val.isNotEmpty) {
                              setState(() {
                                _appear = true;
                              });
                            } else {
                              setState(() {
                                _appear = false;
                              });
                            }
                          },
                          obscureText: hidePassword,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              suffixIcon: InkWell(
                                onTap: () {
                                  hidePassword = !hidePassword;
                                  setState(() {});
                                },
                                child: Icon(hidePassword
                                    ? Icons.remove_red_eye_outlined
                                    : Icons.visibility_off_outlined),
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(18),
                                  borderSide:
                                      BorderSide(color: Color(0xffBDBDBD))),
                              fillColor: AppColors.white,
                              filled: true,
                              hintText: "Enter your password",
                              hintStyle: TextStyle(
                                fontSize: 16,
                              ),
                              // prefixIcon: Icon(Icons.phone_android,
                              //     size: 24, color: Colors.grey),
                              contentPadding: EdgeInsets.all(8)),
                        ),
                        20.height,
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Confirm Password",
                            style: TextStyle(
                                color: AppColors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        10.height,
                        TextFormField(
                          textInputAction: TextInputAction.done,
                          onFieldSubmitted: (v) {
                            FocusScope.of(context).unfocus();
                            if (!_formKey.currentState!.validate()) {
                              return;
                            }
                            String password = _password.text.toString();
                            String confirmPassword =
                                _confirmPassword.text.toString();
                            _registrationController.changePassword(
                              password,
                              confirmPassword,
                              widget.userNumber,
                              widget.token,
                            );
                          },
                          validator: (val) {
                            String password = _password.text.toString();
                            String confirmPassword =
                                _confirmPassword.text.toString();

                            if (val!.isEmpty) {
                              setState(() {
                                ConfirmNumberHeight = 67;
                              });
                              return "Field Empty";
                            } else if (password != confirmPassword) {
                              setState(() {
                                ConfirmNumberHeight = 67;
                              });
                              return "Password and Conform Password not matched";
                            } else if (validNumber(val) != "valid") {
                              setState(() {
                                ConfirmNumberHeight = 97;
                              });
                              return validNumber(val);
                            } else {
                              setState(() {
                                ConfirmNumberHeight = 47;
                              });
                            }
                            return null;
                          },
                          controller: _confirmPassword,
                          onChanged: (val) {
                            print(val);
                            if (val.isNotEmpty) {
                              setState(() {
                                _appear = true;
                              });
                            } else {
                              setState(() {
                                _appear = false;
                              });
                            }
                          },
                          obscureText: hidePasswordConfirm,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              suffixIcon: InkWell(
                                onTap: () {
                                  hidePasswordConfirm = !hidePasswordConfirm;
                                  setState(() {});
                                },
                                child: Icon(hidePasswordConfirm
                                    ? Icons.remove_red_eye_outlined
                                    : Icons.visibility_off_outlined),
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(18),
                                  borderSide:
                                      BorderSide(color: Color(0xffBDBDBD))),
                              fillColor: AppColors.white,
                              filled: true,
                              hintText: "Confirm your password",
                              hintStyle: TextStyle(
                                fontSize: 16,
                              ),
                              // prefixIcon: Icon(Icons.phone_android,
                              //     size: 24, color: Colors.grey),
                              contentPadding: EdgeInsets.all(8)),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        FarenowButton(
                            style: FarenowButtonStyleModel(
                                padding: EdgeInsets.zero),
                            title: "Submit",
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              if (!_formKey.currentState!.validate()) {
                                return;
                              }
                              String password = _password.text.toString();
                              String confirmPassword =
                                  _confirmPassword.text.toString();
                              _registrationController.changePassword(
                                password,
                                confirmPassword,
                                widget.userNumber,
                                widget.token,
                              );
                            },
                            type: BUTTONTYPE.rectangular),
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
                  //               child: Container(
                  //                 alignment: Alignment.centerLeft,
                  //                 width: w,
                  //                 child: Text(
                  //                   "Terms of Use and Privacy",
                  //                   style: TextStyle(
                  //                       fontSize: 14,
                  //                       fontWeight: FontWeight.normal,
                  //                       color: AppColors.blue),
                  //                 ),
                  //               ),
                  //             ),
                  //             SizedBox(
                  //               height: 10,
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
    //                       BuildSizedBox(20),
    //                       Container(
    //                         alignment: Alignment.center,
    //                         width: w * 0.863,
    //                         height: 92,
    //                         child: Text(
    //                           "Change Password",
    //                           style: TextStyle(
    //                               color: AppColors.black,
    //                               fontSize: 38,
    //                               fontWeight: FontWeight.bold),
    //                         ),
    //                       ),
    //                       BuildSizedBox(20),
    //                       Container(
    //                         width: w,
    //                         height: passwordHeight,
    //                         child: TextFormField(
    //                           textInputAction: TextInputAction.next,
    //                           onFieldSubmitted: (value) {
    //                             confirmPassword.requestFocus();
    //                           },
    //                           focusNode: password,
    //                           validator: (val) {
    //                             RegExp regex = RegExp(
    //                                 r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    //                             if (val!.isEmpty) {
    //                               setState(() {
    //                                 passwordHeight = 67;
    //                               });
    //                               return "Field Required*";
    //                             } else if (!regex.hasMatch(val)) {
    //                               passwordHeight = 97;
    //                               setState(() {});
    //                               return "Your password must be at least 8 characters long,\ncontain at least one number and have a\nmixture of uppercase and lowercase letters.";
    //                             } else {
    //                               setState(() {
    //                                 passwordHeight = 47;
    //                               });
    //                             }
    //                             return null;
    //                           },
    //                           controller: _password,
    //                           onChanged: (val) {
    //                             print(val);
    //                             if (val.isNotEmpty) {
    //                               setState(() {
    //                                 _appear = true;
    //                               });
    //                             } else {
    //                               setState(() {
    //                                 _appear = false;
    //                               });
    //                             }
    //                           },
    //                           obscureText: hidePassword,
    //                           keyboardType: TextInputType.text,
    //                           decoration: InputDecoration(
    //                               suffixIcon: InkWell(
    //                                 onTap: () {
    //                                   hidePassword = !hidePassword;
    //                                   setState(() {});
    //                                 },
    //                                 child: Icon(hidePassword
    //                                     ? Icons.remove_red_eye_outlined
    //                                     : Icons.visibility_off_outlined),
    //                               ),
    //                               border: OutlineInputBorder(
    //                                   borderSide: BorderSide.none),
    //                               fillColor: AppColors.grey,
    //                               filled: true,
    //                               hintText: "Password",
    //                               hintStyle: TextStyle(
    //                                 fontSize: 16,
    //                               ),
    //                               prefixIcon: Icon(Icons.phone_android,
    //                                   size: 24, color: Colors.grey),
    //                               contentPadding: EdgeInsets.all(8)),
    //                         ),
    //                       ),
    //                       BuildSizedBox(20),
    //                       Container(
    //                         width: w,
    //                         height: numberHeight,
    //                         child: TextFormField(
    //                           textInputAction: TextInputAction.done,
    //                           focusNode: confirmPassword,
    //                           validator: (val) {
    //                             String password = _password.text.toString();
    //                             String confirmPassword =
    //                                 _confirmPassword.text.toString();
    //                             RegExp regex = RegExp(
    //                                 r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    //                             if (val!.isEmpty) {
    //                               setState(() {
    //                                 numberHeight = 67;
    //                               });
    //                               return "Field Required*";
    //                             } else if (password != confirmPassword) {
    //                               setState(() {
    //                                 numberHeight = 67;
    //                               });
    //                               return "Password and Conform Password not matched";
    //                             } else if (!regex.hasMatch(val)) {
    //                               numberHeight = 97;
    //                               setState(() {});
    //                               return "Your password must be at least 8 characters long,\ncontain at least one number and have a\nmixture of uppercase and lowercase letters.";
    //                             } else {
    //                               setState(() {
    //                                 numberHeight = 47;
    //                               });
    //                             }
    //                             return null;
    //                           },
    //                           controller: _confirmPassword,
    //                           onChanged: (val) {
    //                             print(val);
    //                             if (val.isNotEmpty) {
    //                               setState(() {
    //                                 _appear = true;
    //                               });
    //                             } else {
    //                               setState(() {
    //                                 _appear = false;
    //                               });
    //                             }
    //                           },
    //                           obscureText: hidePasswordConfirm,
    //                           keyboardType: TextInputType.text,
    //                           decoration: InputDecoration(
    //                               suffixIcon: InkWell(
    //                                 onTap: () {
    //                                   hidePasswordConfirm =
    //                                       !hidePasswordConfirm;
    //                                   setState(() {});
    //                                 },
    //                                 child: Icon(hidePasswordConfirm
    //                                     ? Icons.remove_red_eye_outlined
    //                                     : Icons.visibility_off_outlined),
    //                               ),
    //                               border: OutlineInputBorder(
    //                                   borderSide: BorderSide.none),
    //                               fillColor: AppColors.grey,
    //                               filled: true,
    //                               hintText: "Confirm Password",
    //                               hintStyle: TextStyle(
    //                                 fontSize: 16,
    //                               ),
    //                               prefixIcon: Icon(Icons.phone_android,
    //                                   size: 24, color: Colors.grey),
    //                               contentPadding: EdgeInsets.all(8)),
    //                         ),
    //                       ),
    //                       BuildSizedBox(20),
    //                       GestureDetector(
    //                         onTap: () {
    //                           FocusScope.of(context).unfocus();
    //                           if (!_formKey.currentState!.validate()) {
    //                             return;
    //                           }
    //                           String password = _password.text.toString();
    //                           String confirmPassword =
    //                               _confirmPassword.text.toString();
    //                           _registrationController.changePassword(
    //                             password,
    //                             confirmPassword,
    //                             widget.userNumber,
    //                             widget.token,
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
    //                             "Submit",
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

validNumber(val) {
  RegExp regex =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
  if (!regex.hasMatch(val)) {
    return "Your password must be at least 8 characters long,\ncontain at least one number and have a\nmixture of uppercase and lowercase letters.";
  }
  return "valid";
}
