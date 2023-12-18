import 'package:application_1/widgets/custom_container.dart';
import 'package:flutter/material.dart';

class TextWithIcon extends StatelessWidget {
  var width;
  var height;
  var title;
  var icon;
  var fontSize;
  var fontColor;
  var fontWeight;
  var bgColor;
  var alignment;
  var containerAlignment;
  var onTap;
  var trailingIcon;
  var allRadius;
  var topLeftRadius;
  var bottomLeftRadius;
  var topRightRadius;
  var bottomRightRadius;
  var marginAll;
  var marginTop;
  var marginBottom;
  var marginLeft;
  var marginRight;
  var paddingAll;
  var paddingTop;
  var paddingBottom;
  var paddingLeft;
  var paddingRight;
  var shadowColor;
  var shadowSpreadRadius;
  var shadowBlurRadius;
  var shadowOffsetX;
  var shadowOffsetY;
  var gradientColor;
  var borderColor;
  var borderWidth;
  var flex;
  var containerClick;
  var maxLine;
  var overFlow;
  var textAlign;
  var underline;

  TextWithIcon({
    this.width,
    this.height,
    this.title,
    this.icon,
    this.fontSize,
    this.fontColor,
    this.fontWeight,
    this.bgColor,
    this.trailingIcon,
    this.alignment,
    this.onTap,
    this.paddingLeft,
    this.borderColor,
    this.shadowOffsetX,
    this.topLeftRadius,
    this.topRightRadius,
    this.paddingTop,
    this.marginTop,
    this.paddingRight,
    this.marginLeft,
    this.marginRight,
    this.paddingBottom,
    this.marginAll,
    this.marginBottom,
    this.bottomRightRadius,
    this.borderWidth,
    this.bottomLeftRadius,
    this.shadowBlurRadius,
    this.shadowSpreadRadius,
    this.shadowColor,
    this.gradientColor,
    this.shadowOffsetY,
    this.allRadius,
    this.paddingAll,
    this.flex,
    this.containerAlignment,
    this.containerClick,
    this.maxLine,
    this.overFlow,
    this.textAlign,
    this.underline,
  });

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      onTap: containerClick == null ? null : containerClick,
      height: height,
      width: width,
      allRadius: allRadius,
      topLeftRadius: topLeftRadius,
      bottomLeftRadius: bottomLeftRadius,
      topRightRadius: topRightRadius,
      bottomRightRadius: bottomRightRadius,
      marginAll: marginAll,
      marginLeft: marginLeft,
      alignment: containerAlignment,
      marginRight: marginRight,
      marginBottom: marginBottom,
      marginTop: marginTop,
      paddingAll: paddingAll,
      paddingLeft: paddingLeft,
      paddingRight: paddingRight,
      paddingBottom: paddingBottom,
      paddingTop: paddingTop,
      gradientColor: gradientColor,
      shadowOffsetY: shadowOffsetY,
      shadowOffsetX: shadowOffsetX,
      shadowSpreadRadius: shadowSpreadRadius,
      shadowBlurRadius: shadowBlurRadius,
      shadowColor: shadowColor,
      color: bgColor ?? Colors.transparent,
      borderWidth: borderWidth,
      borderColor: borderColor,
      child: Row(
        mainAxisAlignment: alignment ?? MainAxisAlignment.center,
        children: [
          if (icon != null)
            InkWell(
              onTap: onTap,
              child: icon,
            ),
          if (icon != null)
            SizedBox(
              width: 6,
            ),
          Expanded(
            flex: flex ?? 0,
            child: Text(
              "$title",
              textAlign: textAlign ?? TextAlign.start,
              maxLines: maxLine ?? 10,
              overflow: overFlow ?? TextOverflow.visible,
              style: TextStyle(
                  decoration: underline ?? TextDecoration.none,
                  color: fontColor ?? Colors.black,
                  fontSize: double.parse((fontSize ?? 12).toString()),
                  fontWeight: fontWeight ?? FontWeight.normal),
            ),
          ),
          if (trailingIcon != null)
            SizedBox(
              width: 6,
            ),
          if (trailingIcon != null) trailingIcon
        ],
      ),
    );
  }
}
