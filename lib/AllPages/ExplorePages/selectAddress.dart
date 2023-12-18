import 'package:application_1/AllPages/ExplorePages/Controllers/providerListController.dart';
import 'package:application_1/AllPages/ExplorePages/addNewAddress.dart';
import 'package:application_1/AllPages/save_address_controller.dart';
import 'package:application_1/model/add_address/data.dart';
import 'package:application_1/reuseableWidgets/reuseblueButton.dart';
import 'package:application_1/utils/AppColors.dart';
import 'package:application_1/utils/app_dialog_utils.dart';
import 'package:application_1/utils/widgest_utills.dart';
import 'package:application_1/widgets/custom_container.dart';
import 'package:application_1/widgets/text_with_icon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectAddress extends StatelessWidget {
  Color black = AppColors.black;
  Color white = AppColors.white;
  Color blue = AppColors.blue;
  final body;

  SelectAddress({this.body});

  SaveAddressController _addressController = Get.find();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double w = size.width;
    double h = size.height;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back,
            size: 24,
            color: blue,
          ),
        ),
        backgroundColor: white,
        title: Text(
          "Select Your Address",
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      body: Obx(() => Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                  child: Column(
                children: [
                  CustomContainer(
                    width: Get.width,
                    color: Colors.white,
                    shadowColor: Colors.black.withOpacity(0.5),
                    shadowBlurRadius: 5,
                    shadowSpreadRadius: 3,
                    shadowOffsetX: 3,
                    shadowOffsetY: 3,
                    marginRight: 24,
                    marginLeft: 24,
                    marginTop: 12,
                    allRadius: 12,
                    child: Column(
                      children: [
                        TextWithIcon(
                          marginLeft: 18,
                          marginTop: 12,
                          fontSize: 18,
                          marginBottom: 12,
                          fontWeight: FontWeight.w500,
                          title: "Select Any",
                        ),
                        for (int index = 0;
                            index < _addressController.addressList.length;
                            index++)
                          buildAddressList(index)
                      ],
                    ),
                  ),
                  if (_addressController.addressList.length < 5)
                    TextWithIcon(
                      marginTop: 12,
                      fontSize: 16,
                      fontColor: blue,
                      width: Get.width,
                      icon: Icon(
                        Icons.add,
                        color: blue,
                      ),
                      title: "Add New Address",
                      containerClick: () {
                        Get.to(() => AddNewAddress());
                      },
                    ),
                ],
              )),
              Container(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: w,
                    height: 100,
                    color: white,
                    child: ReuseableBlueButton(
                      w: w,
                      h: h,
                      text: "Confirm",
                      onTap: () {
                        if (_addressController.addressList.isEmpty) {
                          snackBar("Please add address first", context);
                          return;
                        }

                        var addressId = _addressController.addressList
                            .value[_addressController.index.value].id;

                        body["address_id"] = addressId;

                        _addressController.createOrder(body);
                        // Get.back();
                      },
                    ),
                  )
                ],
              ))
            ],
          )),
    );
  }

  Widget buildAddressList(int index) {
    AddressData value = _addressController.addressList[index];
    return GetBuilder<ProviderListController>(
      init: ProviderListController(),
      builder: (controller) {
        return GestureDetector(
          onTap: () {
            _addressController.setAddressListTile(index);
          },
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                width: Get.width,
                height: 48,
                decoration: BoxDecoration(
                    color: _addressController.index.value == index
                        ? Colors.blue
                        : Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(8)),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            value.type.capitalizeFirst!,
                            style: TextStyle(
                                fontSize: 14,
                                color: _addressController.index.value == index
                                    ? white
                                    : black),
                          ),
                          Text(
                            "${value.address}",
                            style: TextStyle(
                                fontSize: 12,
                                color: _addressController.index.value == index
                                    ? white
                                    : black),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        _addressController.setAddressListTile(index);
                        alertDialog(
                          title: "Alert",
                          content: "Do you want to delete this?",
                          confirm: MaterialButton(
                            onPressed: () {
                              _addressController
                                  .deleteAddress(value.id.toString());
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
                      child: Icon(Icons.delete,
                          color: _addressController.index.value == index
                              ? white
                              : black),
                    )
                  ],
                )),
          ),
        );
      },
    );
  }
}
