import 'dart:async';

import 'package:application_1/AllPages/ExplorePages/shopMenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> with SingleTickerProviderStateMixin {
  bool selected = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("initState");
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      print("WidgetsBinding");
    });
    SchedulerBinding.instance.addPostFrameCallback((_) {
      print("SchedulerBinding");
    });
    print("called firest");
    return Scaffold(
        appBar: AppBar(
          title: const Text("Moon"),
        ),
        body: GestureDetector(
            onLongPress: () {
              setState(() {
                selected = true;
              });
            },
            onTap: () {
              setState(() {
                selected = false;
              });
            },
            child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Text(
                    "$index",
                    style: TextStyle(color: black),
                  );
                })));
  }
}

typedef void OnWidgetSizeChange(Size size);

class MeasureSizeRenderObject extends RenderProxyBox {
  Size? oldSize;
  OnWidgetSizeChange onChange;

  MeasureSizeRenderObject(this.onChange);

  @override
  void performLayout() {
    super.performLayout();

    Size newSize = child!.size;
    if (oldSize == newSize) return;

    oldSize = newSize;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onChange(newSize);
    });
  }
}

class MeasureSize extends SingleChildRenderObjectWidget {
  final OnWidgetSizeChange onChange;

  const MeasureSize({
    Key? key,
    required this.onChange,
    required Widget child,
  }) : super(key: key, child: child);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return MeasureSizeRenderObject(onChange);
  }

  @override
  void updateRenderObject(
      BuildContext context, covariant MeasureSizeRenderObject renderObject) {
    renderObject.onChange = onChange;
  }
}
//  ChatBubble(
//             padding: const EdgeInsets.all(4.0),
//             backGroundColor: Colors.greenAccent,
//             clipper: ChatBubbleClipper6(
//               type: BubbleType.receiverBubble,
//               nipSize: 5.0,
//             ),
//             child: Container(
//               padding: const EdgeInsets.symmetric(
//                 horizontal: 5.0,
//                 vertical: 4.0,
//               ),
//               decoration: BoxDecoration(
//                 color: Colors.greenAccent,
//                 borderRadius: BorderRadius.circular(
//                   8.0,
//                 ),
//               ),
//               child: Column(
//                 children: [
//                   Container(
//                     decoration: BoxDecoration(
//                       color: Colors.lightGreen,
//                       borderRadius: BorderRadius.circular(
//                         8.0,
//                       ),
//                     ),
//                     child: Column(
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             Flexible(
//                               fit: FlexFit.tight,
//                               child: Container(
//                                 decoration: const BoxDecoration(
//                                   color: Colors.red,
//                                   borderRadius: BorderRadius.only(
//                                     bottomLeft: Radius.circular(
//                                       8.0,
//                                     ),
//                                     topLeft: Radius.circular(
//                                       8.0,
//                                     ),
//                                   ),
//                                 ),
//                                 width: 7.0,
//                               ),
//                             ),
//                             Expanded(
//                               child: Padding(
//                                 padding: const EdgeInsets.all(6.0),
//                                 child: Column(
//                                   crossAxisAlignment:
//                                       CrossAxisAlignment.start,
//                                   children: const [
//                                     Text(
//                                       "Title",
//                                       style: TextStyle(
//                                         fontSize: 18.0,
//                                         color: Colors.red,
//                                       ),
//                                     ),
//                                     Text(
//                                       "SubTitle",
//                                       style: TextStyle(
//                                         fontSize: 14.0,
//                                         color: Colors.black,
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             )
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Column(
//                       children: const [
//                         Text("Text message."),
//                         SizedBox(
//                           height: 5.0,
//                         ),
//                         Align(
//                           alignment: Alignment.bottomRight,
//                           child: Text("12:56 PM"),
//                         )
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
