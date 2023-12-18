import 'package:application_1/AllPages/introPages/questionPages/QuestionPages.dart';
import 'package:application_1/reuseableWidgets/reuseableSizedbox.dart';
import 'package:application_1/utils/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubCategories extends StatelessWidget {
  SubCategories({Key? key}) : super(key: key);
  Color black = AppColors.black;
  Color white = AppColors.white;
  Color grey = AppColors.grey;
  Color blue = AppColors.blue;
  Color green = AppColors.green;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: white,
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                Icons.close,
                size: 22,
                color: blue,
              ),
            ),
          ),
          body: LayoutBuilder(
            builder: (context, size) {
              print(size.maxWidth);
              print(size.maxHeight);
              return ConstrainedBox(
                constraints: BoxConstraints(minHeight: size.maxHeight),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Card(
                          elevation: 2.2,
                          child: Container(
                            width: size.maxWidth,
                            height: 40,
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.search,
                                    color: Colors.black38,
                                  ),
                                  filled: true,
                                  hintText: "Handy Man service",
                                  hintStyle: TextStyle(
                                      height: 3, color: Colors.black38),
                                  fillColor: Colors.white10,
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none)),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          alignment: Alignment.centerLeft,
                          width: size.maxWidth,
                          height: 40,
                          color: Colors.transparent,
                          child: Container(
                            height: 25,
                            child: Text(
                              "Cleaning SubCategories",
                              style: Theme.of(context).textTheme.headline6,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 10,
                        child: Container(
                          // width: size.maxWidth,
                          // height: size.maxHeight * 0.3,
                          child: ListView.builder(
                            itemCount: 5,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: Container(
                                  width: size.maxWidth,
                                  height: size.maxHeight * 0.223,
                                  child: Row(
                                    children: [
                                      Expanded(
                                          child: Container(
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                fit: BoxFit.fill,
                                                image: AssetImage(
                                                    "assets/image 2x/handy.png"))),
                                      )),
                                      Expanded(
                                          child: Container(
                                        alignment: Alignment.center,
                                        color: Colors.blue,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Mounting Pro's",
                                              style: TextStyle(
                                                  color: white, fontSize: 18),
                                            ),
                                            BuildSizedBox(8),
                                            GestureDetector(
                                              onTap: () {
                                                Get.to(Question1());
                                              },
                                              child: Container(
                                                padding: EdgeInsets.all(2),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  color: white,
                                                ),
                                                width: 114,
                                                height: 23,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Text(
                                                      'Book Pro Now',
                                                      style: TextStyle(
                                                          color: blue,
                                                          fontSize: 12),
                                                    ),
                                                    Icon(
                                                      Icons
                                                          .arrow_forward_outlined,
                                                      color: blue,
                                                      size: 12,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          )),
    );
  }
}
