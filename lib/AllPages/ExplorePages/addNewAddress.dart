import 'package:application_1/AllPages/ExplorePages/shopMenu.dart';
import 'package:application_1/AllPages/moving/controllers/dashboard_controller.dart';
import 'package:application_1/AllPages/moving/screes/search_address_screen.dart';
import 'package:application_1/AllPages/save_address_controller.dart';
import 'package:application_1/components/buttons-management/part_of_file/part.dart';
// import 'package:application_1/keyboard_overlay/keyboard_overlay.dart';
import 'package:application_1/model/add_address/add_address_model.dart';
import 'package:application_1/reuseableWidgets/reuseableSizedbox.dart';
import 'package:application_1/utils/AppColors.dart';
import 'package:application_1/utils/widgest_utills.dart';
import 'package:application_1/widgets/custom_container.dart';
import 'package:application_1/widgets/text_with_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddNewAddress extends StatefulWidget {
  @override
  State<AddNewAddress> createState() => _AddNewAddressState();
}

class _AddNewAddressState extends State<AddNewAddress> {
  SaveAddressController _addressController = Get.find();

  DashboardController _dashboardController = Get.find();

  var zipCode = FocusNode();
  var flatNumber = FocusNode();

  @override
  void initState() {
    // setDoneButton();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double w = size.width;
    double h = size.height;
    List<String> types = ["Home", "Office", "Other"];
    // initState();

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconTheme.of(context).copyWith(color: black),
        backgroundColor: white,
        elevation: 0,
        title: Text(
          "Address",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
      body: Obx(() => SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 24,
                      ),
                      Row(
                        children: [
                          for (int index = 0; index < types.length; index++)
                            TextWithIcon(
                              title: types[index],
                              paddingTop: 8,
                              allRadius: 20,
                              paddingBottom: 8,
                              paddingLeft: 18,
                              paddingRight: 18,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              marginLeft: index == 0 ? 0 : 12,
                              bgColor: index ==
                                      _addressController.selectedIndex.value
                                  ? AppColors.solidBlue
                                  : Color(0xffE0E0E0),
                              fontColor: index ==
                                      _addressController.selectedIndex.value
                                  ? Colors.white
                                  : Color(0xff151415),
                              shadowColor: Colors.black.withOpacity(0.5),
                              containerClick: () {
                                _addressController.selectedIndex(index);
                                _addressController.selectedIndex.refresh();
                              },
                            )
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 24,
                          ),
                          Container(
                            width: w,
                            alignment: Alignment.centerLeft,
                            height: 30,
                            child: Text("Address"),
                          ),
                          TextWithIcon(
                            title: _addressController.address.isEmpty
                                ? "Enter Your Address"
                                : _addressController.address,
                            flex: 1,
                            maxLine: 1,
                            fontSize: 16,
                            paddingAll: 12,
                            alignment: MainAxisAlignment.start,
                            borderWidth: 1,
                            allRadius: 16,
                            fontColor: Colors.grey,
                            width: Get.width,
                            borderColor: Colors.grey,
                            containerClick: () {
                              _dashboardController.predictionResult.clear();
                              Get.to(() => SearchAddressScreen(
                                    onAddressSelect:
                                        _addressController.addressSlected,
                                  ));
                            },
                          ),
                          Container(
                            width: w,
                            alignment: Alignment.centerLeft,
                            height: 30,
                            child: Text("Flat Number"),
                          ),
                          CustomContainer(
                            paddingLeft: 12,
                            borderWidth: 1,
                            allRadius: 16,
                            width: Get.width,
                            borderColor: Colors.grey,
                            child: TextField(
                              focusNode: flatNumber,
                              onSubmitted: (value) {
                                // zipCode.requestFocus();
                                Get.focusScope!.unfocus();
                              },
                              textInputAction: TextInputAction.done,
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                _addressController.flatNumber(value);
                                _addressController.flatNumber.refresh();
                                _addressController.addressModel.value.flatNo =
                                    _addressController.flatNumber.value;
                              },
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Enter your flat number"),
                            ),
                          ),
                          Container(
                            width: w,
                            alignment: Alignment.centerLeft,
                            height: 30,
                            child: Text("Zipcode"),
                          ),
                          TextWithIcon(
                            title: _addressController.zipCode.isEmpty
                                ? "Enter your zip code"
                                : _addressController.zipCode,
                            fontSize: 16,
                            paddingTop: 14,
                            alignment: MainAxisAlignment.start,
                            borderWidth: 1,
                            allRadius: 16,
                            fontColor: Colors.grey,
                            paddingBottom: 14,
                            paddingLeft: 12,
                            width: Get.width,
                            paddingRight: 12,
                            borderColor: Colors.grey,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                FarenowButton(
                    title: "Add address",
                    onPressed: () {
                      String type =
                          types[_addressController.selectedIndex.value];
                      _addressController.addressModel.value.type =
                          type.toUpperCase();

                      print("$type");

                      AddAddressModel model =
                          _addressController.addressModel.value;

                      if (model.address == null) {
                        snackBar("Enter your address", context);
                        return;
                      } else if (model.address == null) {
                        snackBar("Enter your flat number", context);
                        return;
                      }

                      var body = _addressController.addressModel.value.toJson();

                      _addressController.saveAddress(body);
                    },
                    type: BUTTONTYPE.rectangular),
              ],
            ),
          )),
    );
  }

  getIndex(List<String> types) {
    for (int index = 0; index < types.length; index++) {
      if (types[index] == _addressController.selectedIndex.value) {
        return index;
      }
    }

    return 0;
  }

  // void setDoneButton() {
  //   if (GetPlatform.isIOS) {
  //     zipCode = GetFocusNodeOverlay(
  //         child: TopKeyboardUtil(
  //       DoneButtonIos(
  //         label: 'Done',
  //         onSubmitted: () => Get.focusScope!.unfocus(),
  //         platforms: ['android', 'ios'],
  //       ),
  //     ));
  //     flatNumber = GetFocusNodeOverlay(
  //         child: TopKeyboardUtil(
  //       DoneButtonIos(
  //         label: 'Done',
  //         onSubmitted: () => Get.focusScope!.unfocus(),
  //         platforms: ['android', 'ios'],
  //       ),
  //     ));
  //   }
  // }
}
