import 'export_file.dart';

// ignore: must_be_immutable
class TopSection extends StatelessWidget {
  ProviderCompleteDetail provider;
  TopSection({required this.provider});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: Get.width * 0.58,
      // color: black,
      child: Column(children: [
        Flexible(
            flex: 2,
            child: Container(
              child: Stack(children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 50),
                  child: Container(
                    width: Get.width,
                    child: Image.asset(
                      'assets/profileImage/map.png',
                      width: Get.width,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey.shade300, shape: BoxShape.circle),
                    child: Container(
                      decoration: BoxDecoration(shape: BoxShape.circle),
                      child: ClipOval(
                        child: provider.image == null
                            ? Image(
                                image: AssetImage(
                                    "assets/user_assets/png/user.png"),
                                height: 100,
                                width: 100,
                              )
                            : cacheNetworkImage(
                                imageUrl:
                                    "${ApiUtills.imageBaseUrl + "${provider.image}"}",
                                // fit: BoxFit.cover,
                                imageWidth: 80,
                                imageHeight: 80),
                      ),
                    ),
                  ),
                ),
              ]),
            )),
        Flexible(
            flex: 1,
            child: Container(
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                Text(
                  "${provider.firstName} ${provider.lastName}",
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(
                  height: 3,
                ),
                FittedBox(
                  child: Text(
                    "${provider.providerServiceRequestsCount} Jobs Completed",
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(
                  height: 3,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.star,
                      size: 12,
                      color: Color(0xffFF9E45),
                    ),
                    SizedBox(
                      width: 1,
                    ),
                    FittedBox(
                      child: Text(
                        "${provider.rating ?? 0.0} ",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      width: 1,
                    ),
                    FittedBox(
                      child: Text(
                        "(${provider.userFeedbacksCount})",
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: 18,
                          color: Colors.black87,
                        ),
                        Text(
                          "${provider.providerProfile!.city}",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ],
                ),
              ]),
            ))
      ]),
    );
  }
}
