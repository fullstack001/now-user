import 'package:application_1/AllPages/payment/stripe.dart';
import 'package:application_1/model/service_response/provider_model.dart';
import 'package:application_1/model/service_response/service_list_data.dart';
import 'package:application_1/reuseableWidgets/reuseableSizedbox.dart';
import 'package:application_1/reuseableWidgets/reuseblueButton.dart';
import 'package:application_1/utils/AppColors.dart';
import 'package:application_1/utils/api_utils.dart';
import 'package:application_1/utils/app_dialog_utils.dart';
import 'package:application_1/utils/project_widget.dart';
import 'package:application_1/utils/widgest_utills.dart';
import 'package:application_1/widgets/rating_start.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../save_address_controller.dart';

class PlumberProfileView extends StatefulWidget {
  final data;
  final hasPayable;

  const PlumberProfileView({Key? key, this.data, this.hasPayable})
      : super(key: key);

  @override
  _PlumberProfileViewState createState() => _PlumberProfileViewState();
}

class _PlumberProfileViewState extends State<PlumberProfileView> {
  SaveAddressController _addressController = Get.put(SaveAddressController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.white,
          elevation: 0,
          title: Text(
            "Order Detail",
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back,
              color: AppColors.blue,
              size: 26,
            ),
          ),
        ),
        body: LayoutBuilder(
          builder: (context, size) {
            return ListView(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  child: Card(
                    child: Container(
                      padding: EdgeInsets.all(12),
                      width: size.maxWidth,
                      height: size.maxHeight * 0.218,
                      child: Column(
                        children: [
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    (widget.data as ServiceListData)
                                                .provider
                                                .image ==
                                            null
                                        ? Image.asset(
                                            'assets/images/img_profile_place_holder.jpg')
                                        : cacheNetworkImage(
                                            imageUrl: ApiUtills.imageBaseUrl +
                                                (widget.data as ServiceListData)
                                                    .provider
                                                    .image,
                                            radius: 60,
                                            imageWidth: 60,
                                            imageHeight: 60,
                                            placeHolder:
                                                'assets/images/img_profile_place_holder.jpg'),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                            "${getUserName((widget.data as ServiceListData).provider)}",
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
                                              ((widget.data as ServiceListData)
                                                          .provider
                                                          .rating ??
                                                      0)
                                                  .toString()),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                Icon(
                                  Icons.bookmark,
                                  size: 22,
                                  color: AppColors.grey,
                                )
                              ],
                            ),
                          ),
                          Expanded(
                              child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.location_on_rounded,
                                      size: 22,
                                      color: Colors.black38,
                                    ),
                                    if ((widget.data as ServiceListData)
                                            .provider
                                            .id !=
                                        null)
                                      Text(
                                        "${(widget.data as ServiceListData).provider.providerProfile['state']}",
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: AppColors.black54),
                                      )
                                  ],
                                ),
                                Text(
                                  "${checkProviderType((widget.data as ServiceListData).provider)}",
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
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Order details",
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ),
                      Container(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Your Order number",
                                style: TextStyle(
                                    fontWeight: FontWeight.w300, fontSize: 16),
                              ),
                              BuildSizedBox(9),
                              Container(
                                color: Colors.blueGrey.shade100,
                                child: Text(
                                  "${widget.data.id}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 16),
                                ),
                              ),
                            ],
                          )),
                      SizedBox(
                        height: 24,
                      ),
                      Container(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              getRow("Service",
                                  "${(widget.data as ServiceListData).subService}",
                                  textAlign: TextAlign.end),
                              SizedBox(
                                height: 12,
                              ),
                              if (widget.data.address != null)
                                getRow("Address",
                                    "${(widget.data as ServiceListData).address}",
                                    textAlign: TextAlign.end),
                              SizedBox(
                                height: 12,
                              ),
                              Text(
                                "Questions",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              getQuesttions(widget.data),
                              SizedBox(
                                height: 12,
                              ),
                              Text(
                                "Work done time",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              BuildSizedBox(9),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${(widget.data as ServiceListData).workedHours} hours",
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 16),
                                  ),
                                ],
                              )
                            ],
                          )),
                      /*Container(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Payment method",
                                style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 16),
                              ),
                              Container(
                                  child: ListTile(
                                leading: Image(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                      "assets/image 1.5x/mastercard.png"),
                                ),
                                title: Text(
                                  "Mastercard",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700),
                                ),
                                subtitle: Text(
                                  "...........2064",
                                  style: TextStyle(fontSize: 16),
                                ),
                              )),
                              Text(
                                "Billing",
                                style:
                                    TextStyle(fontWeight: FontWeight.w300),
                              ),
                            ],
                          )),*/
                      SizedBox(
                        height: 32,
                      ),
                      getRow(
                          "Request Hours",
                          double.parse((widget.data as ServiceListData).hours)
                              .toString()),
                      SizedBox(
                        height: 8,
                      ),
                      if (widget.hasPayable)
                        getRow("Extra Hours", getExtraHours(widget.data)),
                      if (widget.hasPayable)
                        SizedBox(
                          height: 8,
                        ),
                      getRow("Rate/Hour", "\$" + getPerHourRate(widget.data)),
                      SizedBox(
                        height: 8,
                      ),
                      getRow(
                          "Paid Amount",
                          "\$" +
                              double.parse((widget.data as ServiceListData)
                                      .paidAmount)
                                  .toString()),
                      if (widget.hasPayable)
                        SizedBox(
                          height: 8,
                        ),
                      if (widget.hasPayable)
                        getRow("Payable Amount", getPayableAmount(widget.data)),
                      /*  getRow("Discount", "- Rs 20.16"),
                      getRow("Tax", "Rs 10.16")*/
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Grand Total",
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                          Text(
                            getGrandTotal(widget.data),
                            style: TextStyle(
                                color: AppColors.blue,
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      if (widget.data.paymentStatus != 1)
                        ReuseableBlueButton(
                          w: size.maxWidth,
                          h: size.maxHeight,
                          onTap: () {
                            print("");
                            var dat = widget.data;
                            _addressController.getCreditCard(
                                onResponseGet: () async {
                              AppDialogUtils.dismiss();
                              Get.to(() => StripeModel(
                                    payableId: dat.payable.id,
                                    hide: true,
                                    data: widget.data,
                                  ));
                            });
                            // Get.offAllNamed("/tabScreen");
                          },
                          text: "Pay Now",
                        )
                    ],
                  ),
                ),
              ],
            );
          },
        ));
  }

  Row getRow(String title, price, {textAlign}) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.w300),
        ),
        SizedBox(
          width: 40,
        ),
        Expanded(
          child: Text(
            price,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontWeight: FontWeight.w700),
            textAlign: textAlign ?? TextAlign.end,
          ),
        ),
      ],
    );
  }

  checkProviderType(ProviderModel provider) {
    if (provider.providerProfile == null) {
      return "Quotation Base";
    }
    return provider.providerProfile['hourly_rate'] != null
        ? "\$${provider.providerProfile['hourly_rate']}/Hour "
        : "Quotation Base";
  }

  getPayableAmount(data) {
    ServiceListData value = data;
    double hours = double.parse(value.hours);
    double paidAmount = double.parse(value.paidAmount.toString());
    double perHrAmount = paidAmount / hours;
    double extraHours = double.parse(value.workedHours.toString()) - hours;
    double amountTobePaid = extraHours * perHrAmount;

    return "($extraHours * $perHrAmount) \$$amountTobePaid";
  }

  getPerHourRate(data) {
    ServiceListData value = data;
    double hours = double.parse(value.hours);
    double paidAmount = double.parse(value.paidAmount.toString());
    double perHrAmount = paidAmount / hours;
    double extraHours = double.parse(value.workedHours.toString()) - hours;
    double amountTobePaid = extraHours * perHrAmount;

    return "$perHrAmount";
  }

  getExtraHours(data) {
    ServiceListData value = data;
    double hours = double.parse(value.hours);
    double paidAmount = double.parse(value.paidAmount.toString());
    double perHrAmount = paidAmount / hours;
    double extraHours = double.parse(value.workedHours.toString()) - hours;
    double amountTobePaid = extraHours * perHrAmount;

    return "$extraHours";
  }

  String getGrandTotal(data) {
    ServiceListData value = data;
    double hours = double.parse(value.hours);
    double paidAmount = double.parse(value.paidAmount.toString());
    double perHrAmount = paidAmount / hours;
    double extraHours = double.parse(value.workedHours.toString()) - hours;
    double amountTobePaid = extraHours * perHrAmount;
    String amount =
        "($amountTobePaid + $paidAmount) \$${amountTobePaid + paidAmount}";

    if (!widget.hasPayable) {
      amount = "\$$paidAmount";
    }
    return amount;
  }

  getQuesttions(data) {
    ServiceListData value = data;
    return Column(
      children: [
        for (int index = 0; index < value.requestInfos.length; index++)
          Column(
            children: [
              getRow(value.requestInfos[index].question.question,
                  value.requestInfos[index].option.option),
              SizedBox(
                height: 12,
              )
            ],
          ),
      ],
    );
  }
}
