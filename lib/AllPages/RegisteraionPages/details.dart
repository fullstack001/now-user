import 'dart:io';
import 'dart:typed_data';

import 'package:application_1/AllPages/RegisteraionPages/Controllers/RegistrationController.dart';
import 'package:application_1/components/buttons-management/part_of_file/part.dart';
import 'package:application_1/components/buttons-management/style_model.dart';
import 'package:application_1/components/text_fields/farenow_text_field.dart';

import 'package:application_1/utils/AppColors.dart';
import 'package:application_1/utils/AppString.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:gallery_saver/gallery_saver.dart';

import '../../utils/api_utils.dart';
import '../../utils/image_picker.dart';
import '../../utils/widgest_utills.dart';

class Details extends StatefulWidget {
  final edit;

  Details({Key? key, this.edit = false}) : super(key: key);

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();

  final zipCode = TextEditingController();
  final bio = TextEditingController();

  final _formState = GlobalKey<FormState>();

  var image;

  var argumetns;

  bool firstInit = false;
  bool argsInit = false;
  final RegistrationController _registrationController = Get.find();

  String getFirstName(value) {
    return value.toString().split(" ")[0];
  }

  bool hidePassword = true;

  String getLastName(value) {
    String name = value.toString().split(" ")[0];
    return value.toString().replaceAll("${name} ", "").capitalizeFirst!;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool edit = widget.edit ?? false;

    if (argumetns == null && !argsInit) {
      String emailStr = '';
      String fNameStr = '';
      String lNameStr = '';
      argsInit = true;
      argumetns = Get.arguments;
      if (argumetns is GoogleSignInAccount) {
        argumetns['email'] = (argumetns as GoogleSignInAccount).email;
        fNameStr =
            getFirstName((argumetns as GoogleSignInAccount).displayName!);
        lNameStr = getLastName((argumetns as GoogleSignInAccount).displayName!);
      } else if (argumetns is Map) {
        print("${argumetns['email']}");
        emailStr = argumetns['first_name'];
        fNameStr = argumetns['last_name'];
      }

      email.text = emailStr;
      firstName.text = emailStr.capitalizeFirst!;
      lastName.text = fNameStr.capitalizeFirst!;
    }
    if (edit && !firstInit) {
      firstInit = true;
      firstName.text = _registrationController.userData.value.firstName
          .toString()
          .capitalizeFirst!;
      lastName.text = _registrationController.userData.value.lastName
          .toString()
          .capitalizeFirst!;
      email.text = _registrationController.userData.value.email
          .toString()
          .capitalizeFirst!;
      // phone.text = _registrationController.userData.value.phone
      //     .toString()
      //     .capitalizeFirst!;
      zipCode.text = _registrationController.userData.value.zipCode == null
          ? ""
          : _registrationController.userData.value.zipCode
              .toString()
              .capitalizeFirst!;
      bio.text = _registrationController.userData.value.bio == null
          ? ""
          : _registrationController.userData.value.bio
              .toString()
              .capitalizeFirst!;
      setSelection(firstName);
      setSelection(lastName);
      setSelection(zipCode);
      setSelection(bio);
    } else {
      email.text = email.text.toString().isEmpty
          ? _registrationController.numberStr.value
          : email.text.toString();
    }

    return Scaffold(
        backgroundColor: white,
        appBar: AppBar(
          backgroundColor: white,
          elevation: 0,
          iconTheme: IconTheme.of(context).copyWith(color: black),
          title: edit
              ? Text(
                  "Edit Profile Details",
                  style: TextStyle(
                      color: AppColors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                )
              : null,
          actions: [
            edit
                ? Container()
                : const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        "Step 2 of 2",
                        style: TextStyle(color: AppColors.solidBlue),
                      ),
                    ),
                  )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: ListView(
            children: [
              edit
                  ? Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            proFileImage(
                                imageWidget: networkImage(
                                            _registrationController, image) !=
                                        null
                                    ? cacheNetworkImage(
                                        imageUrl: ApiUtills.imageBaseUrl +
                                            _registrationController
                                                .userData.value.image,
                                        imageHeight: 100,
                                        imageWidth: 100,
                                        placeHolder:
                                            'assets/user_assets/png/user.png',
                                        radius: 100)
                                    : image == null
                                        ? Image.asset(
                                            'assets/user_assets/png/user.png',
                                            fit: BoxFit.fill,
                                          )
                                        : Container(
                                            width: 100,
                                            height: 100,
                                            decoration: BoxDecoration(
                                              color: Colors.red,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(70)),
                                              image: DecorationImage(
                                                  image: FileImage(image),
                                                  fit: BoxFit.cover),
                                            ),
                                          ),
                                imagePicker: () {
                                  ImagePickerDialog(
                                      context: context,
                                      imageSelect: (_image) {
                                        if (_image != null) {
                                          image = _image;
                                          saveTODownload(image);
                                        }
                                        setState(() {});
                                      }).showPicker(context);
                                }),
                          ],
                        ),
                      ),
                    )
                  : Container(),
              12.height,
              edit
                  ? Container()
                  : Container(
                      alignment: Alignment.centerLeft,
                      width: Get.width,
                      child: Text(
                        "Sign up",
                        style: TextStyle(
                            color: AppColors.black,
                            fontSize: 36,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
              12.height,
              edit
                  ? Container()
                  : Container(
                      alignment: Alignment.centerLeft,
                      width: Get.width,
                      child: Text(
                        "Create your account to get started. We don’t share your contact info with professionals.",
                        style: TextStyle(
                            color: AppColors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
              25.height,
              Container(
                width: size.width,
                child: Form(
                  key: _formState,
                  child: Column(
                    children: [
                      FarenowTextField(
                        hint: "First Name",
                        label: "First Name",
                        type: TextInputType.emailAddress,
                        readonly: argumetns == null ? false : true,
                        controller: firstName,
                      ),
                      16.height,
                      FarenowTextField(
                        hint: "Last Name",
                        label: "Last Name",
                        readonly: argumetns == null ? false : true,
                        controller: lastName,
                      ),
                      16.height,
                      FarenowTextField(
                        hint: "Email",
                        label: "Enter Email",
                        // node: emailNode,
                        type: TextInputType.emailAddress,

                        readonly: !edit,
                        controller: email,
                      ),
                      16.height,
                      if (!edit)
                        FarenowTextField(
                          hint: "Password",
                          label: "Enter Password",
                          // node: passwordNode,
                          onSubmit: (v) {
                            // zipCodeNode.requestFocus();
                            FocusScope.of(context).nextFocus();
                          },
                          onValidation: (String val) {
                            if (val.isNotEmpty) {
                              if (val.length < 8) {
                                return "Password must contain 8 characters long";
                              }
                            } else {
                              return "Feild required";
                            }
                          },
                          controller: password,
                          isPassword: true,
                        ),
                      16.height,
                      FarenowTextField(
                        hint: "Zipcode",
                        label: "Enter Zipcode",
                        controller: zipCode,
                      ),
                      16.height,
                      FarenowTextField(
                        hint: "Enter your bio ",
                        label: "Enter Bio",
                        // node: bioNode,
                        onSubmit: (v) {
                          _submitResponse();
                        },
                        inputAction: TextInputAction.done,
                        controller: bio,
                        maxLine: 6,
                      ),
                    ],
                  ),
                ),
              ),
              16.height,
              FarenowButton(
                  title: edit ? "Update" : "Submit",
                  onPressed: _submitResponse,
                  style: FarenowButtonStyleModel(padding: EdgeInsets.zero),
                  type: BUTTONTYPE.rectangular)
            ],
          ),
        ));
  }

  buildSnack(String message) {
    Get.rawSnackbar(
      message: message,
      duration: const Duration(seconds: 2),
    );
  }

  checkPhone(String value, argumetns) {
    if (argumetns != null) {
      return false;
    }
    if (value.length == 1) {
      return false;
    }
    return true;
  }

  void saveTODownload(image) async {
    Uint8List bytes = image.readAsBytesSync();

    await GallerySaver.saveImage(image.path, albumName: "Farenow")
        .then((value) {
      print("Save");
    });

    // print("entity ${entity!.title}");
    //
    // var file = await writeFile(bytes, "new_file_${DateTime.now().second}.jpeg");
    // print("saved");
  }

// Future<File> writeFile(Uint8List data, String name) async {
//   // storage permission ask
//   var status = await Permission.storage.status;
//   if (!status.isGranted) {
//     await Permission.storage.request();
//   }
//   // the downloads folder path
//
//   Directory appDocDir = await getApplicationDocumentsDirectory();
//   String appDocPath = appDocDir.path;
//
//
//   Directory tempDir = await DownloadsPathProvider.downloadsDirectory;
//   String tempPath = tempDir.path;
//   var filePath = appDocPath + '/$name';
//   if(GetPlatform.isAndroid){
//     filePath = tempPath + '/$name';
//   }
//   //
//
//   // the data
//   var bytes = ByteData.view(data.buffer);
//   final buffer = bytes.buffer;
//   // save the data in the path
//   return File(filePath).writeAsBytes(
//       buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
// }

  void _submitResponse() {
    if (!_formState.currentState!.validate()) {
      return;
    }
    Map<String, dynamic> _body = <String, dynamic>{
      "first_name": firstName.text.toString().capitalizeFirst,
      "last_name": lastName.text.toString().capitalizeFirst,
      "zip_code": zipCode.text,
      "bio": bio.text
    };
    if (!widget.edit) {
      _body["email"] = email.text;
      // _body["phone"] = phone.text;
      _body["password"] = password.text;
      _body["password_confirmation"] = password.text;
    } else {
      _body["_method"] = 'patch';
      if (_registrationController.userData.value.image != null) {
        _body["image"] = _registrationController.userData.value.image;
      }
    }
    _registrationController.signUpUser(_body,
        imag: image,
        edit: widget.edit,
        id: _registrationController.userData.value.id);
  }
}
