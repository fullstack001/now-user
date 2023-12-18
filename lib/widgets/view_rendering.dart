import 'package:application_1/AllPages/ExplorePages/Controllers/profile_controller.dart';
import 'package:application_1/AllPages/ProjectPages/controller/home_screen_controller.dart';
import 'package:application_1/AllPages/ProjectPages/home_pass_button_screen.dart';
import 'package:application_1/AllPages/chat/chat_screen.dart';
import 'package:application_1/AllPages/moving/screes/moving_detail_screen.dart';
import 'package:application_1/components/buttons-management/part_of_file/part.dart';
import 'package:application_1/components/buttons-management/style_model.dart';
import 'package:application_1/components/text_fields/farenow_text_field.dart';
import 'package:application_1/model/service_response/service_list_data.dart';
import 'package:application_1/utils/AppColors.dart';
import 'package:application_1/utils/date_time_utils.dart';
import 'package:application_1/utils/project_widget.dart';
import 'package:application_1/widgets/data_not_available_widget.dart';
import 'package:application_1/widgets/timmer_widget.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';

import '../AllPages/ExplorePages/Controllers/providerListController.dart';
import '../AllPages/RegisteraionPages/Controllers/RegistrationController.dart';
import '../AllPages/rating_controller.dart';
import '../remote_model/provider_list/provider_list_response_model.dart';
import '../utils/api_utils.dart';
import '../utils/app_dialog_utils.dart';
import '../utils/widgest_utills.dart';

var pages = [];
// List<bool> flags = [true, false, false, false];
// List<bool> flagTabs = [true, false];
List<Widget> page = [];

class ViewRendering {
  final _feedbackController = TextEditingController();

  getWidgetList(indexs, HomeScreenController controller,
      ProfileScreenController _screenController,
      {tabUpDate, tabSelected}) {
    var list = [];
    page = [];
    var listR = controller.charRequest.value.reversed.toList();
    for (int indexx = 0; indexx < flags.length; indexx++) {
      list = getListFromController(indexs, indexx, controller);
      // list = controller.requested.value;
      list = getList(list.reversed.toList());
      list.isNotEmpty || list.isEmpty && indexx == 1
          ? page.add(
              listOfWidget(
                indexx: indexx,
                tabUpDate: tabUpDate,
                tabSelected: tabSelected,
                controller: controller,
                screenController: _screenController,
                list: list,
              ),
            )
          : indexx == 3
              ? page.add(Scaffold(
                  backgroundColor: const Color(0xffF5F5F5),
                  body: Align(
                    alignment: Alignment.topCenter,
                    child: SvgPicture.asset(
                      "assets/user_assets/svg/no_chat_available.svg",
                      width: Get.width * 0.9,
                    ),
                  ),
                ))
              : page.add(DataNotAvailableWidget());
    }

    return page;
  }

  List getList(List<dynamic> list) {
    List newList = [];
    for (int index = 0; index < list.length; index++) {
      print("$index");
      if (list[index].provider.id != null) {
        newList.add(list[index]);
      }
    }
    return newList;
  }

