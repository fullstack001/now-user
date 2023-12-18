import 'package:application_1/AllPages/ExplorePages/payment_screen/CardEdit.dart';
import 'package:application_1/utils/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../payment/stripe.dart';
import '../AddCardDetails.dart';

class SelectMethod extends StatefulWidget {
  var body;
  var formService;
  SelectMethod({super.key, this.formService, this.body});

  @override
  State<SelectMethod> createState() => _SelectMethodState();
}

class _SelectMethodState extends State<SelectMethod> {
  String selected = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE0E0E0).withOpacity(0.4),
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0,
        title: Text(
          "Payment",
          style: Theme.of(context).textTheme.headline6,
        ),
        iconTheme: IconTheme.of(context).copyWith(color: black),
      ),
      body: Column(children: [
        22.height,
        Text(
          "Select Payment Method",
          style: Theme.of(context).textTheme.headline6,
        ),
        22.height,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 6),
          child: GestureDetector(
            onTap: () {
              setState(() {
                selected = "VISA";
              });
              if (widget.formService) {
                Get.to(() => StripeModel(
                      body: widget.body,
                      hide: true,
                      fromService: true,
                      onPageChange: (value) {},
                    ));
              } else {
                Get.to(AddCardDetails(
                  method: selected,
                ));
              }
            },
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: BorderSide(color: Color(0xffE0E0E0))),
              child: Padding(
                padding: const EdgeInsets.all(22.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 28,
                            height: 28,
                            decoration: BoxDecoration(
                                color: white,
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: selected == "VISA"
                                        ? AppColors.solidBlue
                                        : Color(0xffE0E0E0),
                                    width: selected == "VISA" ? 8 : 1)),
                          ),
                          6.width,
                          FittedBox(
                            child: Text("Debit/Credit Card",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xff555555),
                                    fontWeight: FontWeight.w400)),
                          ),
                        ],
                      ),
                      FittedBox(
                          child: Image.asset(
                        "assets/user_assets/png/VISA.png",
                        width: 100,
                        height: 40,
                      ))
                    ]),
              ),
            ),
          ),
        ),
        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 6),
        //   child: GestureDetector(
        //     onTap: () {
        //       setState(() {
        //         selected = "PAYPAL";
        //       });
        //       // Get.to(AddCardDetails(
        //       //   method: selected,
        //       // ));
        //     },
        //     child: Card(
        //       shape: RoundedRectangleBorder(
        //           borderRadius: BorderRadius.circular(16),
        //           side: BorderSide(color: Color(0xffE0E0E0))),
        //       child: Padding(
        //         padding: const EdgeInsets.all(22.0),
        //         child: Row(
        //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //             children: [
        //               Row(
        //                 children: [
        //                   Container(
        //                     width: 28,
        //                     height: 28,
        //                     decoration: BoxDecoration(
        //                         color: white,
        //                         shape: BoxShape.circle,
        //                         border: Border.all(
        //                             color: selected == "PAYPAL"
        //                                 ? AppColors.solidBlue
        //                                 : Color(0xffE0E0E0),
        //                             width: selected == "PAYPAL" ? 8 : 1)),
        //                   ),
        //                   6.width,
        //                   FittedBox(
        //                     child: Text("Paypal",
        //                         style: TextStyle(
        //                             fontSize: 16,
        //                             color: Color(0xff555555),
        //                             fontWeight: FontWeight.w400)),
        //                   ),
        //                 ],
        //               ),
        //               FittedBox(
        //                   child: Image.asset(
        //                 "assets/user_assets/png/PAYPAL.png",
        //                 width: 100,
        //                 height: 40,
        //               ))
        //             ]),
        //       ),
        //     ),
        //   ),
        // ),
      ]),
    );
  }
}
