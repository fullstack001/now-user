// Copyright 2019 Aleksander Woźniak
// SPDX-License-Identifier: Apache-2.0

import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final  icon;
  final  onTap;
  final  margin;
  final  padding;

  const CustomIconButton({
    Key? key,
    this.icon,
    this.onTap,
    this.margin = const EdgeInsets.all(0.0),
    this.padding = const EdgeInsets.all(8.0),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(100.0),
        child: Padding(
          padding: padding,
          child: icon,
        ),
      ),
    );
  }
}
