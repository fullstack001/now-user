// ignore_for_file: deprecated_member_use

import 'package:application_1/AllPages/ExplorePages/shopMenu.dart';
import 'package:application_1/utils/AppColors.dart';
import 'package:flutter/material.dart';

class ButtonGroup extends StatelessWidget {
  static const double _radius = 10.0;
  static const double _outerPadding = 2.0;

  final current;
  final titles;
  final onTab;
  final color;
  final secondaryColor;

  const ButtonGroup({
    Key? key,
    this.titles,
    this.onTab,
    int current = 0,
    Color color = Colors.transparent,
    Color secondaryColor = Colors.transparent,
  })  : assert(titles != null),
        current = current,
        color = color,
        secondaryColor = secondaryColor,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.3,
      child: Material(
        type: MaterialType.button,
        color: color,
        borderRadius: BorderRadius.circular(_radius),
        child: Padding(
          padding: const EdgeInsets.all(_outerPadding),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(_radius - _outerPadding),
            child: IntrinsicHeight(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: _buttonList(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buttonList() {
    final buttons = <Widget>[];
    for (int i = 0; i < titles.length; i++) {
      buttons.add(_button(titles[i], i));
      buttons.add(
        VerticalDivider(
          width: 1.0,
          color: (i == current) ? color : secondaryColor,
          thickness: 1.5,
          indent: 5.0,
          endIndent: 5.0,
        ),
      );
    }
    buttons.removeLast();
    return buttons;
  }

  Widget _button(String title, int index) {
    if (index == this.current)
      return _activeButton(title);
    else
      return _inActiveButton(title, index);
  }

  Widget _activeButton(String title) => Expanded(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextButton(
            // materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            // disabledColor: secondaryColor,
            // disabledTextColor: AppColors.white,
            // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            style: TextButton.styleFrom(
                backgroundColor: Colors.transparent,
                disabledBackgroundColor: secondaryColor,
                disabledForegroundColor: white,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
                textStyle: TextStyle(color: AppColors.black)),
            child: Text(title),
            onPressed: null,
          ),
        ),
      );

  Widget _inActiveButton(String title, int index) => Expanded(
        child: TextButton(
          // materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          // color: Colors.transparent,
          // textColor: AppColors.black,
          // shape: const RoundedRectangleBorder(
          //   borderRadius: BorderRadius.zero,
          // ),
          style: TextButton.styleFrom(
              backgroundColor: Colors.transparent,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
              textStyle: TextStyle(color: AppColors.black)),
          child: Text(title),
          onPressed: () {
            if (onTab != null) onTab(index);
          },
        ),
      );
}
