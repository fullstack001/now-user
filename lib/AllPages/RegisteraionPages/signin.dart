import 'package:application_1/AllPages/RegisteraionPages/Controllers/RegistrationController.dart';
import 'package:application_1/components/buttons-management/part_of_file/part.dart';
import 'package:application_1/components/buttons-management/style_model.dart';
import 'package:application_1/components/text_fields/farenow_text_field.dart';
import 'package:application_1/social_network.dart';
import 'package:application_1/utils/AppColors.dart';
import 'package:application_1/utils/app_dialog_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../App_Routes/app_routes.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController _email = TextEditingController();
  bool _appear = false;
  final _formKey = new GlobalKey<FormState>();
  double numberHeight = 47;
  SocialNetwork _socialNetwork = Get.put(SocialNetwork());

  final RegistrationController _registrationController = Get.find();

  var mobileNode = FocusNode();

  String countryCode = "+1";
  String numberError = "";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double w = size.width;
    double h = size.height;
    if (kDebugMode) {
      _email.text = "shahmeerahmad1435@gmail.com";
      // _email.text = "3041628688";
    }
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        iconTheme: IconTheme.of(context).copyWith(color: black),
        backgroundColor: white,
        elevation: 0,
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                "Step 1 of 2",
                style: TextStyle(color: AppColors.solidBlue),
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Column(
                      children: [
                        12.height,
                        Container(
                          alignment: Alignment.centerLeft,
                          width: Get.width,
                          child: Text(
                            "Sign up",
                            style: TextStyle(
                                color: AppColors.black,
                                fontSize: 36,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        12.height,
                        Container(
                          alignment: Alignment.centerLeft,
                          width: Get.width,
                          child: Text(
                            "Create your account to get started. We don’t share your contact info with professionals.",
                            style: TextStyle(
                                color: AppColors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        33.height,
                        FarenowTextField(
                          hint: "Enter your email address",
                          label: "Email Address",
                          type: TextInputType.emailAddress,
                          controller: _email,
                          inputAction: TextInputAction.done,
                          onSubmit: (v) {
                            FocusScope.of(context).unfocus();
                            if (_formKey.currentState!.validate() &&
                                GetUtils.isEmail(_email.text.trim())) {
                              _registrationController
                                  .verifyNumber(_email.text.trim());
                            } else {
                              AppDialogUtils.errorDialog(
                                  "Provide Correct Email");
                            }
                          },
                        ),
                        5.height,
                        if (numberError.isNotEmpty)
                          Container(
                            margin: const EdgeInsets.only(top: 8),
                            width: Get.width,
                            child: Text(
                              numberError,
                              style: const TextStyle(color: Colors.red),
                            ),
                          ),
                        18.height,
                        FarenowButton(
                            style: FarenowButtonStyleModel(
                                padding: EdgeInsets.zero),
                            title: "Submit",
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              if (_formKey.currentState!.validate() &&
                                  GetUtils.isEmail(_email.text.trim())) {
                                _registrationController
                                    .verifyNumber(_email.text.trim());
                              } else {
                                AppDialogUtils.errorDialog(
                                    "Provide Correct Email");
                              }
                              // String number =
                              //     countryCode + _email.text.toString();
                            },
                            type: BUTTONTYPE.rectangular),
                      ],
                    ),
                    18.height,
                    Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(children: [
                                const TextSpan(
                                    style:
                                        TextStyle(color: black, fontSize: 14),
                                    text:
                                        "By clicking submit, you affirm you have read and agree to the Farenow "),
                                TextSpan(
                                  style: const TextStyle(
                                      color: AppColors.solidBlue, fontSize: 14),
                                  text: "Terms of Use and Privacy",
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      print("helo");
                                      canLaunchUrl(Uri.parse(
                                          "https://www.farenow.com/page/privacy"));

                                      _launchUrl(Uri.parse(
                                          "https://www.farenow.com/page/privacy"));
                                    },
                                )
                              ])),
                          Center(
                            child: FittedBox(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 33),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text("Already have an account? "),
                                    GestureDetector(
                                        onTap: () {
                                          Get.toNamed(AppRoutes.LOGIN);
                                        },
                                        child: const Text(
                                          "Login",
                                          style: TextStyle(
                                              color: AppColors.solidBlue,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400),
                                        ))
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ]),
                  ],
                ),
                SizedBox(
                  height: Get.height * 0.2,
                ),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  elevation: 4,
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            flex: 4,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    onTap: _launchApp,
                                    child: Container(
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
                                    borderRadius: BorderRadius.circular(12)),
                                child: const Icon(
                                  Icons.arrow_forward_outlined,
                                  color: AppColors.solidBlue,
                                ),
                              ))
                        ],
                      )),
                )
              ],
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
    // if (GetPlatform.isAndroid) {
    //   if (!await launchUrl(Uri.parse(
    //       "https://play.google.com/store/apps/details?id=com.farenow.provider"))) {
    //     throw 'Could not launch Play store';
    //   }
    // }

    // if (GetPlatform.isIOS) {
    //   if (!await launchUrl(Uri.parse(
    //       "https://apps.apple.com/pk/app/farenow-provider/id1638701698"))) {
    //     throw 'Could not launch Play store';
    //   }
    // }
  }

  void _launchUrl(url) async {
    if (!await launchUrl(url)) throw 'Could not launch $url';
  }
}
