import 'package:application_1/AllPages/ExplorePages/zip_search_wiget.dart';
import 'package:application_1/AllPages/introPages/intro_controller.dart';
import 'package:application_1/utils/AppColors.dart';
import 'package:application_1/widgets/intro_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final IntroController controller = Get.find();

class QuestionPageModels {
  Color black = AppColors.black;
  Color white = AppColors.white;
  Color blue = AppColors.blue;
  List<String> buttonList = [
    "See Inspiration",
    "Hire a pro",
    "Plan my project",
    'Browse pros',
    "Compare prices",
    "Other"
  ];

  Widget buildpage() {
    return LayoutBuilder(
      builder: (context, size) {
        double h = MediaQuery.of(context).size.height;
        return ConstrainedBox(
          constraints: BoxConstraints(minHeight: h * 0.85),
          child: Container(
            color: Colors.white,
            width: Get.width,
            height: Get.height,
            alignment: Alignment.center,
            padding: EdgeInsets.all(0),
            child: IntroWidget(
              icon: 'assets/icons/image_one.svg',
              textTitle: "Cleaning Service",
              textContent:
                  "Farenow is offering you a platform\nwhere you can connect with the best\nservice provider for cleaning services\nin town.",
            ),
          ),
        );
      },
    );
  }

  buildpage1() {
    return LayoutBuilder(
      builder: (context, size) {
        double h = MediaQuery.of(context).size.height;
        return ConstrainedBox(
          constraints: BoxConstraints(minHeight: h * 0.75),
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.all(15),
            child: IntroWidget(
              icon: "assets/icons/image_five.svg",
              textTitle: "Handyman Services",
              textContent:
                  "Farenow is offering you a platform\nwhere you can connect with the best\n handyman service provider in town.",
            ),
          ),
        );
      },
    );
  }

  buildpage2() {
    return LayoutBuilder(
      builder: (context, size) {
        double h = MediaQuery.of(context).size.height;
        return ConstrainedBox(
          constraints: BoxConstraints(minHeight: h * 0.75),
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.all(15),
            child: IntroWidget(
              icon: "assets/icons/image_four.svg",
              textTitle: "Moving Services",
              textContent:
                  "Farenow is offering you a platform\nwhere you can connect with the best\n service providers for moving services\nin town.",
            ),
          ),
        );
      },
    );
  }

  buildpage4({update, title, hint, inApp, zipCode}) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(15),
      child: IntroWidget(
        icon: "assets/icons/image_two.svg",
        textTitle: "Groceries/Food",
        textContent:
            "Farenow is offering you a platform\nwhere you can find restaurant and grocery\nstores near you.",
      ),
    );
  }

  buildpage3({update, title, hint, inApp, zipCode, previous}) {
    return ZipSearchWiget(
        update: update,
        hint: hint,
        inApp: inApp,
        zipCode: zipCode,
        previous: previous);
  }
}

class DetailList {
  String name = "";
  int index = 0;

  DetailList({this.name = "", this.index = 0});
}

class RadioGroup2 extends StatefulWidget {
  @override
  RadioGroup2Widget createState() => RadioGroup2Widget();
}

class RadioGroup2Widget extends State {
  int id = 1;

  List<DetailList> fList = [
    DetailList(
      index: 1,
      name: "Renter",
    ),
    DetailList(
      index: 2,
      name: "Owner",
    ),
    DetailList(
      index: 3,
      name: "Property Manager",
    ),
    DetailList(
      index: 4,
      name: "Others",
    ),
  ];

  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
            child: Container(
          height: 350.0,
          child: Column(
            children: fList
                .map((data) => RadioListTile(
                      title: Text("${data.name}"),
                      groupValue: id,
                      value: data.index,
                      onChanged: (val) {
                        setState(() {
                          id = data.index;
                          controller.whatBest(data.name);
                        });
                      },
                    ))
                .toList(),
          ),
        )),
      ],
    );
  }
}

class RadioGroup extends StatefulWidget {
  @override
  RadioGroupWidget createState() => RadioGroupWidget();
}

class RadioGroupWidget extends State {
  int id = 1;

  List<DetailList> fList = [
    DetailList(
      index: 1,
      name: "Apartment / Condo",
    ),
    DetailList(
      index: 2,
      name: "Single Family Home",
    ),
    DetailList(
      index: 3,
      name: "Town House",
    ),
    DetailList(
      index: 4,
      name: "Multi Family",
    ),
    DetailList(
      index: 5,
      name: "Others",
    ),
  ];

  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
            child: Container(
          height: 350.0,
          child: Column(
            children: fList
                .map((data) => RadioListTile(
                      title: Text("${data.name}"),
                      groupValue: id,
                      value: data.index,
                      onChanged: (val) {
                        setState(() {
                          id = data.index;
                          controller.homeType(data.name);
                        });
                      },
                    ))
                .toList(),
          ),
        )),
      ],
    );
  }
}
