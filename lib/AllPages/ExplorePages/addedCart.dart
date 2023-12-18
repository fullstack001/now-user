import 'package:application_1/reuseableWidgets/reuseableRatingButton.dart';
import 'package:application_1/reuseableWidgets/reuseableSizedbox.dart';
import 'package:application_1/utils/AppColors.dart';
import 'package:flutter/material.dart';

class AddedCart extends StatelessWidget {
  Color black = AppColors.black;
  Color white = AppColors.white;
  Color grey = AppColors.grey;
  Color blue = AppColors.blue;
  Color green = AppColors.green;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double w = size.width;
    double h = size.height;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.share,
          size: 28,
          color: white,
        ),
        onPressed: () {},
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white12,
          child: Column(
            children: [
              Container(
                width: w,
                height: h * 0.51,
                child: Column(
                  children: [
                    Container(
                      width: w,
                      height: h * 0.305,
                      child: Stack(
                        children: [
                          Container(
                            width: w,
                            height: h * 0.26,
                            child: Image(
                              fit: BoxFit.fill,
                              image: AssetImage(
                                  "assets/image 2x/shopBackground.png"),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Align(
                              alignment: Alignment.topRight,
                              child: IconButton(
                                  icon: Icon(
                                    Icons.close,
                                    size: 24,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {}),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              width: w * 0.312,
                              height: w * 0.312,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "assets/image 2x/shopProfile.png"))),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: [
                          BuildSizedBox(10),
                          Text(
                            "Subway",
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          BuildSizedBox(5),
                          Text(
                            "Eat Fresh",
                            style: TextStyle(
                                fontWeight: FontWeight.w300, fontSize: 14),
                          ),
                          BuildSizedBox(5),
                          Container(
                            width: w,
                            height: w * 0.167,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ReuseableRatingButton(
                                  w: w,
                                  h: h,
                                  txt: "4.5",
                                  onTap: (){},
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Container(
                                  padding: EdgeInsets.all(3),
                                  alignment: Alignment.center,
                                  width: w * 0.19,
                                  height: w * 0.08,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: blue),
                                  child: Text(
                                    "1500 PKR",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: white,
                                        fontSize: w <= 360 ? 12 : 14),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                width: w * 0.918,
                height: w * 0.74,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      width: w,
                      height: 20,
                      child: Text(
                        "Most Ordered",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Container(
                      width: w,
                      height: w * 0.62,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: w * 0.558,
                                  height: w * 0.34,
                                  child: Image(
                                    fit: BoxFit.fill,
                                    image: AssetImage(
                                        "assets/image 2x/burgers.png"),
                                  ),
                                ),
                                Text(
                                  "Ban Patty Burger",
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                                BuildSizedBox(5),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: w * 0.558,
                                      height: w * 0.08,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          ReuseableRatingButton(
                                            w: w,
                                            h: h,
                                            txt: "4.5",
                                            onTap: (){},
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Container(
                                            padding: EdgeInsets.all(3),
                                            alignment: Alignment.center,
                                            width: w * 0.19,
                                            height: w * 0.08,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                color: blue),
                                            child: Text(
                                              "1500 PKR",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: white,
                                                  fontSize: w <= 360 ? 12 : 14),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    BuildSizedBox(5),
                                    Container(
                                      padding: EdgeInsets.all(1),
                                      alignment: Alignment.center,
                                      width: w * 0.33,
                                      height: w * 0.065,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: green),
                                      child: Text(
                                        "1500 PKR",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: white,
                                            fontSize: w <= 360 ? 12 : 14),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: w * 0.558,
                                  height: w * 0.34,
                                  child: Image(
                                    fit: BoxFit.fill,
                                    image: AssetImage(
                                        "assets/image 2x/burgers.png"),
                                  ),
                                ),
                                Text(
                                  "Ban Patty Burger",
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                                BuildSizedBox(5),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: w * 0.558,
                                      height: w * 0.08,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          ReuseableRatingButton(
                                            w: w,
                                            h: h,
                                            txt: "4.5",
                                            onTap: (){},
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Container(
                                            padding: EdgeInsets.all(3),
                                            alignment: Alignment.center,
                                            width: w * 0.19,
                                            height: w * 0.08,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                color: blue),
                                            child: Text(
                                              "1500 PKR",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: white,
                                                  fontSize: w <= 360 ? 12 : 14),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    BuildSizedBox(5),
                                    Container(
                                      padding: EdgeInsets.all(1),
                                      alignment: Alignment.center,
                                      width: w * 0.33,
                                      height: w * 0.065,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: green),
                                      child: Text(
                                        "1500 PKR",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: white,
                                            fontSize: w <= 360 ? 12 : 14),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: w * 0.918,
                height: w * 0.74,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      width: w,
                      height: 20,
                      child: Text(
                        "Menu",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Container(
                      width: w,
                      height: w * 0.62,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: w * 0.558,
                                  height: w * 0.34,
                                  child: Image(
                                    fit: BoxFit.fill,
                                    image: AssetImage(
                                        "assets/image 2x/burgers.png"),
                                  ),
                                ),
                                Text(
                                  "Ban Patty Burger",
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                                BuildSizedBox(5),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: w * 0.558,
                                      height: w * 0.08,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          ReuseableRatingButton(
                                            w: w,
                                            h: h,
                                            txt: "4.5",
                                            onTap: (){},
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Container(
                                            padding: EdgeInsets.all(3),
                                            alignment: Alignment.center,
                                            width: w * 0.19,
                                            height: w * 0.08,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                color: blue),
                                            child: Text(
                                              "1500 PKR",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: white,
                                                  fontSize: w <= 360 ? 12 : 14),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    BuildSizedBox(5),
                                    Container(
                                      padding: EdgeInsets.all(1),
                                      alignment: Alignment.center,
                                      width: w * 0.33,
                                      height: w * 0.065,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: green),
                                      child: Text(
                                        "1500 PKR",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: white,
                                            fontSize: w <= 360 ? 12 : 14),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: w * 0.558,
                                  height: w * 0.34,
                                  child: Image(
                                    fit: BoxFit.fill,
                                    image: AssetImage(
                                        "assets/image 2x/burgers.png"),
                                  ),
                                ),
                                Text(
                                  "Ban Patty Burger",
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                                BuildSizedBox(5),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: w * 0.558,
                                      height: w * 0.08,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          ReuseableRatingButton(
                                            w: w,
                                            h: h,
                                            txt: "4.5",
                                            onTap: (){},
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Container(
                                            padding: EdgeInsets.all(3),
                                            alignment: Alignment.center,
                                            width: w * 0.19,
                                            height: w * 0.08,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                color: blue),
                                            child: Text(
                                              "1500 PKR",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: white,
                                                  fontSize: w <= 360 ? 12 : 14),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    BuildSizedBox(5),
                                    Container(
                                      padding: EdgeInsets.all(1),
                                      alignment: Alignment.center,
                                      width: w * 0.33,
                                      height: w * 0.065,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: green),
                                      child: Text(
                                        "1500 PKR",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: white,
                                            fontSize: w <= 360 ? 12 : 14),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
