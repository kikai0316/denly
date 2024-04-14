import 'package:flutter/material.dart';

double safeHeight(BuildContext context) {
  return MediaQuery.of(context).size.height -
      MediaQuery.of(context).padding.top -
      MediaQuery.of(context).padding.bottom;
}

BoxBorder mainBorder({Color? color, double width = 1}) {
  return Border.all(
    color: color ?? Colors.grey.withOpacity(0.3),
    width: width,
  );
}

BorderRadiusGeometry mainCustomBorderRadius(
  double radius, {
  bool? isTopLeft,
  bool? isTopRight,
  bool? isBottomLeft,
  bool? isBottomRight,
  double? customTopLeft,
  double? customTopRight,
  double? customBottomLeft,
  double? customBottomRight,
}) {
  return BorderRadius.only(
    topLeft: isTopLeft == true
        ? Radius.circular(customTopLeft ?? radius)
        : Radius.zero,
    topRight: isTopRight == true
        ? Radius.circular(customTopRight ?? radius)
        : Radius.zero,
    bottomLeft: isBottomLeft == true
        ? Radius.circular(customBottomLeft ?? radius)
        : Radius.zero,
    bottomRight: isBottomRight == true
        ? Radius.circular(customBottomRight ?? radius)
        : Radius.zero,
  );
}

List<BoxShadow> mainBoxShadow({double shadow = 0.5, Color? color}) {
  return [
    BoxShadow(
      color: color ?? Colors.black.withOpacity(shadow),
      blurRadius: 20,
      spreadRadius: 1.0,
    ),
  ];
}

BoxBorder mainTopBorder({
  Color? color,
}) {
  return Border(
    top: BorderSide(
      color: color ?? Colors.grey.withOpacity(0.1),
    ),
  );
}

EdgeInsetsGeometry xPadding(
  BuildContext context, {
  double? xSize,
  double top = 0,
  double bottom = 0,
}) {
  final safeAreaWidth = MediaQuery.of(context).size.width;
  return EdgeInsets.only(
    left: xSize ?? safeAreaWidth * 0.03,
    right: xSize ?? safeAreaWidth * 0.03,
    top: top,
    bottom: bottom,
  );
}

EdgeInsetsGeometry yPadding(
  BuildContext context, {
  double? ySize,
  double left = 0,
  double right = 0,
}) {
  final safeAreaHeight = safeHeight(context);
  return EdgeInsets.only(
    left: left,
    right: right,
    top: ySize ?? safeAreaHeight * 0.02,
    bottom: ySize ?? safeAreaHeight * 0.02,
  );
}

EdgeInsetsGeometry customPadding({
  double top = 0,
  double bottom = 0,
  double left = 0,
  double right = 0,
}) {
  return EdgeInsets.only(
    left: left,
    right: right,
    top: top,
    bottom: bottom,
  );
}
