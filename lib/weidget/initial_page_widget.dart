import 'dart:typed_data';

import 'package:denly/component/app_bar.dart';
import 'package:denly/component/button.dart';
import 'package:denly/component/component.dart';
import 'package:denly/constant/constant.dart';
import 'package:denly/constant/img.dart';
import 'package:denly/utility/screen_transition_utility.dart';
import 'package:denly/view/photograph_page.dart';
import 'package:denly/weidget/on_items/on_post_widget.dart';
import 'package:flutter/material.dart';

PreferredSizeWidget? initialAppBar(BuildContext context) {
  final safeAreaWidth = MediaQuery.of(context).size.width;
  final safeAreaHeight = safeHeight(context);
  return nAppBar(
    context,
    customRightIcon: imgWidget(
      assetFile: "talk.png",
      size: safeAreaWidth * 0.13,
      borderRadius: 50,
    ),
    customLeftIcon: imgWidget(
      size: safeAreaWidth * 0.1,
      borderRadius: 50,
      networkUrl:
          "https://i.pinimg.com/474x/25/81/ce/2581ce9b2b1d60d3123bb34f91eafdaf.jpg",
    ),
    customTitle: nContainer(
      height: safeAreaHeight * 0.06,
      width: safeAreaWidth * 0.15,
      image: assetImg("logo.png"),
    ),
  );
}

Widget postListWidget(BuildContext context) {
  final safeAreaWidth = MediaQuery.of(context).size.width;
  return SliverToBoxAdapter(
    child: Padding(
      padding: xPadding(context),
      child: SizedBox(
        width: safeAreaWidth,
        child: Column(
          children: [
            for (int i = 0; i < 6; i++)
              const OnPostWidget(
                img:
                    "https://i.pinimg.com/474x/f5/0b/96/f50b96edeb0d5492af52386dde13c8ea.jpg",
              ),
            if (6.isOdd)
              SizedBox(
                width: safeAreaWidth * 0.4,
              ),
          ],
        ),
      ),
    ),
  );
}

Widget bottomNavigator(BuildContext context) {
  final safeAreaWidth = MediaQuery.of(context).size.width;
  final safeAreaHeight = safeHeight(context);
  return CustomAnimatedOpacityButton(
    onTap: () => ScreenTransition(context, const PhotographPage()).top(),
    child: nContainer(
      alignment: Alignment.center,
      height: safeAreaHeight * 0.2,
      width: safeAreaWidth,
      child: nContainer(
        height: safeAreaHeight * 0.12,
        width: safeAreaHeight * 0.12,
        radius: 100,
        border: mainBorder(
          color: Colors.white,
          width: 5,
        ),
      ),
    ),
  );
}

Widget timeWidget(
  BuildContext context,
  Map<String, dynamic>? post,
  String time,
) {
  final safeAreaWidth = MediaQuery.of(context).size.width;
  final safeAreaHeight = safeHeight(context);

  return SliverToBoxAdapter(
    child: Padding(
      padding: yPadding(context),
      child: nContainer(
        alignment: Alignment.center,
        height: safeAreaHeight * 0.18,
        width: safeAreaWidth,
        radius: 20,
        image: assetImg("bg.png"),
        child: post != null
            ? Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(safeAreaWidth * 0.03),
                    child: AspectRatio(
                      aspectRatio: 3 / 4,
                      child: CustomAnimatedOpacityButton(
                        onTap: () {},
                        child: nContainer(
                          padding: EdgeInsets.all(safeAreaWidth * 0.03),
                          color: Colors.grey.withOpacity(0.1),
                          border: mainBorder(),
                          image: memoryImg(post["img"] as Uint8List),
                          radius: 15,
                        ),
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (int i = 0; i < 2; i++)
                        Padding(
                          padding:
                              yPadding(context, ySize: safeAreaHeight * 0.006),
                          child: Row(
                            children: [
                              Padding(
                                padding:
                                    customPadding(right: safeAreaWidth * 0.02),
                                child: Icon(
                                  [Icons.location_on, Icons.schedule][i],
                                  color: Colors.white.withOpacity(0.5),
                                ),
                              ),
                              nText(
                                ["東京都大田区北千束", time][i],
                                fontSize: safeAreaWidth / 25,
                                bold: 800,
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ],
              )
            : nText(
                "投稿して、周囲の人との出会を体験しよう！",
                fontSize: safeAreaWidth / 25,
                color: Colors.white.withOpacity(0.5),
                bold: 700,
              ),
      ),
    ),
  );
}

Widget searchResultsWidget(BuildContext context) {
  final safeAreaWidth = MediaQuery.of(context).size.width;
  return SliverToBoxAdapter(
    child: Padding(
      padding: yPadding(context),
      child: Row(
        children: [
          for (int i = 0; i < 2; i++) ...{
            Expanded(
              child: line(),
            ),
            if (i == 0)
              Padding(
                padding: xPadding(context, xSize: safeAreaWidth * 0.05),
                child: nText("2人のユーザーが見つかりました", fontSize: safeAreaWidth / 30),
              ),
          },
        ],
      ),
    ),
  );
}
