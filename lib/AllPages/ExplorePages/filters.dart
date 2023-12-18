import 'package:application_1/reuseableWidgets/reuseableSizedbox.dart';
import 'package:application_1/utils/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Filter extends StatefulWidget {
  @override
  _FilterState createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  Color black = AppColors.black;
  Color white = AppColors.white;
  Color grey = AppColors.grey;
  Color blue = AppColors.blue;
  Color green = AppColors.green;
  List<String> _texts = [
    "North Indian Food",
    "South Indian Food",
    "American Food",
    "Arabian",
    "Bakers",
    "Asian",
    "African Food"
  ];
  List<String> _quick = [
    "Non Veg",
    "Pure Veg",
    "Free delivery",
  ];
  List<bool>? _isChecked;
  List<bool>? _checkedQuick;

  @override
  void initState() {
    super.initState();
    _isChecked = List<bool>.filled(_texts.length, false);
    _checkedQuick = List<bool>.filled(_quick.length, false);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double w = size.width;
    double h = size.height;

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(
          "Search filter",
          style: TextStyle(
              color: black, fontSize: 20, fontWeight: FontWeight.w700),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.check,
              color: blue,
            ),
            onPressed: () {
              Get.back();
            },
          ),
        ],
        elevation: 0,
        backgroundColor: white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: black,
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: w,
          height: h,
          color: Colors.grey.shade100,
          child: Container(
            width: w * 0.863,
            height: h * 0.73,
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  width: w * 0.863,
                  height: 40,
                  child: Container(
                    child: Text(
                      "Select Type",
                      style: TextStyle(
                          color: black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                Container(
                  width: w * 0.863,
                  height: h * 0.38,
                  child: Card(
                    child: ListView.builder(
                        itemCount: _texts.length,
                        itemBuilder: (context, index) {
                          return Container(
                            width: w * 0.863,
                            height: 35,
                            child: ListTile(
                              leading: Checkbox(
                                value: _isChecked![index],
                                onChanged: (val) {
                                  setState(
                                    () {
                                      _isChecked![index] = val!;
                                    },
                                  );
                                },
                              ),
                              title: Text(_texts[index]),
                            ),
                          );
                        }),
                  ),
                ),
                BuildSizedBox(8),
                Container(
                  width: w * 0.863,
                  height: 30,
                  child: Container(
                    child: Text(
                      "Quick Type",
                      style: TextStyle(
                          color: black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                Container(
                  width: w * 0.863,
                  height: h * 0.18,
                  child: Card(
                    child: ListView.builder(
                        itemCount: _quick.length,
                        itemBuilder: (context, index) {
                          return Container(
                            width: w * 0.863,
                            height: 35,
                            child: ListTile(
                              leading: Checkbox(
                                value: _checkedQuick![index],
                                onChanged: (val) {
                                  setState(
                                    () {
                                      _checkedQuick![index] = val!;
                                    },
                                  );
                                },
                              ),
                              title: Text(_quick[index]),
                            ),
                          );
                        }),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
