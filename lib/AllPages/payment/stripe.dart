import 'package:fdottedline/fdottedline.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:nb_utils/nb_utils.dart';

import 'package:application_1/AllPages/ExplorePages/AddCardDetails.dart';
import 'package:application_1/AllPages/ExplorePages/Controllers/profile_controller.dart';
import 'package:application_1/AllPages/ExplorePages/Controllers/success_request_celebrate.dart';
import 'package:application_1/AllPages/ExplorePages/addNewAddress.dart';
import 'package:application_1/AllPages/ProjectPages/controller/home_screen_controller.dart';
import 'package:application_1/AllPages/feed_back_page.dart';
import 'package:application_1/AllPages/introPages/intro_controller.dart';
import 'package:application_1/AllPages/payment/invoice.dart';
import 'package:application_1/AllPages/save_address_controller.dart';
import 'package:application_1/App_Routes/app_routes.dart';
import 'package:application_1/components/buttons-management/part_of_file/part.dart';
import 'package:application_1/components/buttons-management/style_model.dart';
import 'package:application_1/components/celebrate_screen/celebrate.dart';
import 'package:application_1/model/cart_model/food_cart_model.dart';
import 'package:application_1/model/menu_types.dart';
import 'package:application_1/remote_model/provider_list/provider_profile_detail_model.dart';
import 'package:application_1/screens/Controllers/tabScreenController.dart';
import 'package:application_1/utils/AppColors.dart';
import 'package:application_1/utils/app_dialog_utils.dart';
import 'package:application_1/utils/widgest_utills.dart';
import 'package:application_1/widgets/custom_container.dart';
import 'package:application_1/widgets/text_with_icon.dart';

import '../../custom_package/card_ui/credit_card.dart';
import '../../custom_package/card_ui/extra/card_type.dart';

class StripeModel extends StatefulWidget {
  final body;
  final onPageChange;
  final data;
  final payableId;
  final back;
  var hide;
  var fromService;
  StripeModel(
      {Key? key,
      this.onPageChange,
      this.body,
      this.data,
      this.back,
      this.fromService = false,
      this.hide = false,
      this.payableId})
      : super(key: key);

  @override
  State<StripeModel> createState() => _StripeModelState();
}

class _StripeModelState extends State<StripeModel> {
  int currenIndex = 0;
  SaveAddressController _addressController = Get.put(SaveAddressController());

  ProfileScreenController _profileScreenController = Get.find();
  IntroController _introController = Get.find();

  HomeScreenController _homeScreenController = Get.find();

