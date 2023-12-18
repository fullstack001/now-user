// import 'package:application_1/AllPages/ProjectPages/controller/home_screen_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class RespondDialog extends StatefulWidget {
//   final body;
//   final quotationInfo;
//   final response;
//
//   RespondDialog({Key key, this.body, this.quotationInfo, this.response})
//       : super(key: key);
//
//   @override
//   _RespondDialogState createState() => _RespondDialogState();
// }
//
// class _RespondDialogState extends State<RespondDialog> {
//   String selected = "1 Hour";
//   HomeScreenController _screenController = Get.find();
//   var descriptionNameController = TextEditingController();
//   var priceController = TextEditingController();
//   final _formKey = new GlobalKey<FormState>();
//
//   @override
//   Widget build(BuildContext context) {
//     var id = widget.body.id;
//
//     if (widget.quotationInfo != null) {
//       QuotationInfo info = widget.quotationInfo;
//
//       selected = info.duration;
//       descriptionNameController.text = info.reply;
//       priceController.text = "\$${info.price}";
//     }
//     String filterCheck = widget.body.status ?? "pending";
//     return Form(
//         key: _formKey,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               margin: EdgeInsets.all(32),
//               width: Get.width,
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.all(
//                   Radius.circular(12),
//                 ),
//               ),
//               child: Stack(
//                 alignment: Alignment.topRight,
//                 children: [
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Container(
//                         alignment: Alignment.center,
//                         padding: EdgeInsets.all(12),
//                         width: Get.width,
//                         child: Text(
//                           "Service Quotation",
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                       Divider(),
//                       Container(
//                         padding: EdgeInsets.all(12),
//                         width: Get.width,
//                         child: Row(
//                           children: [
//                             SizedBox(
//                               width: 12,
//                             ),
//                             Text(
//                               "Price",
//                               style: TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.normal,
//                               ),
//                             ),
//                             Expanded(
//                                 child: SizedBox(
//                               width: 10,
//                             )),
//                             Container(
//                               padding: EdgeInsets.only(
//                                   left: 16, right: 16, top: 8, bottom: 8),
//                               decoration: BoxDecoration(
//                                 color: Colors.grey[100],
//                                 borderRadius: BorderRadius.all(
//                                   Radius.circular(12),
//                                 ),
//                               ),
//                               child: Text(
//                                 "\$${(widget.quotationInfo as QuotationInfo).price}",
//                                 textAlign: TextAlign.end,
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.normal,
//                                 ),
//                               ),
//                             ),
//                             SizedBox(
//                               width: 12,
//                             ),
//                           ],
//                         ),
//                       ),
//                       Container(
//                         padding: EdgeInsets.all(12),
//                         width: Get.width,
//                         child: Row(
//                           children: [
//                             SizedBox(
//                               width: 12,
//                             ),
//                             Text(
//                               "Duration",
//                               style: TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.normal,
//                               ),
//                             ),
//                             Expanded(
//                                 child: SizedBox(
//                               width: 10,
//                             )),
//                             Container(
//                               padding: EdgeInsets.only(
//                                   left: 16, right: 16, top: 8, bottom: 8),
//                               decoration: BoxDecoration(
//                                 color: Colors.grey[100],
//                                 borderRadius: BorderRadius.all(
//                                   Radius.circular(12),
//                                 ),
//                               ),
//                               child: Text(
//                                 "${(widget.quotationInfo as QuotationInfo).duration}",
//                                 textAlign: TextAlign.end,
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.normal,
//                                 ),
//                               ),
//                             ),
//                             SizedBox(
//                               width: 12,
//                             )
//                           ],
//                         ),
//                       ),
//                       Container(
//                           margin: EdgeInsets.only(left: 24),
//                           child: Text(
//                             "Detail",
//                             style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.normal,
//                             ),
//                           )),
//                       Container(
//                         margin: EdgeInsets.only(
//                             top: 12, left: 24, right: 24, bottom: 24),
//                         width: Get.width,
//                         padding: EdgeInsets.all(12),
//                         decoration: BoxDecoration(
//                           color: Colors.grey[100],
//                           borderRadius: BorderRadius.all(
//                             Radius.circular(12),
//                           ),
//                         ),
//                         child: Text(
//                           "${(widget.quotationInfo as QuotationInfo).reply}",
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.normal,
//                           ),
//                         ),
//                       ),
//                       Row(
//                         children: [
//                           SizedBox(
//                             width: 12,
//                           ),
//                           if (widget.body.status.toString().toLowerCase() ==
//                                   "rejected" ||
//                               widget.body.status.toLowerCase() == "pending")
//                             Expanded(
//                               child: Row(
//                                 children: [
//                                   Expanded(
//                                     child: InkWell(
//                                       onTap: () {
//                                         // if (widget.body.status.toLowerCase() !=
//                                         //     "rejected") {
//                                         _screenController.updateStatus(
//                                           widget.body.id,
//                                           "REJECTED",
//                                           newStatus: (value) {
//                                             if (widget.response != null) {
//                                               widget.response(value);
//                                             }
//                                             Get.back();
//                                           },
//                                         );
//                                         // }
//                                       },
//                                       child: Container(
//                                         alignment: Alignment.center,
//                                         width: double.infinity,
//                                         height: 47,
//                                         decoration: BoxDecoration(
//                                             color: Colors.redAccent,
//                                             borderRadius:
//                                                 BorderRadius.circular(10)),
//                                         child: Text("Reject",
//                                             style: TextStyle(
//                                                 color: Colors.white,
//                                                 fontSize: 18,
//                                                 fontWeight: FontWeight.normal)),
//                                       ),
//                                     ),
//                                   ),
//                                   if (filterCheck != "rejected")
//                                     SizedBox(
//                                       width: 12,
//                                     ),
//                                 ],
//                               ),
//                             ),
//                           if (widget.body.status.toString().toLowerCase() ==
//                                   "accepted" ||
//                               widget.body.status.toLowerCase() == "pending")
//                             Expanded(
//                               child: InkWell(
//                                 onTap: () {
//                                   // if (widget.body.status.toLowerCase() !=
//                                   //     "accepted") {
//                                   _screenController.updateStatus(
//                                     widget.body.id,
//                                     "ACCEPTED",
//                                     newStatus: (value) {
//                                       if (widget.response != null) {
//                                         widget.response(value);
//                                       }
//                                       Get.back();
//                                     },
//                                   );
//                                   // }
//                                 },
//                                 child: Container(
//                                   alignment: Alignment.center,
//                                   width: double.infinity,
//                                   height: 47,
//                                   decoration: BoxDecoration(
//                                       color: Color(0xff40C08C),
//                                       borderRadius: BorderRadius.circular(10)),
//                                   child: Text(
//                                       widget.body.status.toLowerCase() ==
//                                               "accepted"
//                                           ? widget.body.status
//                                           : "Pass",
//                                       style: TextStyle(
//                                           color: Colors.white,
//                                           fontSize: 18,
//                                           fontWeight: FontWeight.normal)),
//                                 ),
//                               ),
//                             ),
//                           SizedBox(
//                             width: 12,
//                           ),
//                         ],
//                       ),
//                       SizedBox(
//                         height: 20,
//                       )
//                     ],
//                   ),
//                   InkWell(
//
//                     onTap: () {
//                       Get.back();
//                     },
//                     child: Icon(Icons.cancel),
//                   )
//                 ],
//               ),
//             ),
//           ],
//         ));
//   }
// }
