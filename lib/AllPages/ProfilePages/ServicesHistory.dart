import 'package:application_1/AllPages/ProfilePages/plumberprofileView.dart';
import 'package:application_1/AllPages/ProjectPages/controller/home_screen_controller.dart';
import 'package:application_1/model/service_response/service_list_data.dart';
import 'package:application_1/reuseableWidgets/reuseableSizedbox.dart';
import 'package:application_1/utils/AppColors.dart';
import 'package:application_1/utils/date_time_utils.dart';
import 'package:application_1/utils/image_picker.dart';
import 'package:application_1/utils/project_widget.dart';
import 'package:application_1/utils/widgest_utills.dart';
import 'package:application_1/widgets/rating_start.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../components/buttons-management/part_of_file/part.dart';
import '../../components/buttons-management/style_model.dart';
import '../../utils/api_utils.dart';
import '../ExplorePages/Controllers/profile_controller.dart';

class ServiceHistory extends StatefulWidget {
  ServiceHistory({Key? key}) : super(key: key);

  @override
  _ServiceHistoryState createState() => _ServiceHistoryState();
}

class _ServiceHistoryState extends State<ServiceHistory> {
  HomeScreenController _homeScreenController = Get.find();

  bool pending = false;
  List<ServiceListData> paid = [];
  List<ServiceListData> pendingList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    filterList();
  }

  @override
  Widget build(BuildContext context) {
    // paid.clear();
    // pendingList.clear();
    return Scaffold(
      backgroundColor: Color(0xffE0E0E0).withOpacity(0.4),
      appBar: AppBar(
        elevation: 1,
        backgroundColor: AppColors.white,
        iconTheme: IconTheme.of(context).copyWith(color: black),
        title: Text(
          "Service History",
          style: Theme.of(context).textTheme.headline6,
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            12.height,
            Row(
              children: [
                16.width,
                customButton(
                    title: "Paid",
                    height: 40,
                    width: 80,
                    allRadius: 30,
                    textColor: pending ? black : Colors.white,
                    color: pending ? Color(0xffE0E0E0) : AppColors.solidBlue,
                    textWeight: FontWeight.normal,
                    onTap: () {
                      if (pending) {
                        pending = false;
                      }
                      filterList();
                      setState(() {});
                    }),
                16.width,
                customButton(
                    title: "Pending",
                    height: 40,
                    width: 120,
                    allRadius: 40,
                    color: pending ? AppColors.solidBlue : Color(0xffE0E0E0),
                    textColor: pending ? white : Colors.black,
                    textWeight: FontWeight.normal,
                    onTap: () {
                      if (!pending) {
                        pending = true;
                      }
                      filterList();
                      setState(() {});
                    }),
              ],
            ),
            Column(
              children: [
                paid.isEmpty && !pending
                    ? emptyView()
                    : pendingList.isEmpty && pending
                        ? emptyView()
                        : Column(
                            children: List.generate(
                                pending ? pendingList.length : paid.length,
                                (index) {
                              ServiceListData value =
                                  pending ? pendingList[index] : paid[index];

                              return value.isCompleted == 0
                                  ? Container()
                                  : GestureDetector(
                                      onTap: () {
                                        Get.to(PlumberProfileView(
                                          data: value,
                                          hasPayable: pending,
                                        ));
                                      },
                                      child: Column(
                                        children: [
                                          12.height,
                                          historyWidget(index, value),
                                        ],
                                      ),
                                    );
                            }),
                          )
                // : ListView.builder(
                //     itemCount:
                //         pending ? pendingList.length : paid.length,
                //     itemBuilder: (context, index) {
                // ServiceListData value =
                //     pending ? pendingList[index] : paid[index];

                // return value.isCompleted == 0
                //     ? Container()
                //     : GestureDetector(
                //         onTap: () {
                //           Get.to(PlumberProfileView(
                //             data: value,
                //             hasPayable: pending,
                //           ));
                //         },
                //         child: Column(
                //           children: [
                //             Card(
                //               elevation: 2,
                //               child: historyWidget(index, value),
                //             ),
                //           ],
                //         ),
                //       );
                //     })
              ],
            )
          ],
        ),
      ),
    );
  }

  String getOrderDate(String createdAt) {
    //19, January 2020 - 12:00 PM
    DateTime dateTime = DateTimeUtils().convertString(createdAt);
    String time =
        DateTimeUtils().parseDateTime(dateTime, "E ,d MMM yyyy - hh:mm:ss aa");
    return time;
  }

  historyWidget(
    int index,
    ServiceListData value,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        color: white,
        elevation: 2,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          width: Get.width,
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      "Service No.",
                      style: TextStyle(
                          color: Color(0xff555555),
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      " #${value.id}",
                      style: TextStyle(
                          color: Color(0xff151415),
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                      color: !pending ? Color(0xff40C08C) : Color(0xffF8CE39),
                      borderRadius: BorderRadius.circular(30)),
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  child: Text(!pending ? "Paid" : "Pending"),
                )
              ],
            ),
            16.height,
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                "Refrigerator Repair Service",
                style: TextStyle(
                    color: Color(0xff151415),
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
            ),
            6.height,
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                getOrderDate(value.createdAt),
                style: TextStyle(fontWeight: FontWeight.w300, fontSize: 12),
              ),
            ),
            12.height,
            Row(
              children: [
                value.provider.image != null
                    ? cacheNetworkImage(
                        imageUrl: ApiUtills.imageBaseUrl + value.provider.image,
                        imageHeight: 40,
                        imageWidth: 40,
                        placeHolder: 'assets/user_assets/png/user.png',
                        radius: 100)
                    : Image.asset(
                        'assets/user_assets/png/user.png',
                        fit: BoxFit.fill,
                        width: 60,
                        height: 60,
                      ),
                Flexible(
                  child: FarenowButton(
                      onPressed: () {
                        ProfileScreenController profileScreenController =
                            Get.find();
                        profileScreenController.getProviderProfileDetail(
                            value.providerId,
                            fromProject: true);
                      },
                      title: "View Profile",
                      type: BUTTONTYPE.action),
                ),
              ],
            )
          ]),
        ),
      ),
    );

    // return Container(
    //   child: Padding(
    //     padding: const EdgeInsets.all(8.0),
    //     child: Column(
    //       children: [
    //         Row(
    //           children: [
    //             networkImageWidget(imageUrl: value.provider.image),
    //             SizedBox(
    //               width: Get.width * 0.03,
    //             ),
    //             Column(
    //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: [
    //                 Text(
    //                   "${getUserName(value.provider)}",
    //                   style: TextStyle(
    //                       fontSize: 16,
    //                       color: AppColors.black,
    //                       fontWeight: FontWeight.bold),
    //                 ),
    //                 //         //19, January 2020 - 12:00 PM
    //                 BuildSizedBox(5),
    // Text(
    //   getOrderDate(value.createdAt),
    //   style:
    //       TextStyle(fontWeight: FontWeight.w300, fontSize: 12),
    // ),
    //                 BuildSizedBox(5),
    //                 RatingStar(
    //                   size: 14,
    //                   rating:
    //                       double.parse((value.provider.rating ?? 0).toString()),
    //                   color: AppColors.appGreen,
    //                 ),
    //                 BuildSizedBox(5),
    //                 if (pending)
    //                   Text("Pending Amount: ${getPayableAmount(value)}")
    //               ],
    //             )
    //           ],
    //         ),
    //         BuildSizedBox(10),
    //         Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           children: [
    //             Container(
    //               alignment: Alignment.center,
    //               padding: EdgeInsets.only(left: 12, right: 12),
    //               height: Get.height * 30 / 774,
    //               decoration: BoxDecoration(
    //                   color: Colors.green.shade400,
    //                   borderRadius: BorderRadius.circular(30)),
    //               child: Text(
    //                 "${value.subService}",
    //                 style: TextStyle(color: AppColors.white, fontSize: 12),
    //               ),
    //             ),
    //             Container(
    //               alignment: Alignment.center,
    //               height: Get.height * 0.08,
    //               decoration: BoxDecoration(
    //                   // color: Colors.blue,
    //                   borderRadius: BorderRadius.circular(30)),
    //               // child: Text(
    //               //   "Reebook",
    //               //   style: TextStyle(
    //               //       color:
    //               //           AppColors.white,
    //               //       fontSize: 12),
    //               // ),
    //             ),
    //             SizedBox(
    //               width: 10,
    //             ),
    //             Container(
    //               alignment: Alignment.center,
    //               padding: EdgeInsets.only(left: 12, right: 12),
    //               height: Get.width * 0.08,
    //               decoration: BoxDecoration(
    //                   color: Colors.grey,
    //                   borderRadius: BorderRadius.circular(30)),
    //               child: Text(
    //                 "\$${value.paidAmount}",
    //                 style: TextStyle(color: AppColors.white, fontSize: 12),
    //               ),
    //             ),
    //             SizedBox(
    //               width: 0,
    //             ),
    //           ],
    //         )
    //       ],
    //     ),
    //   ),
    // );
  }

  bool checkPayable(ServiceListData data) {
    int hours = int.parse(data.hours.toString());
    int workedHours = int.parse(data.workedHours.toString());
    int result = hours - workedHours;
    bool has = result < 0 ? true : false;
    return has;
  }

  emptyView() {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child:
          SvgPicture.asset("assets/user_assets/svg/empty_service_history.svg"),
    );
  }

  getPayableAmount(data) {
    ServiceListData value = data;
    String _hours = value.hours.toString();
    double hours = double.parse(_hours);
    double paidAmount = double.parse(value.paidAmount.toString());
    double perHrAmount = paidAmount / hours;
    double extraHours = double.parse(value.workedHours.toString()) - hours;
    double amountTobePaid = extraHours * perHrAmount;

    return "($extraHours * $perHrAmount) \$$amountTobePaid";
  }

  void filterList() {
    paid.clear();
    pendingList.clear();
    for (int index = 0;
        index < (_homeScreenController.complete.value).length;
        index++) {
      ServiceListData value = _homeScreenController.complete.value[index];

      if (value.workedHours != null) {
        if (value.paidAmount != null) {
          if (checkPayable(value) && (value.paymentStatus ?? 0) == 0) {
            if (value.payable != null) {
              pendingList.add(value);
            }
          } else {
            paid.add(value);
            paid = paid.reversed.toList();
          }
        }
      }
    }
  }
}
