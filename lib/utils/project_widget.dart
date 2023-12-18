import 'package:application_1/AllPages/ExplorePages/Controllers/profile_controller.dart';
import 'package:application_1/AllPages/ProjectPages/controller/home_screen_controller.dart';
import 'package:application_1/AllPages/ProjectPages/home_pass_button_screen.dart';
import 'package:application_1/AllPages/accepted_order_page.dart';
import 'package:application_1/AllPages/chat/chat_screen.dart';
import 'package:application_1/model/service_response/provider_model.dart';
import 'package:application_1/model/service_response/service_list_data.dart';
import 'package:application_1/utils/AppColors.dart';
import 'package:application_1/utils/date_time_utils.dart';
import 'package:application_1/widgets/data_not_available_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../remote_model/provider_list/provider_list_response_model.dart';

var pages = [];
List<bool> flags = [true, false, false, false];
List<bool> flagTabs = [true, false, false];

getPages(availableJos, HomeScreenController homeScreenController,
    ProfileScreenController _screenController,
    {tabUpDate, tabSelected}) {
  List<Widget> page = [];
  page.clear();

  if (availableJos.serviceListData == null) {
    pages = page;
  }

  var services = removeNullProviders(homeScreenController.availableJos.value);
  services = services.reversed.toList();

  // for (int index = 0; index < services.length; index++) {
  //   ServiceListData obk = services[index];
  //   if (obk.directContact == 1) {
  //     String address = obk.address ?? "";
  //     if (address.isNotEmpty) {
  //       obk.directContact = 0;
  //       services[index] = obk;
  //     }
  //   }
  //   print("");
  // }

  for (int index = 0; index < flags.length; index++) {
    String filter = index == 0
        ? "pending"
        : index == 1
            ? "accepted"
            : index == 2
                ? "rejected"
                : "1";
    bool flag = checkServer(services, filter);

    // List<Widget> list = getScreenWidgets(services, filter, _screenController);

    // flag = list.isEmpty ? false : true;

    flag
        ? page.add(
            Column(
              children: [
                if (filter == "accepted") acceptOnGoingTabs(tabUpDate),
                Expanded(
                  child: ListView(
                    children: [
                      for (int indexI = 0; indexI < services.length; indexI++)
                        if (services[indexI].provider.id != null)
                          if ((filter ==
                                  services[indexI].status.toLowerCase() ||
                              services[indexI].directContact == 1))
                            itemView(
                                services[indexI], indexI, _screenController,
                                filter: filter, tabSelected: tabSelected),
                    ],
                  ),
                ),
              ],
            ),
          )
        : page.add(DataNotAvailableWidget());
  }

  return page;
}

void resetTabsFlags() {
  for (int index = 0; index < flagTabs.length; index++) {
    flagTabs[index] = false;
  }
}

acceptOnGoingTabs(tabUpDate) {
  HomeScreenController _homeScreenControlle = Get.find();
  return Container(
    width: Get.width,
    padding: EdgeInsets.symmetric(vertical: 8),
    // height: 35,
    child: Row(
      children: [
        12.width,
        AppButton(
          onTap: () {
            resetTabsFlags();
            flagTabs[0] = true;
            tabUpDate('accepted');
            // _homeScreenControlle.getAvailableJobs(flag: true);
          },
          shapeBorder:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          color: flagTabs[0]
              ? AppColors.solidBlue
              : Color(0xffE0E0E0).withOpacity(0.9),
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            "Accept",
            style: TextStyle(color: flagTabs[0] ? white : black),
          ),
        ),
        12.width,
        AppButton(
          onTap: () {
            resetTabsFlags();
            flagTabs[1] = true;
            tabUpDate('on_going');
            // _homeScreenControlle.getAvailableJobs(flag: true);
          },
          shapeBorder:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          color: flagTabs[1] ? AppColors.solidBlue : Color(0xffE0E0E0),
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            "Ongoing",
            style: TextStyle(color: flagTabs[1] ? white : black),
          ),
        ),
        12.width,
        AppButton(
          onTap: () {
            resetTabsFlags();
            flagTabs[2] = true;
            tabUpDate('completed');
            // _homeScreenControlle.getAvailableJobs(flag: true);
          },
          shapeBorder:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          color: flagTabs[2] ? AppColors.solidBlue : Color(0xffE0E0E0),
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            "Completed",
            style: TextStyle(color: flagTabs[2] ? white : black),
          ),
        ),
      ],
    ),
  );
}

bool checkServer(List<ServiceListData> services, String filter) {
  for (int index = 0; index < services.length; index++) {
    ServiceListData value = services[index];
    if (value.directContact == 0) {
      if (value.status.toLowerCase() == filter) {
        return true;
      }
    } else if (value.directContact == 1 && filter == "1") {
      return true;
    }
  }
  return false;
}

Widget itemView(
    ServiceListData data, index, ProfileScreenController _screenController,
    {filter, tabSelected}) {
  String filterCheck = filter ?? "pending";
  if (filterCheck.toLowerCase() == "REJECTED".toLowerCase()) {
    print(filterCheck);
  }
  print(data.status);
  return filterCheck == "1" && data.status.toLowerCase() != "rejected"
      ? Container(
          child: itemViewCard(data, _screenController, filter),
        )
      : data.status.toString().toLowerCase() != filterCheck ||
              data.address == null
          ? Container()
          : filterCheck == "accepted"
              ? AcceptedOrderPage(data: data, tabSelected: tabSelected)
              : getUserName(data.provider) == "N/A"
                  ? Container()
                  : itemViewCard(data, _screenController, filter);
}

