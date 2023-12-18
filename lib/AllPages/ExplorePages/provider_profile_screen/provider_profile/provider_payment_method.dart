import 'package:application_1/AllPages/ExplorePages/shopMenu.dart';
import 'package:application_1/utils/AppColors.dart';
import 'package:nb_utils/nb_utils.dart';

import 'export_file.dart';

class ProviderPaymentMethod extends StatelessWidget {
  List<PaymentMethod> paymentMethod;
  ProviderPaymentMethod({Key? key, required this.paymentMethod})
      : super(key: key);
  final List<String> _images = [
    "assets/profileImage/cash.png",
    "assets/profileImage/zelle.png",
    "assets/profileImage/stripe.png",
    "assets/profileImage/googlePay.png",
    "assets/profileImage/ApplePay.png",
    "assets/profileImage/cashApp.png",
    "assets/profileImage/venmo.png",
    "assets/profileImage/paypal.png",
    "assets/profileImage/visa.png"
  ];
  @override
  Widget build(BuildContext context) {
    return GetMainCardColum(widget: [
      const Text(
        "Payment Methods",
        style: TextStyle(
            color: Color(0xff151415),
            fontSize: 20,
            fontWeight: FontWeight.w500),
      ),
      12.height,
      Align(
        alignment: Alignment.center,
        child: Container(
          height: 100,
          width: Get.width,
          child: ListView(
              scrollDirection: Axis.horizontal,
              children: List.generate(
                paymentMethod.length,
                (index) => GestureDetector(
                  onTap: () {},
                  child: FittedBox(
                    child: Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14)),
                      child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 18, vertical: 6),
                          // width: Get.width / 4.3,
                          // height: Get.width / 8.3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              FittedBox(
                                child: paymentMethod[index].icon == null
                                    ? const Image(
                                        image: AssetImage(
                                            "assets/profileImage/imgPlaceholder.png"),
                                        height: 70,
                                        width: 100,
                                      )
                                    : cacheNetworkImage(
                                        placeHolder:
                                            "assets/profileImage/imgPlaceholder.png",
                                        imageUrl:
                                            "${ApiUtills.imageBaseUrl}${paymentMethod[index].icon}",
                                        fit: BoxFit.fitWidth,
                                        imageWidth: 100,
                                        imageHeight: 70),
                              ),
                              5.height,
                              Text(
                                "${paymentMethod[index].name}",
                                style: TextStyle(color: AppColors.black),
                              ),
                            ],
                          )),
                    ),
                  ),
                ),
              )),
        ),
      ),
    ]);
  }
}
