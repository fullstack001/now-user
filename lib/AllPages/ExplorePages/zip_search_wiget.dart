import 'package:application_1/AllPages/introPages/intro_controller.dart';
import 'package:application_1/AllPages/introPages/questionPages/PageModels.dart';
import 'package:application_1/components/buttons-management/farenow_button.dart';
import 'package:application_1/components/buttons-management/part_of_file/part.dart';
import 'package:application_1/components/buttons-management/style_model.dart';
import 'package:application_1/components/text_fields/farenow_text_field.dart';
import 'package:application_1/model/location_detail/location_detail_response.dart';

import 'package:application_1/remote_model/country/country_data.dart';
import 'package:application_1/resources/Api_Services/services.dart';
import 'package:application_1/utils/AppColors.dart';
import 'package:application_1/utils/AppString.dart';
import 'package:application_1/utils/api_utils.dart';
import 'package:application_1/utils/app_dialog_utils.dart';
import 'package:application_1/widgets/conditions_dialog.dart';
import 'package:application_1/widgets/country_dialog.dart';
import 'package:application_1/widgets/text_with_icon.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:jumping_dot/jumping_dot.dart';
import 'package:loading_overlay_pro/loading_overlay_pro.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../model/postal_code/results.dart';
import '../../remote_model/country/cities.dart';
import '../../remote_model/country/zips.dart';
import '../ProjectPages/controller/home_screen_controller.dart';

var zipCodeTyped;

class ZipSearchWiget extends StatefulWidget {
  final update;

  final title;

  final hint;

  final inApp;

  final zipCode;
  final previous;

  ZipSearchWiget(
      {Key? key,
      this.zipCode,
      this.inApp,
      this.update,
      this.title,
      this.hint,
      this.previous})
      : super(key: key);

  @override
  _ZipSearchWigetState createState() => _ZipSearchWigetState();
}

