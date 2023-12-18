import 'package:application_1/utils/AppColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrderHistoryListViewButton extends StatelessWidget {
  static const _radius = 10.0;
  static const _outerPadding = 2.0;

  final current;
  final titles;
  final onTab;
  final color;
  final secondaryColor;
  final btnColor;
  final onTap;

  const OrderHistoryListViewButton(
      {Key? key,
      this.titles,
      this.onTab,
      this.onTap,
      int current = 0,
      Color color = Colors.transparent,
      Color secondaryColor = Colors.transparent,
      this.btnColor})
      : assert(titles != null),
        current = current,
        color = color,
        secondaryColor = secondaryColor,
        assert(btnColor != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        padding: EdgeInsets.all(8),
        scrollDirection: Axis.horizontal,
        children: generateList(context),
      ),
    );
  }

  generateList(BuildContext context) {
    return List.generate(1, (index) {
      return Container(
        width: MediaQuery.of(context).size.width,
        child: Material(
          type: MaterialType.button,
          color: AppColors.white,
          borderRadius: BorderRadius.circular(_radius),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(_radius - _outerPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: _buttonList(),
            ),
          ),
        ),
      );
    });
  }

  List<Widget> _buttonList() {
    final buttons = <Widget>[];
    for (int i = 0; i < titles.length; i++) {
      buttons.add(_button(titles[i], i));
    }

    return buttons;
  }

  Widget _button(String title, int index) {
    if (index == this.current)
      return _activeButton(title);
    else
      return _inActiveButton(title, index);
  }

  Widget _activeButton(String title) => Padding(
        padding: EdgeInsets.all(8),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(width: 1, color: secondaryColor)),
          child: Text(title,
              style: TextStyle(color: secondaryColor, fontSize: 14)),
        ),
      );

  Widget _inActiveButton(String title, int index) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () {
            if (onTab != null) onTab(index);
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(width: 1, color: color)),
            child: Text(title,
                style: TextStyle(color: Colors.black38, fontSize: 14)),
          ),
        ),
      );
}
