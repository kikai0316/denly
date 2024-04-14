import 'package:denly/component/app_bar.dart';
import 'package:denly/component/component.dart';
import 'package:denly/constant/constant.dart';
import 'package:denly/weidget/on_items/on_post_widget.dart';
import 'package:flutter/material.dart';

PreferredSizeWidget? initialAppBar(BuildContext context) {
  final safeAreaWidth = MediaQuery.of(context).size.width;
  return nAppBar(
    context,
    isLeftIcon: false,
    backgroundColor: Colors.white.withOpacity(0.1),
    customTitle: nText(
      "Denly",
      fontSize: safeAreaWidth / 15,
      bold: 800,
      color: Colors.black,
    ),
    // customRightIcon: Row(
    //   mainAxisAlignment: MainAxisAlignment.end,
    //   children: [
    //     for (int i = 0; i < 2; i++)
    //       Padding(
    //         padding: customPadding(left: safeAreaWidth * 0.04),
    //         child: nContainer(
    //           height: safeAreaWidth * 0.12,
    //           width: safeAreaWidth * 0.12,
    //           radius: 10,
    //           color: Colors.grey.withOpacity(0.2),
    //         ),
    //       )
    //   ],
    // )
  );
}

Widget postListWidget(BuildContext context) {
  final safeAreaWidth = MediaQuery.of(context).size.width;
  return SliverToBoxAdapter(
    child: Padding(
      padding: xPadding(context),
      child: SizedBox(
        width: safeAreaWidth,
        child: Wrap(
          runSpacing: 8,
          alignment: WrapAlignment.spaceBetween,
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
