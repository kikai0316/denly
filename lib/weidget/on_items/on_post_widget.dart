import 'dart:ui';

import 'package:denly/component/button.dart';
import 'package:denly/component/component.dart';
import 'package:denly/constant/color.dart';
import 'package:denly/constant/constant.dart';
import 'package:denly/constant/img.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class OnPostWidget extends HookConsumerWidget {
  const OnPostWidget({super.key, required this.img});
  final String img;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final safeAreaWidth = MediaQuery.of(context).size.width;
    final safeAreaHeight = safeHeight(context);
    return SliverToBoxAdapter(
      child: Padding(
        padding: customPadding(top: safeAreaHeight * 0.03),
        child: AspectRatio(
          aspectRatio: 3 / 4,
          child: CustomAnimatedOpacityButton(
            onTap: () {},
            child: nContainer(
              padding: EdgeInsets.all(safeAreaWidth * 0.03),
              color: Colors.grey.withOpacity(0.1),
              border: mainBorder(),
              image: networkImg(img),
              radius: 20,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  nText(
                    "17:01",
                    fontSize: safeAreaWidth / 20,
                    shadows: mainBoxShadow(shadow: 1),
                  ),
                  // drunkennessBar(context),
                  likeWidget(
                    context,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget drunkennessBar(BuildContext context) {
    final safeAreaWidth = MediaQuery.of(context).size.width;
    final safeAreaHeight = safeHeight(context);
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: EdgeInsets.all(safeAreaWidth * 0.03),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            nContainer(
              alignment: Alignment.centerLeft,
              height: safeAreaHeight * 0.006,
              width: safeAreaWidth,
              radius: 50,
              color: Colors.grey.withOpacity(0.3),
              child: FractionallySizedBox(
                widthFactor: 0.2,
                child: nContainer(
                  height: double.infinity,
                  gradient: mainGradation(),
                  radius: 50,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget likeWidget(
    BuildContext context,
  ) {
    final safeAreaWidth = MediaQuery.of(context).size.width;
    final safeAreaHeight = safeHeight(context);

    return Align(
      alignment: Alignment.bottomCenter,
      child: Row(
        children: [
          Expanded(
            child: ClipRect(
// <-- clips to the 200x200 [Container] below
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 10.0,
                  sigmaY: 10.0,
                ),
                child: nContainer(
                  alignment: Alignment.center,
                  height: safeAreaHeight * 0.065,
                  radius: 50,
                  color: Colors.white.withOpacity(
                    0.1,
                  ),
                  child: nText(
                    "メッセージ送信...",
                    fontSize: safeAreaWidth / 25,
                    color: Colors.white.withOpacity(0.5),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: xPadding(context),
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 10.0,
                  sigmaY: 10.0,
                ),
                child: nContainer(
                  alignment: Alignment.center,
                  height: safeAreaHeight * 0.065,
                  width: safeAreaHeight * 0.065,
                  radius: 50,
                  color: Colors.white.withOpacity(
                    0.1,
                  ),
                  child: Icon(
                    Icons.favorite_border,
                    color: Colors.white.withOpacity(0.5),
                    // size: safeAreaWidth / 13,
                  ),
                ),
              ),
            ),
          ),
          // Padding(
          //   padding: xPadding(context),
          //   child: Icon(
          //     Icons.favorite_border,
          //     color: Colors.white,
          //     size: safeAreaWidth / 13,
          //   ),
          // )
        ],
      ),
    );
  }
}
