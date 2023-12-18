import 'package:application_1/AllPages/rating_controller.dart';
import 'package:application_1/remote_model/provider_list/feedback_reviews_list_model.dart';
import 'package:application_1/resources/repositories/service_repository.dart';
import 'package:application_1/utils/AppColors.dart';
import 'package:application_1/utils/rounded_progress_bar/custom_rounded_progress_style.dart';
import 'package:application_1/utils/rounded_progress_bar/rounded_progress_bar.dart';
import 'package:application_1/widgets/rating_start.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';

import 'export_file.dart';

// ignore: must_be_immutable
class ProviderRatingSection extends StatefulWidget {
  var providerId;
  var userFeedbacksCount;
  ProviderRatingSection(
      {required this.providerId, required this.userFeedbacksCount});

  @override
  State<ProviderRatingSection> createState() => _ProviderRatingSectionState();
}

class _ProviderRatingSectionState extends State<ProviderRatingSection> {
  bool isLoading = false;
  bool notFound = true;
  int currentIndex = 0;
  List<DataofFeedback> reviewList = [];
  final width = Get.width * 0.8;
  final ScrollController scrollController = ScrollController();
  void animateToIndex(int index) {
    scrollController.animateTo(
      index * width,
      duration: const Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
  }

  late FeedbackReviewsListRatings _ratingsRatings;
  @override
  void initState() {
    super.initState();

    getReviews(widget.providerId);
    // getReviews(580);
  }

  Future<void> getReviews(id) async {
    await ServiceReposiotry()
        .getProviderProfileReviews(id)
        .then((FeedbackReviewsList? feedbackReviewsList) {
      if (feedbackReviewsList != null) {
        if (!feedbackReviewsList.error) {
          reviewList.addAll(feedbackReviewsList.data);
          _ratingsRatings = feedbackReviewsList.ratings;
          isLoading = true;
        } else {
          notFound = false;
          isLoading = false;
        }
      } else {
        notFound = false;
        isLoading = false;
      }
    });

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    print(widget.userFeedbacksCount);
    return notFound
        ? GetMainCardColum(widget: [
            isLoading
                ? Column(
                    children: [
                      SingleChildScrollView(
                        controller: scrollController,
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(
                              _ratingsRatings.total,
                              (index) => Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      elevation: 4,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 12),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            6.height,
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const Text(
                                                  "Rating and reviews",
                                                  style: TextStyle(
                                                      color: Colors.black87,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 24),
                                                ),
                                                SizedBox(
                                                  width: Get.width * 0.13,
                                                ),
                                                const Icon(
                                                  Icons.arrow_forward,
                                                  color: Colors.black54,
                                                )
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    FittedBox(
                                                      child: Text(
                                                        "${_ratingsRatings.average}",
                                                        style: TextStyle(
                                                            color:
                                                                AppColors.black,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 96),
                                                      ),
                                                    ),
                                                    RatingStar(
                                                      color: const Color(
                                                          0xffFF9E45),
                                                      rating: _ratingsRatings
                                                          .average,
                                                      size: 22,
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    FittedBox(
                                                      child: Text(
                                                        "(${widget.userFeedbacksCount})",
                                                        style: const TextStyle(
                                                            fontSize: 14,
                                                            color:
                                                                Colors.black54,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 13),
                                                  child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      children: [
                                                        getRatingbar(
                                                            _ratingsRatings
                                                                .ratings.five,
                                                            5),
                                                        getRatingbar(
                                                            _ratingsRatings
                                                                .ratings.four,
                                                            4),
                                                        getRatingbar(
                                                            _ratingsRatings
                                                                .ratings.three,
                                                            3),
                                                        getRatingbar(
                                                            _ratingsRatings
                                                                .ratings.two,
                                                            2),
                                                        getRatingbar(
                                                            _ratingsRatings
                                                                .ratings.one,
                                                            1),
                                                      ]),
                                                )
                                              ],
                                            ),
                                            12.height,
                                            Container(
                                              width: Get.width * 0.72,
                                              height: 3,
                                              child: const Divider(
                                                color: Colors.black45,
                                              ),
                                            ),
                                            reviewList[index].user == null
                                                ? Container()
                                                : getReviewDetailSection(
                                                    reviewList[index].user,
                                                    reviewList[index]),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )),
                        ),
                      ),
                      12.height,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                if (currentIndex > 0) {
                                  currentIndex--;
                                }
                                animateToIndex(currentIndex);
                              });
                            },
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              // width: 100,
                              height: 40,
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: const [
                                    Icon(
                                      Icons.arrow_back_ios,
                                      size: 16,
                                      color: Colors.black45,
                                    ),
                                    Text("Previous")
                                  ]),
                            ),
                          ),
                          GetBuilder<RatingController>(
                              init: RatingController(),
                              builder: ((control) {
                                return Text(
                                    "${currentIndex + 1} of ${_ratingsRatings.total}");
                              })),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                if (currentIndex < _ratingsRatings.total - 1) {
                                  currentIndex++;
                                  animateToIndex(currentIndex);
                                }
                              });
                            },
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              height: 40,
                              decoration: BoxDecoration(
                                  color: AppColors.darkBlue,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: const [
                                    Text(
                                      "Next",
                                      style: TextStyle(color: white),
                                    ),
                                    SizedBox(
                                      width: 6,
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      size: 16,
                                      color: Colors.white,
                                    ),
                                  ]),
                            ),
                          ),
                        ],
                      )
                    ],
                  )
                : const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Center(
                      child: CupertinoActivityIndicator(
                        animating: true,
                        radius: 33,
                      ),
                    ),
                  )
          ])
        : Container();
  }

  Column getReviewDetailSection(ReviewUser user, DataofFeedback data) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        12.height,
        user != null
            ? Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: const BoxDecoration(),
                    child: ClipOval(
                      child: user.image == null
                          ? const Image(
                              image:
                                  AssetImage('assets/user_assets/png/user.png'),
                              height: 60,
                              width: 60,
                            )
                          : cacheNetworkImage(
                              imageUrl:
                                  "${ApiUtills.imageBaseUrl}${user.image}",
                            ),
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Text(
                    "${user.firstName} ${user.lastName}",
                    style: const TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w400,
                        fontSize: 18),
                  ),
                ],
              )
            : Container(),
        16.height,
        Row(
          children: [
            RatingStar(
              color: Colors.orange,
              rating: data.rating.toDouble(),
              size: 18,
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              checkDate(data.createdAt),
              style: const TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w400,
                  fontSize: 16),
            ),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            data.comment,
            style: const TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.w400,
                fontSize: 18),
          ),
        ),
      ],
    );
  }

  Padding getRatingbar(index, int barindex) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          FittedBox(
            child: Text(
              NumberFormat.compactCurrency(
                      decimalDigits: 0, symbol: '', locale: 'en')
                  .format(index),
              style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                  fontWeight: FontWeight.w400),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 5),
            alignment: Alignment.topLeft,
            width: Get.width * 0.35,
            child: RoundedProgressBar(
              height: 10,
              style: RoundedProgressBarStyle(borderWidth: 0, widthShadow: 0),
              margin: const EdgeInsets.symmetric(vertical: 2),
              borderRadius: BorderRadius.circular(24),
              percent: double.parse("${20 * (barindex)}"),
            ),
          )
        ],
      ),
    );
  }

  String checkDate(DateTime createdAt) {
    String value = DateFormat("MM/dd/yy").format(createdAt).toString();
    return value;
  }
}
