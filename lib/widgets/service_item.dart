import 'package:application_1/AllPages/ExplorePages/sub_service_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ServiceItem extends StatelessWidget {
  final allServices;

  ServiceItem({
    Key? key,
    this.allServices,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: Get.height,
      child: gridViews(
          columnSpan: 2,
          flex: 1,
          itemCount: getLength(allServices.subServices.length)
              ? allServices.subServices.length + 1
              : allServices.subServices.length,
          builder: (int index, int span) {
            return getLength(allServices.subServices.length) &&
                    index == allServices.subServices.length
                ? Container()
                : Container(
                    margin: EdgeInsets.only(
                        top: index <= 1 ? 24 : 0,
                        right: 12,
                        left: index.isEven ? 12 : 0,
                        bottom: 24),
                    child: SubServiceItem(
                      index: index,
                      imagewidth: Get.width,
                      subService: allServices.subServices[index],
                      allServices: allServices,
                    ),
                  );
          }),
    );
  }



  getLength(length) {
    int size = allServices.subServices.length;
    if (size.isOdd) {
      return true;
    }
    return false;
  }
}
Widget gridViews({builder, columnSpan, itemCount, flex}) {
  columnSpan = columnSpan ?? 0;
  itemCount = itemCount ?? 0;
  int count = 0;
  return Container(
    width: Get.width,
    height: Get.height,
    child: ListView(
      children: [
        for (int index = 0; index < itemCount / columnSpan; index++)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (int indexI = 0; indexI < columnSpan; indexI++, count++)
                if (count < itemCount)
                  Expanded(
                    flex: flex ?? 0,
                    child: builder(count, columnSpan),
                  )
            ],
          )
      ],
    ),
  );
}