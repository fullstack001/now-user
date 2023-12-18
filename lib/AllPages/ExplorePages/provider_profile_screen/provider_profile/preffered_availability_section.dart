import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';

import 'export_file.dart';

converTimeFrom24Hour(String time, BuildContext context) {
  // var timeofDay = TimeOfDay(
  //         hour: int.parse(time.splitBefore(":")),
  //         minute: int.parse(time.splitAfter(":")))
  //     .format(context);
  // var timeofDay = TimeOfDay(hour: 23, minute: 3).format(context);
  DateTime tempDate = DateFormat("hh:mm").parse(
      "${int.parse(time.splitBefore(":"))}:${int.parse(time.splitAfter(":"))}");
  var dateFormat = DateFormat("h:mm a"); // you can change the format here

  // if (tempDate.is) {
  // return timeofDay;
  return dateFormat.format(tempDate);
  // } else {
  //   return "";
  // }
}

// ignore: must_be_immutable
class PrefferedAvailable extends StatelessWidget {
  List<Schedule>? schedule;
  PrefferedAvailable({Key? key, required this.schedule}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMainCardColum(widget: [
      const Padding(
          padding: EdgeInsets.only(bottom: 16),
          child: Text(
            "Preferred Availability",
            style: TextStyle(
                color: Color(0xff151415),
                fontSize: 20,
                fontWeight: FontWeight.w500),
          )),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
                color: const Color(0xffE8F7F1),
                borderRadius: BorderRadius.circular(6)),
            child: const Icon(
              Icons.calendar_month_sharp,
              size: 16,
              color: Color(0xff00B181),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Row(
              children: [
                Container(
                  width: Get.width * 0.6,
                  child: RichText(
                    text: TextSpan(
                        text: "Days: ",
                        style: const TextStyle(
                            color: Color(0xff151415),
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                        children: List.generate(
                            schedule!.length,
                            (index) => TextSpan(
                                  children: [
                                    TextSpan(
                                      text:
                                          "${schedule![index].day!.substring(0, 3)}",
                                      style: const TextStyle(
                                          color: Color(0xff00B181),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    index == schedule!.length - 1
                                        ? const TextSpan(text: " ")
                                        : const TextSpan(text: ", ")
                                  ],
                                  style: const TextStyle(
                                      color: Color(0xff151415),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ))),
                  ),
                )
              ],
            ),
          )
        ],
      ),
      const Divider(
        color: Colors.black54,
      ),
      const SizedBox(
        height: 5,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
                color: const Color(0xffE8F7F1),
                borderRadius: BorderRadius.circular(6)),
            child: const Icon(
              Icons.access_time_filled,
              size: 16,
              color: Color(
                0xff00B181,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Row(
              children: [
                schedule!.length > 1
                    ? Container(
                        width: Get.width * 0.6,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: List.generate(
                                schedule!.length,
                                (index) => Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: 42,
                                            child: Text(
                                              "${schedule![index].day!.substring(0, 3)}: ",
                                              style: const TextStyle(
                                                  color: Color(0xff555555),
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ),
                                          Text(
                                            "${converTimeFrom24Hour("${schedule![index].fromTime}", context)} ",
                                            style: const TextStyle(
                                                color: Color(0xff00B181),
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          const Text(
                                            " to ",
                                            style: TextStyle(
                                                color: Colors.black45,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w300),
                                          ),
                                          Text(
                                            "${converTimeFrom24Hour("${schedule![index].toTime}", context)} ",
                                            style: const TextStyle(
                                                color: Color(0xff00B181),
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          // index == schedule!.length - 1
                                          //     ? const Text("")
                                          //     : const Text(
                                          //         "",
                                          //         style: TextStyle(
                                          //             color: Colors.black,
                                          //             fontSize: 18,
                                          //             fontWeight:
                                          //                 FontWeight.bold),
                                          //       ),
                                        ]))),
                      )
                    // Container(
                    //     width: Get.width * 0.6,
                    //     child: RichText(

                    //         text: TextSpan(
                    //             style: const TextStyle(
                    //                 color: Color(0xff151415),
                    //                 fontSize: 16,
                    //                 fontWeight: FontWeight.w400),
                    //             children: List.generate(
                    //                 schedule!.length,
                    //                 (index) => TextSpan(children: [
                    //                       TextSpan(
                    //                         text:
                    //                             "${schedule![index].day!.substring(0, 3)}: ",
                    //                         style: const TextStyle(
                    //                             color: Color(0xff555555),
                    //                             fontSize: 16,
                    //                             fontWeight: FontWeight.w400),
                    //                       ),
                    //                       TextSpan(
                    //                         text:
                    //                             "${converTimeFrom24Hour("${schedule![index].fromTime}", context)} ",
                    //                         style: const TextStyle(
                    //                             color: Color(0xff00B181),
                    //                             fontSize: 16,
                    //                             fontWeight: FontWeight.w400),
                    //                       ),
                    //                       const TextSpan(
                    //                         text: " to ",
                    //                         style: TextStyle(
                    //                             color: Colors.black,
                    //                             fontSize: 16,
                    //                             fontWeight: FontWeight.w300),
                    //                       ),
                    //                       TextSpan(
                    //                         text:
                    //                             "${converTimeFrom24Hour("${schedule![index].toTime}", context)} ",
                    //                         style: const TextStyle(
                    //                             color: Color(0xff00B181),
                    //                             fontSize: 16,
                    //                             fontWeight: FontWeight.w400),
                    //                       ),
                    //                       index == schedule!.length - 1
                    //                           ? const TextSpan()
                    //                           : const TextSpan(
                    //                               text: "\n",
                    //                               style: TextStyle(
                    //                                   color: Colors.black,
                    //                                   fontSize: 18,
                    //                                   fontWeight:
                    //                                       FontWeight.bold),
                    //                             ),
                    //                     ])))),
                    //   )
                    : Container(
                        width: Get.width * 0.6,
                        margin: EdgeInsets.only(top: 5),
                        child: RichText(
                            text: TextSpan(
                                text: "Time: ",
                                style: const TextStyle(
                                    color: Color(0xff151415),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400),
                                children: List.generate(
                                    schedule!.length,
                                    (index) => TextSpan(children: [
                                          TextSpan(
                                            text:
                                                "${converTimeFrom24Hour("${schedule![index].fromTime}", context)} ",
                                            style: const TextStyle(
                                                color: Color(0xff00B181),
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          const TextSpan(
                                            text: " to ",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          TextSpan(
                                            text:
                                                "${converTimeFrom24Hour("${schedule![index].fromTime}", context)} ",
                                            style: const TextStyle(
                                                color: Color(0xff00B181),
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          index == schedule!.length - 1
                                              ? const TextSpan()
                                              : const TextSpan(
                                                  text: " : ",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                        ])))),
                      ),
              ],
            ),
          )
        ],
      )
    ]);
  }
}
