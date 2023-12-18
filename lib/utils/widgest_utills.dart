import 'package:application_1/utils/AppColors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';

emptyContainer() {
  return Container(
    width: 0,
    height: 0,
  );
}

/*customContainer(
    {width,
    height,
    color,
    allRadius,
    topLeftRadius,
    bottomLeftRadius,
    topRightRadius,
    bottomRightRadius,
    marginAll,
    marginTop,
    marginBottom,
    marginLeft,
    marginRight,
    paddingAll,
    paddingTop,
    paddingBottom,
    paddingLeft,
    paddingRight,
    alignment,
    shadowColor,
    shadowSpreadRadius,
    shadowBlurRadius: 0,
    shadowOffsetX,
    shadowOffsetY,
    gradientColor,
    borderColor,
    borderWidth,
    child}) {
  return Container(
    width: double.parse((width ?? 80).toString()),
    height: double.parse((height ?? 50).toString()),
    alignment: alignment ?? Alignment.center,
    padding: paddingAll != null
        ? EdgeInsets.all(double.parse((paddingAll ?? 0).toString()))
        : EdgeInsets.only(
            top: double.parse((paddingTop ?? 0).toString()),
            bottom: double.parse((paddingBottom ?? 0).toString()),
            left: double.parse((paddingLeft ?? 0).toString()),
            right: double.parse((paddingRight ?? 0).toString()),
          ),
    margin: marginAll != null
        ? EdgeInsets.all(double.parse((marginAll ?? 0).toString()))
        : EdgeInsets.only(
            top: double.parse((marginTop ?? 0).toString()),
            bottom: double.parse((marginBottom ?? 0).toString()),
            left: double.parse((marginLeft ?? 0).toString()),
            right: double.parse((marginRight ?? 0).toString()),
          ),
    decoration: BoxDecoration(
      color: color ?? Colors.white,
      borderRadius: allRadius != null
          ? BorderRadius.all(
              Radius.circular(double.parse((allRadius ?? 0).toString())))
          : BorderRadius.only(
              topLeft: Radius.circular(
                  double.parse((topLeftRadius ?? 6).toString())),
              topRight: Radius.circular(
                  double.parse((topRightRadius ?? 6).toString())),
              bottomLeft: Radius.circular(
                  double.parse((bottomLeftRadius ?? 6).toString())),
              bottomRight: Radius.circular(
                  double.parse((bottomRightRadius ?? 6).toString())),
            ),
      border: Border.all(
          width: double.parse((borderWidth ?? 0).toString()),
          color: borderColor ?? Colors.transparent),
      boxShadow: [
        BoxShadow(
          color: shadowColor ?? Colors.transparent,
          spreadRadius: double.parse((shadowSpreadRadius ?? 0).toString()),
          blurRadius: double.parse((shadowBlurRadius ?? 0).toString()),
          offset: Offset(double.parse((shadowOffsetX ?? 0).toString()),
              double.parse((shadowOffsetY ?? 0).toString())),
        )
      ],
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: gradientColor ??
            [
              color ?? Colors.transparent,
              color ?? Colors.transparent,
            ],
      ),
    ),
    child: child ?? emptyContainer(),
  );
}

widthContainer(
    {width,
    height,
    color,
    allRadius,
    topLeftRadius,
    bottomLeftRadius,
    topRightRadius,
    bottomRightRadius,
    marginAll,
    marginTop,
    marginBottom,
    marginLeft,
    marginRight,
    paddingAll,
    paddingTop,
    paddingBottom,
    paddingLeft,
    paddingRight,
    alignment,
    child}) {
  return Container(
    alignment: alignment ?? Alignment.center,
    padding: paddingAll != null
        ? EdgeInsets.all(double.parse((paddingAll ?? 0).toString()))
        : EdgeInsets.only(
            top: double.parse((paddingTop ?? 0).toString()),
            bottom: double.parse((paddingBottom ?? 0).toString()),
            left: double.parse((paddingLeft ?? 0).toString()),
            right: double.parse((paddingRight ?? 0).toString()),
          ),
    margin: marginAll != null
        ? EdgeInsets.all(double.parse((marginAll ?? 0).toString()))
        : EdgeInsets.only(
            top: double.parse((marginTop ?? 0).toString()),
            bottom: double.parse((marginBottom ?? 0).toString()),
            left: double.parse((marginLeft ?? 0).toString()),
            right: double.parse((marginRight ?? 0).toString()),
          ),
    decoration: BoxDecoration(
      color: color ?? Colors.white,
      borderRadius: allRadius != null
          ? BorderRadius.all(
              Radius.circular(double.parse((allRadius ?? 0).toString())))
          : BorderRadius.only(
              topLeft: Radius.circular(
                  double.parse((topLeftRadius ?? 6).toString())),
              topRight: Radius.circular(
                  double.parse((topRightRadius ?? 6).toString())),
              bottomLeft: Radius.circular(
                  double.parse((bottomLeftRadius ?? 6).toString())),
              bottomRight: Radius.circular(
                  double.parse((bottomRightRadius ?? 6).toString())),
            ),
    ),
    child: child ?? emptyContainer(),
  );
}*/

