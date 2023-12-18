import 'package:app_review/app_review.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:application_1/AllPages/ExplorePages/addressPage.dart';
import 'package:application_1/AllPages/RegisteraionPages/Controllers/RegistrationController.dart';
import 'package:application_1/AllPages/RegisteraionPages/models/user_signup_model/user_data.dart';
import 'package:application_1/AllPages/save_address_controller.dart';
import 'package:application_1/All_Refrences/shared_refrence.dart';
import 'package:application_1/App_Routes/app_routes.dart';
import 'package:application_1/restaurant_controller/order_history_controller.dart';
import 'package:application_1/screens/subscription/package_screens.dart';
import 'package:application_1/utils/AppColors.dart';
import 'package:application_1/utils/api_utils.dart';
import 'package:application_1/utils/app_dialog_utils.dart';
import 'package:application_1/utils/image_picker.dart';
import 'package:application_1/utils/widgest_utills.dart';

import '../../components/buttons-management/part_of_file/part.dart';
import '../../widgets/delete_user.dart';
import '../ExplorePages/payment_screen/CardEdit.dart';
import 'ServicesHistory.dart';

class Profile extends StatefulWidget {
  Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final RegistrationController _registrationController = Get.find();
  OrderHistoryController _historyController = Get.put(OrderHistoryController());
  var image;

  var _list;

  SaveAddressController _addressController = Get.put(SaveAddressController());

