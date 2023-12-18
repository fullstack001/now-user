import 'package:application_1/AllPages/RegisteraionPages/Controllers/RegistrationController.dart';
import 'package:application_1/AllPages/RegisteraionPages/signup.dart';
import 'package:application_1/AllPages/forget_password_screen.dart';
import 'package:application_1/components/buttons-management/part_of_file/part.dart';
import 'package:application_1/components/buttons-management/style_model.dart';
import 'package:application_1/components/text_fields/farenow_text_field.dart';
// import 'package:application_1/keyboard_overlay/keyboard_overlay.dart';
import 'package:application_1/screens/socail_screen.dart';
import 'package:application_1/social_network.dart';
import 'package:application_1/utils/AppColors.dart';
import 'package:application_1/utils/app_dialog_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../App_Routes/app_routes.dart';
import '../RegisteraionPages/signin.dart';

var numberPlaceHolder = "xxx xxx xxxx";

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool _appear = true;
  final _formKey = new GlobalKey<FormState>();
  SocialNetwork _socialNetwork = Get.put(SocialNetwork());

  // double numberHeight = 47;

  bool hidePassword = true;

  final RegistrationController _registrationController = Get.find();

  String countryCode = "+1";
  String numberError = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (kReleaseMode) {
      print('release mode');
    } else {
      print('debug mode');
      // _email.text = "6506492638";
      // _email.text = "shahmeerahmad1435@gmail.com";
      // _email.text = "shahmeer.entspos@gmail.com";
      // _email.text = "+923338683485";
      password.text = "Abc1234@";
    }

    Size size = MediaQuery.of(context).size;
    double w = size.width;
    double h = size.height;
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
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 4,
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Login",
                            style: TextStyle(
                                color: AppColors.black,
                                fontSize: 38,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        20.height,

                        FarenowTextField(
                            controller: _email,
                            hint: "Enter your email address",
                            type: TextInputType.emailAddress,
                            label: "Email Address"),

                        // if (numberError.isNotEmpty)
                        //   Container(
                        //     margin: EdgeInsets.only(top: 8),
                        //     child: Text(
                        //       numberError,
                        //       style: TextStyle(color: Colors.red),
                        //     ),
                        //     width: Get.width,
                        //   ),
                        20.height,
                        FarenowTextField(
                            isPassword: true,
                            controller: password,
                            inputAction: TextInputAction.done,
                            onSubmit: ((p0) {
                              FocusScope.of(context).unfocus();
                              if (_formKey.currentState!.validate() &&
                                  GetUtils.isEmail(_email.text.trim())) {
                                if (_email.text.isEmpty) {
                                  numberError = "field required";
                                  setState(() {});
                                  return;
                                }
                                String email = _email.text.toString().trim();
                                String pass = password.text.toString();
                                Map body = <String, String>{
                                  "user_name": email,
                                  "password": pass
                                };
                                _registrationController.login(body,
                                    context: context);
                                numberError = "";
                                setState(() {});
                              } else {
                                AppDialogUtils.errorDialog(
                                    "Provide Correct Credentials");
                              }
                            }),
                            onValidation: (String val) {
                              if (val.isNotEmpty) {
                                if (val.length < 8) {
                                  return "Password must contain 8 characters long";
                                }
                              } else {
                                return "Feild required";
                              }
                            },
                            hint: "Password",
                            label: "Enter your password"),

                        FarenowButton(
                            style: FarenowButtonStyleModel(
                                padding: const EdgeInsets.only(top: 12)),
                            title: "Forgot Password?",
                            onPressed: () {
                              Get.to(() => ForgetPasswordScreen());
                            },
                            type: BUTTONTYPE.text),
                        FarenowButton(
                            style: FarenowButtonStyleModel(
                                padding: EdgeInsets.zero),
                            title: "Login",
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              if (_formKey.currentState!.validate() &&
                                  GetUtils.isEmail(_email.text.trim())) {
                                if (_email.text.isEmpty) {
                                  numberError = "field required";
                                  setState(() {});
                                  return;
                                }
                                String email = _email.text.toString().trim();
                                String pass = password.text.toString();
                                Map body = <String, String>{
                                  "user_name": email,
                                  "password": pass
                                };
                                _registrationController.login(body,
                                    context: context);
                                numberError = "";
                                setState(() {});
                              } else {
                                AppDialogUtils.errorDialog(
                                    "Provide Correct Credentials");
                              }

                              String number = countryCode + _email.text;
                            },
                            type: BUTTONTYPE.rectangular),
                        20.height,
                        Container(
                          width: Get.width,
                          alignment: Alignment.center,
                          child: const Text(
                            "or continue with",
                            style: TextStyle(
                                color: Color(0xff555555),
                                fontSize: 18,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        25.height,
                        const FittedBox(child: FarenowSocialNetworkScreen()),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 40),
                    child: FittedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Don’t have an account? "),
                          GestureDetector(
                              onTap: () {
                                Get.to(SignIn());
                              },
                              child: const Text(
                                "Sign up",
                                style: TextStyle(color: AppColors.solidBlue),
                              ))
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                      flex: 0,
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        elevation: 4,
                        child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 12),
                            child: GestureDetector(
                              onTap: _launchApp,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    flex: 4,
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            width: w,
                                            child: const Text(
                                              "Are you vendor or Professional?",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.normal,
                                                  color: Colors.black),
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            width: w,
                                            child: Text(
                                              "Donwlodad the app for pro",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.normal,
                                                  color: AppColors.blue),
                                            ),
                                          )
                                        ]),
                                  ),
                                  Flexible(
                                      flex: 1,
                                      child: Container(
                                        padding: const EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                            color: const Color(0xffF5F5F5),
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        child: const Icon(
                                          Icons.arrow_forward_outlined,
                                          color: AppColors.solidBlue,
                                        ),
                                      ))
                                ],
                              ),
                            )),
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _launchApp() async {
    print("helo");
    if (GetPlatform.isAndroid || GetPlatform.isIOS) {
      final url = Uri.parse(
        GetPlatform.isAndroid
            ? "market://details?id=com.farenow.provider"
            : "https://apps.apple.com/app/id1638701698",
      );
      launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      );
    }
  }

  void _launchUrl(url) async {
    if (!await launchUrl(url)) throw 'Could not launch $url';
  }
}

// class LoginPage extends StatefulWidget {
//   LoginPage({Key? key}) : super(key: key);
//
//   @override
//   _LoginPageState createState() => _LoginPageState();
// }
//
// class _LoginPageState extends State<LoginPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }
