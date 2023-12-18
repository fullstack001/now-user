import 'package:application_1/AllPages/payment/stripe.dart';
import 'package:application_1/model/notification/notification_response.dart';
import 'package:application_1/model/service_response/service_list_data.dart';
import 'package:application_1/utils/widgest_utills.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PayableWidget extends StatefulWidget {
  final data;
  final onPayClick;
  final payableId;
  final model;

  PayableWidget(
      {Key? key, this.data, this.onPayClick, this.payableId, this.model})
      : super(key: key);

  @override
  _PayableWidgetState createState() => _PayableWidgetState();
}

class _PayableWidgetState extends State<PayableWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: Get.width,
            margin: EdgeInsets.only(left: 24, right: 24),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              ),
            ),
            child: Column(
              children: [
                Text(
                  "Invoice",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Divider(),
                rowWidget("Requested Hours :",
                    double.parse("${widget.model.hours}").toString()),
                SizedBox(
                  height: 8,
                ),
                rowWidget("Worked Hours :",
                    double.parse("${widget.model.workedHours}").toString()),
                SizedBox(
                  height: 8,
                ),
                rowWidget("Extra Hours :", getExtraHours(widget.model)),
                SizedBox(
                  height: 8,
                ),
                rowWidget("Paid Amount :",
                    "\$" + double.parse(widget.model.paidAmount).toString()),
                SizedBox(
                  height: 8,
                ),
                rowWidget(
                    "Per Hour Rate :", "\$" + getPerHourRate(widget.model)),
                SizedBox(
                  height: 8,
                ),
                rowWidget("Payable Amount :", getPayableAmount(widget.model)),
                SizedBox(
                  height: 24,
                ),
                customButton(
                    title: "Pay Now",
                    textColor: Colors.white,
                    onTap: () {
                      // if (widget.onPayClick != null) {
                      //   widget.onPayClick();
                      // }
                      Get.back();
                      Get.dialog(StripeModel(
                        data: widget.data,
                        payableId: widget.payableId,
                        onPageChange: (value) {},
                      ));
                    })
              ],
            ),
          )
        ],
      ),
    );
  }

  rowWidget(child1, child2) {
    return Row(
      children: [
        SizedBox(
          width: 12,
        ),
        Text(
          child1,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Spacer(),
        Text(child2, style: TextStyle(fontSize: 16)),
        SizedBox(
          width: 12,
        ),
      ],
    );
  }

  getPayableAmount(NotificationResponseData value) {
    double hours = double.parse(value.hours ?? "0");
    double paidAmount = double.parse(value.paidAmount.toString());
    double perHrAmount = paidAmount / hours;
    double extraHours = double.parse(value.workedHours.toString()) - hours;
    double amountTobePaid = extraHours * perHrAmount;

    return "($extraHours * $perHrAmount) \$$amountTobePaid";
  }

  getPerHourRate(data) {
    NotificationResponseData value = data;
    double hours = double.parse(value.hours ?? "0");
    double paidAmount = double.parse(value.paidAmount ?? "");
    double perHrAmount = paidAmount / hours;
    double extraHours = double.parse(value.workedHours ?? "") - hours;
    double amountTobePaid = extraHours * perHrAmount;

    return "$perHrAmount";
  }

  getExtraHours(NotificationResponseData data) {
    double hours = double.parse(data.hours ?? "");
    double paidAmount = double.parse(data.paidAmount ?? "");
    double perHrAmount = paidAmount / hours;
    double extraHours = double.parse(data.workedHours.toString()) - hours;
    double amountTobePaid = extraHours * perHrAmount;

    return "$extraHours";
  }
}
