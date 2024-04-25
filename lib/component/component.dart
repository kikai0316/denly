import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:denly/constant/img.dart';
import 'package:flutter/material.dart';

Widget line({Color? color, EdgeInsetsGeometry padding = EdgeInsets.zero}) {
  return Padding(
    padding: padding,
    child: Container(
      height: 1,
      width: double.infinity,
      color: color ?? Colors.grey.withOpacity(0.3),
    ),
  );
}

Widget nText(
  String text, {
  required double fontSize,
  Color color = Colors.white,
  double bold = 600,
  double height = 1,
  int? maxLiune,
  TextAlign textAlign = TextAlign.center,
  List<Shadow>? shadows,
  bool isOverflow = true,
  bool isFit = false,
  bool isGradation = false,
  TextDecoration decoration = TextDecoration.none,
  TextOverflow? customOverflow,
}) {
  final textWidget = Text(
    text,
    textAlign: textAlign,
    overflow: customOverflow ?? (isOverflow ? TextOverflow.ellipsis : null),
    maxLines: maxLiune,
    style: TextStyle(
      height: height,
      decoration: decoration,
      decorationColor: color,
      fontFamily: "Normal",
      fontVariations: [FontVariation("wght", bold)],
      color: color,
      shadows: shadows,
      fontSize: fontSize,
    ),
  );
  final textWidgetWithGradation =
      // isGradation
      //     ? ShaderMask(
      //         child: textWidget,
      //         shaderCallback: (rect) => mainGradationWithPink().createShader(rect),
      //       )
      //     :
      textWidget;
  if (isFit) {
    return FittedBox(
      fit: BoxFit.fitWidth,
      child: textWidgetWithGradation,
    );
  }
  return textWidgetWithGradation;
}

Widget nContainer({
  double? height,
  double? width,
  Color? color,
  double radius = 0,
  EdgeInsetsGeometry? padding,
  Gradient? gradient,
  AlignmentGeometry? alignment,
  BoxBorder? border,
  Widget? child,
  List<BoxShadow>? boxShadow,
  BorderRadiusGeometry? customBorderRadius,
  DecorationImage? image,
}) {
  return Container(
    padding: padding,
    alignment: alignment,
    height: height,
    width: width,
    decoration: BoxDecoration(
      color: color,
      borderRadius: customBorderRadius ?? BorderRadius.circular(radius),
      border: border,
      gradient: gradient,
      image: image,
      boxShadow: boxShadow,
    ),
    child: child,
  );
}

Widget imgWidget({
  String? assetFile,
  String? networkUrl,
  File? fileData,
  double? size,
  Uint8List? memoryData,
  BoxBorder? border,
  bool? isCircle,
  double borderRadius = 10,
  Color? color,
  Widget? child,
  List<BoxShadow>? boxShadow,
}) {
  return Container(
    alignment: Alignment.bottomRight,
    height: size,
    width: size,
    decoration: BoxDecoration(
      color: color,
      border: border,
      image: fileData != null
          ? fileImg(fileData)
          : networkUrl != null
              ? networkImg(networkUrl)
              : memoryData != null
                  ? memoryImg(memoryData)
                  : assetFile != null
                      ? assetImg(assetFile)
                      : null,
      borderRadius:
          isCircle != true ? BorderRadius.circular(borderRadius) : null,
      boxShadow: boxShadow,
      shape: isCircle == true ? BoxShape.circle : BoxShape.rectangle,
    ),
    child: child,
  );
}

Widget nTextFormField(
  BuildContext context, {
  required TextEditingController? textController,
  required String hintText,
  double? fontSize,
  Color textColor = Colors.white,
  void Function(String)? onChanged,
  TextAlign textAlign = TextAlign.start,
  int? maxLines,
  int? maxLength,
  bool autofocus = true,
  bool obscureText = false,
  TextInputType? keyboardType,
  TextCapitalization textCapitalization = TextCapitalization.none,
  String? initialValue,
  InputBorder enabledBorder = InputBorder.none,
  InputBorder focusedBorder = InputBorder.none,
}) {
  final safeAreaWidth = MediaQuery.of(context).size.width;
  return TextFormField(
    controller: textController,
    initialValue: initialValue,
    keyboardType: keyboardType,
    textCapitalization: textCapitalization,
    obscureText: obscureText,
    maxLines: maxLines,
    autofocus: autofocus,
    maxLength: maxLength,
    textAlign: textAlign,
    onChanged: onChanged,
    cursorColor: textColor,
    style: TextStyle(
      fontFamily: "Normal",
      fontVariations: const [FontVariation("wght", 400)],
      color: textColor,
      fontSize: fontSize ?? safeAreaWidth / 30,
    ),
    decoration: InputDecoration(
      counterText: '',
      enabledBorder: enabledBorder,
      focusedBorder: focusedBorder,
      hintText: hintText,
      hintStyle: TextStyle(
        fontFamily: "Normal",
        color: Colors.grey,
        fontVariations: const [FontVariation("wght", 400)],
        fontSize: fontSize ?? safeAreaWidth / 30,
      ),
    ),
  );
}

Widget nSliverSizeBox(double height) {
  return SliverToBoxAdapter(
    child: SizedBox(
      height: height,
    ),
  );
}
