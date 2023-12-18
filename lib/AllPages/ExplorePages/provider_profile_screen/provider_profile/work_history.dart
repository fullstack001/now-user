import 'package:application_1/AllPages/ExplorePages/provider_profile_screen/provider_profile_controller/work_history_controller.dart';
import 'package:application_1/AllPages/ExplorePages/shopMenu.dart';
import 'package:application_1/remote_model/provider_list/complete_and_ongoing_model.dart';
import 'package:application_1/utils/AppColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import 'export_file.dart';

class WorkHistory extends StatefulWidget {
  late int id;
  WorkHistory({required this.id});
  @override
  State<WorkHistory> createState() => _WorkHistoryState();
}

class _WorkHistoryState extends State<WorkHistory>
    with SingleTickerProviderStateMixin {
  late TabController _tabBarController;
  late WorkHistoryController _workHistoryController = Get.find();
  @override
  void initState() {
    _tabBarController = TabController(length: 2, vsync: this);
    super.initState();
    _workHistoryController.getCompleteServices(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WorkHistoryController>(
        init: WorkHistoryController(),
        builder: (controller) {
          return GetMainCardColum(widget: [
            const Text(
              "Work History",
              style: TextStyle(
                  color: Color(0xff151415),
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
            DefaultTabController(
                animationDuration: const Duration(milliseconds: 1000),
                length: 2,
                child: DecoratedTabBar(
                  tabBar: TabBar(
                    onTap: (index) {
                      controller.resetIndex();
                    },
                    controller: _tabBarController,
                    automaticIndicatorColorAdjustment: true,
                    indicatorColor: AppColors.darkBlue,
                    unselectedLabelColor: Colors.black,
                    unselectedLabelStyle: const TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 18),
                    labelStyle: const TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 18),
                    labelColor: AppColors.darkBlue,
                    tabs: [
                      Tab(
                        text:
                            "Completed (${controller.completeService.length})",
                      ),
                      Tab(
                        text: "Ongoing (${controller.ongoingService.length})",
                      ),
                    ],
                  ),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.black54,
                        width: 1.0,
                      ),
                    ),
                  ),
                )),
            const SizedBox(
              height: 10,
            ),
            Container(
                width: double.infinity,
                height: 210,
                child: controller.isLoading
                    ? TabBarView(controller: _tabBarController, children: [
                        controller.completeService.isNotEmpty
                            ? firstContainer(
                                controller.completeService, controller)
                            : const Center(
                                child: Text("Not Found"),
                              ),
                        controller.ongoingService.isNotEmpty
                            ? firstContainer(
                                controller.ongoingService, controller)
                            : const Center(
                                child: Text("Not Found"),
                              )
                      ])
                    : const Center(
                        child: CupertinoActivityIndicator(
                          radius: 33,
                        ),
                      ))
          ]);
        });
  }

  Container secondTabContainer(
      List<Datum> list, WorkHistoryController controller) {
    print(list);
    return Container(
      child: SingleChildScrollView(
        controller: controller.scrollController,
        scrollDirection: Axis.horizontal,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(list.length, (index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${list[index].subService}",
                      style: TextStyle(
                          color: AppColors.darkBlue,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "${list[index].address}",
                      style: TextStyle(
                          color: AppColors.darkBlue,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      // "${checkDate(list[index].createdAt)}",
                      "${checkDate(list[index].createdAt)} - ${checkDate(list[index].updatedAt)}",
                      style: const TextStyle(
                          color: Color(0xff555555),
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Text(
                      list[index].isCompleted == 1 ? "Completed" : "Ongoing",
                      style: TextStyle(
                          color: green,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      width: Get.width * .75,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            list[index].paidAmount == null
                                ? "0"
                                : "\$${list[index].paidAmount}",
                            style: const TextStyle(
                                color: Color(0xff555555),
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            list[index]
                                        .providerProfile
                                        .providerProfile
                                        .hourlyRate ==
                                    null
                                ? "0"
                                : "\$${list[index].providerProfile.providerProfile.hourlyRate}",
                            style: const TextStyle(
                                color: Color(0xff555555),
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            "${list[index].workedHours}",
                            style: const TextStyle(
                                color: Color(0xff555555),
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            })),
      ),
    );
  }

  firstContainer(List<Datum> data, WorkHistoryController controller) {
    return Column(children: [
      secondTabContainer(data, controller),
      Column(
        children: [
          const SizedBox(
            height: 5,
          ),
          const Divider(
            color: Colors.black54,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  print(controller.cardIndex);
                  if (controller.cardIndex > 0) {
                    controller.decreamentIndexofCard();
                  }
                  controller.animateToIndex(controller.cardIndex);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  // width: 100,
                  height: 40,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(
                          Icons.arrow_back_ios,
                          size: 16,
                          color: Colors.black45,
                        ),
                        const Text("Previous")
                      ]),
                ),
              ),
              GetBuilder<WorkHistoryController>(
                  init: WorkHistoryController(),
                  builder: ((control) {
                    return Text("${control.cardIndex + 1} of ${data.length}");
                  })),
              GestureDetector(
                onTap: () {
                  print(controller.cardIndex);
                  if (controller.cardIndex < data.length - 1) {
                    controller.increamentIndexofCard();
                  }
                  controller.animateToIndex(controller.cardIndex);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  height: 40,
                  decoration: BoxDecoration(
                      color: AppColors.darkBlue,
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Next",
                          style: TextStyle(color: white),
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                        const Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                          color: Colors.white,
                        ),
                      ]),
                ),
              ),
            ],
          )
        ],
      )
    ]);
  }

  String checkDate(DateTime createdAt) {
    String value = DateFormat("dd MMM, yyyy").format(createdAt).toString();
    return value;
  }
}

class DecoratedTabBar extends StatelessWidget implements PreferredSizeWidget {
  DecoratedTabBar({required this.tabBar, required this.decoration});

  final TabBar tabBar;
  final BoxDecoration decoration;

  @override
  Size get preferredSize => tabBar.preferredSize;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(child: Container(decoration: decoration)),
        tabBar,
      ],
    );
  }
}
