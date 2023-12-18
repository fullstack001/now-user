import 'package:application_1/utils/AppColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class ServiceHistoryDetailView extends StatefulWidget {
  ServiceHistoryDetailView({Key? key}) : super(key: key);

  @override
  _ServiceHistoryDetailViewState createState() =>
      _ServiceHistoryDetailViewState();
}

class _ServiceHistoryDetailViewState extends State<ServiceHistoryDetailView> {
  Color black = AppColors.black;
  Color white = AppColors.white;
  Color blue = AppColors.blue;
  Color grey = AppColors.grey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: grey,
      appBar: AppBar(
        backgroundColor: white,
        elevation: 1,
        textTheme: Theme.of(context).textTheme,
        title: Text("Book this provider"),
        leading: Icon(
          Icons.close,
          color: black,
          size: 22,
        ),
      ),
      body: LayoutBuilder(
        builder: (context, size) {
          print(size.maxHeight * 0.55);
          return ConstrainedBox(
            constraints: BoxConstraints(minHeight: size.maxHeight),
            child: Column(
              children: [
                Container(
                    width: size.maxWidth,
                    height: size.maxHeight * 0.2,
                    color: white,
                    child: Card(
                      child: Container(
                        padding: EdgeInsets.all(15),
                        width: size.maxWidth,
                        height: size.maxHeight * 0.218,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 4,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 62,
                                        height: 62,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    "assets/image 2x/dp.png"))),
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Jaylon Schliefer",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1,
                                          ),
                                          Text(
                                            "Jaylon Schliefer",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w300),
                                          ),
                                          SmoothStarRating(
                                              defaultIconData: Icons.star,
                                              allowHalfRating: false,
                                              onRated: (v) {},
                                              starCount: 5,
                                              rating: 3.1,
                                              size: 15.0,
                                              isReadOnly: true,
                                              filledIconData: Icons.star,
                                              halfFilledIconData:
                                                  Icons.star_half,
                                              color: Colors.blue,
                                              borderColor: Colors.grey,
                                              spacing: 0.0),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Icon(
                                    Icons.bookmark,
                                    size: 22,
                                    color: grey,
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                                flex: 2,
                                child: Container(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.location_on_rounded,
                                            size: 22,
                                            color: Colors.black38,
                                          ),
                                          Text(
                                            "Nww York",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(
                                                    color: Colors.black38),
                                          )
                                        ],
                                      ),
                                      Text(
                                        "\$50/Hour",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(color: Colors.black38),
                                      )
                                    ],
                                  ),
                                ))
                          ],
                        ),
                      ),
                    )),
              ],
            ),
          );
        },
      ),
    );
  }
}
