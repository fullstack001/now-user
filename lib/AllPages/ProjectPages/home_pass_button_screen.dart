import 'package:application_1/AllPages/ProjectPages/controller/home_screen_controller.dart';
import 'package:application_1/AllPages/RegisteraionPages/Controllers/RegistrationController.dart';
import 'package:application_1/components/buttons-management/part_of_file/part.dart';
import 'package:application_1/model/order_status/data.dart';
import 'package:application_1/model/order_status/order_status_response.dart';
import 'package:application_1/model/service_response/provider_model.dart';
import 'package:application_1/utils/AppColors.dart';

import 'package:application_1/utils/api_utils.dart';
import 'package:application_1/utils/date_time_utils.dart';

import 'package:application_1/widgets/timmer_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:progressive_image/progressive_image.dart';

import '../../custom_package/stop_watch/stop_watch.dart';
import '../ExplorePages/shopMenu.dart';

class HomePassButtonScreen extends StatefulWidget {
  final datas;

  HomePassButtonScreen({Key? key, this.datas}) : super(key: key);

  @override
  _HomePassButtonScreenState createState() => _HomePassButtonScreenState();
}

class _HomePassButtonScreenState extends State<HomePassButtonScreen> {
  HomeScreenController _homeScreenController = Get.find();
  final RegistrationController _registrationController = Get.find();
  var timePause;
  var data;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _homeScreenController.getTimeFromPrefs();