sortWidgets() {
  return Container(
    height: 48,
    child: ListView(
      scrollDirection: Axis.horizontal,
      children: [
        InkWell(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
              width: 142,
              padding: EdgeInsets.all(10),
              alignment: Alignment.center,
              height: 38,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(30)),
              child: Text(
                "Sort: Most Relevent",
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Container(
            width: 142,
            padding: EdgeInsets.all(10),
            alignment: Alignment.center,
            height: 38,
            decoration: BoxDecoration(
                color: Colors.blue, borderRadius: BorderRadius.circular(30)),
            child: Text(
              "Category 150 Miles",
              style: TextStyle(fontSize: 14, color: Colors.white),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Container(
            width: 120,
            padding: EdgeInsets.all(10),
            alignment: Alignment.center,
            height: 38,
            decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(30)),
            child: Text(
              "Category",
              style: TextStyle(fontSize: 14, color: Colors.white),
            ),
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
  return "${user.firstName} ${user.lastName ?? ""}";
}

itemViewCard(ServiceListData data, ProfileScreenController _screenController,
    filterCheck) {
  return Container(
    padding: EdgeInsets.all(8),
    child: Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    getUserName(data.provider),
                    style: TextStyle(
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
                    DateTimeUtils().convertString(data.createdAt),
                  ),
                  //15 hours ago - pro responded
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w100)),
            ),
            Divider(
              thickness: 1,
              color: Colors.black12,
            ),
            if (data.address != null)
              Column(
                children: [
                  Container(
                    child: Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.all(
                              Radius.circular(18),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Expanded(
                          child: Text(
                            data.address ?? "",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w200),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Container(
                    child: Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.all(
                              Radius.circular(18),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Expanded(
                            child: Container(
                          width: 250,
                          child: Text(
                              "Available on ${DateTimeUtils().parseDateTime(DateTimeUtils().convertString(data.createdAt), "dd MMM yyyy")}",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w200)),
                        ))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: 47,
                      decoration: BoxDecoration(
                          color: Color(0xff40C08C),
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                          data.status.toLowerCase() == "accepted"
                              ? "Send Message"
                              : data.status,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.normal)),
                    ),
                  ),
                ],
              ),
            if (data.address == null)
              if (filterCheck == "1")
                Row(
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
                              color: Color(0xff40C08C),
                              borderRadius: BorderRadius.circular(10)),
                          child: Text(
                              data.status.toLowerCase() == "accepted"
                                  ? " Message"
                                  : data.status,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal)),
                        ),
                      ),
                    ),
                    if (data.status.toLowerCase() == "accepted" &&
                        data.address == null)
                      SizedBox(
                        width: 12,
                      ),
                    if (data.status.toLowerCase() == "accepted" &&
                        data.address == null)
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            String id = data.id.toString();
                            _screenController.providerId(id);
                            ProviderListData pData =
                                ProviderListData(id: data.provider.id);
                            // _screenController.getServiceTimmings(pData,
                            //     fromHome: true, orderId: data.id);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: double.infinity,
                            height: 47,
                            decoration: BoxDecoration(
                                color: Color(0xff40C08C),
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(
                                data.status.toLowerCase() == "accepted"
                                    ? "Book Service"
                                    : data.status,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal)),
                          ),
                        ),
                      ),
                  ],
                ),
            SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                if (data.provider.id == null) {
                  Get.defaultDialog(
                      title: "Alert",
                      content: Text("Service detail not available"),
                      confirm: MaterialButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: Text(
                          "Okay",
                          style: TextStyle(fontSize: 18),
                        ),
                      ));
                } else {
                  Get.to(HomePassButtonScreen(datas: data));
                }
              },
              child: Container(
                alignment: Alignment.center,
                width: double.infinity,
                height: 47,
                decoration: BoxDecoration(
                    color: Color(0xff1B80F5),
                    borderRadius: BorderRadius.circular(10)),
                child: Text("View Details",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.normal)),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

List<Widget> getScreenWidgets(
    services, filter, ProfileScreenController _screenController) {
  List<Widget> list = [];

  for (int indexI = 0; indexI < services.length; indexI++) {
    if (services[indexI].provider.id != null) {
      if ((filter == services[indexI].status.toLowerCase() ||
          services[indexI].directContact == 1)) {
        list.add(itemView(services[indexI], indexI, _screenController,
            filter: filter));
      }
    }
  }

  return list;
}

removeNullProviders(availableJos) {
  List<ServiceListData> list = [];
  for (int index = 0;
      index < (availableJos.serviceListData ?? []).length;
      index++) {
    print("index:$index ${availableJos.serviceListData[index].userId}");
    if (availableJos.serviceListData[index].provider.id != null) {
      list.add(availableJos.serviceListData[index]);
    }
  }
  availableJos.serviceListData = list;
  return availableJos.serviceListData;
}
