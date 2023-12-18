import 'package:application_1/AllPages/RegisteraionPages/Controllers/RegistrationController.dart';
import 'package:application_1/remote_model/provider_list/portfolio_model.dart';
import 'package:application_1/utils/api_utils.dart';
import 'package:application_1/utils/widgest_utills.dart';
import 'package:application_1/widgets/custom_container.dart';
import 'package:application_1/widgets/text_with_icon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImagePerviewScreen extends StatelessWidget {
  var data;

  ImagePerviewScreen({Key? key, this.data}) : super(key: key);
  final RegistrationController _registrationController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.5),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Obx(() => CustomContainer(
                width: Get.width,
                alignment: Alignment.center,
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Column(
                      children: [
                        CustomContainer(
                          width: Get.width,
                          height: Get.width,
                          marginLeft: 24,
                          marginRight: 24,
                          child: cacheNetworkImage(
                              imageUrl:
                                  "${ApiUtills.imageBaseUrl}${data.portfolioImages[_registrationController.currentIndex.value].url}",
                              imageWidth: Get.width,
                              imageHeight: Get.width,
                              fit: BoxFit.cover,
                              placeHolder: 'assets/images/img_gallery.png'),
                        ),
                        TextWithIcon(
                          width: Get.width,
                          marginLeft: 24,
                          marginRight: 24,
                          fontSize: 15,
                          flex: 1,
                          maxLine: 4,
                          overFlow: TextOverflow.ellipsis,
                          fontColor: Colors.white,
                          title:
                              "${data.portfolioImages[_registrationController.currentIndex.value].description}",
                        ),
                        CustomContainer(
                          width: Get.width,
                          height: Get.width / 4,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              for (int index = 0;
                                  index < data.portfolioImages.length;
                                  index++)
                                CustomContainer(
                                  marginTop: 12,
                                  marginLeft: index == 0 ? 24 : 6,
                                  marginRight:
                                      index == (data.portfolioImages.length) - 1
                                          ? 24
                                          : 6,
                                  child: CustomContainer(
                                    onTap: () {
                                      _registrationController
                                          .currentIndex(index);
                                      _registrationController.currentIndex
                                          .refresh();
                                    },
                                    width: (Get.width / 4) - 24,
                                    height: (Get.width / 4) - 24,
                                    borderColor: _registrationController
                                                .currentIndex.value ==
                                            index
                                        ? Colors.white
                                        : Colors.transparent,
                                    paddingAll: 4,
                                    borderWidth: 1,
                                    allRadius: Get.width / 3,
                                    child: cacheNetworkImage(
                                        imageUrl:
                                            "${ApiUtills.imageBaseUrl}${data.portfolioImages[index].url}",
                                        imageWidth: (Get.width / 4) - 24,
                                        imageHeight: (Get.width / 4) - 24,
                                        radius: Get.width / 3,
                                        placeHolder:
                                            'assets/images/img_gallery.png'),
                                  ),
                                )
                            ],
                          ),
                        )
                      ],
                    ),
                    CustomContainer(
                      onTap: () {
                        Get.back();
                      },
                      marginRight: 24,
                      width: 24,
                      height: 24,
                      child: Icon(
                        Icons.cancel,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
