import 'dart:convert';

import 'package:application_1/AllPages/ExplorePages/Controllers/profile_controller.dart';
import 'package:application_1/AllPages/introPages/intro_controller.dart';
// import 'package:application_1/keyboard_overlay/src/components/done_button_ios.dart';
// import 'package:application_1/keyboard_overlay/src/components/utils/top_keyboard_util.dart';
// import 'package:application_1/keyboard_overlay/src/handle_focus_nodes_overlay_mixin.dart';
import 'package:application_1/remote_model/service_questions/service_question_questions.dart';
import 'package:application_1/utils/AppColors.dart';
import 'package:application_1/utils/app_dialog_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatRequestWidget extends StatefulWidget {
  final providerId;
  final onRequested;

  ChatRequestWidget({Key? key, this.providerId, this.onRequested})
      : super(key: key);

  @override
  _ChatRequestWidgetState createState() => _ChatRequestWidgetState();
}

class _ChatRequestWidgetState extends State<ChatRequestWidget> {
  var _requestTextController = TextEditingController();
  final IntroController _controller = Get.find();
  ProfileScreenController _profileScreenController = Get.find();

  var detailNode = FocusNode();

  @override
  void initState() {
    // if (GetPlatform.isIOS) {
    //   detailNode = GetFocusNodeOverlay(
    //       child: TopKeyboardUtil(
    //     DoneButtonIos(
    //       label: 'Done',
    //       onSubmitted: () => Get.focusScope!.unfocus(),
    //       platforms: ['android', 'ios'],
    //     ),
    //   ));
    // }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 24, right: 24),
          width: Get.width,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: Get.width,
                height: 45,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(12),
                      topLeft: Radius.circular(12)),
                  color: AppColors.solidBlue,
                ),
                alignment: Alignment.center,
                child: const Text(
                  "Chat Request",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Container(
                width: Get.width,
                margin: const EdgeInsets.only(left: 12),
                child: const Text(
                  "Request detail:",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Container(
                width: Get.width,
                height: 200,
                margin: const EdgeInsets.only(left: 12, right: 12),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                    border: Border.all(color: Colors.grey)),
                child: TextField(
                  onSubmitted: (val) {
                    if (val.isNotEmpty) {
                      _onSubmited();
                    }
                  },
                  maxLines: 20,
                  focusNode: detailNode,
                  controller: _requestTextController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    hintText: "Enter Request detail here...",
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              MaterialButton(
                padding: const EdgeInsets.only(left: 12, right: 12),
                onPressed: _onSubmited,
                child: Container(
                  width: Get.width,
                  height: 45,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: AppColors.solidBlue,
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  child: const Text(
                    "Send Request",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _onSubmited() {
    Get.focusScope!.unfocus();
    if (_requestTextController.text.isEmpty) {
      alertDialog(
          title: "Alert",
          content: "Please enter request detail",
          confirm: MaterialButton(
            child: const Text("Okay"),
            onPressed: () {
              Get.back();
            },
          ));
      return;
    }

    String message = _requestTextController.text;
    String providerId = widget.providerId;
    Map body = <String, dynamic>{"provider_id": providerId, "message": message};
    List<ServiceQuestionQuestions> question = _controller
        .resp.value.serviceQuestionQuestions
        .cast<ServiceQuestionQuestions>();
    Map questions = <String, dynamic>{};
    List<String> optionList = <String>[];
    int indexOfQuestion = -1;

    for (int index = 0; index < (question).length; index++) {
      optionList = [];
      for (int qIndex = 0;
          qIndex < question[index].serviceQuestionOptions.length;
          qIndex++) {
        if (question[index].serviceQuestionOptions[qIndex].selected) {
          optionList.add(
              question[index].serviceQuestionOptions[qIndex].id.toString());
          indexOfQuestion = question[index].id;
        }
      }
      if (indexOfQuestion > -1) {
        List<String> _optionList = <String>[];
        _optionList.assignAll(optionList);
        questions["question_${indexOfQuestion.toString()}"] = _optionList;
      }
    }
    body["questions"] = questions;
    _profileScreenController.sendChatRequest(body, question,
        onRequested: widget.onRequested);
  }
}
