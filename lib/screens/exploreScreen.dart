import 'dart:async';
import 'dart:convert';

import 'package:application_1/AllPages/ExplorePages/Controllers/providerListController.dart';
import 'package:application_1/AllPages/ExplorePages/see_all_screen.dart';
import 'package:application_1/AllPages/ExplorePages/sub_service_item.dart';
import 'package:application_1/AllPages/ProfilePages/plumberprofileView.dart';
import 'package:application_1/AllPages/ProjectPages/controller/home_screen_controller.dart';
import 'package:application_1/AllPages/ProjectPages/home_pass_button_screen.dart';
import 'package:application_1/AllPages/chat/chat_screen.dart';
import 'package:application_1/AllPages/chat/chatt_controller.dart';
import 'package:application_1/AllPages/chat/message_controller.dart';
import 'package:application_1/AllPages/feed_back_page.dart';
import 'package:application_1/AllPages/grocery/controllers/grocery_controller.dart';
import 'package:application_1/AllPages/introPages/intro_controller.dart';
import 'package:application_1/AllPages/moving/controllers/dashboard_controller.dart';
import 'package:application_1/AllPages/payable_widget.dart';
import 'package:application_1/All_Refrences/shared_refrence.dart';
import 'package:application_1/main.dart';
import 'package:application_1/model/active_orders_resp/active_orders_data.dart';
import 'package:application_1/model/chat/user_chat_response.dart';
import 'package:application_1/model/notification/notification_response.dart';
import 'package:application_1/model/service_response/service_list_data.dart';
import 'package:application_1/model/service_response/service_response.dart';
import 'package:application_1/remote_model/main_services/main_services_data.dart';
import 'package:application_1/resources/repositories/service_repository.dart';
import 'package:application_1/restaurant_controller/cart_controller.dart';
import 'package:application_1/restaurant_controller/restaurant_controller.dart';
import 'package:application_1/reuseableWidgets/reuseableSizedbox.dart';
import 'package:application_1/screens/Controllers/tabScreenController.dart';
import 'package:application_1/service/notification_service.dart';
import 'package:application_1/utils/AppColors.dart';
import 'package:application_1/utils/api_utils.dart';
import 'package:application_1/widgets/button_with_icon.dart';
import 'package:application_1/widgets/filter_item.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../service/awsom_notification_service.dart';
import '../service/push_notification_service.dart';

TextEditingController queryController = TextEditingController();
var queryFocus = FocusNode();

class ExploreScreen extends StatefulWidget {
  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  Color white = AppColors.white;

  Color blue = AppColors.blue;

  TabScreenController _tabScreenController = Get.put(TabScreenController());
  static const platform = const MethodChannel('flutter.native/helper');
  static const platformIOS =
      const MethodChannel('test.flutter.methodchannel/iOS');
  ProviderListController _providerListController = Get.find();

  MessageController _messageController = Get.find();
  HomeScreenController _homeScreenControlle =
      Get.put(HomeScreenController(flag: true));

  RestaurantController _restaurantModel = Get.put(RestaurantController());
  CartController _cartController = Get.put(CartController());
  GroceryController _groceryController = Get.put(GroceryController());

  IntroController _introController = Get.find();
  DashboardController _dashboardController = Get.put(DashboardController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (_providerListController.mainServices.length > 0) {
      selected = _providerListController.mainServices.value[0].name;
    }

    // _cartController.getCart(flag: false);
    // _restaurantModel.getAllRestaurant();
    _messageController.getUserList(flag: true);
    _homeScreenControlle.getAvailableJobs(flag: true);
    _providerListController.getMainServices(
        flag: getBoolValue(_providerListController));

    messaging.getToken().then((token) async {
      print("fcm token $token");
      int platform = GetPlatform.isIOS ? 2 : 1;

      String authToken =
          await SharedRefrence().getString(key: ApiUtills.authToken);
      await ServiceReposiotry().uploadToken(token!, authToken, platform);
    });
    if (GetPlatform.isAndroid) {
      // platfromSpecific();
    }
    if (GetPlatform.isAndroid) {
      // PushNotificationService(context).initialise();
      // AwsomNotificationService.initializeAwesomeNotification();

      // AwsomNotificationService().listAction();

      // platform.setMethodCallHandler(nativeMethodCallHandler);
    }
    if (GetPlatform.isIOS) {
      // PushNotificationService(context).initialise();
      // iosMethodChannel();
    }
  }

