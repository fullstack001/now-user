import 'package:application_1/model/service_response/service_list_data.dart';
import 'package:application_1/utils/AppColors.dart';
import 'package:application_1/utils/api_utils.dart';
import 'package:application_1/utils/date_time_utils.dart';
import 'package:application_1/utils/project_widget.dart';
import 'package:application_1/utils/widgest_utills.dart';
import 'package:application_1/widgets/custom_container.dart';
import 'package:application_1/widgets/rating_start.dart';
import 'package:application_1/widgets/text_with_icon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MovingDetailScreen extends StatefulWidget {
  final data;

  MovingDetailScreen({Key? key, this.data}) : super(key: key);

  @override
  _MovingDetailScreenState createState() => _MovingDetailScreenState();
}

class _MovingDetailScreenState extends State<MovingDetailScreen> {
  var data;

  @override
  Widget build(BuildContext context) {
    if (data == null) {
      data = widget.data;
    }
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.blue,
          ),
        ),
        backgroundColor: Colors.white,
        centerTitle: false,
        title: Text(
          "Order Detail",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              width: double.infinity,
              height: 200,
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 145,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage("assets/images/mapHeader.png"))),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: 112,
                      height: 112,
                      child: ClipOval(
                        child: widget.data.provider.image == null
                            ? Image(
                                image: AssetImage(
                                    'assets/images/img_profile_place_holder.jpg'),
                              )
                            : cacheNetworkImage(
                                placeHolder:
                                    "assets/images/img_profile_place_holder.jpg",
                                imageUrl: ApiUtills.imageBaseUrl +
                                    data.provider.image),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              width: double.infinity,
              height: 150,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 6,
                  ),
                  Text(
                    getUserName(data.provider),
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                  if (data.address != null)
                    Text(
                      data.address,
                      style:
                          TextStyle(color: Colors.grey.shade500, fontSize: 12),
                    ),
                  RatingStar(
                    size: 20,
                    rating:
                        double.parse((data.provider.rating ?? 0).toString()),
                    color: AppColors.appGreen,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {},
                    child: CustomContainer(
                        width: 300,
                        height: 40,
                        color: Colors.grey,
                        allRadius: 20,
                        child: Text(
                          "Chat Request sent",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                          textAlign: TextAlign.center,
                        )),
                  ),
                  Divider(
                    endIndent: 10,
                    indent: 10,
                    thickness: 1,
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              width: double.infinity,
              height: 100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Job Type",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Text(
                    "Moving",
                    style: TextStyle(fontWeight: FontWeight.w300, fontSize: 20),
                  ),
                  Text(
                    "${convertToAgo(DateTime.parse(data.createdAt))}",
                    style: TextStyle(fontWeight: FontWeight.w300, fontSize: 12),
                  ),
                  // Text(
                  //   "${DateTimeUtils().checkSince(DateTimeUtils().convertString(data.createdAt))}",
                  //   style: TextStyle(fontWeight: FontWeight.w300, fontSize: 12),
                  // ),
                  Divider(
                    thickness: 1,
                    indent: 10,
                    endIndent: 10,
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              width: double.infinity,
              height: 100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "From Address",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Text(
                    "${widget.data.movingQuotationInfo.fromAddress ?? "N/A"}",
                    style: TextStyle(fontWeight: FontWeight.w300, fontSize: 18),
                  ),
                  Divider(
                    thickness: 1,
                    indent: 10,
                    endIndent: 10,
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              width: double.infinity,
              height: 100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "To Address",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Text(
                    "${widget.data.movingQuotationInfo.toAddress ?? "N/A"}",
                    style: TextStyle(fontWeight: FontWeight.w300, fontSize: 18),
                  ),
                  Divider(
                    thickness: 1,
                    indent: 10,
                    endIndent: 10,
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              width: double.infinity,
              height: 100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "ZipCode",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Text(
                    "${widget.data.provider.zipCode ?? "N/A"}",
                    style: TextStyle(fontWeight: FontWeight.w300, fontSize: 18),
                  ),
                  Divider(
                    thickness: 1,
                    indent: 10,
                    endIndent: 10,
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              width: double.infinity,
              height: 100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Date",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Text(
                    "${widget.data.movingQuotationInfo.date ?? "N/A"}",
                    style: TextStyle(fontWeight: FontWeight.w300, fontSize: 18),
                  ),
                  Divider(
                    thickness: 1,
                    indent: 10,
                    endIndent: 10,
                  ),
                ],
              ),
            ),
            TextWithIcon(
              width: Get.width,
              height: 40,
              marginTop: 60,
              allRadius: 12,
              marginLeft: 24,
              marginRight: 24,
              marginBottom: 12,
              bgColor: AppColors.appGreen,
              title: data.status,
              fontSize: 18,
              fontColor: Colors.white,
              fontWeight: FontWeight.w700,
            )
          ],
        ),
      ),
    );
  }

  String convertToAgo(DateTime input) {
    Duration diff = DateTime.now().difference(input);

    if (diff.inDays >= 1) {
      if (diff.inDays == 1) {
        return '${diff.inDays} day ago';
      } else {
        return '${diff.inDays} days ago';
      }
    } else if (diff.inHours >= 1) {
      if (diff.inHours == 1) {
        return '${diff.inHours} hour ago';
      } else {
        return '${diff.inHours} hours ago';
      }
    } else if (diff.inMinutes >= 1) {
      if (diff.inMinutes == 1) {
        return '${diff.inMinutes} minute ago';
      } else {
        return '${diff.inMinutes} minutes ago';
      }
    } else if (diff.inSeconds >= 1) {
      if (diff.inSeconds == 1) {
        return '${diff.inSeconds} second ago';
      } else {
        return '${diff.inSeconds} seconds ago';
      }
    } else {
      return 'just now';
    }
  }
}
