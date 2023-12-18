import 'package:application_1/AllPages/ExplorePages/sub_service_item.dart';
import 'package:application_1/utils/api_utils.dart';
import 'package:application_1/widgets/service_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SeeAllScreen extends StatefulWidget {
  final serviceHeader;
  final allServices;

  SeeAllScreen({
    Key? key,
    this.allServices,
    this.serviceHeader,
  }) : super(key: key);

  @override
  _SeeAllScreenState createState() => _SeeAllScreenState();
}

class _SeeAllScreenState extends State<SeeAllScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        centerTitle: false,
        title: Text(
          "${widget.serviceHeader}",
          style: TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),
        ),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back,
            size: 25,
            color: Colors.blue,
          ),
        ),
      ),
      body: Container(
        height: Get.height,
        width: Get.width,
        child: ServiceItem(
          allServices: widget.allServices,
        ),
      ),
    );
  }
}
