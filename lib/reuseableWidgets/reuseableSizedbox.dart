import 'package:flutter/material.dart';

class BuildSizedBox extends StatelessWidget {
  double value;
  BuildSizedBox(this.value) : super();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: value,
    );
  }
}
