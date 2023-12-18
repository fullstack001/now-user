import 'package:application_1/utils/AppColors.dart';
import 'package:flutter/material.dart';

class TimeButtonGroup extends StatelessWidget {
  static const double _radius = 10.0;
  static const double _outerPadding = 2.0;

  final current;
  final titles;
  final onTab;
  final color;
  final secondaryColor;
  final btnColor;
  final onTap;
  const TimeButtonGroup(
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
      child: SingleChildScrollView(
        child: Column(
          children: generateList(context),
        ),
      ),
    );
  }

  generateList(BuildContext context) {
    return List.generate(77, (index) {
      return Container(
        width: MediaQuery.of(context).size.width,
        child: Material(
          type: MaterialType.button,
          color: AppColors.white,
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

  Widget _activeButton(String title) => Expanded(
        child: MaterialButton(
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          disabledColor: AppColors.blue,
          disabledTextColor: AppColors.white,
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 1, color: secondaryColor),
            borderRadius: BorderRadius.circular(9.9),
          ),
          child: Text(title),
          onPressed: null,
        ),
      );

  Widget _inActiveButton(String title, int index) => Expanded(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: MaterialButton(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            color: AppColors.white,
            textColor: AppColors.black,
            shape: RoundedRectangleBorder(
              side: BorderSide(width: 1, color: secondaryColor),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              title,
              style: TextStyle(color: secondaryColor),
            ),
            onPressed: () {
              if (onTab != null) onTab(index);
            },
          ),
        ),
      );
}
