import 'package:application_1/provider/paymentProvider.dart';
import 'package:application_1/reuseableWidgets/reuseableSizedbox.dart';
import 'package:application_1/reuseableWidgets/reuseblueButton.dart';
import 'package:application_1/utils/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class OrderTracking extends StatelessWidget {
  Color black = AppColors.black;
  Color white = AppColors.white;
  Color grey = AppColors.grey;
  Color blue = AppColors.blue;
  Color green = AppColors.green;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: white,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.close,
            color: blue,
          ),
        ),
        title: Text(
          "Order Placed",
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, size) {
          return ConstrainedBox(
            constraints: BoxConstraints(minHeight: size.maxHeight),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Consumer<Paymentprovider>(
                builder: (context, provider, child) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: size.maxWidth,
                        height: size.maxHeight * 0.17,
                        child: ListView(
                          children: [
                            GestureDetector(
                              onTap: () {
                                provider.setOrderTrack(true);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color:
                                        provider.callOrderTrack ? blue : white),
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                alignment: Alignment.centerLeft,
                                width: size.maxWidth,
                                height: size.maxHeight * 0.076,
                                child: Text(
                                  "Call To Resturent",
                                  style: TextStyle(
                                      color: provider.callOrderTrack
                                          ? white
                                          : black,
                                      fontSize: 18),
                                ),
                              ),
                            ),
                            BuildSizedBox(10),
                            GestureDetector(
                              onTap: () {
                                provider.setOrderTrack(false);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color:
                                        provider.callOrderTrack ? white : blue),
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                alignment: Alignment.centerLeft,
                                width: size.maxWidth,
                                height: size.maxHeight * 0.076,
                                child: Text(
                                  "Chat To Resturent",
                                  style: TextStyle(
                                      color: provider.callOrderTrack
                                          ? black
                                          : white,
                                      fontSize: 18),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: ReuseableBlueButton(
                          w: size.maxWidth,
                          h: size.maxHeight,
                          text: "Track Your Order",
                          onTap: () {
                            Get.offNamed("/tabScreen");
                          },
                        ),
                      )
                    ],
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