  TabScreenController _tabScreenController = Get.put(TabScreenController());
  int offvalue = 0;
  double hourlyRate = 0;
  int hours = 0;
  bool paymentMethodSelected = false;
  int planId = 0;
  @override
  Widget build(BuildContext context) {
    hourlyRate = double.parse(_profileScreenController
        .providerProfileDetails.value.data.provider.providerProfile.hourlyRate);

    hours = _profileScreenController.time;

    print(_profileScreenController
        .providerProfileDetails.value.data.provider.packagePlans);
    return Scaffold(
      backgroundColor: const Color(0xffE0E0E0).withOpacity(0.5),
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconTheme.of(context).copyWith(color: black),
        title: Text(
          widget.hide ? "Payment Method" : "Checkout",
          style: const TextStyle(color: black),
        ),
        backgroundColor: white,
      ),
      body: Obx(() => Stack(
            children: [
              Container(
                color: Color(0xffE0E0E0).withOpacity(0.1),
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    // Expanded(
                    //     child: ListView(
                    //   children: [
                    //     for (int index = 0;
                    //         index < _addressController.checkOutList.length;
                    //         index++)
                    //       createCheckOutList(
                    //           index, _addressController.checkOutList.value),
                    //   ],
                    // )),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 12),
                      child: Card(
                        elevation: 0,
                        color: Color(0xffE0E0E0).withOpacity(0.1),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24)),
                        child: Column(
                            children: List.generate(
                                _addressController.checkOutList.length,
                                (index) {
                          return createCheckOutList(
                              index, _addressController.checkOutList.value);
                        })),
                      ),
                    ),
                    if (widget.fromService)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 12),
                        child: Card(
                          color: Colors.grey.shade50,
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 18),
                            child: Column(
                                children: List.generate(
                                    _profileScreenController
                                        .providerProfileDetails
                                        .value
                                        .data
                                        .provider
                                        .packagePlans
                                        .length, (index) {
                              PackagePlans _data = _profileScreenController
                                  .providerProfileDetails
                                  .value
                                  .data
                                  .provider
                                  .packagePlans[index];
                              if (currenIndex == index && currenIndex == 0) {
                                offvalue = _data.off;

                                currenIndex = index;
                                planId = _data.id;
                              }
                              print(_data);
                              return GestureDetector(
                                onTap: () {
                                  // hourlyRate = int.parse(
                                  //     _profileScreenController
                                  //         .providerProfileDetails
                                  //         .value
                                  //         .data
                                  //         .provider
                                  //         .providerProfile
                                  //         .hourlyRate);

                                  // hours = _profileScreenController.time;
                                  offvalue = _data.off;
                                  setState(() {
                                    currenIndex = index;
                                    planId = _data.id;
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 0, vertical: 6),
                                  child: Card(
                                    elevation: 1,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18)),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(18),
                                          border: Border.all(
                                              color: currenIndex == index
                                                  ? AppColors.solidBlue
                                                  : white)),
                                      width: Get.width,
                                      // height: 50,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 14),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  width: 25,
                                                  height: 25,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              90),
                                                      border: Border.all(
                                                          color: currenIndex ==
                                                                  index
                                                              ? AppColors
                                                                  .solidBlue
                                                              : const Color(
                                                                  0xffBDBDBD),
                                                          width: currenIndex ==
                                                                  index
                                                              ? 9
                                                              : 1)),
                                                ),
                                                8.width,
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "${_data.type}",
                                                      style: const TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color: Color(
                                                              0xff151415)),
                                                    ),
                                                    5.height,
                                                    Text(
                                                      // "Pay for a full ${_data.type}",
                                                      _data.type == "BiWeekly"
                                                          ? "Pay for a full  2 weeks"
                                                          : _data.type ==
                                                                  "Weekly"
                                                              ? "Pay for a full  week"
                                                              : _data.type ==
                                                                      "Yearly"
                                                                  ? "Pay for a full  year"
                                                                  : _data.type ==
                                                                          "Monthly"
                                                                      ? "Pay for a full month"
                                                                      : "".toLowerCase(),
                                                      style: const TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: Color(
                                                              0xff757575)),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Row(children: [
                                              Text(
                                                "${_data.off}%",
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w700,
                                                    color: Color(0xff151415)),
                                              ),
                                              const Text(
                                                " discount",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w400,
                                                    color: Color(0xff757575)),
                                              )
                                              // Text(
                                              //   _data.type == "BiWeekly"
                                              //       ? " /2 weeks"
                                              //       : _data.type == "Weekly"
                                              //           ? " /week"
                                              //           : _data.type == "Yearly"
                                              //               ? " /year"
                                              //               : _data.type ==
                                              //                       "Monthly"
                                              //                   ? "/month"
                                              //                   : "".toLowerCase(),
                                              //   style: TextStyle(
                                              //       fontSize: 12,
                                              //       fontWeight: FontWeight.w400,
                                              //       color: Color(0xff757575)),
                                              // )
                                            ])
                                          ]),
                                      // child: ListTile(
                                      //   title: Text("Yearly"),
                                      //   subtitle: Text("Pay for a full year"),
                                      //   leading: Container(),
                                      //   trailing: Row(
                                      //       children: [Text("Yearly"), Text("Yearly")]),
                                      // ),
                                    ),
                                  ),
                                ),
                              );
                            })),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.bottomCenter,

                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (!widget.fromService)
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: FarenowButton(
                                style: FarenowButtonStyleModel(
                                    padding: EdgeInsets.zero),
                                title: "Previous",
                                onPressed: () {
                                  Get.back();
                                },
                                type: BUTTONTYPE.outline),
                          ),
                        ),
                      // Flexible(
                      //   child: Padding(
                      //     padding: const EdgeInsets.symmetric(horizontal: 8),
                      //     child: AppButton(
                      //       padding: EdgeInsets.symmetric(
                      //           horizontal: 0, vertical: 12),
                      //       text: "Previous",
                      //       textColor: AppColors.solidBlue,
                      //       shapeBorder: RoundedRectangleBorder(
                      //           side: BorderSide(color: AppColors.solidBlue),
                      //           borderRadius: BorderRadius.circular(12)),
                      //     ),
                      //   ),
                      // ),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: FarenowButton(
                            style: FarenowButtonStyleModel(
                                padding: EdgeInsets.zero),
                            title: widget.fromService
                                ? "Make payment"
                                : "Process Request",
                            type: BUTTONTYPE.rectangular,
                            onPressed: () {
                              if (_addressController.cardIndex.value == -1) {
                                alertDialog(
                                    title: "Alert",
                                    content: "Please selected payment method",
                                    confirm: MaterialButton(
                                      onPressed: () {
                                        Get.back();
                                      },
                                      child: const Text("Okay"),
                                    ));
                                return;
                              }
                              if (!widget.fromService) {
                                Get.to(InvoiceOfPayment(
                                  hourlyRate: hourlyRate,
                                  discount: 0,
                                  hours: hours,
                                  serviceName: _introController.selectedService,
                                  providerName:
                                      "${_profileScreenController.providerProfileDetails.value.data.provider.firstName} ${_profileScreenController.providerProfileDetails.value.data.provider.lastName}",
                                  isPakcage: false,
                                  address:
                                      _introController.selectedAddress.value,
                                  onSubmit: () {
                                    if (getTotal(0, hourlyRate, hours)
                                            .toDouble() >
                                        0.4) {
                                      submitCard();
                                    } else if (getTotal(
                                            offvalue, hourlyRate, hours) ==
                                        "0.00") {
                                      submitCard();
                                    } else {
                                      alertDialog(
                                          title: "Alert",
                                          content:
                                              "After discount your price is less than \$0.5 but the base charges are \$0.5 so please increase number of hours or proceed with \$0.5",
                                          confirm: button(
                                              title: "Continue",
                                              onClick: () {
                                                submitCard();
                                              }),
                                          cancel: button(
                                              title: "Cancel",
                                              onClick: () {
                                                Get.back();
                                              }));
                                    }
                                  },
                                ));
                              } else {
                                if (currenIndex > -1) {
                                  Get.to(InvoiceOfPayment(
                                    serviceName:
                                        _introController.selectedService,
                                    providerName:
                                        "${_profileScreenController.providerProfileDetails.value.data.provider.firstName} ${_profileScreenController.providerProfileDetails.value.data.provider.lastName}",
                                    isPakcage: true,
                                    address:
                                        _introController.selectedAddress.value,
                                    hours: hours,
                                    hourlyRate: hourlyRate,
                                    discount: offvalue,
                                    onSubmit: () {
                                      if (getTotal(offvalue, hourlyRate, hours)
                                              .toDouble() >
                                          0.4) {
                                        submitCard();
                                      } else if (getTotal(
                                              offvalue, hourlyRate, hours) ==
                                          "0.00") {
                                        submitCard();
                                      } else {
                                        alertDialog(
                                            title: "Alert",
                                            content:
                                                "After discount your price is less than \$0.5 but the base charges are \$0.5 so please increase number of hours or proceed with \$0.5",
                                            confirm: button(
                                                title: "Continue",
                                                onClick: () {
                                                  submitCard();
                                                }),
                                            cancel: button(
                                                title: "Cancel",
                                                onClick: () {
                                                  Get.back();
                                                }));
                                      }
                                    },
                                  ));
                                } else {
                                  alertDialog(
                                      title: "Alert",
                                      content: "Please selected package",
                                      confirm: MaterialButton(
                                        onPressed: () {
                                          Get.back();
                                        },
                                        child: const Text("Okay"),
                                      ));
                                }
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // TextWithIcon(
                //   title: fromService ? "Make payment" : "Process Request",
                //   bgColor: AppColors.appBlue,
                //   width: Get.width,
                //   // paddingAll: 14,
                //   fontSize: 19,
                //   // marginRight: 24,
                //   // marginLeft: 24,
                //   // marginBottom: 12,
                //   allRadius: 12,
                //   fontColor: Colors.white,
                //   fontWeight: FontWeight.w700,
                //   containerClick: () {
                //     if (_addressController.cardIndex.value == -1) {
                //       alertDialog(
                //           title: "Alert",
                //           content: "Please selected payment method",
                //           confirm: MaterialButton(
                //             onPressed: () {
                //               Get.back();
                //             },
                //             child: Text("Okay"),
                //           ));
                //       return;
                //     }
                //     _submitCard();
                //   },
                // ),
              ),
            ],
          )),
    );
  }

  createCheckOutList(int index, List<dynamic> checkoutList) {
    MenuTypes value = checkoutList[index];
    return CustomContainer(
      // marginLeft: 12,
      alignment: Alignment.center,
      // marginRight: 12,
      width: Get.width,
      // color: Color(0xffE0E0E0).withOpacity(0.5),
      child: Column(
        children: [
          // const Divider(),
          // CustomContainer(
          //   // onTap: () {
          //   //   // print("list index ${checkoutList[index].selected}");
          //   //   // // for (int indexY = 0;
          //   //   // //     indexY < _addressController.checkOutList.length;
          //   //   // //     indexY++) {
          //   //   // //   if (index != indexY) {
          //   //   // //     _addressController.checkOutList.value[index].selected = false;
          //   //   // //   }
          //   //   // // }
          //   //   // bool flag = _addressController.checkOutList.value[index].selected;
          //   //   // flag = !checkoutList[index].selected;
          //   //   // print("flag $flag");
          //   //   // _addressController.checkOutList.value[index].selected = flag;
          //   //   // _addressController.checkOutList.refresh();
          //   // },
          //   paddingLeft: 12,
          //   paddingRight: 12,
          //   paddingTop: 12,
          //   width: Get.width,
          //   height: 50,
          //   alignment: Alignment.center,
          //   child: Column(
          //     children: [
          //       // Row(
          //       //   crossAxisAlignment: CrossAxisAlignment.center,
          //       //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       //   children: [
          //       //     TextWithIcon(
          //       //       title: widget.hide ? "Card List" : "${value.name}",
          //       //       fontSize: 17,
          //       //     ),
          //       //     // CustomContainer(
          //       //     //   child: Icon(
          //       //     //     value.selected
          //       //     //         ? Icons.keyboard_arrow_up
          //       //     //         : Icons.keyboard_arrow_down,
          //       //     //     size: 28,
          //       //     //   ),
          //       //     // )
          //       //   ],
          //       // ),
          //     ],
          //   ),
          // ),

          if (value.selected) expandAbleList(index)
        ],
      ),
    );
  }

  expandAbleList(int index) {
    String type = index == 0
        ? "cardList"
        : index == 1
            ? "addressList"
            : "deliveryMethod";
    return index == 0
        ? cardListView()
        : index == 1
            ? addressListView()
            : emptyContainer();
  }

  cardListView() {
    return Container(
      // color: Color(0xffE0E0E0).withOpacity(0.5),
      child: Column(
        children: [
          for (int index = 0;
              index < _addressController.crditCards.length;
              index++)
            CustomContainer(
              onTap: () {
                _addressController.cardIndex(index);
                _addressController.cardIndex.refresh();
              },
              height: 220,
              // paddingAll: 18,
              paddingTop: 16,
              paddingBottom: 16,
              width: Get.width,
              // borderColor: _addressController.cardIndex.value == index
              //     ? AppColors.appBlue
              //     : const Color(0xffeaeceb),
              borderWidth: 1,
              marginTop: index == 0 ? 0 : 8,
              child: GestureDetector(
                onLongPress: () {
                  alertDialog(
                    title: "Alert",
                    content: "Do you want to delete this?",
                    confirm: MaterialButton(
                      onPressed: () {
                        _addressController.deleteCard(
                            _addressController.crditCards.value[index].id);
                        Get.back();
                      },
                      child: const Text("Yes"),
                    ),
                    cancel: MaterialButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: const Text("No"),
                    ),
                  );
                },
                child: CreditCard(
                    cardNumber:
                        "**** **** **** ${_addressController.crditCards.value[index].last4}",
                    cardExpiry: "10/25",
                    cardHolderName: " ",
                    cvv: "456",
                    bankName:
                        "${_addressController.crditCards.value[index].brand}",
                    cardType: _addressController.crditCards.value[index].brand
                                .toString()
                                .toLowerCase() ==
                            "visa"
                        ? CardType.visa
                        : CardType
                            .masterCard, // Optional if you want to override Card Type
                    showBackSide: false,
                    frontBackground: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: _addressController.cardIndex.value == index
                                  ? Color(0xff0068E1).withOpacity(0.5)
                                  : const Color(0xffeaeceb),
                              width: 4),
                          borderRadius: BorderRadius.circular(42),
                          gradient: const LinearGradient(colors: [
                            Color(0xff3EB0E5),
                            Color(0xff0050AD),
                          ])),
                    ),
                    backBackground: Container(color: redColor),
                    showShadow: false,
                    width: double.infinity,
                    textExpDate: 'Exp Date:',
                    textName: '',
                    textExpiry: 'MM/YY'),
              ),

              //     Row(
              //   mainAxisAlignment: MainAxisAlignment.start,
              //   children: [
              //     getCard("${_addressController.crditCards.value[index].brand}"
              //         .toLowerCase()),
              //     Expanded(
              //       child: TextWithIcon(
              //         title:
              //             "**** **** **** ${_addressController.crditCards.value[index].last4}",
              //         alignment: MainAxisAlignment.start,
              //         marginLeft: 24,
              //         fontSize: 17,
              //       ),
              //     ),
              //     if (_addressController.cardIndex.value == index)
              //       Icon(
              //         Icons.check_circle,
              //         color: AppColors.appBlue,
              //       ),
              //     InkWell(
              //         onTap: () {
              // alertDialog(
              //   title: "Alert",
              //   content: "Do you want to delete this?",
              //   confirm: MaterialButton(
              //     onPressed: () {
              //       _addressController.deleteCard(
              //           _addressController.crditCards.value[index].id);
              //       Get.back();
              //     },
              //     child: const Text("Yes"),
              //   ),
              //   cancel: MaterialButton(
              //     onPressed: () {
              //       Get.back();
              //     },
              //     child: const Text("No"),
              //   ),
              // );
              //         },
              //         child: const Icon(
              //           Icons.delete,
              //           color: Colors.grey,
              //         )),
              //   ],
              // ),
            ),
          if (!widget.hide)
            CustomContainer(
              onTap: () {
                _addressController.cardIndex(-2);
                _addressController.cardIndex.refresh();
              },
              paddingAll: 8,
              width: Get.width,
              borderColor: _addressController.cardIndex.value == -2
                  ? AppColors.appBlue
                  : const Color(0xffeaeceb),
              borderWidth: 1,
              marginTop: 8,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(
                    Fontisto.dollar,
                    color: Colors.grey,
                  ),
                  Expanded(
                    child: TextWithIcon(
                      title: "Cash On Delivery",
                      alignment: MainAxisAlignment.start,
                      marginLeft: 24,
                      fontSize: 17,
                    ),
                  ),
                  if (_addressController.cardIndex.value == -2)
                    Icon(
                      Icons.check_circle,
                      color: AppColors.appBlue,
                    )
                ],
              ),
            ),
          if (_addressController.crditCards.length < 5) buildBottomContainer(),
          // TextWithIcon(
          //   containerClick: () {
          //     // Get.to(() => AddCardDetails());
          //     Get.to(() => AddCardDetails());
          //   },
          //   marginTop: 12,
          //   width: Get.width,
          //   icon: Icon(
          //     Icons.add,
          //     color: AppColors.appBlue,
          //   ),
          //   title: "Add Card",
          //   fontSize: 17,
          //   fontColor: AppColors.appBlue,
          // )
        ],
      ),
    );
  }

  addressListView() {
    return Column(
      children: [
        for (int index = 0;
            index < _addressController.addressList.length;
            index++)
          CustomContainer(
            onTap: () {
              _addressController.addressIndex(index);
              _addressController.addressIndex.refresh();
            },
            paddingAll: 8,
            width: Get.width,
            borderColor: _addressController.addressIndex.value == index
                ? AppColors.appBlue
                : const Color(0xffeaeceb),
            borderWidth: 1,
            marginTop: index == 0 ? 0 : 8,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextWithIcon(
                  title: "${_addressController.addressList.value[index].type}",
                  alignment: MainAxisAlignment.start,
                  fontSize: 17,
                ),
                Expanded(
                  child: TextWithIcon(
                    width: Get.width,
                    flex: 1,
                    title:
                        "${_addressController.addressList.value[index].address}",
                    alignment: MainAxisAlignment.start,
                    marginLeft: 24,
                    fontSize: 17,
                  ),
                ),
                if (_addressController.addressIndex.value == index)
                  Icon(
                    Icons.check_circle,
                    color: AppColors.appBlue,
                  ),
                InkWell(
                    onTap: () {
                      alertDialog(
                        title: "Alert",
                        content: "Do you want to delete this?",
                        confirm: MaterialButton(
                          onPressed: () {
                            _addressController.deleteAddress(_addressController
                                .addressList.value[index].id
                                .toString());
                            Get.back();
                          },
                          child: const Text("Yes"),
                        ),
                        cancel: MaterialButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: const Text("No"),
                        ),
                      );
                    },
                    child: const Icon(
                      Icons.delete,
                      color: Colors.grey,
                    )),
              ],
            ),
          ),
        if (_addressController.addressList.length < 5)
          TextWithIcon(
            containerClick: () {
              // Get.to(() => SelectAddress());
              Get.to(() => AddNewAddress());
            },
            marginTop: 12,
            width: Get.width,
            icon: Icon(
              Icons.add,
              color: AppColors.appBlue,
            ),
            title: "Add Address",
            fontSize: 17,
            fontColor: AppColors.appBlue,
          )
      ],
    );
  }

  buildBottomContainer() {
    return _addressController.crditCards.length == 5
        ? emptyContainer()
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
            child: GestureDetector(
              onTap: () {
                // Get.to(AddCardDetails());
                // Get.to(SelectMethod(
                //   formService: false,
                // ));
                Get.to(() => AddCardDetails(
                      method: "VISA",
                    ));
              },
              child: FDottedLine(
                color: AppColors.solidBlue,
                corner: FDottedLineCorner.all(12),
                child: Container(
                  alignment: Alignment.center,
                  width: Get.width,
                  height: 48,
                  decoration: BoxDecoration(
                      color: white, borderRadius: BorderRadius.circular(12)),
                  child: const Text(
                    "+ Add New Card",
                    style: TextStyle(
                        color: AppColors.solidBlue,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
          );
  }

  getCartIds(FoodCartModel value) {
    print("");
    List ids = [];
    for (int index = 0; index < value.foodCart.length; index++) {
      ids.add(value.foodCart[index].id);
    }
    return ids;
  }

  Future<void> submitCard({lessthan = false}) async {
    Get.focusScope!.unfocus();
    try {
      var cardID =
          "${_addressController.crditCards.value[_addressController.cardIndex.value].id}";
      if (widget.data == null) {
        widget.body["card_id"] = cardID;

        widget.body["is_hourly"] = true;
        if (widget.fromService) {
          widget.body["plan_id"] = planId;
        }
        // widget.body["slots"] = "464";
        print(widget.body);

        _profileScreenController.bookNow(
            body: widget.body,
            flag: false,
            tabScreenController: _tabScreenController,
            onsubmit: () {
              if (widget.fromService) {
                Get.offAll(SubscriptionSuccess());
              } else {
                Get.offAll(CelebrateScreen(
                    imageUrl: "assets/user_assets/svg/celebrate.svg",
                    buttonText: "Done",
                    onTap: () {
                      Get.offNamedUntil(AppRoutes.TABSCREEN, (route) => false);
                    },
                    successMsg: "Request Processed",
                    detail: "Your service have been booked successfully"));
              }
            });
      } else {
        Map body = <String, dynamic>{
          "payable_id": widget.payableId,
          "card_id": cardID
        };
        print(body);
        _profileScreenController.payDueAmount(
            body: body,
            flag: true,
            onUpdate: () {
              if (widget.back == null) {
                Get.offNamedUntil(AppRoutes.TABSCREEN, (route) => false);
              } else {
                Get.back();
                Get.back();
              }
              Future.delayed(const Duration(seconds: 2)).then((value) {
                Get.dialog(FeedBackPage(
                  data: widget.data,
                  onRateComplete: () {
                    Get.back();
                    _homeScreenController.getAvailableJobs(flag: true);
                  },
                ));
              });
            });
      }
    } catch (error) {
      AppDialogUtils.dismiss();
    }
  }
}

/*
import 'package:application_1/AllPages/ExplorePages/selectAddress.dart';
import 'package:application_1/AllPages/ExplorePages/shopMenu.dart';
import 'package:application_1/AllPages/save_address_controller.dart';
import 'package:application_1/model/card/credit_card_data.dart';
import 'package:application_1/model/cart_model/food_cart_model.dart';
import 'package:application_1/restaurant_controller/cart_controller.dart';
import 'package:application_1/reuseableWidgets/reuseableSizedbox.dart';
import 'package:application_1/reuseableWidgets/reuseblueButton.dart';
import 'package:application_1/utils/AppColors.dart';
import 'package:application_1/utils/widgest_utills.dart';
import 'package:application_1/widgets/custom_container.dart';
import 'package:application_1/widgets/getLocation.dart';
import 'package:application_1/widgets/text_with_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class CartAddress extends StatelessWidget {
  bool paymentBox = false;
  String txt = "";

  CartAddress({this.paymentBox, this.txt});

  CartController _cartController = Get.find();

  SaveAddressController _addressController = Get.put(SaveAddressController());
  bool paymentMethodSelected = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double w = size.width;
    double h = size.height;
    return Scaffold(
      appBar: AppBar(
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
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Checkout",
              style: Theme.of(context).textTheme.headline6,
            ),
          ],
        ),
      ),
      body: Container(
        color: Colors.white.withOpacity(0.1),
        child: Obx(() => Column(
              children: [
                // buildUpperContainer(w, h),
                buildPaymentContainer(),
                Expanded(
                  child: SizedBox(
                    height: 140,
                  ),
                ),
                buildBottomContainer(w, h, context)
              ],
            )),
      ),
    );
  }

  buildPaymentContainer() {
    return CustomContainer(
      width: Get.width,
      marginAll: 15,
      shadowColor: Colors.black.withOpacity(0.5),
      shadowBlurRadius: 5,
      shadowSpreadRadius: 3,
      color: Colors.white,
      allRadius: 12,
      paddingAll: 12,
      shadowOffsetY: 3,
      shadowOffsetX: 3,
      child: Column(
        children: [
          TextWithIcon(
              title: "Please Enter Your Details",
              fontSize: 18,
              fontWeight: FontWeight.w600),
          if (_addressController.selectedCard.value.id != null)
            Column(
              children: [
                SizedBox(
                  height: 18,
                ),
                CustomContainer(
                  onTap: () {
                    if (_cartController.cashOnDelivery.value) {
                      _cartController.cashOnDelivery.value =
                          !_cartController.cashOnDelivery.value;
                      _cartController.cashOnDelivery.refresh();
                      paymentMethodSelected = true;
                    }
                  },
                  child: Row(
                    children: [
                      createIcon(
                          check: _cartController.cashOnDelivery.value
                              ? false
                              : true),
                      buildListTile(),
                    ],
                  ),
                ),
              ],
            ),
          BuildSizedBox(5),
          TextWithIcon(
            marginTop: 12,
            icon: createIcon(check: _cartController.cashOnDelivery.value),
            title: "Cash On Delivery",
            fontSize: 14,
            containerClick: () {
              print("");
              if (!_cartController.cashOnDelivery.value) {
                _cartController.cashOnDelivery.value =
                    !_cartController.cashOnDelivery.value;
                _cartController.cashOnDelivery.refresh();
                paymentMethodSelected = true;
              }
            },
            fontWeight: FontWeight.w600,
          ),
        ],
      ),
    );
  }

  createIcon({bool check}) {
    return !check
        ? Icon(Icons.radio_button_off, color: AppColors.appGreen)
        : FaIcon(FontAwesome.check_circle, color: AppColors.appGreen);
  }

  Widget buildUpperContainer(double w, h) {
    return CustomContainer(
      color: Colors.white,
      shadowColor: Colors.black.withOpacity(0.5),
      marginTop: 15,
      marginLeft: 15,
      marginRight: 15,
      allRadius: 12,
      shadowOffsetX: 3,
      shadowOffsetY: 3,
      shadowBlurRadius: 5,
      shadowSpreadRadius: 2,
      width: w,
      child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  width: w,
                  height: h * 0.038,
                  child: Text(
                    "Delivery Address",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ),
                BuildSizedBox(h * 0.01),
                Container(
                  width: w,
                  height: h * 0.209,
                  child: GetLocation(
                    w: w,
                    h: h,
                  ),
                ),
                BuildSizedBox(h * 0.01),
                Container(
                  alignment: Alignment.centerLeft,
                  width: w,
                  height: h * 0.038,
                  child: Text(
                    "Subway Eat Fresh",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  width: w,
                  height: h * 0.038,
                  child: Text(
                    "1 Manchester Ave Zurich Lake, IL 60047",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w200),
                  ),
                ),
              ],
            ),
          )),
    );
  }

  Widget buildBottomContainer(double w, double h, BuildContext context) {
    return CustomContainer(
      width: w,
      color: white,
      shadowColor: Colors.black.withOpacity(0.5),
      shadowBlurRadius: 6,
      shadowSpreadRadius: 5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              width: w,
              height: h * 0.2,
              color: Colors.white,
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Payment Method",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: Column(
                      children: [
                        ListTile(
                          onTap: () {
                            _addressController.getCreditCard();
                          },
                          leading: Icon(Icons.add, color: blue),
                          title: Text(
                            "Add Payment Method",
                            style: TextStyle(color: blue),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  // buildRow(context, "Total", "342.0"),
                  buildRow(
                    context,
                    TextWithIcon(
                      title: "Subtotal",
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                    TextWithIcon(
                      title:
                          "RS ${_cartController.getSubtotalPrice(_cartController.summaryList.value)}",
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  BuildSizedBox(5),
                  ReuseableBlueButton(
                    w: w,
                    h: h,
                    text: txt,
                    onTap: () async {
                      await _addressController.getAddress();
                      paymentMethodSelected = checkSelection();
                      if (!paymentMethodSelected) {
                        snackBar("Please selected payment method", context);
                        return;
                      }
                      var cardIds = getCartIds(_cartController.foodCart.value);

                      Map body = <String, dynamic>{
                        "cart_ids": cardIds,
                        "address": "new order"
                      };

                      if (_cartController.cashOnDelivery.value) {
                        body['type'] = "CASH_ON_DELIVERY";
                        body.remove("card_id");
                      } else {
                        body['card_id'] =
                            "${_addressController.selectedCard.value.id}";
                        body.remove("key");
                      }
                      Get.to(() => SelectAddress(body: body));
                    },
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding buildRow(BuildContext context, head, price) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [head, price],
      ),
    );
  }

  buildListTile() {
    CreditCardData value = _addressController.selectedCard.value;
    return Row(
      children: [
        CustomContainer(
          width: 20,
          height: 25,
          marginLeft: 16,
          marginRight: 24,
          child: getCard(value.brand.toLowerCase()),
        ),
        Column(
          children: [
            TextWithIcon(
              title: "${value.brand}",
              fontSize: 16,
            ),
            TextWithIcon(
              title: ".......${value.last4}",
              fontSize: 14,
              fontColor: Colors.grey,
            ),
          ],
        )
      ],
    );
  }

  bool checkSelection() {
    if (_addressController.selectedCard.value.id != null) {
      return true;
    }
    if (_cartController.cashOnDelivery.value) {
      return true;
    }
    return false;
  }

  getCartIds(FoodCartModel value) {
    print("");
    List ids = [];
    for (int index = 0; index < value.foodCart.length; index++) {
      ids.add(value.foodCart[index].id);
    }
    return ids;
  }
}
*/

/*
import 'package:application_1/AllPages/ExplorePages/Controllers/profile_controller.dart';
import 'package:application_1/AllPages/ProjectPages/controller/home_screen_controller.dart';
import 'package:application_1/AllPages/feed_back_page.dart';
import 'package:application_1/App_Routes/app_routes.dart';
import 'package:application_1/utils/AppColors.dart';
import 'package:application_1/utils/api_utils.dart';
import 'package:application_1/utils/app_dialog_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:get/get.dart';
import 'package:stripe_payment/stripe_payment.dart';

class StripeModel extends StatefulWidget {
  final body;
  final ValueChanged<String> onPageChange;
  final data;
  final payableId;
  final back;

  StripeModel(
      {Key key,
      this.onPageChange,
      this.body,
      this.data,
      this.back,
      this.payableId})
      : super(key: key);
  static const routeName = 'stipeScreen';

  @override
  _StripeModelState createState() => _StripeModelState();
}

class _StripeModelState extends State<StripeModel> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  bool _isLoading = false;
  ProfileScreenController _profileScreenController = Get.find();
  HomeScreenController _homeScreenController = Get.find();

  //function to check if card is valid or not
  void _showErrorDialog(String message) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text('An Error Occured'),
              content: Text(message),
              actions: <Widget>[
                FlatButton(
                    onPressed: () => Navigator.of(ctx).pop(),
                    child: Text('Okay'))
              ],
            ));
  }

  Future<void> _submitCard() async {
    Get.focusScope.unfocus();
    try {
      setState(() {
        final CreditCard _creditCard = CreditCard(
          number: cardNumber,
          expMonth: int.parse(expiryDate.split("/")[0]),
          expYear: int.parse(expiryDate.split("/")[1]),
          name: cardHolderName,
          cvc: cvvCode,
        );
        AppDialogUtils.dialogLoading();
        StripePayment.createTokenWithCard(_creditCard).then((value) {
          if (widget.data == null) {
            print(value.tokenId);
            widget.body["token"] = value.tokenId;

            widget.body["is_hourly"] = "1";
            // widget.body["slots"] = "464";
            print(widget.body);
            _profileScreenController.bookNow(body: widget.body, flag: true);
          } else {
            Map body = <String, dynamic>{
              "payable_id": widget.payableId,
              "token": value.tokenId
            };
            _profileScreenController.payDueAmount(
                body: body,
                flag: true,
                onUpdate: () {
                  if (widget.back == null) {
                    Get.offNamedUntil(AppRoutes.TABSCREEN, (route) => false);
                  } else {
                    Get.back();
                    Get.back();
                  }
                  Future.delayed(Duration(seconds: 2)).then((value) {
                    Get.dialog(FeedBackPage(
                      data: widget.data,
                      onRateComplete: () {
                        Get.back();
                        _homeScreenController.getAvailableJobs(flag: true);
                      },
                    ));
                  });
                });
          }
        });
      });
    } catch (error) {
      AppDialogUtils.dismiss();
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    StripePayment.setOptions(StripeOptions(
        publishableKey: publishKey,
        merchantId: merchantId,
        androidPayMode: paymentMode));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Payment",
          style: TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 25,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            CreditCardWidget(
              cardNumber: cardNumber ?? "",
              expiryDate: expiryDate ?? "",
              cardHolderName: cardHolderName ?? "",
              cvvCode: cvvCode ?? "",
              showBackView: isCvvFocused ?? "",
              onCreditCardWidgetChange: (CreditCardBrand) {
                print("");
              },
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    CreditCardForm(
                      themeColor: Colors.cyan,
                      onCreditCardModelChange: onCreditCardModelChange,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(16),
              width: Get.width,
              child: FlatButton.icon(
                onPressed: _submitCard,
                color: AppColors.appGreen,
                label: Text(
                  'Pay',
                  style: TextStyle(color: Colors.white),
                ),
                icon: Icon(
                  Icons.payment_outlined,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onCreditCardModelChange(creditCardModel) {
    setState(() {
      cardNumber = creditCardModel.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }
}
*/
/*
_profileScreenController.bookNow(
                                body: body, question: question);
 */
