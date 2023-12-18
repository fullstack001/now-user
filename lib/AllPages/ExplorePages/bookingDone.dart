import 'package:application_1/AllPages/ExplorePages/providerProfile.dart';
import 'package:application_1/reuseableWidgets/reuseableSizedbox.dart';
import 'package:application_1/reuseableWidgets/reuseblueButton.dart';
import 'package:application_1/utils/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookingDone extends StatelessWidget {
  Color black = AppColors.black;
  Color white = AppColors.white;
  Color grey = AppColors.grey;
  Color blue = AppColors.blue;
  Color green = AppColors.green;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: white,
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.close,
              color: black,
            ),
          ),
          title: Text(
            "Provider Booked",
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewPort) {
            double w = viewPort.maxWidth;
            double h = viewPort.maxHeight;

            return ConstrainedBox(
              constraints: BoxConstraints(minHeight: viewPort.minHeight),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      alignment: Alignment.center,
                      width: w,
                      height: h * 0.41,
                      child: Card(
                        elevation: 0,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "Estimated Arrival Time",
                              style: TextStyle(
                                  color: black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              "15 - 20 Mins",
                              style: TextStyle(
                                  color: black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                            ),
                            CircleAvatar(
                              radius: h * 0.075,
                              child: Icon(
                                Icons.check,
                                size: h * 0.075,
                                color: white,
                              ),
                            ),
                            Text(
                              "your order number is : 343ffe3",
                              style: TextStyle(
                                  color: black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600),
                            ),
                            Container(
                              alignment: Alignment.bottomLeft,
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              width: w,
                              height: 40,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Floor Cleaning",
                                    style: TextStyle(
                                        color: black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    "1 Manchester Ave.Lake zurich, IL 42342 ",
                                    style: TextStyle(
                                        color: black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w200),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    width: w,
                    height: h * 0.478,
                    padding: EdgeInsets.all(15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Booking Details",
                                  style: TextStyle(
                                      color: black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                                BuildSizedBox(15),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "2 Hour",
                                      style: TextStyle(
                                          color: black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w300),
                                    ),
                                    Text(
                                      "RS -20.16",
                                      style: TextStyle(
                                          color: black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                                BuildSizedBox(8),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Extra charges depends on extra hour",
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ],
                                ),
                                BuildSizedBox(15),
                                Text(
                                  "Select Payment Method",
                                  style: TextStyle(
                                      color: black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                                BuildSizedBox(10),
                                ListTile(
                                  title: Text(
                                    "MasterCard",
                                    style: TextStyle(
                                        color: black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  subtitle: Text(
                                    ".......2234",
                                    style: TextStyle(
                                        color: black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w200),
                                  ),
                                  leading: Container(
                                    alignment: Alignment.center,
                                    width: 30,
                                    height: 30,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                "assets/image 1.5x/mastercard.png"))),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total",
                              style: TextStyle(
                                  color: black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              "RS -20.16",
                              style: TextStyle(
                                  color: black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        BuildSizedBox(5),
                        Container(
                          width: w,
                          alignment: Alignment.center,
                          child: ReuseableBlueButton(
                            w: w,
                            h: h,
                            text: "Contact Provider",
                            onTap: () {
                              Get.to(ProviderProfile());
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ));
  }
}
