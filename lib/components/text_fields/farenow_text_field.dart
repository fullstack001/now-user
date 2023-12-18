import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

// ignore: must_be_immutable
class FarenowTextField extends StatefulWidget {
  late TextEditingController? controller;
  late bool isPassword;
  late TextInputType type;
  String hint;
  FocusNode? node;
  late String label;
  bool isDOB;
  Function(String)? onSubmit;
  late bool? readonly;
  int maxLine;
  VoidCallback? onTap;
  ValueChanged? onChange;
  String? initailValue;
  Color? filledColor;
  InputBorder? border;
  VoidCallback? onDOBTap;
  var onValidation;
  TextInputAction inputAction;

  FarenowTextField(
      {Key? key,
      this.controller,
      required this.hint,
      this.type = TextInputType.emailAddress,
      this.isPassword = false,
      this.isDOB = false,
      this.onDOBTap,
      this.node,
      this.onSubmit,
      required this.label,
      this.readonly = false,
      this.maxLine = 1,
      this.onChange,
      this.onTap,
      this.initailValue,
      this.filledColor,
      this.border,
      this.onValidation,
      this.inputAction = TextInputAction.next})
      : super(key: key);

  @override
  State<FarenowTextField> createState() => _FarenowTextFieldState();
}

class _FarenowTextFieldState extends State<FarenowTextField> {
  late bool isVisible;

  @override
  void initState() {
    isVisible = widget.isPassword;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: Get.width,
          alignment: Alignment.topLeft,
          child: Text(
            widget.label,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
          ),
        ),
        12.height,
        Material(
          child: TextFormField(
            initialValue: widget.initailValue,
            onTap: widget.onTap,
            onChanged: widget.onChange,
            maxLines: widget.maxLine,
            textInputAction: widget.inputAction,
            readOnly: widget.readonly!,
            onFieldSubmitted: widget.onSubmit,
            focusNode: widget.node,
            cursorColor: black,
            keyboardType: widget.type,
            onEditingComplete: () {
              FocusScope.of(context).nextFocus();
            },
            controller: widget.controller,
            validator: widget.onValidation ??
                ((value) {
                  if (value!.isEmpty) {
                    return "Field required*";
                  }
                  return null;
                }),
            decoration: InputDecoration(
                fillColor: widget.filledColor ?? white,
                filled: true,
                suffixIcon: widget.isPassword
                    ? IconButton(
                        onPressed: () => setState(() {
                              isVisible = !isVisible;
                            }),
                        icon: isVisible
                            ? const Icon(Icons.visibility_off)
                            : const Icon(Icons.visibility))
                    : widget.isDOB
                        ? InkWell(
                            onTap: widget.onDOBTap,
                            child: ImageIcon(
                              AssetImage("assets/cale.png"),
                            ),
                          )
                        : null,
                hintText: widget.hint,
                border: widget.border ??
                    OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide:
                            const BorderSide(color: Colors.black38, width: 1)),
                focusedBorder: widget.border ??
                    OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            const BorderSide(color: Colors.green, width: 1))),
            obscureText: isVisible,
          ),
        ),
      ],
    );
  }
}
