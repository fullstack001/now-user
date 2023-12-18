import 'package:application_1/AllPages/ProjectPages/controller/home_screen_controller.dart';
import 'package:application_1/AllPages/ProjectPages/home_pass_button_screen.dart';
import 'package:application_1/AllPages/chat/chat_screen.dart';
import 'package:application_1/model/service_response/provider_model.dart';
import 'package:application_1/model/service_response/service_list_data.dart';
import 'package:application_1/utils/date_time_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AcceptedOrderPage extends StatefulWidget {
  final data;
  final tabSelected;

  AcceptedOrderPage({Key? key, this.data, this.tabSelected}) : super(key: key);

  @override
  _AcceptedOrderPageState createState() => _AcceptedOrderPageState();
}

class _AcceptedOrderPageState extends State<AcceptedOrderPage> {
  HomeScreenController homeScreenController = Get.find();

  List<bool> flags = [true, false];

  @override
  Widget build(BuildContext context) {
    String type = widget.tabSelected ?? "accepted";
    return Column(
      children: [
        type == "accepted" &&
                widget.data.workingStatus == null &&
                widget.data.isCompleted != 1
            ? getWidget("accepted".capitalizeFirst)
            : type == "on_going" &&
                    widget.data.workingStatus.toString().toLowerCase() ==
                        "started" &&
                    widget.data.isCompleted != 1
                ? getWidget("started".capitalizeFirst)
                : Container(),
      ],
    );
  }

  String getUserName(ProviderModel user) {
    if (user.firstName == null) {
      return "N/A";
    }
    return "${user.firstName} ${user.lastName ?? ""}";
  }

  getTime({flag, homeScreenController, id}) {
    int hourResult = 0;
    int minResult = 0;
    int secResult = 0;
    if (homeScreenController.pauseTimeEmpty(id)) {
      String pauseTime = homeScreenController.getPauseTime(id);
      if (pauseTime.isNotEmpty) {
        hourResult = int.parse(pauseTime.split(":")[0]);
        minResult = int.parse(pauseTime.split(":")[1]);
        secResult = int.parse(pauseTime.split(":")[2]);
      }
      print(pauseTime);
    }
  }

  String passTitle(ServiceListData data) {
    if (data.status.toLowerCase() == "accepted" && data.directContact == 1) {
      return "Message";
    }
    if (data.status.toLowerCase() == "accepted") {
      return "accepted".capitalizeFirst!;
    }
    if (data.directContact == 1 && data.address == null) {
      return "accept".capitalizeFirst!;
    }
    return "accept".capitalizeFirst!;
  }

  getWidget(title) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          getUserName(widget.data.provider),
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                        DateTimeUtils().checkSince(
                          DateTimeUtils().convertString(widget.data.createdAt),
                        ),
                        //15 hours ago - pro responded
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w100)),
                  ),
                  const Divider(
                    thickness: 1,
                    color: Colors.black12,
                  ),
                  if (widget.data.address != null)
                    Column(
                      children: [
                        Container(
                          child: Row(
                            children: [
                              Container(
                                width: 8,
                                height: 8,
                                decoration: const BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(18),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 12,
                              ),
                              if (widget.data.address != null)
                                Expanded(
                                  child: Text(
                                    widget.data.address,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w200),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Container(
                          child: Row(
                            children: [
                              Container(
                                width: 8,
                                height: 8,
                                decoration: const BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(18),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 12,
                              ),
                              Expanded(
                                  child: Container(
                                width: 250,
                                child: Text(
                                    "Date:  ${DateTimeUtils().parseDateTime(DateTimeUtils().convertString(widget.data.createdAt), "dd MMM yyyy")}",
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w200)),
                              ))
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        if (widget.data.status.toString().toLowerCase() ==
                            "accepted")
                          InkWell(
                            onTap: () {
                              if (widget.data.status.toLowerCase() ==
                                      "accepted" &&
                                  widget.data.directContact == 1) {
                                print("");
                                String userId = widget.data.userId.toString();
                                String providerId = widget.data.providerId;
                                String name = getUserName(widget.data.provider);
                                Get.to(ChatScreen(
                                  senderId: providerId,
                                  receiverId: userId,
                                  name: name,
                                ));
                              }
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: double.infinity,
                              height: 47,
                              decoration: BoxDecoration(
                                  color: const Color(0xff40C08C),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Text(title,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.normal)),
                            ),
                          ),
                        const SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: () {
                            if (widget.data.provider.id == null) {
                              Get.defaultDialog(
                                  title: "Alert",
                                  content: const Text(
                                      "Service detail not available"),
                                  confirm: MaterialButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: const Text(
                                      "Okay",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ));
                            } else {
                              Get.to(HomePassButtonScreen(datas: widget.data));
                            }
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: double.infinity,
                            height: 47,
                            decoration: BoxDecoration(
                                color: const Color(0xff1B80F5),
                                borderRadius: BorderRadius.circular(10)),
                            child: const Text("View Details",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal)),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
