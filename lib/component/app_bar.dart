import 'package:denly/component/component.dart';
import 'package:denly/constant/constant.dart';
import 'package:flutter/material.dart';

PreferredSizeWidget? nAppBar(
  BuildContext context, {
  String? title,
  Widget? customRightIcon,
  Widget? customLeftIcon,
  Widget? customTitle,
  Color backgroundColor = Colors.transparent,
  bool isLeftIcon = true,
}) {
  final safeAreaWidth = MediaQuery.of(context).size.width;
  final safeAreaHeight = safeHeight(context);

  return AppBar(
    backgroundColor: backgroundColor,
    surfaceTintColor: backgroundColor,
    elevation: 0,
    automaticallyImplyLeading: false,
    title: SizedBox(
      height: safeAreaHeight * 0.1,
      width: safeAreaWidth,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: isLeftIcon
                ? customLeftIcon ??
                    imgWidget(
                      size: safeAreaWidth * 0.07,
                      assetFile: "icon_arrow.png",
                    )
                : const SizedBox(),
          ),
          Align(
            child: customTitle ??
                nText(
                  title ?? "",
                  fontSize: safeAreaWidth / 23,
                  bold: 700,
                  color: Colors.black,
                ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: customRightIcon ?? const SizedBox(),
          ),
        ],
      ),
    ),
  );
}
