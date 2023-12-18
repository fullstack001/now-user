import 'package:application_1/AllPages/ExplorePages/Controllers/profile_controller.dart';
import 'package:application_1/AllPages/introPages/intro_controller.dart';
import 'package:application_1/components/buttons-management/part_of_file/part.dart';
import 'package:application_1/components/buttons-management/style_model.dart';
import 'package:application_1/utils/AppColors.dart';
import 'package:application_1/utils/api_utils.dart';
import 'package:application_1/utils/widgest_utills.dart';
import 'package:application_1/widgets/data_not_available_widget.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../remote_model/provider_list/provider_list_response_model.dart';

enum filter { QUOTATION, HOURLY, BOTH }

class ProviderList extends StatelessWidget {
  ProviderList({Key? key}) : super(key: key);
  Color black = AppColors.black;
  Color white = AppColors.white;
  Color grey = AppColors.grey;
  Color blue = AppColors.blue;
  Color green = AppColors.green;
  IntroController _introController = Get.find();
  ProfileScreenController _screenController = Get.find();
  var selectedFilter = filter.BOTH;
  var filterList = [];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          backgroundColor: AppColors.grey,
          appBar: AppBar(
            elevation: 2,
            backgroundColor: Colors.white,
            title: Text(
              "${_introController.selectedService.value}",
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
                size: 25,
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(
                  Icons.close,
                  color: Colors.black45,
                ),
                onPressed: () {
                  // do something
                  Get.back();
                  // Get.back();
                },
              )
            ],
          ),
          body: LayoutBuilder(
            builder: (context, size) {
              return ConstrainedBox(
                constraints: BoxConstraints(minHeight: size.maxHeight),
                child: Obx(() => Column(
                      children: [
                        Flexible(
                          flex: 1,
                          fit: FlexFit.tight,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Text(
                                    "Best match",
                                    style: TextStyle(
                                        color: black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                                Flexible(
                                  child: GestureDetector(
                                    onTap: () {
                                      showModalBottomSheet(
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(24),
                                                  topRight:
                                                      Radius.circular(24))),
                                          context: context,
                                          builder: (_) {
                                            return GetBuilder<IntroController>(
                                                init: IntroController(),
                                                builder: (control) {
                                                  return Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 18),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(top: 6),
                                                          child: Container(
                                                            height: 7,
                                                            width: 60,
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            30),
                                                                color: const Color(
                                                                    0xffCDCFD0)),
                                                          ),
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            control.selectedUI !=
                                                                    "filter"
                                                                ? IconButton(
                                                                    onPressed:
                                                                        () {
                                                                      control.updateSelctedUI(
                                                                          "filter");
                                                                    },
                                                                    icon: Icon(GetPlatform
                                                                            .isAndroid
                                                                        ? Icons
                                                                            .arrow_back
                                                                        : Icons
                                                                            .arrow_back_ios),
                                                                  )
                                                                : Container(),
                                                            FittedBox(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child: Text(
                                                                control.selectedUI ==
                                                                        "time"
                                                                    ? "Time Slot"
                                                                    : control.selectedUI ==
                                                                            "rating"
                                                                        ? "Star Rating"
                                                                        : "Filter Result",
                                                                style: const TextStyle(
                                                                    color: Color(
                                                                        0xff151415),
                                                                    fontSize:
                                                                        22,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              ),
                                                            ),
                                                            Container(
                                                              width: 30,
                                                            ),
                                                          ],
                                                        ),
                                                        control.selectedUI ==
                                                                "time"
                                                            ? Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child: Row(
                                                                  children: [
                                                                    Flexible(
                                                                      flex: 3,
                                                                      child:
                                                                          Container(
                                                                        alignment:
                                                                            Alignment.centerLeft,
                                                                        child:
                                                                            const Padding(
                                                                          padding:
                                                                              EdgeInsets.only(left: 10),
                                                                          child:
                                                                              Text(
                                                                            "Select time slot",
                                                                            style:
                                                                                TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Flexible(
                                                                      flex: 2,
                                                                      child:
                                                                          Card(
                                                                        elevation:
                                                                            2,
                                                                        shape: RoundedRectangleBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(12)),
                                                                        color: Colors
                                                                            .grey
                                                                            .shade200,
                                                                        child:
                                                                            FittedBox(
                                                                          child:
                                                                              DropdownButton<String>(
                                                                            dropdownColor:
                                                                                Colors.white,
                                                                            borderRadius:
                                                                                BorderRadius.circular(12),
                                                                            elevation:
                                                                                2,
                                                                            hint:
                                                                                const Text("Select item"),
                                                                            underline:
                                                                                Container(),
                                                                            value:
                                                                                control.selectedFilter,
                                                                            icon:
                                                                                Container(
                                                                              padding: const EdgeInsets.only(right: 12),
                                                                              child: const Icon(
                                                                                Icons.keyboard_arrow_down_rounded,
                                                                                size: 32,
                                                                              ),
                                                                            ),
                                                                            onChanged:
                                                                                (String? value) {
                                                                              control.updateSlotFilter(value!);
                                                                            },
                                                                            items:
                                                                                [
                                                                              "morning",
                                                                              "afternoon",
                                                                              "evening",
                                                                              "night"
                                                                            ].map((String user) {
                                                                              return DropdownMenuItem<String>(
                                                                                value: user,
                                                                                child: Row(
                                                                                  children: <Widget>[
                                                                                    const SizedBox(
                                                                                      width: 20,
                                                                                    ),
                                                                                    Text(
                                                                                      user.capitalizeFirst.toString(),
                                                                                      style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 16),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              );
                                                                            }).toList(),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                      width: 24,
                                                                    )
                                                                  ],
                                                                ),
                                                              )
                                                            : Container(),
                                                        // 6.height,
                                                        control.selectedUI ==
                                                                "filter"
                                                            ? Column(
                                                                children: [
                                                                  getListOfTile(
                                                                      "Quotation",
                                                                      control.selectedFilter ==
                                                                              "Quotation"
                                                                          ? true
                                                                          : false,
                                                                      () {
                                                                    control.updateSelectedFilter(
                                                                        "Quotation");
                                                                  }),
                                                                  getListOfTile(
                                                                      "Hourly",
                                                                      control.selectedFilter ==
                                                                              "Hourly"
                                                                          ? true
                                                                          : false,
                                                                      () {
                                                                    control.updateSelectedFilter(
                                                                        "Hourly");
                                                                  }),
                                                                  getListOfTile(
                                                                      "Both",
                                                                      control.selectedFilter ==
                                                                              "Both"
                                                                          ? true
                                                                          : false,
                                                                      () {
                                                                    control.updateSelectedFilter(
                                                                        "Both");
                                                                  }),
                                                                  getListOfTile(
                                                                      "Rating",
                                                                      control.selectedFilter ==
                                                                              "rating"
                                                                          ? true
                                                                          : false,
                                                                      () {
                                                                    control.updateSelctedUI(
                                                                        "rating");
                                                                  },
                                                                      arrow:
                                                                          true,
                                                                      selectedUI:
                                                                          control
                                                                              .selectedUI),
                                                                  getListOfTile(
                                                                      "Time Slot",
                                                                      control.selectedFilter ==
                                                                              "time"
                                                                          ? true
                                                                          : false,
                                                                      () {
                                                                    control.updateSelctedUI(
                                                                        "time");
                                                                  },
                                                                      arrow:
                                                                          true),
                                                                ],
                                                              )
                                                            : control.selectedUI ==
                                                                    "rating"
                                                                ? Column(
                                                                    children: [
                                                                      for (int i =
                                                                              5;
                                                                          i > 0;
                                                                          i--)
                                                                        getListOfTile(
                                                                            "",
                                                                            control.selectedFilter == "$i"
                                                                                ? true
                                                                                : false,
                                                                            () {
                                                                          control
                                                                              .updateSelectedFilter("$i");
                                                                        },
                                                                            selectedUI:
                                                                                control.selectedFilter,
                                                                            widget: Row(
                                                                              children: [
                                                                                getStars(i),
                                                                                12.width,
                                                                                Text(
                                                                                  i == 5 ? "($i star)" : "($i+ star)",
                                                                                  style: const TextStyle(color: Color(0xff555555), fontSize: 14),
                                                                                )
                                                                              ],
                                                                            ))
                                                                    ],
                                                                  )
                                                                : Container(
                                                                    child: Wrap(
                                                                        children: List.generate(
                                                                            control.selectedFilterSlot.length,
                                                                            (index) => GestureDetector(
                                                                                  onTap: () {
                                                                                    control.updateSelectedFilterSlotIndex(index);
                                                                                  },
                                                                                  child: Padding(
                                                                                    padding: const EdgeInsets.all(8.0),
                                                                                    child: Container(
                                                                                      alignment: Alignment.center,
                                                                                      decoration: BoxDecoration(
                                                                                        color: control.selectedFilterSlotIndex == index ? AppColors.solidBlue : const Color(0xffE0E0E0),
                                                                                        borderRadius: BorderRadius.circular(8),
                                                                                      ),
                                                                                      width: Get.width * 0.25,
                                                                                      height: 40,
                                                                                      child: Text(
                                                                                        "${control.selectedFilterSlot[index]}",
                                                                                        style: TextStyle(color: control.selectedFilterSlotIndex == index ? AppColors.white : black, fontSize: 12),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ))),
                                                                  ),
                                                        FarenowButton(
                                                            style: FarenowButtonStyleModel(
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        4,
                                                                    vertical:
                                                                        8)),
                                                            title:
                                                                "Apply Filter",
                                                            onPressed:
                                                                () async {
                                                              if (control
                                                                      .selectedUI ==
                                                                  "filter") {
                                                                if (control
                                                                    .selectedFilter
                                                                    .isNotEmpty) {
                                                                  if (control
                                                                          .selectedFilter
                                                                          .toLowerCase() ==
                                                                      "hourly") {
                                                                    _introController.getProviderListFilter(
                                                                        _introController
                                                                            .selectZipCode
                                                                            .value,
                                                                        _introController
                                                                            .selectedServiceId,
                                                                        hourly:
                                                                            true);
                                                                  }
                                                                  if (control
                                                                          .selectedFilter
                                                                          .toLowerCase() ==
                                                                      "quotation") {
                                                                    _introController.getProviderListFilter(
                                                                        _introController
                                                                            .selectZipCode
                                                                            .value,
                                                                        _introController
                                                                            .selectedServiceId,
                                                                        quotation:
                                                                            true);
                                                                  }
                                                                  if (control
                                                                          .selectedFilter
                                                                          .toLowerCase() ==
                                                                      "both") {
                                                                    _introController
                                                                        .getProviderListFilter(
                                                                      _introController
                                                                          .selectZipCode
                                                                          .value,
                                                                      _introController
                                                                          .selectedServiceId,
                                                                    );
                                                                  }
                                                                }
                                                              }
                                                              if (control
                                                                      .selectedUI ==
                                                                  "rating") {
                                                                if (control
                                                                    .selectedFilter
                                                                    .isNotEmpty) {
                                                                  _introController.getProviderListFilter(
                                                                      _introController
                                                                          .selectZipCode
                                                                          .value,
                                                                      _introController
                                                                          .selectedServiceId,
                                                                      rating: int.parse(
                                                                          control
                                                                              .selectedFilter));
                                                                }
                                                              }
                                                              if (control
                                                                      .selectedUI ==
                                                                  "time") {
                                                                String st = "";
                                                                String et = "";
                                                                String _sTime = control
                                                                    .selectedFilterSlot[
                                                                        control
                                                                            .selectedFilterSlotIndex]
                                                                    .splitBefore(
                                                                        "-")
                                                                    .trim();
                                                                String _eTime = control
                                                                    .selectedFilterSlot[
                                                                        control
                                                                            .selectedFilterSlotIndex]
                                                                    .splitAfter(
                                                                        "-")
                                                                    .trim();

                                                                if (_sTime
                                                                    .contains(
                                                                        "AM")) {
                                                                  st = _sTime
                                                                      .numericOnly();
                                                                }

                                                                if (_sTime
                                                                    .contains(
                                                                        "PM")) {
                                                                  int num = _sTime
                                                                      .numericOnly()
                                                                      .toInt();

                                                                  int val =
                                                                      num + 12;

                                                                  if (val ==
                                                                      24) {
                                                                    val = 00;
                                                                  }
                                                                  st = val
                                                                      .toString();
                                                                }
                                                                if (_eTime
                                                                    .contains(
                                                                        "AM")) {
                                                                  et = _eTime
                                                                      .numericOnly();
                                                                }

                                                                if (_eTime
                                                                    .contains(
                                                                        "PM")) {
                                                                  int num = _eTime
                                                                      .numericOnly()
                                                                      .toInt();

                                                                  int val =
                                                                      num + 12;

                                                                  if (val ==
                                                                      24) {
                                                                    val = 00;
                                                                  }
                                                                  et = val
                                                                      .toString();
                                                                }
                                                                print(
                                                                    "$st $et");
                                                                _introController.getProviderListFilter(
                                                                    _introController
                                                                        .selectZipCode
                                                                        .value,
                                                                    _introController
                                                                        .selectedServiceId,
                                                                    start_slot:
                                                                        "$st:00",
                                                                    end_slot:
                                                                        "$et:00");
                                                              }
                                                              control
                                                                  .updateSelectedFilter(
                                                                      "morning");
                                                              control
                                                                  .updateSelectedFilterSlotIndex(
                                                                      -1);
                                                              control
                                                                  .updateSelctedUI(
                                                                      "filter");
                                                            },
                                                            type: BUTTONTYPE
                                                                .rectangular)
                                                      ],
                                                    ),
                                                  );
                                                });
                                          });
                                    },
                                    child: Container(
                                      width: 40,
                                      height: 40,
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: white,
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Image(
                                          image: AssetImage(
                                              "assets/images/filter.png")),
                                    ),
                                  ),
                                  //  PopupMenuButton(
                                  // child: Container(
                                  //   width: 40,
                                  //   height: 40,
                                  //   padding: EdgeInsets.all(8),
                                  //   decoration: BoxDecoration(
                                  //     color: white,
                                  //     shape: BoxShape.circle,
                                  //   ),
                                  //   child: Image(
                                  //       image: AssetImage(
                                  //           "assets/images/filter.png")),
                                  // ),
                                  // onSelected: filterClick,
                                  // itemBuilder: (context) => [
                                  //       PopupMenuItem(
                                  //         value: filter.QUOTATION.index,
                                  //         child: Row(
                                  //           children: [
                                  //             Text(
                                  //               "${filter.QUOTATION.name.toString().capitalizeFirst}",
                                  //               style: TextStyle(
                                  //                   fontSize: 15.0,
                                  //                   fontWeight:
                                  //                       FontWeight.w400),
                                  //             ),
                                  //           ],
                                  //         ),
                                  //       ),
                                  //       PopupMenuItem(
                                  //         value: filter.HOURLY.index,
                                  //         child: Row(
                                  //           children: [
                                  //             Text(
                                  //               "${filter.HOURLY.name.toString().capitalizeFirst}",
                                  //               style: TextStyle(
                                  //                   fontSize: 15.0,
                                  //                   fontWeight:
                                  //                       FontWeight.w400),
                                  //             ),
                                  //           ],
                                  //         ),
                                  //       ),
                                  //       PopupMenuItem(
                                  //         value: filter.BOTH.index,
                                  //         child: Row(
                                  //           children: [
                                  //             Text(
                                  //               "${filter.BOTH.name.toString().capitalizeFirst}",
                                  //               style: TextStyle(
                                  //                   fontSize: 15.0,
                                  //                   fontWeight:
                                  //                       FontWeight.w400),
                                  //             ),
                                  //           ],
                                  //         ),
                                  //       ),
                                  //     ]),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 9,
                          fit: FlexFit.tight,
                          child: _introController.providerListData.isEmpty
                              ? DataNotAvailableWidget()
                              : ListView.builder(
                                  itemCount: _introController.filter.value
                                      ? _introController
                                          .filterproviderListData.length
                                      : _introController
                                          .providerListData.length,
                                  itemBuilder: (context, index) {
                                    ProviderListData data =
                                        _introController.filter.value
                                            ? _introController
                                                .filterproviderListData[index]
                                            : _introController
                                                .providerListData[index];

                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4, horizontal: 12),
                                      child: GestureDetector(
                                        onTap: () {
                                          String id = data.id.toString();
                                          _screenController
                                              .selectedProvider.value = data;
                                          _screenController.providerId(id);
                                          _screenController
                                              .getProviderProfileDetail(id);
                                          // _screenController
                                          //     .getServiceTimmings(data);
                                        },
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(22)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Container(
                                              width: Get.width,
                                              height: Get.height / 6.5,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Flexible(
                                                    flex: 2,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Flexible(
                                                          flex: 2,
                                                          child: Row(
                                                            children: [
                                                              Container(
                                                                width: 70,
                                                                height: 70,
                                                                child: Stack(
                                                                  children: [
                                                                    Container(
                                                                      width: 70,
                                                                      height:
                                                                          70,
                                                                      child: data.image !=
                                                                              null
                                                                          ? cacheNetworkImage(
                                                                              imageUrl: "${ApiUtills.imageBaseUrl + data.image}",
                                                                              placeHolder: 'assets/user_assets/png/user.png',
                                                                              imageHeight: 60,
                                                                              imageWidth: 60,
                                                                              radius: 100)
                                                                          : const Image(image: AssetImage('assets/user_assets/png/user.png')),
                                                                    ),
                                                                    Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .bottomRight,
                                                                      child:
                                                                          Container(
                                                                        decoration: BoxDecoration(
                                                                            shape:
                                                                                BoxShape.circle,
                                                                            color: white),
                                                                        padding:
                                                                            const EdgeInsets.all(2),
                                                                        child: Container(
                                                                            margin:
                                                                                const EdgeInsets.only(bottom: 2, right: 2),
                                                                            width: 12,
                                                                            height: 12,
                                                                            decoration: BoxDecoration(shape: BoxShape.circle, color: green)),
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                              Flexible(
                                                                flex: 2,
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Flexible(
                                                                        child:
                                                                            Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.start,
                                                                          children: [
                                                                            Flexible(
                                                                              flex: 4,
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.all(2.0),
                                                                                child: FittedBox(
                                                                                  child: Text(
                                                                                    "${getName(data)}",
                                                                                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xff151415)),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Flexible(
                                                                                child: FittedBox(
                                                                                    child: Icon(
                                                                              Icons.verified,
                                                                              size: 18,
                                                                              color: data.verifiedAt != null ? AppColors.darkBlue : Colors.grey,
                                                                            )))
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      Flexible(
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(2.0),
                                                                          child:
                                                                              FittedBox(
                                                                            child:
                                                                                Text(
                                                                              "${data.providerCompletedServiceRequestsCount} Jobs Completed",
                                                                              style: const TextStyle(fontSize: 12, color: Color(0xff555555), fontWeight: FontWeight.w400),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Flexible(
                                                                        child:
                                                                            Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.start,
                                                                          children: [
                                                                            const Icon(
                                                                              Icons.star,
                                                                              size: 14,
                                                                              color: Color(0xffFF9E45),
                                                                            ),
                                                                            const SizedBox(
                                                                              width: 2,
                                                                            ),
                                                                            FittedBox(
                                                                              child: Text(
                                                                                getRating(data.rating).toString(),
                                                                                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xff151415)),
                                                                              ),
                                                                            ),
                                                                            data.rating != null
                                                                                ? FittedBox(
                                                                                    child: Text(
                                                                                      "(${data.userFeedbacksCount})",
                                                                                      style: const TextStyle(fontSize: 14, color: Color(0xff555555), fontWeight: FontWeight.w400),
                                                                                    ),
                                                                                  )
                                                                                : Container(),
                                                                          ],
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Flexible(
                                                          flex: 1,
                                                          child: badge(data),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  Flexible(
                                                      flex: 1,
                                                      child: Container(
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                const Icon(
                                                                  Icons
                                                                      .location_on_outlined,
                                                                  size: 22,
                                                                  color: Color(
                                                                      0xff555555),
                                                                ),
                                                                Text(
                                                                  "${data.providerProfile.city}",
                                                                  style: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .bodyText1!
                                                                      .copyWith(
                                                                          color: const Color(
                                                                              0xff555555),
                                                                          fontWeight:
                                                                              FontWeight.w400),
                                                                )
                                                              ],
                                                            ),
                                                            data.providerProfile
                                                                        .hourlyRate ==
                                                                    null
                                                                ? Container()
                                                                : Row(
                                                                    children: [
                                                                      Text(
                                                                        "\$${double.parse(data.providerProfile.hourlyRate)}",
                                                                        style: Theme.of(context)
                                                                            .textTheme
                                                                            .bodyText1!
                                                                            .copyWith(
                                                                                color: Colors.black87,
                                                                                fontWeight: FontWeight.w500),
                                                                      ),
                                                                      Text(
                                                                          "/hr",
                                                                          style: Theme.of(context)
                                                                              .textTheme
                                                                              .bodyText1!
                                                                              .copyWith(color: Colors.black45, fontWeight: FontWeight.w400))
                                                                    ],
                                                                  ),
                                                            data.providerType
                                                                        .toString()
                                                                        .toLowerCase() ==
                                                                    "Individual"
                                                                        .toLowerCase()
                                                                ? Container(
                                                                    padding: const EdgeInsets
                                                                            .symmetric(
                                                                        horizontal:
                                                                            14,
                                                                        vertical:
                                                                            6),
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8),
                                                                      color: const Color(
                                                                          0xff0068E1),
                                                                    ),
                                                                    child: Text(
                                                                      "Book Service",
                                                                      style: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .bodyText1!
                                                                          .copyWith(
                                                                              color: Colors.white,
                                                                              fontSize: 12),
                                                                    ),
                                                                  )
                                                                : Container(
                                                                    padding: const EdgeInsets
                                                                            .symmetric(
                                                                        horizontal:
                                                                            14,
                                                                        vertical:
                                                                            6),
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8),
                                                                      color: const Color(
                                                                          0xff0068E1),
                                                                    ),
                                                                    child: Text(
                                                                      "Get Quotation",
                                                                      style: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .bodyText1!
                                                                          .copyWith(
                                                                              color: Colors.white,
                                                                              fontSize: 12),
                                                                    ),
                                                                  )
                                                          ],
                                                        ),
                                                      ))
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                        )
                      ],
                    )),
              );
            },
          ),
        ),
        onWillPop: () async {
          _introController.selectZipCode("");
          return true;
        });
  }

  getListOfTile(String title, bool selected, VoidCallback onTap,
      {arrow = false, selectedUI = "filter", widget}) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Card(
          elevation: 1,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(
                  color: selected ? AppColors.solidBlue : Colors.white)),
          child: Container(
            width: Get.width,
            height: Get.width * 0.1,
            decoration: BoxDecoration(
                color: const Color(0xffF5F5F5),
                borderRadius: BorderRadius.circular(12)),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(children: [
                  Container(
                    width: 18,
                    height: 18,
                    decoration: BoxDecoration(
                        color: white,
                        border: Border.all(
                            color:
                                selected ? AppColors.solidBlue : Colors.black45,
                            width: selected ? 6 : 1),
                        borderRadius: BorderRadius.circular(90)),
                  ),
                  12.width,
                  selectedUI == "filter"
                      ? Text(
                          title,
                          style: const TextStyle(
                              color: Color(0xff555555),
                              fontSize: 18,
                              fontWeight: FontWeight.w400),
                        )
                      : widget
                ]),
                arrow
                    ? const Icon(
                        Icons.arrow_forward_ios,
                        size: 18,
                        color: Color(0xff555555),
                      )
                    : Container()
              ],
            ),
          ),
        ),
      ),
    );
  }

  getName(ProviderListData data) {
    // if (data.providerType == "Business") {
    //   if (data.businessName != null) {
    //     return data.businessName;
    //   }
    // }
    return "${data.firstName} ${data.lastName}";
  }

  filterClick(value) {
    try {
      List data = _introController.providerListData;

      List<ProviderListData> list = data.cast<ProviderListData>().toList();
      if (value == filter.QUOTATION.index) {
        _introController.filter(true);
        selectedFilter = filter.QUOTATION;
        getFilterList(list, selectedFilter);
      } else if (value == filter.HOURLY.index) {
        _introController.filter(true);
        selectedFilter = filter.HOURLY;
        getFilterList(list, selectedFilter);
      } else if (value == filter.BOTH.index) {
        _introController.filter(false);
        selectedFilter = filter.BOTH;
        getFilterList(list, selectedFilter);
      }
      print("$value");
    } catch (e) {}
  }

  void getFilterList(
      List<ProviderListData> filterproviderListData, filter selectedFilter) {
    List<ProviderListData> list = [];
    for (int index = 0; index < filterproviderListData.length; index++) {
      ProviderListData value = filterproviderListData[index];
      if (selectedFilter == filter.QUOTATION) {
        // if (value.providerProfile.hourlyRate == null) {
        if (value.providerType.toString().toLowerCase() !=
            "Individual".toLowerCase()) {
          list.add(value);
        }
      } else if (selectedFilter == filter.HOURLY) {
        if (value.providerType.toString().toLowerCase() ==
            "Individual".toLowerCase()) {
          list.add(value);
        }
      }
    }
    print(list);
    if (selectedFilter == filter.BOTH) {
      // _introController.filterproviderListData();
      _introController.filterproviderListData.clear();
    } else {
      _introController.filterproviderListData(list);
    }
    _introController.filterproviderListData.refresh();
  }

  badge(data) {
    return Padding(
        padding: const EdgeInsets.only(top: 10),
        child: data.providerCompletedServiceRequestsCount == null
            ? Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: green),
                    borderRadius: const BorderRadius.all(Radius.circular(16))),
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                child: Text(
                  "Not Available",
                  style: TextStyle(color: green, fontSize: 12),
                ),
              )
            : Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: green),
                    borderRadius: const BorderRadius.all(Radius.circular(16))),
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                child: Text(
                  "Available",
                  style: TextStyle(color: green, fontSize: 12),
                ),
              ));
  }

  networktImage(String value) {
    String image = value;
    return Container(
      width: 60,
      height: 60,
      child: Stack(
        children: [
          Container(
            width: 60,
            height: 60,
            child: cacheNetworkImage(
                imageUrl: "${ApiUtills.imageBaseUrl + image}",
                placeHolder: 'assets/user_assets/png/user.png',
                imageHeight: 60,
                imageWidth: 60,
                radius: 100),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              decoration: BoxDecoration(shape: BoxShape.circle, color: white),
              padding: const EdgeInsets.all(2),
              child: Container(
                  margin: const EdgeInsets.only(bottom: 2, right: 2),
                  width: 12,
                  height: 12,
                  decoration:
                      BoxDecoration(shape: BoxShape.circle, color: green)),
            ),
          )
        ],
      ),
    );
  }

  double getRating(dynamic value) {
    if (value != null) {
      return value.toDouble();
    } else {
      return 0.0;
    }
  }

  getStars(int i) {
    return Row(
        children: List.generate(
            5,
            (index) => index < i
                ? const Icon(
                    Icons.star,
                    size: 22,
                    color: Color(0xffFF9E45),
                  )
                : const Icon(
                    Icons.star_border,
                    size: 22,
                    color: Color(0xff555555),
                  )));
  }
}