  // Future<void> iosMethodChannel() async {
  //   String _model;
  //   try {
  //     // 1
  //     final String result = await platformIOS.invokeMethod('getDeviceModel');

  //     // 2
  //     _model = result;
  //   } catch (e) {
  //     // 3
  //     _model = "Can't fetch the method: '$e'.";
  //   }
  //   if (_model.contains("0_0")) {
  //     var list = _model.split("0_0");
  //     String title = list[0];
  //     String body = list[1];
  //     String providerId = list[2];
  //     String type = list[3];
  //     String serviceRequestId = list[4];
  //     String payable = list[5];
  //     String requestedHours = list[6];
  //     String paidAmount = list[7];
  //     String workedHours = list[8];

  //     NotificationResponseData model = NotificationResponseData();
  //     model.title = title;
  //     model.body = body;
  //     model.type = type;
  //     model.providerId = providerId;
  //     model.serviceRequestId = serviceRequestId;
  //     model.payable = payable;
  //     model.hours = requestedHours;
  //     model.workedHours = workedHours;
  //     model.paidAmount = paidAmount;

  //     controlData(model);
  //   }

  //   print("model $_model");
  //   // Get.defaultDialog(title: "alert", content: Text(_model));
  // }

  // Future<void> platfromSpecific() async {
  //   String response = "";
  //   try {
  //     final String? result = await platform.invokeMethod('helloFromNativeCode');
  //     response = result ?? "";
  //     print(response);
  //   } on PlatformException catch (e) {
  //     response = "Failed to Invoke: '${e.message}'.";
  //   }
  // }

  // Future<dynamic> nativeMethodCallHandler(MethodCall methodCall) async {
  //   print('Native call!');
  //   switch (methodCall.method) {
  //     case "open_notification":
  //       {
  //         if (chatOpen) {
  //           return;
  //         }
  //         String body = methodCall.arguments.toString();
  //         print("pay load " + body);
  //         NotificationResponseData model =
  //             NotificationResponseData.fromJson(json.decode(body));
  //         print("parsed");
  //         MessageController controller = Get.put(MessageController());

  //         await controller.getUserList();

  //         HomeScreenController _homeScreenControlle = Get.find();
  //         WidgetsFlutterBinding.ensureInitialized();
  //         _homeScreenControlle.getAvailableJobs(flag: true);
  //         // if (userOpen != model.senderId) {
  //         if (model.show) {
  //           if (model.title == "End working on your Service Request") {
  //             // if (model.payable != null) {
  //             //   Get.dialog(PayableWidget());
  //             // } else {
  //             Future.delayed(const Duration(seconds: 1)).then((value) async {
  //               String response =
  //                   await SharedRefrence().getString(key: "orders");
  //               if (response.isNotEmpty) {
  //                 ServiceResponse parseData =
  //                     ServiceResponse.fromJson(json.decode(response));

  //                 var data;
  //                 if (model.payable != null) {
  //                   data = await _homeScreenControlle
  //                       .getService(model.serviceRequestId);
  //                 } else {
  //                   for (int index = 0;
  //                       index < parseData.serviceData.serviceListData.length;
  //                       index++) {
  //                     ServiceListData value =
  //                         parseData.serviceData.serviceListData[index];
  //                     if (model.serviceRequestId == value.id.toString()) {
  //                       data = value;
  //                       break;
  //                     }
  //                   }
  //                 }