  Widget listOfWidget({
    indexx,
    tabUpDate,
    tabSelected,
    controller,
    screenController,
    list,
  }) {
    print(indexx);
    print(list.length);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        children: [
          if (indexx == 1) acceptOnGoingTabs(tabUpDate),
          // SizedBox(
          //   height: 12,
          // ),
          // sortWidgets(),
          Expanded(
            child: indexx == 1
                ? Container(
                    child: tabSelected == "accepted"
                        ? acceptedView(
                            tabSelected, controller.accepted, screenController)
                        : tabSelected == "completed"
                            ? acceptedView(tabSelected, controller.complete,
                                screenController)
                            : acceptedView(tabSelected, controller.onGoing,
                                screenController),
                  )
                : indexx == 3
                    ? ListView(
                        children: [
                          for (int indexI = 0; indexI < list.length; indexI++)
                            if (list[indexI].provider.id != null)
                              chatCard(list[indexI], screenController,
                                  homeScreenController: controller)
                        ],
                      )
                    : ListView(
                        children: [
                          for (int indexI = 0; indexI < list.length; indexI++)
                            if (list[indexI].provider.id != null)
                              itemViewCard(list[indexI], screenController,
                                  homeScreenController: controller)
                        ],
                      ),
          ),
        ],
      ),
    );
  }

  chatCard(
      ServiceListData data, ProfileScreenController profileScreenController,
      {index, HomeScreenController? homeScreenController}) {
    final RegistrationController _registrationController = Get.find();
    print(data);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Column(
            children: [
              ListTile(
                leading: data.provider.image != null
                    ? cacheNetworkImage(
                        imageUrl: ApiUtills.imageBaseUrl + data.provider.image,
                        imageHeight: 40,
                        imageWidth: 40,
                        placeHolder: 'assets/user_assets/png/user.png',
                        radius: 100)
                    : Image.asset(
                        'assets/user_assets/png/user.png',
                        fit: BoxFit.fill,
                        width: 40,
                        height: 40,
                      ),
                title: Row(
                  children: [
                    Text(
                      "${data.provider.firstName} ${data.provider.lastName}",
                      style: const TextStyle(
                          color: Color(0xff151415),
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                    5.width,
                    Icon(
                      Icons.verified,
                      color: data.provider.verifiedAt != null
                          ? AppColors.solidBlue
                          : const Color(0xffE0E0E0),
                      size: 18,
                    )
                  ],
                ),
                subtitle: Text("${data.provider.bio}"),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(top: 8, left: 12),
                alignment: Alignment.centerLeft,
                child: Text(
                    DateTimeUtils().checkSince(DateFormat("yyyy-MM-ddTHH:mm:ss")
                        .parse(data.createdAt, true)),

                    //15 hours ago - pro responded
                    style: const TextStyle(
                        color: Color(0xff757575),
                        fontSize: 12,
                        fontWeight: FontWeight.w400)),
              ),
              Row(
                children: [
                  Flexible(
                    child: FarenowButton(
                        style: FarenowButtonStyleModel(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 4, vertical: 12)),
                        title: "Message",
                        onPressed: () {
                          Get.to(ChatScreen(
                            orderId: data.id,
                            senderId: _registrationController.userData.value.id,
                            receiverId: data.providerId,
                            name:
                                "${data.provider.firstName} ${data.provider.lastName}",
                          ));
                        },
                        type: BUTTONTYPE.action),
                  ),
                  Flexible(
                    child: FarenowButton(
                        style: FarenowButtonStyleModel(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 4, vertical: 12)),
                        title: "View Details",
                        onPressed: () {
                          profileScreenController.getProviderProfileDetail(
                              data.providerId,
                              fromProject: true);
                        },
                        type: BUTTONTYPE.rectangular),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  acceptedView(tabSelected, RxList<dynamic> accepted, _screenController) {
    print(accepted);
    if (accepted.isNotEmpty) {
      return ListView(
        children: [
          for (int indexI = 0; indexI < accepted.length; indexI++)
            if (accepted[indexI].provider.id != null)
              Obx(() {
                return itemViewCard(accepted[indexI], _screenController,
                    index: tabSelected == "accepted" ? -1 : 0);
              })
        ],
      );
    }
    return DataNotAvailableWidget();
  }

  itemViewCard(
    ServiceListData data,
    ProfileScreenController _screenController, {
    index,
    HomeScreenController? homeScreenController,
  }) {
    var initialRating = 1.0;
    if (homeScreenController == null) {
      homeScreenController = Get.put(HomeScreenController(flag: true));
    }
    int ind = index ?? -1;

    print(data);
    print("Data");
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        elevation: 12,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Text(
                        "Service No. ",
                        style: TextStyle(
                            color: Color(0xff555555),
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                      Text(
                        "#${data.id}",
                        style: const TextStyle(
                            color: Color(0xff151415),
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  if (data.isCompleted == 0)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color:
                              data.status.toString().toLowerCase() == "rejected"
                                  ? const Color(0xffEC766D)
                                  : data.status.toString().toLowerCase() ==
                                          "accepted"
                                      ? const Color(0xff40C08C)
                                      : const Color(0xffF8CE39)),
                      child: Text(data.workingStatus == null
                          ? "${data.status}".capitalizeFirst.toString()
                          : "${data.workingStatus}".capitalizeFirst.toString()),
                    ),
                  if (data.isCompleted == 1)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: const Color(0xffE0E0E0),
                      ),
                      child: Text("Completed".capitalizeFirst.toString()),
                    )
                ],
              ),
              16.height,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          // getUserName(data.provider),
                          "${data.subService}",
                          style: const TextStyle(
                              color: Color(0xff151415),
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                        if (data.workingStatus.toString().toLowerCase() ==
                                "started" &&
                            data.type.toString().toLowerCase() !=
                                "moving_request")
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 4),
                            decoration: BoxDecoration(
                                color: const Color(0xffE0E0E0),
                                borderRadius: BorderRadius.circular(30)),
                            child: getTime(
                                homeScreenController: homeScreenController,
                                data: data),
                          )
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(top: 8),
                    alignment: Alignment.centerLeft,
                    child: Text(
                        DateTimeUtils().checkSince(
                            DateFormat("yyyy-MM-ddTHH:mm:ss")
                                .parse(data.createdAt, true)),

                        //15 hours ago - pro responded
                        style: const TextStyle(
                            color: Color(0xff757575),
                            fontSize: 12,
                            fontWeight: FontWeight.w400)),
                  ),
                ],
              ),

              // if (data.type == "MOVING_REQUEST") movingPoints(data),
              // if (data.address != null)
              //   Column(
              //     children: [
              //       // Container(
              //       //   child: addressRow(data.address),
              //       // ),
              //       SizedBox(
              //         height: 12,
              //       ),
              //       Container(
              //         child: Row(
              //           children: [
              //             Container(
              //               width: 8,
              //               height: 8,
              //               decoration: BoxDecoration(
              //                 color: Colors.black,
              //                 borderRadius: BorderRadius.all(
              //                   Radius.circular(18),
              //                 ),
              //               ),
              //             ),
              //             SizedBox(
              //               width: 12,
              //             ),
              //             Expanded(
              //                 child: Container(
              //               width: 250,
              //               child: Text(
              //                   "Available on ${DateTimeUtils().parseDateTime(DateTimeUtils().convertString(data.createdAt), "dd MMM yyyy")}",
              //                   style: TextStyle(
              //                       color: Colors.black,
              //                       fontSize: 16,
              //                       fontWeight: FontWeight.w200)),
              //             ))
              //           ],
              //         ),
              //       ),
              //       SizedBox(
              //         height: 10,
              //       ),
              //     ],
              //   ),
              data.status.toString().toLowerCase() == "accepted" &&
                      data.directContact == 1
                  ? Container(
                      child: chatButtons(data, _screenController),
                    )
                  : pendingButton(ind == -1 ? data.status : data.workingStatus,
                      homeScreenController!, data, _screenController),
              if (data.status.toString().toLowerCase() == "accepted")
                data.userFeedback == null && data.isCompleted != 0
                    ? Builder(builder: (context) {
                        return FarenowButton(
                            title: "Give Feedback",
                            style: FarenowButtonStyleModel(
                                padding: const EdgeInsets.only(top: 12)),
                            onPressed: () {
                              // Get.dialog(FeedBackPage(
                              //     data: data,
                              //     onRateComplete: () {
                              //       homeScreenController!
                              //           .getAvailableJobs(flag: true);
                              //     }));
                              showModalBottomSheet(
                                isScrollControlled: false,
                                backgroundColor: white,
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(30),
                                        topRight: Radius.circular(30))),
                                context: context,
                                builder: (context) {
                                  return Card(
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(30),
                                            topRight: Radius.circular(30))),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 24,
                                          left: 24,
                                          right: 24,
                                          top: 0),
                                      child: Column(
                                          // mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 4),
                                              child: Container(
                                                width: 60,
                                                height: 5,
                                                decoration: BoxDecoration(
                                                    color:
                                                        const Color(0xffE0E0E0),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30)),
                                              ),
                                            ),
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 4),
                                              child: const Text(
                                                "Add Feedback",
                                                style: TextStyle(
                                                    color: Color(0xff151415),
                                                    fontSize: 32,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                            FarenowTextField(
                                              controller: _feedbackController,
                                              hint: "Enter feedback here",
                                              label: "Add Comment",
                                              maxLine: 5,
                                              inputAction: TextInputAction.done,
                                              onSubmit: (v) {
                                                RatingController rating =
                                                    Get.put(RatingController());
                                                if (_feedbackController
                                                    .text.isEmpty) {
                                                  alertDialog(
                                                    title: "Alert",
                                                    content:
                                                        "Please enter your feedback",
                                                    confirm: MaterialButton(
                                                      onPressed: () {
                                                        Get.back();
                                                      },
                                                      child: const Text("Okay"),
                                                    ),
                                                  );
                                                  return;
                                                }

                                                String feedBack =
                                                    _feedbackController.text
                                                        .toString();
                                                var userId = data.provider.id;
                                                var serviceId = data.id;

                                                Map body = <String, dynamic>{
                                                  "service_request_id":
                                                      serviceId,
                                                  "provider_id": userId,
                                                  "comment": feedBack,
                                                  "rating": initialRating
                                                };
                                                print(body);
                                                rating.sendFeedback(
                                                    body: body,
                                                    onSendFeedback: () async {
                                                      ProviderListController
                                                          _providerListController =
                                                          Get.find();
                                                      // _providerListController
                                                      //         .getMainServices(
                                                      //             flag:
                                                      //                 false);

                                                      homeScreenController!
                                                          .getAvailableJobs(
                                                              feedbk: true,
                                                              flag: false);
                                                    });
                                                Get.back();
                                              },
                                            ),
                                            Container(
                                              alignment: Alignment.centerLeft,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 6),
                                              child: const Text(
                                                "Add Rating",
                                                style: TextStyle(
                                                    color: Color(0xff151415),
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                            ),
                                            Container(
                                              padding: const EdgeInsets.only(
                                                  bottom: 4),
                                              alignment: Alignment.centerLeft,
                                              child: RatingBar.builder(
                                                initialRating: initialRating,
                                                minRating: 1,
                                                direction: Axis.horizontal,
                                                allowHalfRating: false,
                                                unratedColor:
                                                    const Color(0xffE0E0E0),
                                                itemCount: 5,
                                                itemSize: 34.0,
                                                itemPadding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 0.0),
                                                itemBuilder: (context, _) {
                                                  if (_ < initialRating) {
                                                    return const Icon(
                                                      Icons.star,
                                                      color:
                                                          AppColors.solidBlue,
                                                    );
                                                  } else {
                                                    return const Icon(
                                                      Icons.star_border,
                                                    );
                                                  }
                                                },
                                                onRatingUpdate: (value) {
                                                  print(value.toString());
                                                  initialRating = value;
                                                },
                                                updateOnDrag: true,
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Flexible(
                                                  child: FarenowButton(
                                                      title: "Cancel",
                                                      style: FarenowButtonStyleModel(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      6)),
                                                      onPressed: () {
                                                        Get.back();
                                                      },
                                                      type: BUTTONTYPE.action),
                                                ),
                                                Flexible(
                                                  child: FarenowButton(
                                                      style: FarenowButtonStyleModel(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      6)),
                                                      title: "Submit",
                                                      onPressed: () {
                                                        RatingController
                                                            rating = Get.put(
                                                                RatingController());
                                                        if (_feedbackController
                                                            .text.isEmpty) {
                                                          alertDialog(
                                                            title: "Alert",
                                                            content:
                                                                "Please enter your feedback",
                                                            confirm:
                                                                MaterialButton(
                                                              onPressed: () {
                                                                Get.back();
                                                              },
                                                              child: const Text(
                                                                  "Okay"),
                                                            ),
                                                          );
                                                          return;
                                                        }

                                                        String feedBack =
                                                            _feedbackController
                                                                .text
                                                                .toString();
                                                        var userId =
                                                            data.provider.id;
                                                        var serviceId = data.id;

                                                        Map body =
                                                            <String, dynamic>{
                                                          "service_request_id":
                                                              serviceId,
                                                          "provider_id": userId,
                                                          "comment": feedBack,
                                                          "rating":
                                                              initialRating
                                                        };
                                                        print(body);
                                                        rating.sendFeedback(
                                                            body: body,
                                                            onSendFeedback:
                                                                () async {
                                                              ProviderListController
                                                                  _providerListController =
                                                                  Get.find();
                                                              // _providerListController
                                                              //         .getMainServices(
                                                              //             flag:
                                                              //                 false);

                                                              homeScreenController!
                                                                  .getAvailableJobs(
                                                                      feedbk:
                                                                          true,
                                                                      flag:
                                                                          false);
                                                            });
                                                        Get.back();
                                                      },
                                                      type: BUTTONTYPE
                                                          .rectangular),
                                                ),
                                              ],
                                            )
                                          ]),
                                    ),
                                  );
                                },
                              );
                            },
                            type: BUTTONTYPE.rectangular);
                      })
                    : AppButton(
                        width: double.infinity,
                        enabled: false,
                        disabledColor: const Color(0xffE0E0E0),
                        shapeBorder: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        child: Text(
                          data.isCompleted == 1
                              ? "Feedback submitted"
                              : "Give Feedback",
                          style: TextStyle(
                              color: const Color(0xff555555).withOpacity(0.5),
                              fontWeight: FontWeight.w500,
                              fontSize: 16),
                        ),
                      ),

              if (data.status.toString().toLowerCase() == "pending")
                FarenowButton(
                    title: "View Order",
                    style: FarenowButtonStyleModel(
                        padding: const EdgeInsets.only(top: 12)),
                    onPressed: () {
                      if (data.provider.id == null) {
                        Get.defaultDialog(
                            title: "Alert",
                            content: const Text("Service detail not available"),
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
                        if (isMoving(data)) {
                          Get.to(MovingDetailScreen(data: data));
                        } else {
                          Get.to(HomePassButtonScreen(datas: data));
                        }
                      }
                    },
                    type: BUTTONTYPE.rectangular)

              // InkWell(
              //   onTap: () {
              //     if (data.provider.id == null) {
              //       Get.defaultDialog(
              //           title: "Alert",
              //           content: Text("Service detail not available"),
              //           confirm: MaterialButton(
              //             onPressed: () {
              //               Get.back();
              //             },
              //             child: Text(
              //               "Okay",
              //               style: TextStyle(fontSize: 18),
              //             ),
              //           ));
              //     } else {
              //       if (isMoving(data)) {
              //         Get.to(MovingDetailScreen(data: data));
              //       } else {
              //         Get.to(HomePassButtonScreen(datas: data));
              //       }
              //     }
              //   },
              //   child: Container(
              //     alignment: Alignment.center,
              //     width: double.infinity,
              //     height: 47,
              //     decoration: BoxDecoration(
              //         color: Color(0xff1B80F5),
              //         borderRadius: BorderRadius.circular(10)),
              //     child: Text("View Details",
              //         style: TextStyle(
              //             color: Colors.white,
              //             fontSize: 18,
              //             fontWeight: FontWeight.normal)),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  bool isMoving(ServiceListData data) {
    if ((data.requestInfos ?? []).isNotEmpty) {
      return false;
    }
    if (data.type.toString().toLowerCase() == "moving_request") {
      return true;
    }
    if (data.movingQuotationInfo != null) {
      return true;
    }
    return false;
  }

  chatButtons(data, _screenController) {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: () {
              if (data.status.toLowerCase() == "accepted") {
                String senderId = data.userId.toString();
                String receiverId = data.providerId.toString();
                String name = getUserName(data.provider);
                Get.to(ChatScreen(
                  senderId: senderId,
                  receiverId: receiverId,
                  name: name,
                ));
                print("");
              }
            },
            child: Container(
              alignment: Alignment.center,
              width: double.infinity,
              height: 47,
              decoration: BoxDecoration(
                  color: const Color(0xff40C08C),
                  borderRadius: BorderRadius.circular(10)),
              child: Text(
                  data.status.toLowerCase() == "accepted"
                      ? " Message"
                      : data.status,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.normal)),
            ),
          ),
        ),
        if (data.status.toLowerCase() == "accepted" && data.address == null)
          const SizedBox(
            width: 12,
          ),
        if (data.status.toLowerCase() == "accepted" && data.address == null)
          Expanded(
            child: InkWell(
              onTap: () {
                String id = data.id.toString();
                _screenController.providerId(id);
                ProviderListData pData = ProviderListData(id: data.provider.id);
                _screenController.getServiceTimmings(pData,
                    fromHome: true, orderId: data.id);
              },
              child: Container(
                alignment: Alignment.center,
                width: double.infinity,
                height: 47,
                decoration: BoxDecoration(
                    color: const Color(0xff40C08C),
                    borderRadius: BorderRadius.circular(10)),
                child: Text(
                    data.status.toLowerCase() == "accepted"
                        ? "Book Service"
                        : data.status,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.normal)),
              ),
            ),
          ),
      ],
    );
  }

  pendingButton(title, HomeScreenController homeScreenController,
      ServiceListData data, ProfileScreenController profileScreenController) {
    final RegistrationController _registrationController = Get.find();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: data.provider.image != null
              ? cacheNetworkImage(
                  imageUrl: ApiUtills.imageBaseUrl + data.provider.image,
                  imageHeight: 40,
                  imageWidth: 40,
                  placeHolder: 'assets/user_assets/png/user.png',
                  radius: 100)
              : Image.asset(
                  'assets/user_assets/png/user.png',
                  fit: BoxFit.fill,
                  width: 40,
                  height: 40,
                ),
        ),
        Expanded(
          flex: 2,
          child: FarenowButton(
              style: FarenowButtonStyleModel(
                  height: 47,
                  padding: const EdgeInsets.symmetric(vertical: 12)),
              onPressed: () {
                profileScreenController.getProviderProfileDetail(
                    data.providerId,
                    fromProject: true);
              },
              title: "View Profile",
              type: BUTTONTYPE.action),
        ),
        if (data.status.toString().toLowerCase() == "accepted" ||
            data.status.toString().toLowerCase() == "rejected")
          Expanded(
              flex: 2,
              child: GestureDetector(
                onTap: () {
                  if (data.provider.id == null) {
                    Get.defaultDialog(
                        title: "Alert",
                        content: const Text("Service detail not available"),
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
                    if (isMoving(data)) {
                      Get.to(MovingDetailScreen(data: data));
                    } else {
                      Get.to(HomePassButtonScreen(datas: data));
                    }
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 2, vertical: 12),
                  decoration: BoxDecoration(
                      color: data.status.toString().toLowerCase() == "rejected"
                          ? AppColors.solidBlue
                          : white,
                      borderRadius: BorderRadius.circular(12),
                      border: data.status.toString().toLowerCase() == "rejected"
                          ? null
                          : Border.all(color: AppColors.solidBlue)),
                  child: FittedBox(
                    child: Text(
                      "View Order",
                      style: TextStyle(
                          color:
                              data.status.toString().toLowerCase() == "rejected"
                                  ? white
                                  : AppColors.solidBlue,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              )),
        if (data.status.toString().toLowerCase() == "pending")
          Expanded(
              flex: 2,
              child: GestureDetector(
                onTap: () {
                  homeScreenController.cancelRequest(data.id);
                },
                child: Container(
                  alignment: Alignment.center,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 2, vertical: 12),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.solidBlue)),
                  child: const FittedBox(
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                          color: AppColors.solidBlue,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              )),

        // Expanded(
        //   child: Container(
        //     alignment: Alignment.center,
        //     width: double.infinity,
        //     height: 47,
        //     decoration: BoxDecoration(
        //         color: Color(0xff40C08C),
        //         borderRadius: BorderRadius.circular(10)),
        //     child: Text(title ?? "PENDING",
        //         style: TextStyle(
        //             color: Colors.white,
        //             fontSize: 18,
        //             fontWeight: FontWeight.normal)),
        //   ),
        // ),
      ],
    );
  }

  Widget getTime({homeScreenController, data}) {
    var dta = getWorkedList(data);
    String time = getStartTime(dta);
    DateTime cTime = DateFormat("yyyy-MM-dd HH:mm:ss").parse(time, true);
    String convertTime =
        DateTimeUtils().parseDateTime(DateTime.now(), "yyyy-MM-dd HH:mm:ss");
    DateTime now = DateTimeUtils().convertStringSeconds(convertTime,
        format: "yyyy-MM-dd HH:mm:ss", isHour12: true);

    if (cTime.isUtc) {
      cTime = cTime.toLocal();
    }
/*

 */
    int diffSc =data.isPaused == 1
        ? getPauseTime(dta, now)
        : data.isCompleted == 1
        ? getWorkedTime(dta)
        : now.difference(cTime).inSeconds;

    int beakLaps = getBeakTime(dta);
    // if (_data.isCompleted == 0) {
    diffSc = diffSc - beakLaps;
    // }
    int sec = diffSc ~/ 60;
    int secResult = diffSc - (sec * 60);
    int hourResult = sec ~/ 60;
    int minResult = sec - (hourResult * 60);
    int days = hourResult ~/ 24;
    // if (days != 0) {
    //   int daysInHours = days * 24;
    //   hourResult = hourResult - daysInHours;
    // }

    return TimmerWidget(
        hours: hourResult,
        minutes: minResult,
        seconds: secResult,

        // days: days,
        pause: data.workingStatus.toString().toLowerCase() == "paused"
            ? true
            : false,
        timeChange: (value) {
          // timePause = value;
          print("tik tik $value");
        });
  }

  String getStartTime(List workedTimes) {
    workedTimes.sort((a, b) => a.startAt.compareTo(b.startAt));

    for (int index = 0; index < workedTimes.length; index++) {
      if (workedTimes[index].endAt == null) {
        var dateTime = DateFormat("yyyy-MM-ddTHH:mm:ss")
            .parse(workedTimes.first.createdAt, true);
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
            .parse(workedTimes.first.createdAt, true);
        String tme = dateTime.toString();
        if (tme.toString().toLowerCase().contains("t")) {
          tme = tme.replaceAll(
            "T",
            " ",
          );
        }
        return tme;
      }
    }
    return DateTime.now().toString();
  }

  getPauseTime(List workedTimes, endTime) {
    int count = 0;
    workedTimes.sort((a, b) => a.startAt.compareTo(b.startAt));
    DateTime startTime =
        DateTimeUtils().convertStringSeconds(workedTimes[0].startAt);

    if (workedTimes.length == 1) {
      endTime = DateTimeUtils().convertStringSeconds(workedTimes[0].endAt);
    } else {
      endTime = DateTimeUtils().convertStringSeconds(workedTimes.last.endAt);
    }

    int diffSc = endTime.difference(startTime).inSeconds;
    count = count + diffSc;

    return count;
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

  getWorkedList(data) {
    List list = data.workedTimes ?? [];
    return list;
  }

  movingPoints(ServiceListData data) {
    return Column(
      children: [
        addressRow("${data.movingQuotationInfo.fromAddress}"),
        const SizedBox(
          height: 8,
        ),
        addressRow("${data.movingQuotationInfo.toAddress}"),
        const SizedBox(
          height: 12,
        ),
      ],
    );
  }

  addressRow(String? address) {
    return Row(
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
          child: Text(
            address ?? "",
            style: const TextStyle(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.w200),
          ),
        ),
      ],
    );
  }

  List getListFromController(indexs, indexx, controller) {
    if (indexx == 0) {
      return controller.requested.value.reversed.toList();
    } else if (indexx == 1) {
      if (controller.accepted.value.isNotEmpty) {
        return controller.accepted.value.reversed.toList();
      }
      return controller.onGoing.value.reversed.toList();
    } else if (indexx == 2) {
      return controller.rejected.value.reversed.toList();
    } else if (indexx == 3) {
      return controller.charRequest.value.reversed.toList();
    }
    return [];
  }

  String checkDate(DateTime createdAt) {
    String value =
        DateFormat("yyyy-MM-ddTHH:mm:ss").format(createdAt).toString();
    return value;
  }
}
