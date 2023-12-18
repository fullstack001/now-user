import 'package:application_1/AllPages/moving/screes/google_map_view.dart';
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

class MovingDetailScreen extends StatelessWidget {
  final data;

  MovingDetailScreen({this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Moving History",
          style: TextStyle(color: Colors.black, fontSize: 16),
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
      body: SafeArea(
        child: ListView(
          children: [
            CustomContainer(
              color: Colors.white,
              width: Get.width,
              marginTop: 24,
              marginRight: 24,
              marginLeft: 24,
              paddingAll: 12,
              allRadius: 12,
              shadowBlurRadius: 5,
              shadowSpreadRadius: 3,
              shadowColor: Colors.black.withOpacity(0.5),
              shadowOffsetX: 2,
              shadowOffsetY: 2,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipOval(
                    child: (data).provider.image == null
                        ? Image(
                            image: AssetImage(
                              'assets/images/img_profile_place_holder.jpg',
                            ),
                            width: 80,
                          )
                        : cacheNetworkImage(
                            imageUrl:
                                ApiUtills.imageBaseUrl + (data).provider.image,
                            imageHeight: 80,
                            imageWidth: 80,
                          ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("${getUserName((data).provider)}",
                          style: TextStyle(
                              fontSize: 16,
                              color: AppColors.black,
                              fontWeight: FontWeight.bold)),
                      // Text(
                      //   "179 Jobs Completed",
                      //   style: TextStyle(
                      //       fontSize: 12,
                      //       fontWeight: FontWeight.w300),
                      // ),
                      RatingStar(
                        size: 18,
                        color: AppColors.appGreen,
                        rating: double.parse(
                            ((data).provider.rating ?? 0).toString()),
                      )
                    ],
                  )
                ],
              ),
            ),
            TextWithIcon(
              marginTop: 24,
              marginLeft: 24,
              fontSize: 18,
              fontWeight: FontWeight.w700,
              title: "Delivery Location",
            ),
            CustomContainer(
              width: 100,
              height: 250,
              color: Colors.yellow,
              marginTop: 12,
              marginLeft: 24,
              marginRight: 24,
              child: GoogleMapView(),
            ),
            movingWidget(
                label: "Deliver Date & time",
                content: "${workTime(data.createdAt)}",
                icon: Icon(
                  Icons.watch_later,
                  color: Colors.grey[300],
                )),
            movingWidget(
                label: "From Address",
                content: "${data.movingQuotationInfo.fromAddress}",
                flex: 1,
                icon: Icon(
                  Icons.location_on,
                  color: Colors.grey[300],
                )),
            movingWidget(
                label: "To Address",
                content: "${data.movingQuotationInfo.toAddress}",
                flex: 1,
                icon: Icon(
                  Icons.location_on,
                  color: Colors.grey[300],
                )),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }

  workTime(createdAt) {
    DateTime dateTime = DateTimeUtils().convertStringWoT(createdAt);
    String time =
        DateTimeUtils().parseDateTime(dateTime, "dd/MM/yyyy  HH:mm aa");
    return time;
  }

  movingWidget({label, icon, content, flex}) {
    return Column(
      children: [
        TextWithIcon(
          marginTop: 12,
          marginLeft: 24,
          marginRight: 24,
          fontSize: 18,
          fontWeight: FontWeight.w700,
          title: "$label",
        ),
        TextWithIcon(
          width: Get.width,
          marginTop: 6,
          marginLeft: 24,
          marginRight: 24,
          fontSize: 16,
          maxLine: 1,
          icon: icon,
          flex: 1,
          fontWeight: FontWeight.w400,
          title: "$content",
        ),
      ],
    );
  }
}