    if (widget.datas.status.toString().toLowerCase() == "accepted" &&
        widget.datas.workingStatus != null) {
      _homeScreenController.getOrderStatus(widget.datas.id, flag: true,
          upDateView: () {
        setState(() {});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    data ??= widget.datas;
    return Scaffold(
      backgroundColor: const Color(0xffE0E0E0).withOpacity(0.3),
      appBar: AppBar(
        iconTheme: IconTheme.of(context).copyWith(color: blackColor),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        title: const Text(
          "Order Detail",
          style: TextStyle(
              color: Color(0xff151415),
              fontWeight: FontWeight.w500,
              fontSize: 18),
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  child: Column(
                    children: [
                      // Container(
                      //   width: double.infinity,
                      //   height: 200,
                      //   child: Stack(
                      //     children: [
                      //       Container(
                      //         width: double.infinity,
                      //         height: 145,
                      //         decoration: BoxDecoration(
                      //             image: DecorationImage(
                      //                 fit: BoxFit.cover,
                      //                 image:
                      //                     AssetImage("assets/images/mapHeader.png"))),
                      //       ),
                      // Align(
                      //   alignment: Alignment.bottomCenter,
                      //   child: Container(
                      //     width: 112,
                      //     height: 112,
                      //     child: ClipOval(
                      //       child: data.provider.image == null
                      //           ? Image(
                      //               image: AssetImage(
                      //                   'assets/images/img_profile_place_holder.jpg'),
                      //             )
                      //           : ProgressiveImage(
                      //               placeholder: AssetImage(
                      //                   'assets/images/img_profile_place_holder.jpg'),
                      //               // size: 1.87KB
                      //               thumbnail: NetworkImage(
                      //                   ApiUtills.imageBaseUrl +
                      //                       data.provider.image),
                      //               // size: 1.29MB
                      //               image: NetworkImage(ApiUtills.imageBaseUrl +
                      //                   data.provider.image),
                      //               height: 300,
                      //               width: 500,
                      //             ),
                      //     ),
                      //   ),
                      // ),
                      //     ],
                      //   ),
                      // ),

                      // Container(
                      //   alignment: Alignment.center,
                      //   width: double.infinity,
                      //   height: 150,
                      //   child: Column(
                      //     crossAxisAlignment: CrossAxisAlignment.center,
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     children: [
                      //       SizedBox(
                      //         height: 6,
                      //       ),
                      //       Text(
                      //         getUserName(data.provider),
                      //         style: TextStyle(
                      //             color: Colors.black,
                      //             fontWeight: FontWeight.bold,
                      //             fontSize: 16),
                      //       ),
                      //       if (data.address != null)
                      //         Text(
                      //           data.address,
                      //           style: TextStyle(
                      //               color: Colors.grey.shade500, fontSize: 12),
                      //         ),
                      //       RatingStar(
                      //         size: 20,
                      //         rating:
                      //             double.parse((data.provider.rating ?? 0).toString()),
                      //         color: AppColors.appGreen,
                      //       ),
                      //       SizedBox(
                      //         height: 10,
                      //       ),
                      //       InkWell(
                      //         onTap: () {
                      //           if (getReplied()) {
                      //             Get.to(ChatScreen(
                      //               receiverId: data.providerId,
                      //               senderId: _registrationController.userData.value.id,
                      //               name: getUserName(data.provider),
                      //               orderId: data.id.toString(),
                      //             ));
                      //           }
                      //         },
                      //         child: CustomContainer(
                      //             width: 300,
                      //             height: 40,
                      //             color: getReplied() ? Colors.blue : Colors.grey,
                      //             allRadius: 20,
                      //             child: Text(
                      //               getReplied() ? "Message" : "Chat Request sent",
                      //               style: TextStyle(color: Colors.white, fontSize: 16),
                      //               textAlign: TextAlign.center,
                      //             )),
                      //       ),
                      //
                      //     ],
                      //   ),
                      // ),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: ListTile(
                          leading: Container(
                            width: 50,
                            height: 50,
                            child: Stack(
                              children: [
                                Container(
                                  width: 50,
                                  height: 50,
                                  child: ClipOval(
                                    child: data.provider.image == null
                                        ? const Image(
                                            image: AssetImage(
                                                'assets/user_assets/png/user.png'),
                                          )
                                        : ProgressiveImage(
                                            placeholder: const AssetImage(
                                                'assets/user_assets/png/user.png'),
                                            // size: 1.87KB
                                            thumbnail: NetworkImage(
                                                ApiUtills.imageBaseUrl +
                                                    data.provider.image),
                                            // size: 1.29MB
                                            image: NetworkImage(
                                                ApiUtills.imageBaseUrl +
                                                    data.provider.image),

                                            height: 50,
                                            width: 50,
                                          ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Container(
                                    width: 15,
                                    height: 15,
                                    decoration: const BoxDecoration(
                                        color: whiteColor,
                                        shape: BoxShape.circle),
                                    padding: const EdgeInsets.all(2),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: green, shape: BoxShape.circle),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          title: Text(
                            getUserName(data.provider),
                            style: const TextStyle(
                                color: Color(0xff151415),
                                fontWeight: FontWeight.w500,
                                fontSize: 18),
                          ),
                          subtitle: Row(children: [
                            const Icon(
                              Icons.star,
                              color: Color(0xffFF9E45),
                            ),
                            Text(
                              "${data.provider.rating}",
                              style: const TextStyle(
                                  color: Color(0xff151415),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16),
                            ),
                            Text(
                              " (${data.provider.userFeedbackCount ?? 0}) ",
                              style: const TextStyle(
                                  color: Color(0xff555555),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16),
                            ),
                          ]),
                        ),
                      ),

                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                        color: const Color(0xffE0E0E0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Order Detail",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                    color: data.workingStatus == "ENDED" &&
                                            data.status == "ACCEPTED"
                                        ? const Color(0xff868B9A)
                                        : const Color(0xffF8CE39),
                                    borderRadius: BorderRadius.circular(30)),
                                child: Text(
                                  data.workingStatus == "ENDED" &&
                                          data.status == "ACCEPTED"
                                      ? "Completed"
                                      : "${data.status}",
                                  style: const TextStyle(
                                      color: Color(0xff151415), fontSize: 12),
                                ),
                              )
                            ]),
                      ),

                      //TODO Service Number
                      if (data.id != null)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 12),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Service Number:",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                        color: Color(0xff555555)),
                                  ),
                                  Text(
                                    "#${data.id.toString()}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                        color: Color(0xff151415)),
                                  ),
                                ],
                              ),

                              // Align(
                              //   alignment: Alignment.centerLeft,
                              //   child: Text(
                              //     "${DateTimeUtils().checkSince(DateTimeUtils().getUtcTime(data.createdAt))}",
                              //     style: TextStyle(
                              //         fontWeight: FontWeight.w300, fontSize: 12),
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      if (data.id != null)
                        const Divider(
                          thickness: 1,
                        ),

                      if (data.workedHours != null)
                        getContainer("Worked Hours:", "${data.workedHours}",
                            hide: true),
                      if (data.workedHours != null)
                        const Divider(
                          thickness: 1,
                        ),

                      if (_homeScreenController.orderStatus.value.data != null)
                        // _homeScreenController.orderStatus.value.data.isPaused ==
                        //         1
                        //     ? Container()
                        //     :
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 12),
                          child: Row(
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Job Timer:",
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    color: Color(0xff555555)),
                              ),
                              // getTimeDate(
                              //     _homeScreenController.orderStatus.value)
                              Obx(() {
                                return getTime(getList(
                                    _homeScreenController.orderStatus.value));
                              }),

                              // Divider(
                              //   thickness: 1,
                              //   indent: 10,
                              //   endIndent: 10,
                              // )
                            ],
                          ),
                        ),
                      if (_homeScreenController.orderStatus.value.data != null)
                        // _homeScreenController.orderStatus.value.data.isPaused ==
                        //     1
                        // ? Container()
                        // :
                        const Divider(
                          thickness: 1,
                        ),
                      if (data.requestInfos.isNotEmpty)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 6),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Job Type:",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                        color: Color(0xff555555)),
                                  ),
                                  FittedBox(
                                    child: Text(
                                      data.requestInfos.first.question
                                          .subService.name,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                          color: Color(0xff151415)),
                                    ),
                                  ),
                                ],
                              ),

                              // Align(
                              //   alignment: Alignment.centerLeft,
                              //   child: Text(
                              //     "${DateTimeUtils().checkSince(DateTimeUtils().getUtcTime(data.createdAt))}",
                              //     style: TextStyle(
                              //         fontWeight: FontWeight.w300, fontSize: 12),
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      if (data.requestInfos.isNotEmpty)
                        const Divider(
                          thickness: 1,
                        ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                        child: Row(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Date:",
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: Color(0xff555555)),
                            ),
                            Text(
                              "${DateTimeUtils().parseDateTime(DateTimeUtils().convertString(data.createdAt), "dd MMM yyyy")}",
                              style: const TextStyle(
                                  color: Color(0xff151415), fontSize: 12),
                            ),

                            // Text(
                            //   "${convertToAgo(DateTime.parse(data.createdAt))}",
                            //   style:
                            //       TextStyle(fontWeight: FontWeight.w300, fontSize: 16),
                            // ),
                            // Text(
                            //   "${DateTimeUtils().checkSince(DateTimeUtils().convertString(data.createdAt))}",
                            //   style: TextStyle(fontWeight: FontWeight.w300, fontSize: 16),
                            // ),
                          ],
                        ),
                      ),

                      const Divider(
                        thickness: 1,
                      ),

                      // TODO working status

                      if (data.workingStatus != null)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 12),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Working Status:",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                        color: Color(0xff555555)),
                                  ),
                                  Text(
                                    data.workingStatus.toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                        color: Color(0xff151415)),
                                  ),
                                ],
                              ),

                              // Align(
                              //   alignment: Alignment.centerLeft,
                              //   child: Text(
                              //     "${DateTimeUtils().checkSince(DateTimeUtils().getUtcTime(data.createdAt))}",
                              //     style: TextStyle(
                              //         fontWeight: FontWeight.w300, fontSize: 12),
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      if (data.workingStatus != null)
                        const Divider(
                          thickness: 1,
                        ),

                      if (data.timeSlots.isNotEmpty)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 6),
                          child: Row(
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Timing",
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    color: Color(0xff555555)),
                              ),

                              Text("${data.timeSlots.first.start}",
                                  style: const TextStyle(
                                      color: Color(0xff151415), fontSize: 12)),
                              // Text(
                              //   "Timing : Afternoon (3pm- 6pm)",
                              //   style: TextStyle(fontWeight: FontWeight.normal, fontSize: 20),
                              // ),
                              // Text(
                              //   "${convertToAgo(DateTime.parse(data.createdAt))}",
                              //   style:
                              //       TextStyle(fontWeight: FontWeight.w300, fontSize: 16),
                              // ),
                              // Text(
                              //   "${DateTimeUtils().checkSince(DateTimeUtils().convertString(data.createdAt))}",
                              //   style: TextStyle(fontWeight: FontWeight.w300, fontSize: 16),
                              // ),
                            ],
                          ),
                        ),

                      if (data.timeSlots.isNotEmpty)
                        const Divider(
                          thickness: 1,
                        ),
                      // getContainer("Prototo Type", "Home"),
                      if (data.address != null)
                        getContainer("Address", "${data.address}", hide: true),
                      // if (data.address != null)
                      //   Divider(
                      //     thickness: 1,
                      //   )
                      ////end
                      // getContainer(
                      //     "Job Type", data.requestInfos.first.question.subService.name),
                      // for (int index = 0; index < data.requestInfos.length; index++)
                      //   if (data.requestInfos[index].question != null)
                      //     getContainer(
                      //         data.requestInfos[index].question.question,
                      //         getOption(
                      //             data.requestInfos[index].question.id, index),
                      //         hide: true),
                      // getContainer("Message",
                      //     "Lorem ipsum dolor sit amet, consectetur adipiscing elit ut aliquam"),
                      // getContainer(
                      //     "Travel prefrences", "Professional must travel to my address"),
                      // getContainer("Zip code", "100024"),

                      // if ((data.quotationInfo ?? QuotationInfo()).id != null)
                      /*Column(
                          children: [
                            getContainer("Quotation Detail", data.quotationInfo.detail,
                                hide: false),
                            if (data.quotationInfo.reply != null)
                              Column(
                                children: [
                                  SizedBox(
                                    height: 12,
                                  ),
                                  getContainer("Response Detail", null, hide: true),
                                  SizedBox(
                                    height: 12,
                                  ),
                                  getContainer("Work Price", data.quotationInfo.price,
                                      hide: false),
                                  getContainer("Work Duration", data.quotationInfo.duration,
                                      hide: false),
                                  getContainer("Work Description", data.quotationInfo.reply,
                                      hide: false),
                                ],
                              )
                          ],
                        ),*/

                      /* data.quotationInfo != null && data.status.toLowerCase() == "pending"
                          ? InkWell(
                              onTap: () {
                                Get.dialog(RespondDialog(
                                  body: data,
                                  quotationInfo: data.quotationInfo,
                                  response: (value) {
                                    var response = json.decode(value);
                                    data.status = response['data']['status'];
                                    print(value);
                                  },
                                ));
                              },
                              child: Container(
                                margin: EdgeInsets.only(left: 12, right: 12),
                                alignment: Alignment.center,
                                width: double.infinity,
                                height: 47,
                                decoration: BoxDecoration(
                                    color: Color(0xff40C08C),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Text("Check Response",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.normal)),
                              ),
                            )
                          : */
                    ],
                  ),
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                    child: data.workingStatus == "ENDED" &&
                            data.status == "ACCEPTED"
                        ? Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: AppButton(
                              shapeBorder: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              enabled: false,
                              text: "Completed",
                              disabledColor: Colors.grey.shade300,
                              textStyle: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: AppColors.solidBlue),
                            ),
                          )
                        : FarenowButton(
                            title: "${data.status.toString().capitalizeFirst!}",
                            onPressed: () {},
                            type: BUTTONTYPE.rectangular,
                          )
                    // InkWell(
                    //     onTap: () {},
                    //     child: Container(
                    //       alignment: Alignment.center,
                    //       width: double.infinity,
                    //       height: 47,
                    //       decoration: BoxDecoration(
                    //           color: Color(0xff40C08C),
                    //           borderRadius: BorderRadius.circular(10)),
                    //       child: Text(data.status.toString().capitalizeFirst!,
                    //           style: TextStyle(
                    //               color: Colors.white,
                    //               fontSize: 18,
                    //               fontWeight: FontWeight.normal)),
                    //     ),
                    //   ),
                    ),
              ],
            ),
          )
        ],
      ),
    );
  }

  String getUserName(ProviderModel user) {
    if (user.firstName == null) {
      return "N/A";
    }
    return "${user.firstName.toString().capitalizeFirst} ${user.lastName.toString().capitalizeFirst ?? ""}";
  }

  Container getContainer(String val1, val2, {hide}) {
    bool lineHide = hide ?? false;
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("$val1",
                    style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Color(0xff555555))),
                if (val2 != null)
                  Container(
                    width: Get.width * 0.42,
                    alignment: Alignment.centerRight,
                    child: Text(
                      "$val2",
                      style: const TextStyle(
                          fontWeight: FontWeight.normal, fontSize: 16),
                    ),
                  ),
              ],
            ),
          ),
          // if (lineHide)
          //   Divider(
          //     thickness: 1,
          //   ),
        ],
      ),
    );
  }

  check(data) {
    if (data.status.toLowerCase() != "accepted") {
      return false;
    }
    if (data.status.toLowerCase() != "rejected") {
      return false;
    }

    return true;
  }

  getOption(int id, int index) {
    // if (data.requestInfos[index].option.questionId == id) {
    //   return data.requestInfos[index].option.option;
    // }
    return "N/A";
  }

  bool getReplied() {
    if (data.status.toString().toLowerCase() == "accepted") {
      return true;
    }

    return (data.isReplied ?? 0) != 0;
  }

  getTime(List data, {flag}) {
    String time = getStartTime(data);
    DateTime cTime = DateFormat("yyyy-MM-dd HH:mm:ss").parse(time, true);
    String convertTime =
        DateTimeUtils().parseDateTime(DateTime.now(), "yyyy-MM-dd HH:mm:ss");
    DateTime now = DateTimeUtils().convertStringSeconds(convertTime,
        format: "yyyy-MM-dd HH:mm:ss", isHour12: true);

    if (cTime.isUtc) {
      cTime = cTime.toLocal();
    }

    int diffSc = _homeScreenController.orderStatus.value.data.isPaused == 1
        ? getPauseTime(getList(_homeScreenController.orderStatus.value))
        : _homeScreenController.orderStatus.value.data.isCompleted == 1
            ? getWorkedTime(getList(_homeScreenController.orderStatus.value))
            : now.difference(cTime).inSeconds;

    int beakLaps =
        getBeakTime(getList(_homeScreenController.orderStatus.value));
    // if (_homeScreenController.orderStatus.value.data.isCompleted == 0) {
    diffSc = diffSc - beakLaps;
    // }
    int sec = diffSc ~/ 60;
    int secResult = diffSc - (sec * 60);
    int hourResult = sec ~/ 60;
    int minResult = sec - (hourResult * 60);
    int days = hourResult ~/ 24;
    if (days != 0) {
      int daysInHours = days * 24;
      hourResult = hourResult - daysInHours;
    }

    return TimmerWidget(
        hours: hourResult,
        minutes: minResult,
        seconds: secResult,
        // days: days,
        pause: _homeScreenController.orderStatus.value.data.isCompleted == 1 &&
                widget.datas.workingStatus.toString().toLowerCase() == "ended"
            ? true
            : _homeScreenController.orderStatus.value.data.isPaused == 1
                ? true
                : false,
        timeChange: (value) {
          timePause = value;
          print("tik tik $timePause");
        });
  }

  int getBeakTime(List workedTimes) {
    int count = 0;
    workedTimes.sort((a, b) => a.startAt.compareTo(b.startAt));
    if (workedTimes.length > 1) {
      for (int index = 0; index < workedTimes.length; index++) {
        if (workedTimes[index].endAt != null && index != 0) {
          DateTime startTime =
              DateTimeUtils().convertStringSeconds(workedTimes[index].startAt);
          DateTime endTime =
              DateTimeUtils().convertStringSeconds(workedTimes[index].endAt);

          int diffSc = endTime.difference(startTime).inSeconds;
          count = count + diffSc;
        }
      }
    }
    return count;
  }

  String getStartTime(List workedTimes) {
    workedTimes.sort((a, b) => a.startAt.compareTo(b.startAt));

    for (int index = 0; index < workedTimes.length; index++) {
      if (workedTimes[index].endAt == null) {
        var dateTime = DateFormat("yyyy-MM-ddTHH:mm:ss")
            .parse(workedTimes[index].createdAt, true);
        String tme = dateTime.toString();
        if (tme.toString().toLowerCase().contains("t")) {
          tme = tme.replaceAll(
            "T",
            " ",
          );
        }
        return tme;
      } else {
        var dateTime = DateFormat("yyyy-MM-ddTHH:mm:ss")
            .parse(workedTimes[index].createdAt, true);
        String tme = dateTime.toLocal().toString();
        if (tme.toString().toLowerCase().contains("t")) {
          tme = tme.replaceAll("T", " ");
        }
        return tme;
      }
    }
    return DateTime.now().toString();
  }

  getWorkedTime(List workedTimes) {
    int count = 0;
    workedTimes.sort((a, b) => a.startAt.compareTo(b.startAt));
    for (int index = 0; index < workedTimes.length; index++) {
      DateTime startTime =
          DateTimeUtils().convertStringSeconds(workedTimes[index].startAt);
      DateTime endTime =
          DateTimeUtils().convertStringSeconds(workedTimes[index].endAt);

      int diffSc = endTime.difference(startTime).inSeconds;
      count = count + diffSc;
      break;
    }

    return count;
  }

  getPauseTime(List workedTimes) {
    int count = 0;
    workedTimes.sort((a, b) => a.startAt.compareTo(b.startAt));
    DateTime startTime =
        DateTimeUtils().convertStringSeconds(workedTimes[0].startAt);
    DateTime endTime = DateTime.now();

    if (workedTimes.length == 1) {
      endTime = DateTimeUtils().convertStringSeconds(workedTimes[0].startAt);
    } else {
      endTime = DateTimeUtils().convertStringSeconds(workedTimes.last.startAt);
    }

    int diffSc = endTime.difference(startTime).inSeconds;
    count = count + diffSc;

    return count;
  }

  List getList(OrderStatusResponse value) {
    Data data = _homeScreenController.orderStatus.value.data ?? Data();
    List list = data.workedTimes ?? [];
    return list;
  }

  String convertToAgo(DateTime input) {
    Duration diff = DateTime.now().difference(input);

    if (diff.inDays >= 1) {
      if (diff.inDays == 1) {
        return '${diff.inDays} day ago';
      } else {
        return '${diff.inDays} days ago';
      }
    } else if (diff.inHours >= 1) {
      if (diff.inHours == 1) {
        return '${diff.inHours} hour ago';
      } else {
        return '${diff.inHours} hours ago';
      }
    } else if (diff.inMinutes >= 1) {
      if (diff.inMinutes == 1) {
        return '${diff.inMinutes} minute ago';
      } else {
        return '${diff.inMinutes} minutes ago';
      }
    } else if (diff.inSeconds >= 1) {
      if (diff.inSeconds == 1) {
        return '${diff.inSeconds} second ago';
      } else {
        return '${diff.inSeconds} seconds ago';
      }
    } else {
      return 'just now';
    }
  }

  getTimeDate(value) {
    DateTime dt1 = DateTime.parse("2021-12-23 11:47:00");
    DateTime dt2 = DateTime.parse("2020-09-12 10:57:00");
    Duration diff = dt1.difference(dt2);

    if (diff != null) {
      print("Difference is negative");
      var r = "${diff.inHours}: ${diff.inMinutes} :${diff.inSeconds}";
      return Text("");
    }
    return Text("");
  }
}
