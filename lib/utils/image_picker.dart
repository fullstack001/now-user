import 'dart:io';

import 'package:application_1/AllPages/ExplorePages/shopMenu.dart';
import 'package:application_1/utils/api_utils.dart';
import 'package:application_1/utils/widgest_utills.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerDialog {
  BuildContext? context;
  var imageSelect;

  ImagePickerDialog({this.context, this.imageSelect});

  File? image;
  final ImagePicker _picker = ImagePicker();
  _imgFromCamera() async {
    var selectedimage =
        await _picker.pickImage(source: ImageSource.camera, imageQuality: 50);
    print("");
    if (selectedimage != null) {
      image = File(selectedimage.path);
    }

    if (imageSelect != null) {
      imageSelect(image);
    }
  }

  _imgFromGallery() async {
    XFile? _image =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    print("");
    image = File(_image!.path);

    if (imageSelect != null) {
      imageSelect(image);
    }
  }

  void showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: Wrap(
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(8),
                    child: Container(
                      width: 48,
                      height: 5,
                      decoration: BoxDecoration(
                          color: const Color(0xffCDCFD0),
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                  const Divider(
                    thickness: 1,
                  ),
                  ListTile(
                      leading: SvgPicture.asset(
                          "assets/user_assets/svg/gallery-add.svg"),
                      title: const Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  const Divider(
                    thickness: 1,
                  ),
                  ListTile(
                    leading:
                        SvgPicture.asset("assets/user_assets/svg/camera.svg"),
                    title: const Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                  const Divider(
                    thickness: 1,
                  ),
                ],
              ),
            ),
          );
        });
  }
}

proFileImage({imageWidget, context, imagePicker, hide}) {
  bool viewHide = hide ?? false;
  return Stack(
    alignment: Alignment.bottomRight,
    children: [
      Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(80),
        ),
        child: ClipOval(
          child: imageWidget,
        ),
      ),
      if (!viewHide)
        Container(
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(color: white, shape: BoxShape.circle),
          child: InkWell(
            onTap: imagePicker,
            child: Container(
              padding: const EdgeInsets.all(6),
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                  color: const Color(0xff40C08C),
                  borderRadius: BorderRadius.circular(20)),
              child: SvgPicture.asset(
                "assets/user_assets/svg/pen.svg",
              ),
            ),
          ),
        )
    ],
  );
}

networkImage(controller, File image) {
  if (image != null) {
    return null;
  }
  if (controller.userData.value == null) {
    return null;
  }
  return controller.userData.value.image;
}

getFormDataGet(map) {
  return FormData(map);
}

Widget networkImageWidget({imageUrl}) {
  return Container(
    width: 62,
    height: 62,
    decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage("'assets/user_assets/png/user.png'"))),
    child: proFileImage(
      hide: true,
      imageWidget: imageUrl != null
          ? cacheNetworkImage(imageUrl: "${ApiUtills.imageBaseUrl + imageUrl}")
          : Image.asset('assets/user_assets/png/user.png'),
    ),
  );
}