  //                 if (data == null) {
  //                   showNotification(model);
  //                 } else if (data.toString() != "true") {
  //                   if (data != null) {
  //                     if (model.payable != null) {
  //                       var payableData = json.decode(model.payable);
  //                       bool hasPayable = checkPayable(data);
  //                       Get.dialog(PayableWidget(
  //                         data: data,
  //                         payableId: payableData['id'],
  //                         model: model,
  //                       ));
  //                     } else {
  //                       Get.dialog(FeedBackPage(
  //                         data: data,
  //                         onRateComplete: () {
  //                           _homeScreenControlle.getAvailableJobs(flag: true);
  //                         },
  //                       ));
  //                     }
  //                   }
  //                 }
  //               }
  //             });
  //             // }
  //           } else {
  //             showNotification(model);
  //           }
  //         } else {
  //           controlData(json.decode(body));
  //         }
  //         // }
  //         // }
  //         break;
  //       }
  //     case "helloFromNativeCode":
  //       {
  //         print("sdfsfs");
  //       }
  //       break;
  //   }
  // }

  List filterListData = [];

  String selected = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0,
        title: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 2.2,
          child: SizedBox(
            width: Get.width,
            height: 47,
            child: Material(
              child: TextFormField(
                keyboardType: TextInputType.text,
                controller: queryController,
                focusNode: queryFocus,
                onChanged: (value) {
                  filterList(value);
                },
                decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    filled: false,
                    hintText: "Search service",
                    hintStyle: const TextStyle(height: 3),
                    fillColor: Colors.white10,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none)),
              ),
            ),
          ),
        ),
      ),
      body: Obx(() {
        filterListData = _providerListController.filterList.value;

        return SingleChildScrollView(
          child: IntrinsicWidth(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (filterListData.isEmpty && queryController.text.isEmpty)
                  BuildSizedBox(5),
                filterListData.isEmpty && queryController.text.isNotEmpty
                    ? recordNotEmpty()
                    : filterListData.isNotEmpty ||
                            queryController.text.isNotEmpty
                        ? SizedBox(
                            width: Get.width,
                            height: Get.height,
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 12),
                                  height: 40,
                                  width: Get.width,
                                  child: Text(
                                    "Filter List",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: AppColors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: Get.width,
                                  height: Get.height - Get.width * 0.7,
                                  child: FilterItem(
                                      filterList: filterListData,
                                      introController: _introController,
                                      dashboardController: _dashboardController,
                                      controller: _homeScreenControlle,
                                      mainServices:
                                          _providerListController.mainServices,
                                      providerListController:
                                          _providerListController),
                                ),
                              ],
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 0),
                            child: _providerListController
                                    .mainServices.isNotEmpty
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Wrap(
                                        alignment: WrapAlignment.start,
                                        // runAlignment: WrapAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            WrapCrossAlignment.center,
                                        children: List.generate(
                                            _providerListController
                                                .mainServices.length, (index) {
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 4, vertical: 3),
                                            child: AppButton(
                                              onTap: () {
                                                setState(() {
                                                  selected =
                                                      _providerListController
                                                          .mainServices
                                                          .value[index]
                                                          .name;
                                                });
                                              },
                                              padding: EdgeInsets.zero,
                                              width: Get.width * 0.435,
                                              shapeBorder:
                                                  RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30)),
                                              color: isSeletect(
                                                      _providerListController
                                                          .mainServices
                                                          .value[index]
                                                          .name)
                                                  ? AppColors.solidBlue
                                                  : const Color(0xffE0E0E0),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 12),
                                                child: FittedBox(
                                                  child: Text(
                                                    _providerListController
                                                        .mainServices
                                                        .value[index]
                                                        .name,
                                                    style: TextStyle(
                                                        color: isSeletect(
                                                                _providerListController
                                                                    .mainServices
                                                                    .value[
                                                                        index]
                                                                    .name)
                                                            ? white
                                                            : black,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        }),
                                      ),
                                      12.height,
                                      if (selected.isNotEmpty)
                                        getSelectedSubServiceDetails(selected),
                                      18.height,
                                    ],
                                  )
                                : Center(
                                    child: Text("Center"),
                                  ),
                          )
              ],
            ),
          ),
        );
      }),
    );
  }

  getBelowContainer(double w, h, BuildContext context, String serviceHeader,
      image, serviceName,
      {subService}) {
    // String resp = subService ?? "";
    return isEmpty(subService)
        ? Container()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 15, right: 15),
                    child: Text(
                      serviceHeader,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w400),
                    ),
                  ),
                  const Spacer(),
                  ButtonWithIcon(
                    onTap: () {
                      Get.to(() => SeeAllScreen(
                            serviceHeader: serviceHeader,
                            allServices: subService,
                          ));
                    },
                  ),
                  const SizedBox(
                    width: 15,
                  )
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Container(
                width: Get.width,
                height: 180,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    for (int index = 0;
                        index < subService.subServices.length;
                        index++)
                      Container(
                        width: w * 200 / 360,
                        margin: EdgeInsets.only(
                            left: index == 0 ? 15 : 0, right: 15),
                        child: SubServiceItem(
                          index: index,
                          imagewidth: w * 200 / 360,
                          subService: subService.subServices[index],
                          serviceHeader: serviceHeader,
                          allServices: subService,
                        ),
                      )
                  ],
                ),
              )
            ],
          );
  }

  getContainer(double w, h, String image, serviceTime, deliveryName,
      List<Color> backgroundColor, onTap) {
    Color white = AppColors.white;
    Color blue = AppColors.blue;
    return Padding(
      padding: const EdgeInsets.only(right: 15, top: 10),
      child: Container(
        width: w * 0.445,
        height: h * 170 / 800,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            gradient: LinearGradient(
                begin: FractionalOffset.center,
                end: FractionalOffset.bottomCenter,
                colors: backgroundColor)),
        child: Stack(
          children: [
            Opacity(
              opacity: 0.2,
              child: ClipPath(
                clipper: CustomClipPath(),
                child: Container(
                  height: w * 0.5,
                  color: Colors.white60,
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(2),
                child: Container(
                  // width: w * 0.213,
                  // height: w * 0.249,
                  width: w * 76 / 360,
                  height: h * 90 / 800,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover, image: AssetImage(image))),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    serviceTime,
                    style: TextStyle(
                        color: white,
                        fontSize: 22,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    deliveryName,
                    style: TextStyle(
                        color: white,
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  ),
                  MaterialButton(
                      textColor: blue,
                      color: white,
                      height: 23,
                      splashColor: blue,
                      shape: const StadiumBorder(),
                      child: Container(
                        width: 80,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Expanded(
                                flex: 6,
                                child: Text(
                                  'Coming Soon',
                                  style: TextStyle(fontSize: 12),
                                )),
                            // Expanded(
                            //   flex: 1,
                            //   child: Icon(
                            //     Icons.arrow_forward_outlined,
                            //     color: blue,
                            //     size: 12,
                            //   ),
                            // )
                          ],
                        ),
                      ),
                      // onPressed: onTap
                      onPressed: () {})
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  getSubservices(MainServicesData value) {
    var response = value.toJson();
    return json.encode(response);
  }

  checkEven(int inde) {
    int index = (inde / 2).toInt();
    // (inde/2).toInt()
    return index.isEven;
  }

  getBoolValue(ProviderListController providerListController) {
    if (_providerListController.mainServices == null) {
      return false;
    }
    return _providerListController.mainServices.isNotEmpty;
  }

  bool checkPayable(ServiceListData data) {
    int hours = int.parse(data.hours.toString());
    int workedHours = int.parse(data.workedHours.toString());
    int result = hours - workedHours;
    bool has = result < 0 ? true : false;
    return has;
  }

  isEmpty(subService) {
    return subService.subServices.isEmpty;
  }

  // void controlData(data) {
  //   MessageController controller = Get.find();
  //   NotificationResponseData modelParsed =
  //       NotificationResponseData.fromJson(data);
  //   if (modelParsed.title == "Request ACCEPTED") {
  //     _tabScreenController.setTabIndex(1);
  //     return;
  //   }
  //   var id = modelParsed.serviceRequestId;
  //   var lists = _homeScreenControlle.availableJos.value.serviceListData;
  //   for (int index = 0; index < lists.length; index++) {
  //     ServiceListData value = lists[index];
  //     if (value.id.toString() == id) {
  //       if (modelParsed.title.contains("Start working")) {
  //         Get.to(() => HomePassButtonScreen(
  //               datas: value,
  //             ));
  //       } else if (modelParsed.title.contains("End working")) {
  //         Get.to(PlumberProfileView(
  //           data: value,
  //           hasPayable: false,
  //         ));
  //       } else if (modelParsed.title.contains("New message received")) {
  //         for (int indexJ = 0;
  //             indexJ < controller.messageList.length;
  //             indexJ++) {
  //           print("index");
  //           if (controller.messageList.value[indexJ].id.toString() ==
  //               modelParsed.serviceRequestId) {
  //             ChatController _chatController = Get.put(ChatController());
  //             _chatController.chatData(UserChatResponse());
  //             ActiveOrdersData data = controller.messageList.value[indexJ];
  //             Get.to(() => ChatScreen(
  //                   senderId: data.message.receiverId,
  //                   receiverId: data.message.senderId,
  //                   orderId: value.id.toString(),
  //                   name: getProviderName(value.provider),
  //                   onUpdate: () async {
  //                     await _messageController.getUserList();
  //                     setState(() {});
  //                   },
  //                 ));
  //           }
  //         }
  //       }

  //       break;
  //     }
  //   }
  //   print("");
  // }

  void showNotification(model) async {
    // await NotificationService().init(
    //     message: model.body,
    //     path: model,
    //     flag: false,
    //     onClick: (value) {
    //       var data = json.decode(value);
    //       controlData(data);

    //       setState(() {});
    //     });
  }

  getProviderName(var provider) {
    return "${provider.firstName.toString().capitalizeFirst} ${provider.lastName.toString().capitalizeFirst}";
  }

  void filterList(String value) {
    _providerListController.filterList.clear();
    if (value.isEmpty) {
      _providerListController.filterList.clear();
    } else {
      List filter = [];
      for (int index = 0;
          index < _providerListController.allServices.length;
          index++) {
        if (_providerListController.allServices.value[index].name
            .toLowerCase()
            .contains(value.toLowerCase())) {
          filter.add(_providerListController.allServices.value[index]);
        }
      }
      _providerListController.filterList.addAll(filter);
      _providerListController.filterList.refresh();
    }
  }

  recordNotEmpty() {
    return Container(
      width: Get.width,
      height: Get.height,
      child: Column(
        children: [
          SizedBox(
            height: Get.height * 0.4,
          ),
          const Text(
            "Search not found",
            style: TextStyle(fontSize: 22),
          )
        ],
      ),
    );
  }

  isSeletect(String value) {
    if (selected == value) {
      return true;
    } else {
      return false;
    }
  }

  getSelectedSubServiceDetails(String selected) {
    // _providerListController.mainServices;
    if (_providerListController.mainServices.isNotEmpty) {
      for (var i = 0; i < _providerListController.mainServices.length; i++) {
        if (_providerListController.mainServices.value[i].name == selected) {
          return Container(
            alignment: Alignment.center,
            width: Get.width,
            child: Wrap(
                spacing: 22,
                runSpacing: 16,
                alignment: WrapAlignment.start,
                crossAxisAlignment: WrapCrossAlignment.start,
                runAlignment: WrapAlignment.start,
                children: List.generate(
                    _providerListController
                        .mainServices.value[i].subServices.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      child: Container(
                        // width: Get.width * 0.4,
                        width: MediaQuery.of(context).size.shortestSide / 2.5,
                        height: Get.width * 0.55,
                        child: SubServiceItem(
                          index: index,
                          imagewidth: Get.width * 0.4,
                          subService: _providerListController
                              .mainServices.value[i].subServices[index],
                          allServices: _providerListController
                              .mainServices.value[i].subServices[index],
                        ),
                      ),
                    ),
                  );
                })),
          );
        }
      }
    }
  }
}

class CustomClipPath extends CustomClipper<Path> {
  var radius = 10.0;

  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 120);
    print(size.height);
    print(size.width);
    path.quadraticBezierTo(size.width - 50, 30, size.height + 20, 162);
    // path.quadraticBezierTo(
    //     // size.width / 4, size.height / 3, size.width, size.height - 100);

    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class CustomClipPath2 extends CustomClipper<Path> {
  var radius = 10.0;

  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(size.width / 2, 0);
    print(size.height);
    print(size.width);
    path.quadraticBezierTo(0, 10, size.width, 132);
    // path.quadraticBezierTo(
    //     // size.width / 4, size.height / 3, size.width, size.height - 100);

    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