class _ZipSearchWigetState extends State<ZipSearchWiget>
    with TickerProviderStateMixin {
  TextEditingController addressController = TextEditingController();
  HomeScreenController _homeScreenController = Get.find();
  IntroController introController = Get.find();
  Color black = AppColors.black;
  Color white = AppColors.white;
  Color blue = AppColors.blue;
  var _controller = ScrollController();
  bool hasFocus = false;
  var focusNode = FocusNode();
  var keyboardVisibilityController = KeyboardVisibilityController();

  @override
  void initState() {
    super.initState();

    // _controller.addListener(() {
    //   if (introController.zipCodeList.isNotEmpty && widget.inApp) {
    //     if (_controller.position.atEdge) {
    //       if (_controller.position.pixels != 0) {
    //         var list = getList(introController.zipCodeList.value);

    //         var pageSize = ((list.length / 20).ceilToDouble().toInt()) + 1;
    //         var currentPage = ((list.length / 20).floorToDouble().toInt());
    //         currentPage = currentPage == 0 ? currentPage + 1 : currentPage;
    //         int page = currentPage * 20;
    //         //
    //         if (list.length == page) {
    //           loading = true;
    //           print("pagination");
    //           introController.searchZipCode(zipCodeTyped,
    //               pageSize: pageSize,
    //               subId: introController.selectedServiceId, upDate: () {
    //             loading = false;
    //             setState(() {});
    //           });
    //           setState(() {});
    //         } else {
    //           print("pagination out");
    //         }
    //       }
    //     }
    //   }
    // });
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool loading = false;
  bool firstInit = false;
  var inApp;

  var hint;
  var title;
  var zipCode;
  var update;
  var inAppSearch;
  List<Zips>? zipsList = [];
  String label = "";

  @override
  Widget build(BuildContext context) {
    // Get.focusScope!.unfocus();
    // firstInit = false;
    if (!firstInit) {
      firstInit = true;
      inApp = widget.inApp ?? false;
      zipCode = widget.zipCode;
      hint = widget.hint;
      title = widget.title;
      update = widget.update;
      inAppSearch = inApp ?? false;
    }
    if (!inAppSearch) {
      addressController.text = introController.address.value;
    } else {
      // addressController.text =
      //     zipCode.toString().isEmpty ? zipCodeTyped : zipCo de;
    }
    if (introController.address.value.isEmpty) {
      print(":");
    }

    return Obx(() {
      var selectedCityId = _homeScreenController.cityId.value;
      List locList = introController.locationList.value;
      List<dynamic> countries = _homeScreenController.countryList.value;
      // List<Zips>? zipCodes = getZipCodes(selectedCityId, countries);
      // List<Zips>? zipsList = getZipCodes(selectedCityId, countries);
      label = _homeScreenController.cityName.value;
      if (_homeScreenController.zipFilters.isNotEmpty) {
        // zipCodes = _homeScreenController.zipFilters.value
        //     .map((val) => Zips(code: val.code, id: val.id))
        //     .toList();
      } else {
        zipCode = zipsList;
      }
      return ListView(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: Get.width * 0.4,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 2,
              color: white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                width: Get.width,
                // height: Get.width * 0.7,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: Get.width,
                      height: 90,
                      alignment: Alignment.topCenter,
                      padding:
                          EdgeInsets.symmetric(vertical: 18, horizontal: 22),
                      child: Text(
                        title ?? "Search Providers by zip code",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w700),
                      ),
                    ),
                    // if (_homeScreenController.countryList.isNotEmpty)
                    //   SizedBox(
                    //     height: 12,
                    //   ),
                    // if (_homeScreenController.countryList.isNotEmpty)
                    //   dropDownList(
                    //       _homeScreenController.countryList.value,
                    //       _homeScreenController.selectedId.value,
                    //       _homeScreenController.cityId.value,
                    //       _homeScreenController.selectedCountryIndex.value),

                    TextFormField(
                      // initialValue: introController.selectedAddrexx.value,
                      controller: addressController,
                      // getController(introController.selectedAddrexx.value),
                      focusNode: focusNode,
                      keyboardType: TextInputType.text,

                      onFieldSubmitted: (value) {
                        Get.focusScope!.unfocus();
                      },
                      onChanged: (value) async {
                        zipCodeTyped = value;
                        if (update != null) {
                          update(value);
                        }
                        introController.selectedAddrexx(value);
                        if (!inAppSearch) {
                          introController.address(value);
                          if (value.isEmpty) {
                            introController.predictionResults.clear();
                            var empty = [];
                            introController.address("");
                            introController.predictionResults(empty);
                            return;
                          } else {
                            await Services()
                                .searchPlaceByZip(value)
                                .then((value) {
                              if (value != null) {
                                print("$value");
                                introController
                                    .predictionResults(value.predictions);
                              }
                            });

                            // Future.delayed(Duration(seconds: 0))
                            //     .then((valu) async {
                            //   // var result =
                            //   //     await Services().searchPlaceByZip(value);
                            //   // print("$result");
                            //   // introController
                            //   //     .predictionResults(result.predictions);
                            // });
                          }
                        } else {
                          if (value.length > 0) {
                            var cityId = _homeScreenController.cityId.value;
                            var countryId =
                                _homeScreenController.selectedId.value;
                            // _homeScreenController.zipFilters.clear();
                            // for (int index = 0;
                            //     index < zipsList!.length;
                            //     index++) {
                            //   if (zipsList[index].code!.contains(value)) {
                            //     _homeScreenController.zipFilters
                            //         .add(zipsList[index]);
                            //   }
                            // }
                            // _homeScreenController.zipFilters.refresh();
                            // introController.searchZipCode(value,
                            //     subId: introController.selectedServiceId,
                            //     cityId: cityId,
                            //     countryId: countryId);

                            introController.searchPlace(value);
                          }
                          if (value.isEmpty) {
                            _homeScreenController.zipFilters.clear();
                            introController.zipCodeList.clear();
                            introController.zipCodeList.refresh();
                          }
                        }
                        // setSelection(addressController);
                      },
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(
                              Icons.close,
                              color: Color(0xff555555),
                            ),
                            onPressed: () {
                              setState(() {
                                controller.selectedAddrexx.value = "";
                                addressController.text = "";
                              });
                            },
                          ),
                          prefixIcon: Icon(
                            Icons.location_on_outlined,
                            color: Color(0xff555555),
                          ),
                          hintText: hint ?? "Enter your address",
                          fillColor: white,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),
                              borderSide: BorderSide(color: blue, width: 1)),
                          hintStyle: TextStyle(color: Color(0xff555555))),
                    ),

                    Container(
                      width: Get.width,
                      height: 80,
                      child: inApp
                          ? getZipCodeList(
                              update,
                              introController.zipCodeList.value,
                              addressController,
                              _controller,
                              locList,
                            )
                          : introController.address.isEmpty
                              ? Container()
                              : Container(
                                  alignment: Alignment.topCenter,
                                  child: ListView.builder(
                                    itemCount: introController
                                        .predictionResults.value.length,
                                    itemBuilder: (context, index) {
                                      if (introController.address.isEmpty) {
                                        print("empty");
                                      }
                                      return InkWell(
                                        onTap: () async {
                                          Get.focusScope!.unfocus();
                                          print(
                                              "${introController.predictionResults.value[index].description}");
                                          introController.address(
                                              introController.predictionResults
                                                  .value[index].description);

                                          String placeId = introController
                                              .predictionResults
                                              .value[index]
                                              .placeId;
                                          // final request =
                                          //     'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&fields=address_component&key=AIzaSyA8qxfA7q_7adQ75SebuC2qgogFZ-I7FN8&sessiontoken=123345667';
                                          // String key =
                                          //     "AIzaSyA8qxfA7q_7adQ75SebuC2qgogFZ-I7FN8";
                                          String key =
                                              "AIzaSyDM06VJYrW1xHW4F4zvL1Bt4lgcF7YgZ7U";
                                          String request =
                                              "https://maps.googleapis.com/maps/api/place/details/json?placeid=$placeId&key=${ApiUtills.mapKey}";
                                          Dio dio = Dio();
                                          var response =
                                              await dio.post(request);
                                          print("");

                                          LocationDetailResponse detail =
                                              LocationDetailResponse.fromJson(
                                                  response.data);
                                          // response.data['result']['address_components'][0]['long_name']
                                          if (detail.status.toLowerCase() ==
                                              "ok") {
                                            introController.components(detail
                                                .result.addressComponents);
                                          }

                                          var zipCode =
                                              introController.getPostalCode(
                                                  introController.components);

                                          introController.zipCode(zipCode);

                                          print("click on zip list");

                                          introController.predictionResults
                                              .clear();
                                          var empty = [];
                                          introController
                                              .predictionResults(empty);
                                          if (update != null) {
                                            update(
                                                introController.zipCode.value);
                                          }
                                        },
                                        child: Container(
                                          padding: EdgeInsets.only(
                                              top: 8, bottom: 8),
                                          child: Text(
                                            "${introController.predictionResults.value[index].description}",
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                    ),

                    Container(
                      child: Row(children: [
                        Flexible(
                          fit: FlexFit.tight,
                          child: FarenowButton(
                              style: FarenowButtonStyleModel(
                                  padding: EdgeInsets.symmetric(horizontal: 8)),
                              title: "Previous",
                              onPressed: widget.previous,
                              type: BUTTONTYPE.action),
                        ),
                        Flexible(
                          fit: FlexFit.tight,
                          child: FarenowButton(
                              style: FarenowButtonStyleModel(
                                  padding: EdgeInsets.symmetric(horizontal: 8)),
                              title: "Done",
                              onPressed: () {
                                if (introController.selectZipCode.isNotEmpty &&
                                    addressController.text.isNotEmpty) {
                                  showModalBottomSheet(
                                      isDismissible: true,
                                      constraints: BoxConstraints(
                                          maxHeight: Get.height,
                                          maxWidth: Get.width),
                                      isScrollControlled: true,
                                      context: context,
                                      builder: (context) {
                                        return Container(
                                          color: Colors.white,
                                          child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 50),
                                                  width: Get.width,
                                                  height: 100,
                                                  child: const FittedBox(
                                                    fit: BoxFit.fitWidth,
                                                    child: Image(
                                                      fit: BoxFit.cover,
                                                      image: AssetImage(
                                                          "assets/user_assets/png/logo.png"),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  padding:
                                                      const EdgeInsets.all(22),
                                                  alignment: Alignment.center,
                                                  width: double.infinity,
                                                  height: 100,
                                                  child: Text(
                                                      "please wait we are finding provider for you"
                                                          .capitalizeFirst
                                                          .toString(),
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: const TextStyle(
                                                          fontSize: 24,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ),
                                                Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            15.0),
                                                    child: Column(
                                                      children: <Widget>[
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      20),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Text(
                                                                "finding "
                                                                    .capitalizeFirst
                                                                    .toString(),
                                                                style: const TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    fontSize:
                                                                        18),
                                                              ),
                                                              const JumpingDots(
                                                                color: Colors
                                                                    .black45,
                                                                radius: 6,
                                                                numberOfDots: 5,
                                                                animationDuration:
                                                                    Duration(
                                                                        milliseconds:
                                                                            200),
                                                              ),
                                                            ],
                                                          ),
                                                          //     FittedBox(
                                                          //   child:
                                                          //       LoadingPercentage(
                                                          //     isLineLoading:
                                                          //         true,
                                                          //     isLoading:
                                                          //         true,
                                                          //     timer: const Duration(
                                                          //         seconds:
                                                          //             3),
                                                          //     overLoading:
                                                          //         Row(
                                                          //       children: [
                                                          //         Text(
                                                          //           "finding "
                                                          //               .capitalizeFirst
                                                          //               .toString(),
                                                          //           style: const TextStyle(
                                                          //               fontWeight: FontWeight.w400,
                                                          //               fontSize: 18),
                                                          //         ),
                                                          //         const JumpingDots(
                                                          //           color:
                                                          //               Colors.black45,
                                                          //           radius:
                                                          //               6,
                                                          //           numberOfDots:
                                                          //               5,
                                                          //           animationDuration:
                                                          //               Duration(milliseconds: 200),
                                                          //         ),
                                                          //       ],
                                                          //     ),
                                                          //     paintingStyle:
                                                          //         PaintingStyle
                                                          //             .stroke,
                                                          //     strokeCap:
                                                          //         StrokeCap
                                                          //             .round,
                                                          //     strokeJoin:
                                                          //         StrokeJoin
                                                          //             .miter,
                                                          //     strokeWidth:
                                                          //         16,
                                                          //     bottomLoading:
                                                          //         Container(),
                                                          //     backgroundColor:
                                                          //         white,
                                                          //     colorLoading:
                                                          //         blue,
                                                          //     showProgress:
                                                          //         true,
                                                          //     colorBackgroudLoading:
                                                          //         white,
                                                          //     child:
                                                          //         const Text(
                                                          //             ""),
                                                          //   ),
                                                          // ),
                                                        )
                                                      ],
                                                    ))
                                              ]),
                                        );
                                      });

                                  introController.getProviderList(
                                      // introController.selectZipCode.value,
                                      introController.selectedServiceId,
                                      introController.selectedAddrexx.value);
                                  addressController.text = "";

                                  // introController.selectZipCode.value = "";
                                  // introController.selectedAddrexx.value = "";
                                }
                              },
                              type: BUTTONTYPE.rectangular),
                        ),
                      ]),
                    ),
                    12.height,
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    });
  }

  Widget getZipCodeList(
      update,
      var value,
      TextEditingController addressController,
      ScrollController controller,
      locList) {
    List<dynamic> value1 = value;
    List<dynamic> value2 = value;

    value = getList(value);
    // return zipCodes!.isEmpty
    //     ? TextWithIcon(
    //         width: Get.width,
    //         height: Get.height,
    //         fontSize: 18,
    //         title: "Provider list is empty",
    //       )
    //     :
    return locList.isNotEmpty
        ? Container(
            child: ListView.builder(
              controller: _controller,
              itemCount: locList.length,
              itemBuilder: (BuildContext context, int index) {
                // Zips data = zipCodes[index];

                Results value = locList[index];
                int size = locList.length - 1;
                return Container(
                  margin: EdgeInsets.only(
                    top: index == 0 ? 12 : 0,
                    bottom: index == size ? 12 : 0,
                  ),
                  width: Get.width,
                  child: InkWell(
                    onTap: () {
                      Get.focusScope!.unfocus();
                      if (update != null) {}

                      introController.selectZipCode(
                          value.addressComponents.first.longName);
                      // introController.selectedAddrexx(value.formattedAddress);
                      introController.selectedAddrexx(value.placeId);

                      addressController.text = value.formattedAddress;
                      introController.locationList.clear();
                      introController.locationList.refresh();
                      setState(() {});
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: Get.width,
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${value.formattedAddress}",
                            style: TextStyle(fontSize: 16),
                          ),
                          Divider()
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        : Container();
  }

  List<dynamic> getList(List<dynamic> value) {
    List<dynamic> list = [];
    list.addAll(value);

    return value;
  }

  Future<void> _checkPermission() async {
    final serviceStatus = await Permission.locationWhenInUse.serviceStatus;
    // ignore: unrelated_type_equality_checks
    final isGpsOn = serviceStatus == serviceStatus.isEnabled;
    if (!isGpsOn) {
      print('Turn on location services before requesting permission.');
      return;
    }

    final status = await Permission.locationWhenInUse.request();
    if (status == PermissionStatus.granted) {
      print('Permission granted');
    } else if (status == PermissionStatus.denied) {
      print(
          'Permission denied. Show a dialog and again ask for the permission');
    } else if (status == PermissionStatus.permanentlyDenied) {
      print('Take the user to the settings page.');
      await openAppSettings();
    }
  }

  _getCurrentLocation() {
    Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best,
            forceAndroidLocationManager: true)
        .then((Position position) {
      print("");
    }).catchError((e) {
      print(e);
    });
  }

  getController(String value) {
    addressController.text = value;
    setSelection(addressController);
    return addressController;
  }

  dropDownList(List<dynamic> valuex, countryId, cityId, selectedCountryIndex) {
    var selectedCityId = _homeScreenController.selectedCountryIndex.value;
    List<dynamic> countries = _homeScreenController.countryList.value;
    List<dynamic> cities = getcities(selectedCityId, countries);
    cities.sort((a, b) => a.name
        .toString()
        .toLowerCase()
        .compareTo(b.name.toString().toLowerCase()));
    valuex.sort((a, b) => a.name
        .toString()
        .toLowerCase()
        .compareTo(b.name.toString().toLowerCase()));
    return Row(
      children: [
        Expanded(
            child: Container(
          padding: EdgeInsets.only(left: 8),
          alignment: Alignment.centerLeft,
          height: 40,
          color: Colors.grey.withOpacity(0.3),
          child: SizedBox(
            width: Get.width,
            child: InkWell(
              onTap: () {
                Get.dialog(CountryDialog(
                  countriesList: valuex,
                ));
              },
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      child: Text("${getCountryName(valuex, countryId)}"),
                    ),
                  ),
                  Icon(Icons.arrow_drop_down)
                ],
              ),
            )
            /*PopupMenuButton(
              color: AppColors.appBlue,
              child: ,
              onSelected: (value) {
                for (int index = 0; index < valuex.length; index++) {
                  if (valuex[index].id == value) {
                    _homeScreenController.selectedId.value =
                        int.parse((value).toString());
                    _homeScreenController.selectedCountryIndex.value = index;

                    if (_homeScreenController
                        .countryList.value[index].cities.isNotEmpty) {
                      int idd = _homeScreenController
                          .countryList.value[index].cities.first.id;
                      _homeScreenController.cityId(idd);
                    }
                    _homeScreenController.selectedCountryIndex.refresh();
                  }
                }
              },
              itemBuilder: (context) => valuex
                  .map((e) => PopupMenuItem(
                        value: e.id,
                        child: Text(
                          "${e.name}",
                          style: TextStyle(color: white),
                        ),
                      ))
                  .toList(),
            )*/
            ,
          ),
        )),
        SizedBox(
          width: 12,
        ),
        Expanded(
            child: InkWell(
          onTap: () {
            var selectedCityId =
                _homeScreenController.selectedCountryIndex.value;
            List<dynamic> countries = _homeScreenController.countryList.value;
            List citiez = getcities(selectedCityId, countries);
            Get.dialog(ConditionsDialog(
              citiesList: citiez,
            ));
          },
          child: Container(
            padding: EdgeInsets.only(left: 8),
            alignment: Alignment.centerLeft,
            height: 40,
            color: Colors.grey.withOpacity(0.3),
            child: Container(
              width: Get.width,
              height: 50,
              child: Row(
                children: [
                  Expanded(child: Text(label)),
                  Icon(Icons.arrow_drop_down_rounded)
                ],
              ),
            ),
          ),
        )),
      ],
    );
  }

  getCountryName(List<dynamic> valuex, cityId) {
    for (int index = 0; index < valuex.length; index++) {
      print("");
      if (valuex[index].id == cityId) {
        return valuex[index].name;
      }
    }

    return "Select Country";
  }

  getCityName(List<dynamic> valuex, countryId) {
    for (int index = 0; index < valuex.length; index++) {
      print("");
      if (valuex[index].id == countryId) {
        return valuex[index].name;
      }
    }

    return "Select City";
  }

  List<Zips>? getZipCodes(int selectedCityId, List<dynamic> countries) {
    CountryData? countriex;
    for (int index = 0; index < countries.length; index++) {
      print("");
      if (countries[index].id ==
          _homeScreenController.selectedCountryIndex.value) {
        countriex = countries[index];
      }
    }
    for (int index = 0; index < countriex!.cities!.length; index++) {
      print("");
      if (countriex.cities![index].id == selectedCityId) {
        Cities city = countriex.cities![index];
        List<Zips>? list = city.zips;
        _homeScreenController.cityName(city.name);
        return list;
      }
    }
    return [];
  }

  List getcities(int selectedCityId, List<dynamic> countries) {
    for (int index = 0; index < countries.length; index++) {
      print("");
      if (countries[index].id == selectedCityId) {
        return countries[index].cities;
      }
    }
    return [];
  }
}
/*
PopupMenuButton(
              color: AppColors.appBlue,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      child: Text("${getCityName(cities, cityId)}"),
                    ),
                  ),
                  Icon(Icons.arrow_drop_down)
                ],
              ),
              onSelected: (value) {
                for (int index = 0; index < cities.length; index++) {
                  if (cities[index].id == value) {
                    _homeScreenController.cityId.value =
                        int.parse((value).toString());
                    _homeScreenController.cityId.refresh();
                    break;
                  }
                }
              },
              itemBuilder: (context) => cities
                  .map((e) => PopupMenuItem(
                        value: e.id,
                        child: Text(
                          "${e.name}",
                          style: TextStyle(color: white),
                        ),
                      ))
                  .toList(),
            )
//  */







