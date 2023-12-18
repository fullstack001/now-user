import 'package:application_1/utils/AppColors.dart';
import 'package:flutter/material.dart';

class ReuseableTextField extends StatefulWidget {
  var controller;
  var textHint;
  ReuseableTextField({this.controller, this.textHint});
  @override
  _ReuseableTextFieldState createState() => _ReuseableTextFieldState();
}

class _ReuseableTextFieldState extends State<ReuseableTextField> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double w = size.width;
    double h = size.height;
    return Container(
      width: w,
      height: 47,
      child: TextFormField(
        validator: (val) {
          if (val!.isEmpty) {
            return "Field Empty";
          }
        },
        controller: widget.controller,
        onChanged: (val) {},
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
            border: OutlineInputBorder(borderSide: BorderSide.none),
            fillColor: AppColors.grey,
            filled: true,
            hintText: "${widget.textHint}",
            hintStyle: TextStyle(
              fontSize: 16,
            ),
            prefixIcon: Icon(Icons.email, size: 24, color: Colors.grey),
            contentPadding: EdgeInsets.all(8)),
      ),
    );
  }
}
