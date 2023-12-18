import 'package:application_1/AllPages/ExplorePages/shopMenu.dart';
import 'package:application_1/utils/widgest_utills.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class AppDialogUtils {
  static dialogLoading({msg}) {
    EasyLoading.show(status: msg ?? "Please wait..", dismissOnTap: true);
  }

  static errorDialog(String msg) {
    EasyLoading.showError(msg, duration: Duration(seconds: 2));
  }

  static successDialog(String msg) {
    EasyLoading.showSuccess(msg, duration: Duration(seconds: 3));
  }

  static dismiss() {
    EasyLoading.dismiss();
  }
}

alertDialog({title, content, confirm, cancel}) {
  Get.defaultDialog(
    title: title,
    content: Text(
      content,
      textAlign: TextAlign.center,
    ),
    confirmTextColor: Colors.black,
    confirm: confirm == null ? emptyContainer : confirm,
    cancel: confirm == null ? emptyContainer : cancel,
  );
}

getQuestionOptionFormat(List question) {
  String questions = "";
  List<int> qsts = [];
  String qst = "";

  for (int index = 0; index < question.length; index++) {
    for (int qIndex = 0;
        qIndex < question[index].serviceQuestionOptions.length;
        qIndex++) {
      if (question[index].serviceQuestionOptions[qIndex].selected) {
        if (question[index].is_multiple == 0) {
          qst =
              "\"question_${question[index].id}\":${question[index].serviceQuestionOptions[qIndex].id}";
        } else {
          qsts.add(question[index].serviceQuestionOptions[qIndex].id);
        }
      }
    }
    if (question[index].is_multiple == 0) {
      questions = questions + "${index == 0 ? "" : ", "}$qst";
      print(questions);
    } else {
      qst = "\"question_${question[index].id}\":$qsts";
      questions = questions + "${index == 0 ? "" : ", "}$qst";
      print(questions);
    }
  }
  return questions;
}

selectedImageView(image, {required onTap, height, width, cross, index}) {
  bool hideCross = cross ?? false;
  return Builder(builder: (context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Card(
          elevation: 5,
          child: Hero(
            tag: index,
            child: GestureDetector(
              onTap: () {
                showImageDialogue(context, index, image);
              },
              child: Container(
                width: width ?? 240,
                height: height ?? 210,
                margin: EdgeInsets.all(8),
                child: image,
              ),
            ),
          ),
        ),
        if (!hideCross)
          InkWell(
            onTap: onTap,
            child: Icon(
              Icons.cancel,
              size: 18,
              color: Colors.red,
            ),
          )
      ],
    );
  });
}

showImageDialogue(BuildContext context, index, image) {
  return Get.dialog(
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          alignment: Alignment.center,
          height: Get.width,
          width: Get.width,
          child: Container(
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Hero(
                      tag: index,
                      child: image,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: white,
                    ),
                    child: Icon(
                      Icons.cancel,
                      size: 33,
                      color: Colors.red,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
