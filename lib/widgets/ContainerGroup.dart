import 'package:flutter/material.dart';

class ContainerGroup extends StatelessWidget {
  static const double _radius = 10.0;
  static const double _outerPadding = 2.0;

  final current;
  final containerText;
  final onTab;
  final color;
  final secondaryColor;

  const ContainerGroup({
    Key? key,
    this.containerText,
    this.onTab,
    int current = 0,
    Color color = Colors.transparent,
    Color secondaryColor = Colors.transparent,
  })  : assert(containerText != null),
        current = current,
        color = color,
        secondaryColor = secondaryColor,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: MediaQuery.of(context).size.width,
      // height: MediaQuery.of(context).size.height,
      child: Material(
        type: MaterialType.card,
        color: color,
        borderRadius: BorderRadius.circular(_radius),
        child: Padding(
          padding: const EdgeInsets.all(_outerPadding),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(_radius - _outerPadding),
            child: IntrinsicHeight(
                child: Column(
              children: _containerList(context),
            )),
          ),
        ),
      ),
    );
  }

  List<Widget> _containerList(BuildContext context) {
    final containers = <Widget>[];
    for (int i = 0; i < containerText.length; i++) {
      containers.add(_button(containerText[i], i, context));
    }

    return containers;
  }

  Widget _button(ContainerGroupText details, int index, BuildContext context) {
    if (index == this.current)
      return _activeButton(details, context);
    else
      return _inActiveButton(details, index, context);
  }

  Widget _activeButton(ContainerGroupText title, BuildContext context) =>
      Expanded(
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: secondaryColor,
                      borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title.title,
                        style: TextStyle(color: color),
                      ),
                      Text(
                        title.subtitle,
                        style: TextStyle(color: color),
                      )
                    ],
                  ))));

  Widget _inActiveButton(
          ContainerGroupText title, int index, BuildContext context) =>
      Expanded(
          child: GestureDetector(
        onTap: () {
          if (onTab != null) onTab(index);
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(12)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [Text(title.title), Text(title.subtitle)],
              )),
        ),
      ));
}

class ContainerGroupText {
  var title;
  var subtitle;

  ContainerGroupText({this.title, this.subtitle});
}