Widget button({title, onClick, textColor, fontSize}) {
  return MaterialButton(
    onPressed: onClick,
    child: Text(
      title,
      style: TextStyle(
        color: textColor ?? Colors.black,
        fontWeight: FontWeight.w400,
        fontSize: double.parse((fontSize ?? 14).toString()),
      ),
    ),
  );
}

cacheNetworkImage(
    {imageUrl,
    imageHeight,
    imageWidth,
    placeHolder,
    radius,
    topRightRad,
    topLeftRad,
    bottomLeftRad,
    bottomRightRad,
    fit,
    color}) {
  var rad = double.parse((radius ?? 0).toString());
  var topRightRadius = double.parse((topRightRad ?? 0).toString());
  var topLeftRadius = double.parse((topLeftRad ?? 0).toString());
  var bottomLeftRadius = double.parse((bottomLeftRad ?? 0).toString());
  var bottomRightRadius = double.parse((bottomRightRad ?? 0).toString());
  return Container(
    decoration: BoxDecoration(
        color: color ?? Colors.transparent,
        borderRadius: radius != null
            ? BorderRadius.circular(rad)
            : BorderRadius.only(
                topLeft: Radius.circular(topLeftRadius),
                topRight: Radius.circular(topRightRadius),
                bottomLeft: Radius.circular(bottomLeftRadius),
                bottomRight: Radius.circular(bottomRightRadius),
              ),
        image: DecorationImage(
          image: AssetImage(
            placeHolder ?? 'assets/user_assets/png/user.png',
          ),
          fit: fit ?? BoxFit.cover,
        )),

    //
    child: CachedNetworkImage(
      imageUrl: imageUrl,
      height: double.parse((imageHeight ?? 48).toString()),
      width: double.parse((imageWidth ?? 48).toString()),
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: radius != null
              ? BorderRadius.circular(rad)
              : BorderRadius.only(
                  topLeft: Radius.circular(topLeftRadius),
                  topRight: Radius.circular(topRightRadius),
                  bottomLeft: Radius.circular(bottomLeftRadius),
                  bottomRight: Radius.circular(bottomRightRadius),
                ),
          image: DecorationImage(
            image: imageProvider,
            fit: fit ?? BoxFit.cover,
          ),
        ),
      ),
      placeholder: (context, url) => CupertinoTheme(
        data: CupertinoTheme.of(context).copyWith(brightness: Brightness.dark),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FittedBox(
              child: CircularProgressIndicator(
                color: AppColors.appBlue,
              ),
            ),
          ],
        ),
      ),
      errorWidget: (context, url, error) => Container(
        decoration: BoxDecoration(
            borderRadius: radius != null
                ? BorderRadius.circular(rad)
                : BorderRadius.only(
                    topLeft: Radius.circular(topLeftRadius),
                    topRight: Radius.circular(topRightRadius),
                    bottomLeft: Radius.circular(bottomLeftRadius),
                    bottomRight: Radius.circular(bottomRightRadius),
                  ),
            image: DecorationImage(
                image: AssetImage(
                    placeHolder ?? 'assets/user_assets/png/user.png'),
                fit: fit ?? BoxFit.cover)),
      ),
    ),
  );
}

