import 'package:application_1/components/buttons-management/part_of_file/part.dart';
import 'package:application_1/utils/AppColors.dart';
import 'package:nb_utils/nb_utils.dart';

class InvoiceOfPayment extends StatelessWidget {
  var onSubmit;
  var discount;
  var hourlyRate;
  var hours;
  var serviceName;
  var providerName;
  var isPakcage;
  var address;
  InvoiceOfPayment(
      {super.key,
      this.onSubmit,
      this.discount,
      this.hourlyRate,
      this.hours,
      this.serviceName,
      this.providerName,
      this.address,
      required this.isPakcage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconTheme.of(context).copyWith(color: black),
        backgroundColor: white,
        title: const Text(
          "Order Summary",
          style: TextStyle(
              color: black, fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
                child: Column(
                  children: [
                    12.height,
                    getList(name: "Service", title: "${serviceName}"),
                    getList(name: "Provider", title: "${providerName}"),
                    getList(name: "Hourly Rate", title: "${hourlyRate}"),

                    isPakcage
                        ? getList(name: "Discount", title: "${discount}%")
                        : Container(),
                    getList(name: "Work Hours", title: "${hours}"),
                    getList(name: "Address", title: "${address}"),
                    // getList(
                    //     name: "Service:", title: "Commercial Cleaning Service"),
                    Container(
                      decoration: const BoxDecoration(
                          color: Color(0xff3B5998),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(18),
                              bottomRight: Radius.circular(18))),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Total (USD):",
                              style: TextStyle(
                                  color: white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                            isPakcage
                                ? Text(
                                    "\$${getTotal(discount, hourlyRate, hours)}",
                                    style: const TextStyle(
                                        color: white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  )
                                : Text(
                                    "\$${(hourlyRate * hours)}",
                                    style: const TextStyle(
                                        color: white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ),
                          ],
                        ),
                      ),
                    )
                  ],
                )),
          ),
          FarenowButton(
              title: "Submit",
              onPressed: onSubmit,
              type: BUTTONTYPE.rectangular),
          // Padding(
          //   padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       Flexible(
          //         child: FarenowButton(
          //             style: FarenowButtonStyleModel(
          //                 padding: EdgeInsets.symmetric(horizontal: 6),
          //                 buttonColor: Colors.grey.shade100),
          //             title: "Previous",
          //             onPressed: () {
          //               Get.back();
          //             },
          //             type: BUTTONTYPE.outline),
          //       ),
          //       Flexible(
          //         child: FarenowButton(
          //             style: FarenowButtonStyleModel(
          //                 padding: EdgeInsets.symmetric(horizontal: 6)),
          //             title: "Submit",
          //             onPressed: onSubmit,
          //             type: BUTTONTYPE.rectangular),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }

  getList({name, title}) {
    return Container(
      color: white,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "$name",
                  style: const TextStyle(
                      color: black, fontSize: 14, fontWeight: FontWeight.w400),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  width: Get.width * 0.35,
                  child: Text(
                    "$title",
                    style: const TextStyle(
                        color: black,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            thickness: 1,
          )
        ],
      ),
    );
  }
}

String getTotal(int discount, double hourlyRate, int hours) {
  double _hours = (hourlyRate * hours).toDouble();
  double _percentage = (_hours / (100 / discount));
  String _total = (_hours - _percentage).toStringAsFixed(2);
  return _total.toString();
}
