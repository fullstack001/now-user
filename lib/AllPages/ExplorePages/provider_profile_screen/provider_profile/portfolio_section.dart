import 'package:application_1/AllPages/ExplorePages/shopMenu.dart';
import 'package:application_1/utils/AppColors.dart';

import 'export_file.dart';

// ignore: must_be_immutable
class PortFolioSection extends StatefulWidget {
  List<Portfolio> portfolios;
  PortFolioSection({Key? key, required this.portfolios}) : super(key: key);

  @override
  State<PortFolioSection> createState() => _PortFolioSectionState();
}

class _PortFolioSectionState extends State<PortFolioSection> {
  final ScrollController _controller = ScrollController();

  final double _height = 180.0;
  int indexIncreament = 0;
  void _animateToIndex(int index) {
    _controller.animateTo(
      index * _height,
      duration: Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  void initState() {
    indexIncreament = 0;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMainCardColum(widget: [
      Container(
        width: Get.width,
        height: _height,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            controller: _controller,
            itemCount: widget.portfolios.length,
            itemBuilder: ((context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: Get.width / 2.7,
                  child: FittedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Card(
                          color: Colors.grey.shade200,
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14)),
                          child: Container(
                            width: Get.width / 2.7,
                            height: 100,
                            child: Padding(
                                padding: const EdgeInsets.all(9),
                                child: widget.portfolios[index].image == null
                                    ? Image(
                                        image: AssetImage(
                                            'assets/images/img_profile_place_holder.jpg'),
                                        height: 100,
                                        width: 100,
                                      )
                                    : cacheNetworkImage(
                                        placeHolder:
                                            "assets/images/img_profile_place_holder.jpg",
                                        imageUrl:
                                            "${ApiUtills.imageBaseUrl + "${widget.portfolios[index].image}"}",
                                      )),
                          ),
                        ),
                        widget.portfolios[index].description != null
                            ? Padding(
                                padding: const EdgeInsets.only(top: 8, left: 8),
                                child: FittedBox(
                                    child: Text(
                                  "${widget.portfolios[index].description}",
                                  style: TextStyle(
                                      color: Color(0xff151415),
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                )),
                              )
                            : Container()
                      ],
                    ),
                  ),
                ),
              );
            })),
      ),
      Divider(
        color: Colors.black45,
      ),
      SizedBox(
        height: 5,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              if (indexIncreament > 0) {
                setState(() {
                  indexIncreament--;
                });
                _animateToIndex(indexIncreament);
              }
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12),
              // width: 100,
              height: 40,
              decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.arrow_back_ios,
                      size: 16,
                      color: Colors.black45,
                    ),
                    Text("Previous")
                  ]),
            ),
          ),
          Text("${indexIncreament + 2} of ${widget.portfolios.length}"),
          GestureDetector(
            onTap: () {
              if (indexIncreament < widget.portfolios.length) {
                setState(() {
                  indexIncreament++;
                });
                _animateToIndex(indexIncreament);
              }
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12),
              height: 40,
              decoration: BoxDecoration(
                  color: AppColors.darkBlue,
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
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
    ]);
  }
}
