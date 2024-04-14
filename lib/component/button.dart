import 'package:denly/component/component.dart';
import 'package:denly/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CustomAnimatedOpacityButton extends HookConsumerWidget {
  const CustomAnimatedOpacityButton({
    super.key,
    required this.onTap,
    required this.child,
    this.onLongPress,
    this.opacity,
  });
  final Widget child;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final double? opacity;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isTapEvent = useState<bool>(false);
    return GestureDetector(
      onTap: onTap != null
          ? () {
              isTapEvent.value = false;
              onTap?.call();
            }
          : null,
      onLongPress: onLongPress,
      onTapDown: onTap != null ? (_) => isTapEvent.value = true : null,
      onTapCancel: onTap != null ? () => isTapEvent.value = false : null,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 100),
        opacity: isTapEvent.value ? opacity ?? 0.6 : 1,
        child: child,
      ),
    );
  }
}

Widget mainButton(
  BuildContext context, {
  required String text,
  required VoidCallback? onTap,
  Color? backGroundColor,
  Color textColor = Colors.white,
  double? height,
  double? width,
  double? fontSize,
  double radius = 15,
  List<BoxShadow>? boxShadow,
  Color? borderColor,
  AlignmentGeometry alignment = Alignment.center,
  Widget? customWidget,
}) {
  final safeAreaHeight = safeHeight(context);
  final safeAreaWidth = MediaQuery.of(context).size.width;
  return CustomAnimatedOpacityButton(
    onTap: onTap,
    child: Container(
      padding: xPadding(context),
      alignment: alignment,
      height: height ?? safeAreaHeight * 0.07,
      width: width ?? safeAreaWidth,
      decoration: BoxDecoration(
        color: backGroundColor,
        border: borderColor != null ? Border.all(color: borderColor) : null,
        borderRadius: BorderRadius.circular(radius),
        boxShadow: boxShadow,
      ),
      child: customWidget ??
          nText(
            text,
            color: textColor,
            fontSize: fontSize ?? safeAreaWidth / 28,
            bold: 700,
          ),
    ),
  );
}
