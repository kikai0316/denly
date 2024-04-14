import 'package:denly/component/button.dart';
import 'package:denly/component/component.dart';
import 'package:denly/constant/color.dart';
import 'package:denly/constant/constant.dart';
import 'package:denly/weidget/initial_page_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class InitialPage extends HookConsumerWidget {
  const InitialPage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final safeAreaHeight = safeHeight(context);
    final safeAreaWidth = MediaQuery.of(context).size.width;
    final pageIndex = useState<int>(0);
    return Scaffold(
      extendBody: true,
      backgroundColor: whiteColor,
      appBar: initialAppBar(context),
      body: CupertinoTheme(
        data: const CupertinoThemeData(
          brightness: Brightness.light,
        ),
        child: CustomScrollView(
          slivers: [
            CupertinoSliverRefreshControl(
              onRefresh: () async {
                await Future<void>.delayed(const Duration(seconds: 1));
              },
            ),
            nSliverSizeBox(
              safeAreaHeight * 0.005,
            ),
            postListWidget(
              context,
            ),
          ],
        ),
      ),
      bottomNavigationBar: nContainer(
        alignment: Alignment.topCenter,
        padding: customPadding(top: safeAreaHeight * 0.01),
        height: safeAreaHeight * 0.1,
        color: Colors.white,
        radius: 30,
        border: mainBorder(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            for (int i = 0; i < 3; i++)
              CustomAnimatedOpacityButton(
                onTap: () => pageIndex.value = i,
                child: Column(
                  children: [
                    Opacity(
                      opacity: pageIndex.value == i ? 1 : 0.2,
                      child: imgWidget(
                        size: safeAreaWidth * 0.08,
                        assetFile: [
                          "icon_home.png",
                          "icon_like.png",
                          "icon_account.png",
                        ][i],
                      ),
                    ),
                    if (pageIndex.value == i)
                      Padding(
                        padding: customPadding(top: safeAreaHeight * 0.006),
                        child: nContainer(
                          width: safeAreaWidth * 0.015,
                          height: safeAreaWidth * 0.015,
                          gradient: mainGradation(),
                          radius: 50,
                        ),
                      ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