customButton({
  title,
  onTap,
  width,
  height,
  allRadius,
  topLeftRadius,
  topRightRadius,
  bottomLeftRadius,
  bottomRightRadius,
  color,
  textSize,
  textWeight,
  textColor,
  marginAll,
  marginTop,
  marginBottom,
  marginLeft,
  marginRight,
  paddingAll,
  paddingTop,
  paddingBottom,
  paddingLeft,
  paddingRight,
}) {
  return InkWell(
    onTap: onTap ??
        () {
          print("invalid click");
        },
    child: Container(
      width: double.parse((width ?? Get.width).toString()),
      height: double.parse((height ?? 40).toString()),
      margin: marginAll == null
          ? EdgeInsets.only(
              top: double.parse((marginTop ?? 0).toString()),
              bottom: double.parse((marginBottom ?? 0).toString()),
              left: double.parse((marginLeft ?? 0).toString()),
              right: double.parse((marginRight ?? 0).toString()),
            )
          : EdgeInsets.all(double.parse((marginAll ?? 0).toString())),
      padding: paddingAll == null
          ? EdgeInsets.only(
              top: double.parse((paddingTop ?? 0).toString()),
              bottom: double.parse((paddingBottom ?? 0).toString()),
              left: double.parse((paddingLeft ?? 0).toString()),
              right: double.parse((paddingRight ?? 0).toString()),
            )
          : EdgeInsets.all(double.parse((paddingAll ?? 0).toString())),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: color ?? AppColors.appGreen,
          borderRadius: allRadius == null
              ? BorderRadius.only(
                  topLeft: Radius.circular(
                      double.parse((topLeftRadius ?? 0).toString())),
                  topRight: Radius.circular(
                      double.parse((topRightRadius ?? 0).toString())),
                  bottomRight: Radius.circular(
                      double.parse((bottomRightRadius ?? 0).toString())),
                  bottomLeft: Radius.circular(
                      double.parse((bottomLeftRadius ?? 0).toString())),
                )
              : BorderRadius.all(
                  Radius.circular(double.parse((allRadius ?? 0).toString())))),
      child: Text(
        title ?? "Click Me",
        style: TextStyle(
            color: textColor ?? Colors.black,
            fontSize: double.parse((textSize ?? 18).toString()),
            fontWeight: textWeight ?? FontWeight.bold),
      ),
    ),
  );
}

List<String> cardList = [
  "visa",
  "amex",
  "mastercard",
  "dinersclub",
  "jcb",
  "unionpay",
  "maestro",
  "elo",
  "mir",
  "hiper",
  "hipercard",
  "unknown"
];

getCard(String type) {
  if (type == "visa") {
    return Icon(
      Fontisto.visa,
      color: Colors.grey,
    );
  } else if (type == "amex") {
    return Icon(
      Fontisto.american_express,
      color: Colors.grey,
    );
  } else if (type == "mastercard") {
    return Icon(
      Fontisto.mastercard,
      color: Colors.grey,
    );
  } else if (type == "jcb") {
    return Icon(
      Fontisto.jcb,
      color: Colors.grey,
    );
  } else {
    return Icon(
      Fontisto.credit_card,
      color: Colors.grey,
    );
  }
}

snackBar(String message, BuildContext context) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      duration: Duration(seconds: 2),
    ),
  );
}
