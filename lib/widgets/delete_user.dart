import 'dart:convert';

import 'package:application_1/AllPages/ExplorePages/shopMenu.dart';
import 'package:application_1/App_Routes/app_routes.dart';
import 'package:application_1/components/buttons-management/part_of_file/part.dart';
import 'package:application_1/components/buttons-management/style_model.dart';
import 'package:application_1/components/text_fields/farenow_text_field.dart';
import 'package:application_1/utils/AppColors.dart';
import 'package:application_1/utils/api_utils.dart';
import 'package:application_1/utils/app_dialog_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/files.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nb_utils/nb_utils.dart';

import '../AllPages/RegisteraionPages/models/user_signup_model/user_data.dart';
import '../All_Refrences/shared_refrence.dart';

class DeleteUser extends StatefulWidget {
  @override
  State<DeleteUser> createState() => _DeleteUserState();
}

class _DeleteUserState extends State<DeleteUser> {
  TextEditingController _pass = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(30))),
          width: Get.width,
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
                child: Image.asset(
                  "assets/user_assets/png/delete.png",
                ),
              ),
              const Text(
                "Delete Account",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    color: AppColors.solidBlue),
              ),
              12.height,
              const Text(
                "This action will clear all your data. Enter your password to confirm account delete.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff555555)),
              ),
              const SizedBox(
                height: 24,
              ),
              Container(
                margin: const EdgeInsets.only(left: 24, right: 24),
                child: FarenowTextField(
                  controller: _pass,
                  hint: "Enter your password",
                  label: "Password",
                  isPassword: true,
                ),
                // child: TextFormField(
                //   controller: _pass,
                //   decoration: const InputDecoration(
                //     hintText: "Enter your password",
                //   ),
                // ),
              ),
              const SizedBox(
                height: 24,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 24,
                  ),
                  Expanded(
                      child: FarenowButton(
                    onPressed: () {
                      Get.back();
                    },
                    style: FarenowButtonStyleModel(
                        padding: EdgeInsets.symmetric(horizontal: 3)),
                    title: "Cancel",
                    type: BUTTONTYPE.action,
                  )
                      //  Container(
                      //   width: Get.width,
                      //   height: 44,
                      //   decoration: const BoxDecoration(
                      //       color: Colors.grey,
                      //       borderRadius: BorderRadius.all(Radius.circular(12))),
                      //   child: MaterialButton(
                      //     onPressed: () {
                      //       Get.back();
                      //     },
                      //     child: const Text(
                      //       "Cancel",
                      //       style: TextStyle(color: Colors.white, fontSize: 17),
                      //     ),
                      //   ),
                      // ),
                      ),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                      child: FarenowButton(
                    style: FarenowButtonStyleModel(
                        padding: EdgeInsets.symmetric(horizontal: 3)),
                    onPressed: () async {
                      String pass = _pass.text.toString();
                      if (pass.isNotEmpty) {
                        try {
                          String authToken = await SharedRefrence()
                              .getString(key: ApiUtills.authToken);
                          String url = baseUrl + "user/delete";
                          setState(() {
                            isLoading = true;
                          });

                          var response = await http.delete(Uri.parse(url),
                              headers: {
                                "Authorization": authToken
                              },
                              body: {
                                "password": pass,
                                "password_confirmation": pass
                              });

                          if (response.statusCode == 200) {
                            final json = jsonDecode(response.body);

                            SharedRefrence().remove(key: ApiUtills.authToken);
                            SharedRefrence().remove(key: ApiUtills.userData);
                            SharedRefrence().remove(key: "login");
                            Get.back();
                            Get.offAllNamed(AppRoutes.START);

                            AppDialogUtils.successDialog(json["message"]);
                          } else if (response.statusCode == 403) {
                            final json = jsonDecode(response.body);
                            Get.back();
                            AppDialogUtils.errorDialog(json["message"]);
                          }
                          setState(() {
                            isLoading = false;
                          });
                        } catch (e) {
                          print(e.toString());
                        }
                      } else {
                        AppDialogUtils.errorDialog("Password required");
                      }
                    },
                    title: "Delete",
                    type: BUTTONTYPE.rectangular,
                  )
                      // Container(
                      //   width: Get.width,
                      //   height: 44,
                      //   decoration: BoxDecoration(
                      //       color: AppColors.appBlue,
                      //       borderRadius:
                      //           const BorderRadius.all(Radius.circular(12))),
                      //   child: MaterialButton(
                      //     onPressed: () async {
                      //       String pass = _pass.text.toString();
                      //       if (pass.isNotEmpty) {
                      //         try {
                      //           String authToken = await SharedRefrence()
                      //               .getString(key: ApiUtills.authToken);
                      //           String url = baseUrl + "user/delete";
                      //           setState(() {
                      //             isLoading = true;
                      //           });

                      //           var response = await http.delete(Uri.parse(url),
                      //               headers: {
                      //                 "Authorization": authToken
                      //               },
                      //               body: {
                      //                 "password": pass,
                      //                 "password_confirmation": pass
                      //               });

                      //           if (response.statusCode == 200) {
                      //             final json = jsonDecode(response.body);

                      //             SharedRefrence()
                      //                 .remove(key: ApiUtills.authToken);
                      //             SharedRefrence()
                      //                 .remove(key: ApiUtills.userData);
                      //             SharedRefrence().remove(key: "login");
                      //             Get.back();
                      //             Get.offAllNamed(AppRoutes.START);

                      //             AppDialogUtils.successDialog(json["message"]);
                      //           } else if (response.statusCode == 403) {
                      //             final json = jsonDecode(response.body);
                      //             Get.back();
                      //             AppDialogUtils.errorDialog(json["message"]);
                      //           }
                      //           setState(() {
                      //             isLoading = false;
                      //           });
                      //         } catch (e) {
                      //           print(e.toString());
                      //         }
                      //       } else {
                      //         Get.back();
                      //       }
                      //     },
                      //     child: isLoading
                      //         ? Center(
                      //             child: CupertinoActivityIndicator(
                      //             color: white,
                      //           ))
                      //         : const Text(
                      //             "Delete",
                      //             style: TextStyle(
                      //                 color: Colors.white, fontSize: 17),
                      //           ),
                      //   ),
                      // ),

                      ),
                  const SizedBox(
                    width: 24,
                  ),
                ],
              ),
              const SizedBox(
                height: 24,
              ),
            ],
          ),
        )
      ]),
    );
  }
}
