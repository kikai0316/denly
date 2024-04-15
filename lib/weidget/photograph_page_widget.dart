import 'dart:typed_data';

import 'package:denly/component/button.dart';
import 'package:denly/component/component.dart';
import 'package:denly/constant/constant.dart';
import 'package:flutter/material.dart';

Widget photographShootingButtonWidget(
  BuildContext context, {
  required bool isAccess,
  required ValueNotifier<bool> isFlash,
  required void Function(bool) flashTapEvent,
  required VoidCallback returnTapEvent,
  required VoidCallback shootingTapEvent,
  required ValueNotifier<int> shootingType,
}) {
  final safeAreaWidth = MediaQuery.of(context).size.width;
  Widget photographPageIconWidget(
    IconData icon, {
    required VoidCallback? onTap,
  }) =>
      CustomAnimatedOpacityButton(
        onTap: onTap,
        child: Icon(
          icon,
          color: Colors.white,
          size: safeAreaWidth / 9,
        ),
      );
  return Expanded(
    child: Opacity(
      opacity: isAccess ? 1 : 0.3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Padding(
          //   padding: customPadding(bottom: safeAreaHeight * 0.02),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       for (int i = 0; i < 2; i++)
          //         CustomAnimatedOpacityButton(
          //           onTap: () => shootingType.value = i,
          //           child: nContainer(
          //             alignment: Alignment.center,
          //             height: safeAreaHeight * 0.045,
          //             width: safeAreaWidth * 0.2,
          //             customBorderRadius: mainCustomBorderRadius(
          //               10,
          //               isBottomLeft: i == 0,
          //               isTopLeft: i == 0,
          //               isBottomRight: i == 1,
          //               isTopRight: i == 1,
          //             ),
          //             color: shootingType.value == i ? Colors.white : null,
          //             border: mainBorder(),
          //             child: nText(
          //               ["通常モード", "ぶれモード"][i],
          //               fontSize: safeAreaWidth / 40,
          //               color: shootingType.value == i
          //                   ? Colors.black
          //                   : Colors.white,
          //               bold: 800,
          //             ),
          //           ),
          //         ),
          //     ],
          //   ),
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              photographPageIconWidget(
                isFlash.value ? Icons.flash_on : Icons.flash_off,
                onTap: isAccess
                    ? () {
                        isFlash.value = !isFlash.value;
                        flashTapEvent(isFlash.value);
                      }
                    : null,
              ),
              CustomAnimatedOpacityButton(
                onTap: isAccess ? shootingTapEvent : null,
                child: nContainer(
                  alignment: Alignment.center,
                  height: safeAreaWidth * 0.22,
                  width: safeAreaWidth * 0.22,
                  radius: 100,
                  border: mainBorder(
                    color: Colors.white,
                    width: 6,
                  ),
                ),
              ),
              photographPageIconWidget(
                Icons.cached,
                onTap: isAccess ? returnTapEvent : null,
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget photographPostButtonWidget(
  BuildContext context, {
  required ValueNotifier<Uint8List?> picture,
  required VoidCallback postTapEvent,
}) {
  final safeAreaWidth = MediaQuery.of(context).size.width;

  return Expanded(
    child: Container(
      alignment: Alignment.center,
      child: CustomAnimatedOpacityButton(
        onTap: postTapEvent,
        child: Container(
          width: safeAreaWidth * 0.33,
          padding: EdgeInsets.all(safeAreaWidth * 0.01),
          color: Colors.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              nText(
                "投稿",
                fontSize: safeAreaWidth / 10,
              ),
              Padding(
                padding: customPadding(top: safeAreaWidth * 0.01),
                child: Icon(
                  Icons.send,
                  color: Colors.white,
                  size: safeAreaWidth / 12,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget afterTakingPhoto(
  BuildContext context,
  Uint8List picture, {
  required VoidCallback cancelOnTap,
  required VoidCallback saveOnTap,
}) {
  final safeAreaWidth = MediaQuery.of(context).size.width;
  return imgWidget(
    size: double.infinity,
    borderRadius: 40,
    memoryData: picture,
    child: Padding(
      padding: EdgeInsets.all(safeAreaWidth * 0.04),
      child: Stack(
        children: [
          for (int i = 0; i < 2; i++)
            Align(
              alignment: [
                Alignment.topRight,
                Alignment.bottomRight,
              ][i],
              child: GestureDetector(
                onTap: [cancelOnTap, saveOnTap][i],
                child: nContainer(
                  height: safeAreaWidth * 0.09,
                  width: safeAreaWidth * 0.09,
                  radius: 50,
                  color: Colors.black.withOpacity(0.3),
                  child: Icon(
                    [
                      Icons.close,
                      Icons.save_alt,
                    ][i],
                    color: Colors.white,
                    size: safeAreaWidth / 20,
                  ),
                ),
              ),
            ),
        ],
      ),
    ),
  );
}
