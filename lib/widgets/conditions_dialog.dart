import 'package:application_1/AllPages/ProjectPages/controller/home_screen_controller.dart';
import 'package:application_1/remote_model/country/cities.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'custom_container.dart';

class ConditionsDialog extends StatefulWidget {
  var citiesList;

  ConditionsDialog({Key? key, this.citiesList}) : super(key: key);

  @override
  State<ConditionsDialog> createState() => _ConditionsDialogState();
}

class _ConditionsDialogState extends State<ConditionsDialog> {
  HomeScreenController _controller = Get.find();

  var _editingController = TextEditingController();
  List filterList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        width: Get.width,
        height: Get.height,
        child: Obx(() {
          int size = _controller.zipFilters.length;
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: Get.width * 0.85,
                height: 340,
                color: Colors.white,
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.centerRight,
                      children: [
                        Container(
                          width: Get.width * 0.85,
                          height: 50,
                          alignment: Alignment.center,
                          child: Text(
                            "State List",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              Get.back();
                            },
                            icon: Icon(
                              Icons.cancel,
                              size: 28,
                              color: Colors.red,
                            ))
                      ],
                    ),
                    CustomContainer(
                      width: Get.width,
                      paddingRight: 24,
                      paddingLeft: 24,
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        controller: _editingController,
                        style: TextStyle(color: Colors.black),
                        onChanged: (value) {
                          filterList.clear();
                          List list = [];
                          if (value.isEmpty) {
                            setState(() {});
                          } else {
                            for (int index = 0;
                                index < widget.citiesList.length;
                                index++) {
                              if (widget.citiesList[index].name
                                  .toString()
                                  .toLowerCase()
                                  .contains(value)) {
                                list.add(widget.citiesList[index]);
                              }
                            }
                            filterList.addAll(list);
                            setState(() {});
                          }
                          // 2.delay().then((val) {
                          //   if (value.isEmpty) {
                          //     filterList.clear();
                          //     setState(() {});
                          //   }
                          // });
                        },
                        decoration: InputDecoration(
                            helperStyle: TextStyle(color: Colors.black),
                            counterStyle: TextStyle(color: Colors.black),
                            labelStyle: TextStyle(color: Colors.black),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            prefixIcon: SizedBox(
                              width: 50,
                              child: Icon(
                                Icons.search,
                                size: 24,
                              ),
                            ),
                            hintText: "search state",
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                            )),
                      ),
                    ),
                    Expanded(
                        child: ListView.builder(
                      itemCount: filterList.isEmpty
                          ? widget.citiesList.length
                          : filterList.length,
                      itemBuilder: (BuildContext context, int index) {
                        Cities value = filterList.isEmpty
                            ? widget.citiesList[index]
                            : filterList[index];
                        int size = filterList.isEmpty
                            ? widget.citiesList.length - 1
                            : filterList.length - 1;

                        return InkWell(
                          onTap: () {
                            Get.focusScope!.unfocus();
                            _controller.cityId(value.id);
                            _controller.cityName(value.name);
                            Get.back();
                          },
                          child: Column(
                            children: [
                              Container(
                                width: Get.width,
                                child: Text(
                                  "${value.name!}",
                                  style: TextStyle(color: Colors.black),
                                ),
                                padding: EdgeInsets.only(
                                  left: 12,
                                  right: 12,
                                  top: 12,
                                  bottom: 12,
                                ),
                              ),
                              Container(
                                width: Get.width,
                                height: 1,
                                color: Colors.grey.withOpacity(0.2),
                              ),
                            ],
                          ),
                        );
                      },
                    ))
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