  @override
  void initState() {
    // TODO: implement initState
    if (_registrationController.userData.value != null) {
      if (_registrationController.userData.value.id != null) {
        _registrationController.getProfile(
            _registrationController.userData.value.id,
            showLoading: true);
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getList();
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Obx(() => Container(
                width: Get.width,
                height: 160,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          12.width,
                          userImage(),
                          12.width,
                          Flexible(
                            flex: 3,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${_registrationController.userData.value.firstName} ${_registrationController.userData.value.lastName}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18,
                                      color: AppColors.black),
                                ),
                                5.height,
                                FittedBox(
                                  child: Text(
                                    "${_registrationController.userData.value.email}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                        color: Color(0xff555555)),
                                  ),
                                ),
                                5.height,
                                InkWell(
                                  onTap: () {
                                    _registrationController.getProfile(
                                        _registrationController
                                            .userData.value.id);
                                  },
                                  child: Row(
                                    children: [
                                      const Text(
                                        "Edit Profile",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.solidBlue),
                                      ),
                                      5.width,
                                      SvgPicture.asset(
                                          "assets/user_assets/svg/edit.svg")
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )),
          const Divider(
            thickness: 0.2,
            color: Colors.black,
          ),
          Container(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  for (int index = 0; index < _list.length; index++)
                    _list[index]
                ],
              ),
            ),
          )
        ],
      ),
    ));
  }

  Widget buildListTilt(String icon, String text, var onTap, {visible = true}) {
    return Visibility(
        visible: visible,
        child: Column(
          children: [
            ListTile(
              leading: SvgPicture.asset(icon),
              title: Text(
                text,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: text == "Delete Account"
                        ? const Color(0xffF95959)
                        : const Color(0xff151415)),
              ),
              onTap: onTap,
              trailing: const Icon(
                Icons.arrow_forward_ios,
                color: Color(0xff555555),
                size: 14,
              ),
            ),
            const Divider(
              thickness: 1,
            ),
          ],
        ));
  }

  void getList() {
    _list = [
      // buildListTilt(
      //   Icons.history_edu_outlined,
      //   "My Order History",
      //   () {
      //     _addressController.getCreditCard(flag: true);
      //     _historyController.getOrderHistory();
      //   },
      //   visible: true,
      // ),
      buildListTilt(
        "assets/user_assets/svg/document.svg",
        "My Service History",
        () {
          Get.to(ServiceHistory());
        },
        visible: true,
      ),
      // buildListTilt(
      //   "assets/user_assets/svg/moving.svg",
      //   "Moving History ",
      //   () {
      //     Get.to(MovingListScreen());
      //   },
      //   visible: true,
      // ),
      buildListTilt("assets/user_assets/svg/payment.svg", "Payment", () {
        _addressController.getCreditCard(
            flag: true,
            onResponseGet: () {
              Get.to(CardEdit());
            });
      }),
      buildListTilt(
          "assets/user_assets/svg/subscription.svg", "Subscription & Packages",
          () {
        _addressController.getCreditCard(
            flag: true,
            onResponseGet: () {
              Get.to(PackageScreen.new);
            });
      }),
      buildListTilt("assets/user_assets/svg/location.svg", "My Address",
          () async {
        SaveAddressController _addressController =
            Get.put(SaveAddressController());
        await _addressController.getAddress(onResponseGet: () {
          Get.to(AddressPage());
        });
      }),
      buildListTilt("assets/user_assets/svg/Shape.svg", "Share", () async {
        await FlutterShare.share(
            title: 'Example share',
            text: 'Farenow',
            linkUrl: 'https://www.farenow.com',
            chooserTitle: 'Example Chooser Title');
      }),

      buildListTilt("assets/user_assets/svg/rate_us.svg", "Rate Us", () {
        AppReview.requestReview.then((onValue) {
          if (onValue != null) {
            if (GetPlatform.isAndroid) {
              AppReview.openGooglePlay();
            }
            if (GetPlatform.isIOS) {
              AppReview.openAppStore();
            }
          }
        });
        // 1638701755
        // in_app_review: ^2.0.6
        // StoreRedirect.redirect(
        //     androidAppId: "com.app.farenow", iOSAppId: "com.comp.farenow");
      }),
      // buildListTilt(Icons.headset, "Help Center", () {}),
      buildListTilt(
        "assets/user_assets/svg/faq.svg",
        "FAQ",
        () {
          canLaunchUrl(Uri.parse("https://farenow.com/faq"));
          _launchUrl(Uri.parse("https://farenow.com/faq"));
        },
      ),
      buildListTilt(
        "assets/user_assets/svg/privicy.svg",
        "Privacy & Policy",
        () {
          canLaunchUrl(Uri.parse("https://www.farenow.com/page/Policy"));
          _launchUrl(Uri.parse("https://www.farenow.com/page/Policy"));
        },
      ),

      buildListTilt("assets/user_assets/svg/logout.svg", "Logout", () {
        alertDialog(
            title: "Alert",
            content: "Do you want to log out?",
            confirm: button(
                title: "Yes",
                onClick: () {
                  _registrationController.userData.value = UserData();
                  SharedRefrence().remove(key: ApiUtills.authToken);
                  SharedRefrence().remove(key: ApiUtills.userData);
                  SharedRefrence().remove(key: "login");
                  Get.offAllNamed(AppRoutes.START);
                }),
            cancel: button(
                title: "No",
                onClick: () {
                  Get.back();
                }));
      }),
      buildListTilt("assets/user_assets/svg/delete.svg", "Delete Account", () {
        Get.dialog(DeleteUser());
      }),
    ];
  }

  userImage() {
    return proFileImage(
        hide: true,
        imageWidget: networkImage(_registrationController, image) != null
            ? cacheNetworkImage(
                imageUrl: ApiUtills.imageBaseUrl +
                    _registrationController.userData.value.image,
                imageHeight: 90,
                imageWidth: 90,
                placeHolder: 'assets/images/img_profile_place_holder.jpg',
                radius: 90)
            : image == null
                ? FittedBox(
                    child: Image.asset(
                      'assets/user_assets/png/user.png',
                      fit: BoxFit.fill,
                      width: 80,
                      height: 80,
                    ),
                  )
                : Image.file(
                    image,
                    fit: BoxFit.fill,
                  ),
        imagePicker: () {
          ImagePickerDialog(
              context: context,
              imageSelect: (_image) {
                if (_image != null) {
                  image = _image;
                }
                setState(() {});
              }).showPicker(context);
        });
  }

  void _launchUrl(url) async {
    if (!await launchUrl(url)) throw 'Could not launch $url';
  }
}
