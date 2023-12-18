import 'package:application_1/AllPages/rating_controller.dart';
import 'package:application_1/utils/AppColors.dart';
import 'package:application_1/utils/api_utils.dart';
import 'package:application_1/utils/app_dialog_utils.dart';
import 'package:application_1/utils/project_widget.dart';
import 'package:application_1/utils/widgest_utills.dart';
import 'package:application_1/widgets/rating_start.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

class FeedBackPage extends StatefulWidget {
  final data;
  final onRateComplete;

  FeedBackPage({
    Key? key,
    this.data,
    this.onRateComplete,
  }) : super(key: key);

  @override
  _FeedBackPageState createState() => _FeedBackPageState();
}

class _FeedBackPageState extends State<FeedBackPage> {
  TextEditingController _feedbackController = TextEditingController();

  var initialRating = 1.0;

  @override
  Widget build(BuildContext context) {
    RatingController rating = Get.put(RatingController());
    if (!kReleaseMode) {
      _feedbackController.text = "A quick brow fox jump over the lazy dog";
    }
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(left: 24, right: 24),
            padding: EdgeInsets.only(top: 12, bottom: 12),
            width: Get.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              color: Colors.white,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 24,
                    ),
                    ClipOval(
                      child: cacheNetworkImage(
                        imageHeight: 72,
                        imageWidth: 72,
                        imageUrl:
                            "${ApiUtills.imageBaseUrl + (widget.data.provider.image ?? "")}",
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          getUserName(widget.data.provider),
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        RatingStar(
                          size: 20,
                          rating: double.parse(
                              (widget.data.provider.rating ?? 0.0).toString()),
                          color: AppColors.appGreen,
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 12,
                ),
                RatingBar.builder(
                  initialRating: initialRating,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: false,
                  unratedColor: Colors.amber.withAlpha(50),
                  itemCount: 5,
                  itemSize: 40.0,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (value) {
                    print(value.toString());
                    initialRating = value;
                  },
                  updateOnDrag: true,
                ),
                SizedBox(
                  height: 12,
                ),
                Container(
                  width: Get.width,
                  height: 180,
                  margin: EdgeInsets.only(left: 12, right: 12),
                  padding: EdgeInsets.only(left: 12, right: 12),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                      border: Border.all(width: 1, color: Colors.grey)),
                  child: TextFormField(
                    controller: _feedbackController,
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (v) {
                      if (_feedbackController.text.isEmpty) {
                        alertDialog(
                          title: "Alert",
                          content: "Please enter your feedback",
                          confirm: MaterialButton(
                            onPressed: () {
                              Get.back();
                            },
                            child: Text("Okay"),
                          ),
                        );
                        return;
                      }

                      String feedBack = _feedbackController.text.toString();
                      var userId = widget.data.provider.id;
                      var serviceId = widget.data.id;

                      Map body = <String, dynamic>{
                        "service_request_id": serviceId,
                        "provider_id": userId,
                        "comment": feedBack,
                        "rating": initialRating
                      };

                      rating.sendFeedback(
                          body: body,
                          onSendFeedback: () {
                            Get.back();
                            widget.onRateComplete();
                          });
                    },
                    maxLines: 10,
                    decoration: InputDecoration(
                      hintText: "Enter your feedback for use",
                      enabledBorder: new OutlineInputBorder(
                          borderSide: new BorderSide(
                        color: Color(0xffF3F4F4),
                      )),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xffF3F4F4),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                InkWell(
                  onTap: () {
                    if (_feedbackController.text.isEmpty) {
                      alertDialog(
                        title: "Alert",
                        content: "Please enter your feedback",
                        confirm: MaterialButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: Text("Okay"),
                        ),
                      );
                      return;
                    }

                    String feedBack = _feedbackController.text.toString();
                    var userId = widget.data.provider.id;
                    var serviceId = widget.data.id;

                    Map body = <String, dynamic>{
                      "service_request_id": serviceId,
                      "provider_id": userId,
                      "comment": feedBack,
                      "rating": initialRating
                    };

                    rating.sendFeedback(
                        body: body,
                        onSendFeedback: () {
                          Get.back();
                          widget.onRateComplete();
                        });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(left: 12, right: 12),
                    width: Get.width,
                    height: 45,
                    decoration: BoxDecoration(
                      color: AppColors.appGreen,
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                    child: Text(
                      "Submit",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 6,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
