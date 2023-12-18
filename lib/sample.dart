// import 'package:application_1/AllPages/introPages/intro_controller.dart';
// import 'package:application_1/model/location_detail/location_detail_response.dart';
// import 'package:application_1/model/zip_search/zip_search_list.dart';
// import 'package:application_1/remote_model/country/country_data.dart';
// import 'package:application_1/resources/Api_Services/services.dart';
// import 'package:application_1/utils/AppColors.dart';
// import 'package:application_1/utils/AppString.dart';
// import 'package:application_1/utils/api_utils.dart';
// import 'package:application_1/utils/widgest_utills.dart';
// import 'package:application_1/widgets/conditions_dialog.dart';
// import 'package:application_1/widgets/country_dialog.dart';
// import 'package:application_1/widgets/text_with_icon.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:get/get.dart';
// import 'package:permission_handler/permission_handler.dart';
//
// import '../../remote_model/country/cities.dart';
// import '../../remote_model/country/zips.dart';
// import '../ProjectPages/controller/home_screen_controller.dart';
//
// var zipCodeTyped;
//
// class ZipSearchWiget extends StatefulWidget {
//   final update;
//
//   final title;
//
//   final hint;
//
//   final inApp;
//
//   final zipCode;
//
//   ZipSearchWiget(
//       {Key? key, this.zipCode, this.inApp, this.update, this.title, this.hint})
//       : super(key: key);
//
//   @override
//   _ZipSearchWigetState createState() => _ZipSearchWigetState();
// }
//
// class _ZipSearchWigetState extends State<ZipSearchWiget> {
//   var addressController = TextEditingController();
//   HomeScreenController _homeScreenController = Get.find();
//   IntroController introController = Get.find();
//   Color black = AppColors.black;
//   Color white = AppColors.white;
//   Color blue = AppColors.blue;
//   var _controller = ScrollController();
//   bool hasFocus = false;
//   var focusNode = FocusNode();
//   var keyboardVisibilityController = KeyboardVisibilityController();
//
//   @override
//   void initState() {
//     super.initState();
//     _controller.addListener(() {
//       if (introController.zipCodeList.isNotEmpty && widget.inApp) {
//         if (_controller.position.atEdge) {
//           if (_controller.position.pixels != 0) {
//             var list = getList(introController.zipCodeList.value);
//
//             var pageSize = ((list.length / 20).ceilToDouble().toInt()) + 1;
//             var currentPage = ((list.length / 20).floorToDouble().toInt());
//             currentPage = currentPage == 0 ? currentPage + 1 : currentPage;
//             int page = currentPage * 20;
//             //
//             if (list.length == page) {
//               loading = true;
//               print("pagination");
//               introController.searchZipCode(zipCodeTyped,
//                   pageSize: pageSize,
//                   subId: introController.selectedServiceId, upDate: () {
//                     loading = false;
//                     setState(() {});
//                   });
//               setState(() {});
//             } else {
//               print("pagination out");
//             }
//           }
//         }
//       }
//     });
//
//     if (GetPlatform.isIOS) {
//       keyboardVisibilityController.onChange.listen((bool visible) {
//         var width = Get.height;
//         print('Keyboard visibility update. Is visible: $visible');
//         if (width < 570) {
//           bool flag = introController.visibleKeyboard.value;
//           introController.visibleKeyboard(visible);
//           introController.visibleKeyboard.refresh();
//         }
//         hasFocus = !hasFocus;
//         setState(() {});
//       });
//     } else if (GetPlatform.isAndroid) {
//       keyboardVisibilityController.onChange.listen((bool visible) {
//         var width = Get.height;
//         print('Keyboard visibility update. Is visible: $visible');
//         hasFocus = !hasFocus;
//         setState(() {});
//       });
//     }
//   }
//
//   bool loading = false;
//   bool firstInit = false;
//   var inApp;
//
//   var hint;
//   var title;
//   var zipCode;
//   var update;
//   var inAppSearch;
//   List<Zips>? zipsList = [];
//   String label = "";
//
//   @override
//   Widget build(BuildContext context) {
//     // firstInit = false;
//     if (!firstInit) {
//       firstInit = true;
//       inApp = widget.inApp ?? false;
//       zipCode = widget.zipCode;
//       hint = widget.hint;
//       title = widget.title;
//       update = widget.update;
//       inAppSearch = inApp ?? false;
//     }
//     if (!inAppSearch) {
//       addressController.text = introController.address.value;
//     } else {
//       // addressController.text =
//       //     zipCode.toString().isEmpty ? zipCodeTyped : zipCode;
//     }
//     if (introController.address.value.isEmpty) {
//       print(":");
//     }
//     return LayoutBuilder(
//       builder: (context, size) {
//         double h = MediaQuery.of(context).size.height;
//         return Obx(() {
//           var selectedCityId = _homeScreenController.cityId.value;
//           List<dynamic> countries = _homeScreenController.countryList.value;
//           List<Zips>? zipCodes = getZipCodes(selectedCityId, countries);
//           List<Zips>? zipsList = getZipCodes(selectedCityId, countries);
//           label = _homeScreenController.cityName.value;
//           if (_homeScreenController.zipFilters.isNotEmpty) {
//             zipCodes = _homeScreenController.zipFilters.value
//                 .map((val) => Zips(code: val.code, id: val.id))
//                 .toList();
//           } else {
//             zipCode = zipsList;
//           }
//           return ConstrainedBox(
//             constraints: BoxConstraints(minHeight: h * 0),
//             child: Container(
//               padding: EdgeInsets.all(15),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Container(
//                     child: Text(
//                       title ?? "Search Providers by zip code",
//                       style:
//                       TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
//                     ),
//                   ),
//                   // if (_homeScreenController.countryList.isNotEmpty)
//                   //   SizedBox(
//                   //     height: 12,
//                   //   ),
//                   // if (_homeScreenController.countryList.isNotEmpty)
//                   //   dropDownList(
//                   //       _homeScreenController.countryList.value,
//                   //       _homeScreenController.selectedId.value,
//                   //       _homeScreenController.cityId.value,
//                   //       _homeScreenController.selectedCountryIndex.value),
//                   SizedBox(
//                     height: 12,
//                   ),
//                   TextField(
//                     controller:
//                     getController(introController.selectZipCode.value),
//                     focusNode: focusNode,
//                     keyboardType: TextInputType.number,
//                     onSubmitted: (value) {
//                       Get.focusScope!.unfocus();
//                     },
//                     onChanged: (value) async {
//                       zipCodeTyped = value;
//                       if (update != null) {
//                         update(value);
//                       }
//                       introController.selectZipCode(value);
//                       if (!inAppSearch) {
//                         introController.address(value);
//                         if (value.isEmpty) {
//                           introController.predictionResults.clear();
//                           var empty = [];
//                           introController.address("");
//                           introController.predictionResults(empty);
//                           return;
//                         } else {
//                           Future.delayed(Duration(seconds: 1))
//                               .then((valu) async {
//                             var result =
//                             await Services().searchPlaceByZip(value);
//                             print("$result");
//                             introController
//                                 .predictionResults(result.predictions);
//                           });
//                         }
//                       } else {
//                         if (value.length > 0) {
//                           var cityId = _homeScreenController.cityId.value;
//                           var countryId =
//                               _homeScreenController.selectedId.value;
//                           introController.selectZipCode(value);
//                           // _homeScreenController.zipFilters.clear();
//                           // for (int index = 0;
//                           //     index < zipsList!.length;
//                           //     index++) {
//                           //   if (zipsList[index].code!.contains(value)) {
//                           //     _homeScreenController.zipFilters
//                           //         .add(zipsList[index]);
//                           //   }
//                           // }
//                           // _homeScreenController.zipFilters.refresh();
//                           // introController.searchZipCode(value,
//                           //     subId: introController.selectedServiceId,
//                           //     cityId: cityId,
//                           //     countryId: countryId);
//
//                           introController.searchPlace(value);
//                         }
//                         if (value.isEmpty) {
//                           _homeScreenController.zipFilters.clear();
//                           introController.zipCodeList.clear();
//                           introController.zipCodeList.refresh();
//                         }
//                       }
//                       setSelection(addressController);
//                     },
//                     decoration: InputDecoration(
//                         prefixIcon: Icon(
//                           Icons.location_on_rounded,
//                           color: blue,
//                         ),
//                         hintText: hint ?? "Your Address here",
//                         fillColor: white,
//                         border: OutlineInputBorder(
//                             borderSide: BorderSide(color: blue, width: 1)),
//                         hintStyle: TextStyle(color: blue)),
//                   ),
//                   Expanded(
//                     child: inApp
//                         ? getZipCodeList(
//                         update,
//                         introController.zipCodeList.value,
//                         addressController,
//                         _controller,
//                         zipCodes)
//                         : introController.address.isEmpty
//                         ? Container()
//                         : Container(
//                       alignment: Alignment.topCenter,
//                       child: ListView.builder(
//                         itemCount: introController
//                             .predictionResults.value.length,
//                         itemBuilder: (context, index) {
//                           if (introController.address.isEmpty) {
//                             print("empty");
//                           }
//                           return InkWell(
//                             onTap: () async {
//                               Get.focusScope!.unfocus();
//                               print(
//                                   "${introController.predictionResults.value[index].description}");
//                               introController.address(introController
//                                   .predictionResults
//                                   .value[index]
//                                   .description);
//
//                               String placeId = introController
//                                   .predictionResults
//                                   .value[index]
//                                   .placeId;
//                               // final request =
//                               //     'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&fields=address_component&key=AIzaSyA8qxfA7q_7adQ75SebuC2qgogFZ-I7FN8&sessiontoken=123345667';
//                               // String key =
//                               //     "AIzaSyA8qxfA7q_7adQ75SebuC2qgogFZ-I7FN8";
//                               String key =
//                                   "AIzaSyDM06VJYrW1xHW4F4zvL1Bt4lgcF7YgZ7U";
//                               String request =
//                                   "https://maps.googleapis.com/maps/api/place/details/json?placeid=$placeId&key=${ApiUtills.mapKey}";
//                               Dio dio = Dio();
//                               var response = await dio.post(request);
//                               print("");
//
//                               LocationDetailResponse detail =
//                               LocationDetailResponse.fromJson(
//                                   response.data);
//                               // response.data['result']['address_components'][0]['long_name']
//                               if (detail.status.toLowerCase() ==
//                                   "ok") {
//                                 introController.components(
//                                     detail.result.addressComponents);
//                               }
//
//                               var zipCode =
//                               introController.getPostalCode(
//                                   introController.components);
//
//                               introController.zipCode(zipCode);
//
//                               print("click on zip list");
//
//                               introController.predictionResults
//                                   .clear();
//                               var empty = [];
//                               introController
//                                   .predictionResults(empty);
//                               if (update != null) {
//                                 update(introController.zipCode.value);
//                               }
//                             },
//                             child: Container(
//                               padding:
//                               EdgeInsets.only(top: 8, bottom: 8),
//                               child: Text(
//                                 "${introController.predictionResults.value[index].description}",
//                                 style: TextStyle(fontSize: 16),
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         });
//       },
//     );
//   }
//
//   Widget getZipCodeList(
//       update,
//       var value,
//       TextEditingController addressController,
//       ScrollController controller,
//       List<Zips>? zipCodes,
//       ) {
//     List<dynamic> value1 = value;
//     List<dynamic> value2 = value;
//
//     value = getList(value);
//     return !hasFocus
//         ? Container(
//       width: 0,
//       height: 0,
//       color: Colors.red,
//     )
//         : zipCodes!.isEmpty
//         ? TextWithIcon(
//       width: Get.width,
//       height: Get.height,
//       fontSize: 18,
//       title: "Provider list is empty",
//     )
//         : ListView.builder(
//       controller: _controller,
//       itemCount: zipCodes.length,
//       itemBuilder: (BuildContext context, int index) {
//         Zips data = zipCodes[index];
//         return InkWell(
//           onTap: () {
//             if (update != null) {
//               Get.focusScope!.unfocus();
//               addressController.text = data.code!;
//               zipCodeTyped = data.code;
//               setSelection(addressController);
//               introController.selectZipCode(data.code);
//               update(data.code);
//             }
//           },
//           child: Column(
//             children: [
//               loading && index == value.length - 1
//                   ? CircularProgressIndicator()
//                   : Container(
//                 width: Get.width,
//                 padding: EdgeInsets.all(12),
//                 child: Text(
//                   data.code!,
//                   style: TextStyle(fontSize: 16),
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   List<dynamic> getList(List<dynamic> value) {
//     List<dynamic> list = [];
//     list.addAll(value);
//
//     return value;
//   }
//
//   Future<void> _checkPermission() async {
//     final serviceStatus = await Permission.locationWhenInUse.serviceStatus;
//     // ignore: unrelated_type_equality_checks
//     final isGpsOn = serviceStatus == serviceStatus.isEnabled;
//     if (!isGpsOn) {
//       print('Turn on location services before requesting permission.');
//       return;
//     }
//
//     final status = await Permission.locationWhenInUse.request();
//     if (status == PermissionStatus.granted) {
//       print('Permission granted');
//     } else if (status == PermissionStatus.denied) {
//       print(
//           'Permission denied. Show a dialog and again ask for the permission');
//     } else if (status == PermissionStatus.permanentlyDenied) {
//       print('Take the user to the settings page.');
//       await openAppSettings();
//     }
//   }
//
//   _getCurrentLocation() {
//     Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.best,
//         forceAndroidLocationManager: true)
//         .then((Position position) {
//       print("");
//     }).catchError((e) {
//       print(e);
//     });
//   }
//
//   getController(String value) {
//     addressController.text = value;
//     setSelection(addressController);
//     return addressController;
//   }
//
//   dropDownList(List<dynamic> valuex, countryId, cityId, selectedCountryIndex) {
//     var selectedCityId = _homeScreenController.selectedCountryIndex.value;
//     List<dynamic> countries = _homeScreenController.countryList.value;
//     List<dynamic> cities = getcities(selectedCityId, countries);
//     cities.sort((a, b) => a.name
//         .toString()
//         .toLowerCase()
//         .compareTo(b.name.toString().toLowerCase()));
//     valuex.sort((a, b) => a.name
//         .toString()
//         .toLowerCase()
//         .compareTo(b.name.toString().toLowerCase()));
//     return Row(
//       children: [
//         Expanded(
//             child: Container(
//               padding: EdgeInsets.only(left: 8),
//               alignment: Alignment.centerLeft,
//               height: 40,
//               color: Colors.grey.withOpacity(0.3),
//               child: SizedBox(
//                 width: Get.width,
//                 child: InkWell(
//                   onTap: () {
//                     Get.dialog(CountryDialog(
//                       countriesList: valuex,
//                     ));
//                   },
//                   child: Row(
//                     children: [
//                       Expanded(
//                         child: Container(
//                           child: Text("${getCountryName(valuex, countryId)}"),
//                         ),
//                       ),
//                       Icon(Icons.arrow_drop_down)
//                     ],
//                   ),
//                 )
//                 /*PopupMenuButton(
//               color: AppColors.appBlue,
//               child: ,
//               onSelected: (value) {
//                 for (int index = 0; index < valuex.length; index++) {
//                   if (valuex[index].id == value) {
//                     _homeScreenController.selectedId.value =
//                         int.parse((value).toString());
//                     _homeScreenController.selectedCountryIndex.value = index;
//
//                     if (_homeScreenController
//                         .countryList.value[index].cities.isNotEmpty) {
//                       int idd = _homeScreenController
//                           .countryList.value[index].cities.first.id;
//                       _homeScreenController.cityId(idd);
//                     }
//                     _homeScreenController.selectedCountryIndex.refresh();
//                   }
//                 }
//               },
//               itemBuilder: (context) => valuex
//                   .map((e) => PopupMenuItem(
//                         value: e.id,
//                         child: Text(
//                           "${e.name}",
//                           style: TextStyle(color: white),
//                         ),
//                       ))
//                   .toList(),
//             )*/
//                 ,
//               ),
//             )),
//         SizedBox(
//           width: 12,
//         ),
//         Expanded(
//             child: InkWell(
//               onTap: () {
//                 var selectedCityId =
//                     _homeScreenController.selectedCountryIndex.value;
//                 List<dynamic> countries = _homeScreenController.countryList.value;
//                 List citiez = getcities(selectedCityId, countries);
//                 Get.dialog(ConditionsDialog(
//                   citiesList: citiez,
//                 ));
//               },
//               child: Container(
//                 padding: EdgeInsets.only(left: 8),
//                 alignment: Alignment.centerLeft,
//                 height: 40,
//                 color: Colors.grey.withOpacity(0.3),
//                 child: Container(
//                   width: Get.width,
//                   height: 50,
//                   child: Row(
//                     children: [
//                       Expanded(child: Text(label)),
//                       Icon(Icons.arrow_drop_down_rounded)
//                     ],
//                   ),
//                 ),
//               ),
//             )),
//       ],
//     );
//   }
//
//   getCountryName(List<dynamic> valuex, cityId) {
//     for (int index = 0; index < valuex.length; index++) {
//       print("");
//       if (valuex[index].id == cityId) {
//         return valuex[index].name;
//       }
//     }
//
//     return "Select Country";
//   }
//
//   getCityName(List<dynamic> valuex, countryId) {
//     for (int index = 0; index < valuex.length; index++) {
//       print("");
//       if (valuex[index].id == countryId) {
//         return valuex[index].name;
//       }
//     }
//
//     return "Select City";
//   }
//
//   List<Zips>? getZipCodes(int selectedCityId, List<dynamic> countries) {
//     CountryData? countriex;
//     for (int index = 0; index < countries.length; index++) {
//       print("");
//       if (countries[index].id ==
//           _homeScreenController.selectedCountryIndex.value) {
//         countriex = countries[index];
//       }
//     }
//     for (int index = 0; index < countriex!.cities!.length; index++) {
//       print("");
//       if (countriex.cities![index].id == selectedCityId) {
//         Cities city = countriex.cities![index];
//         List<Zips>? list = city.zips;
//         _homeScreenController.cityName(city.name);
//         return list;
//       }
//     }
//     return [];
//   }
//
//   List getcities(int selectedCityId, List<dynamic> countries) {
//     for (int index = 0; index < countries.length; index++) {
//       print("");
//       if (countries[index].id == selectedCityId) {
//         return countries[index].cities;
//       }
//     }
//     return [];
//   }
// }
// /*
// PopupMenuButton(
//               color: AppColors.appBlue,
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: Container(
//                       child: Text("${getCityName(cities, cityId)}"),
//                     ),
//                   ),
//                   Icon(Icons.arrow_drop_down)
//                 ],
//               ),
//               onSelected: (value) {
//                 for (int index = 0; index < cities.length; index++) {
//                   if (cities[index].id == value) {
//                     _homeScreenController.cityId.value =
//                         int.parse((value).toString());
//                     _homeScreenController.cityId.refresh();
//                     break;
//                   }
//                 }
//               },
//               itemBuilder: (context) => cities
//                   .map((e) => PopupMenuItem(
//                         value: e.id,
//                         child: Text(
//                           "${e.name}",
//                           style: TextStyle(color: white),
//                         ),
//                       ))
//                   .toList(),
//             )
//  */
