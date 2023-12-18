import 'package:application_1/AllPages/RegisteraionPages/Controllers/RegistrationController.dart';
import 'package:application_1/AllPages/save_address_controller.dart';
import 'package:application_1/components/buttons-management/part_of_file/part.dart';
import 'package:application_1/components/buttons-management/style_model.dart';
import 'package:application_1/model/add_address/data.dart';
import 'package:application_1/utils/AppColors.dart';
import 'package:application_1/utils/api_utils.dart';
import 'package:application_1/utils/app_dialog_utils.dart';
import 'package:application_1/utils/widgest_utills.dart';
import 'package:application_1/widgets/custom_container.dart';
import 'package:application_1/widgets/text_with_icon.dart';

import 'package:flutter_svg/svg.dart';

import 'package:nb_utils/nb_utils.dart';

import 'addNewAddress.dart';

class AddressPage extends StatefulWidget {
  var text;
  var btnText;
  var pageCall;

  AddressPage({Key? key, this.text, this.btnText, this.pageCall})
      : super(key: key);

  @override
  _AddressPageState createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  var current = 0;
  final RegistrationController _registrationController = Get.find();
  SaveAddressController _addressController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffE0E0E0).withOpacity(0.1),
        appBar: AppBar(
            backgroundColor: white,
            elevation: 1,
            titleTextStyle: Theme.of(context).textTheme.bodyMedium,
            title: Text(widget.text ?? ""),
            leading: IconButton(
              icon: Icon(
                Icons.close,
                color: black,
                size: 22,
              ),
              onPressed: () {
                Get.back();
              },
            )),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            /*Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Container(
                      // width: size.maxWidth,
                      // height: size.maxHeight * 0.23,
                      child: Card(
                    child: Container(
                      padding: EdgeInsets.all(15),
                      // width: size.maxWidth,
                      // height: size.maxHeight * 0.218,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 5,
                            child: Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    getImage(_registrationController
                                        .userData.value.image),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${"${_registrationController.userData.value.firstName} ${_registrationController.userData.value.lastName}"}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1,
                                        ),
                                        RatingStar(
                                          rating: _registrationController
                                              .userData.value.rating,
                                          size: 18,
                                          color: Colors.blue,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Icon(
                                  Icons.bookmark,
                                  size: 22,
                                  color: grey,
                                )
                              ],
                            ),
                          ),

              Expanded(
                              flex: 2,
                              child: Container(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.location_on_rounded,
                                          size: 22,
                                          color: Colors.black38,
                                        ),
                                        Text(
                                          "${getAddress(_registrationController)}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1
                                              .copyWith(
                                                  color: Colors.black38),
                                        )
                                      ],
                                    ),
                                    Text(
                                      "\$50/Hour",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1
                                          .copyWith(color: Colors.black38),
                                    )
                                  ],
                                ),
                              ))
                        ],
                      ),
                    ),
                  )),
                ),
              ),
              Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: size.maxWidth * 0.95,
                    // height: size.maxHeight * 0.5,
                    color: white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                            flex: 1,
                            child: Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Your Selected Address",
                                style: Theme.of(context).textTheme.headline6,
                              ),
                            )),
                        Expanded(
                          flex: 5,
                          child: ContainerGroup(
                            color: white,
                            secondaryColor: blue,
                            current: current,
                            onTab: (selected) {
                              setState(() {
                                current = selected;
                              });
                            },
                            containerText: [
                              ContainerGroupText(
                                  title: "Home",
                                  subtitle:
                                      "1 Manchester Ave. Lake IL Zurich 60047"),
                              ContainerGroupText(
                                  title: "Home",
                                  subtitle:
                                      "1 Manchester Ave. Lake IL Zurich 60047"),
                            ],
                          ),
                        ),
                        Expanded(
                            flex: 1,
                            child: GestureDetector(
                              onTap: () {
                                Get.to(AddNewAddress());
                              },
                              child: Container(
                                  alignment: Alignment.center,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.add,
                                        color: blue,
                                      ),
                                      Text(
                                        "Add More Address",
                                        style: TextStyle(
                                            color: blue, fontSize: 18),
                                      ),
                                    ],
                                  )),
                            )),
                      ],
                    ),
                  ),
                ),
              ),

               */
            Obx(() {
              return _addressController.addressList.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.only(top: 80),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: Card(
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              child: Container(
                                padding: EdgeInsets.only(top: 24, bottom: 12),
                                width: Get.width,
                                child: Column(children: [
                                  SvgPicture.asset(
                                      "assets/user_assets/svg/empty_address.svg"),
                                  12.height,
                                  Text(
                                    "No Address Available",
                                    style: TextStyle(
                                        color: Color(0xff151415),
                                        fontSize: 24,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  12.height,
                                  Text(
                                    "New address will appear here.",
                                    style: TextStyle(
                                        color: Color(0xff555555),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  12.height,
                                  FarenowButton(
                                      title: "+ Add address",
                                      onPressed: () {
                                        Get.to(() => AddNewAddress());
                                      },
                                      type: BUTTONTYPE.rectangular)
                                ]),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 18),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 16),
                          child: Column(children: [
                            for (int index = 0;
                                index < _addressController.addressList.length;
                                index++)
                              addressList(index),
                            24.height,
                            if (_addressController.addressList.length < 5)
                              FarenowButton(
                                  style: FarenowButtonStyleModel(
                                      padding: EdgeInsets.zero),
                                  title: "+ Add more address",
                                  onPressed: () {
                                    Get.to(() => AddNewAddress());
                                  },
                                  type: BUTTONTYPE.outline)
                            // TextWithIcon(
                            //   marginTop: 12,
                            //   width: Get.width,
                            //   fontSize: 18,
                            //   containerClick: () {
                            //     Get.to(() => AddNewAddress());
                            //   },
                            //   fontColor: AppColors.solidBlue,
                            //   icon: Icon(
                            //     Icons.add,
                            //     color: AppColors.solidBlue,
                            //   ),
                            //   title: "Add more address",
                            // )
                          ]),
                        ),
                      ),
                    );
            }),

            // Obx(() => CustomContainer(
            //       marginAll: 12,
            //       color: Colors.white,
            //       width: Get.width,
            //       paddingAll: 12,
            //       allRadius: 12,
            //       shadowColor: Colors.black.withOpacity(0.5),
            //       shadowBlurRadius: 3,
            //       shadowSpreadRadius: 2,
            //       shadowOffsetX: 3,
            //       shadowOffsetY: 4,
            //       child: _addressController.addressList.isEmpty
            //           ? Container()
            // : Column(
            //     children: [
            //       // TextWithIcon(
            //       //   fontSize: 18,
            //       //   fontWeight: FontWeight.w700,
            //       //   title: "Your Selected Address",
            //       // ),
            //       // for (int index = 0;
            //       //     index < _addressController.addressList.length;
            //       //     index++)
            //       //   addressList(index),
            //       // if (_addressController.addressList.length < 5)
            //       //   TextWithIcon(
            //       //     marginTop: 12,
            //       //     width: Get.width,
            //       //     fontSize: 18,
            //       //     containerClick: () {
            //       //       Get.to(() => AddNewAddress());
            //       //     },
            //       //     fontColor: blue,
            //       //     icon: Icon(
            //       //       Icons.add,
            //       //       color: blue,
            //       //     ),
            //       //     title: "Add more address",
            //       //   )
            //     ],
            //   ),
            //     ))
          ],
        ));
  }

  getImage(String image) {
    return image == null
        ? Container(
            width: 62,
            height: 62,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                        "assets/images/img_profile_place_holder.jpg"))),
          )
        : cacheNetworkImage(
            imageUrl: ApiUtills.imageBaseUrl + image,
            imageHeight: 62,
            radius: 40,
            imageWidth: 62);
  }

  addressList(index) {
    AddressData value = _addressController.addressList.value[index];
    return CustomContainer(
      alignment: Alignment.centerLeft,
      marginTop: index == 0 ? 4 : 8,
      width: Get.width,
      color: Color(0xffF5F5F5),
      paddingAll: 12,
      allRadius: 12,
      child: Row(
        children: [
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWithIcon(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  title: "${value.type}",
                ),
                6.height,
                Marquee(
                  child: Text(
                    "${value.address}",
                  ),
                  direction: Axis.horizontal,
                  animationDuration: Duration(milliseconds: 5000),
                  textDirection: TextDirection.ltr,
                  directionMarguee: DirectionMarguee.oneDirection,
                )
              ],
            ),
          ),
          12.width,
          Container(
            decoration: BoxDecoration(
                color: white, borderRadius: BorderRadius.circular(8)),
            padding: EdgeInsets.all(4),
            child: InkWell(
              onTap: () {
                _addressController.setAddressListTile(index);
                alertDialog(
                  title: "Alert",
                  content: "Do you want to delete this?",
                  confirm: MaterialButton(
                    onPressed: () {
                      _addressController.deleteAddress(value.id.toString());
                      Get.back();
                    },
                    child: Text("Yes"),
                  ),
                  cancel: MaterialButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text("No"),
                  ),
                );
              },
              child: Icon(Icons.delete_forever_outlined,
                  color: AppColors.solidBlue),
            ),
          )
        ],
      ),
    );
  }
}
