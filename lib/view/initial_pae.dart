import 'dart:async';

import 'package:denly/component/component.dart';
import 'package:denly/constant/constant.dart';
import 'package:denly/view_model/post_data.dart';
import 'package:denly/weidget/initial_page_widget.dart';
import 'package:denly/weidget/on_items/on_post_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

Timer? timer;

class InitialPage extends HookConsumerWidget {
  const InitialPage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final safeAreaHeight = safeHeight(context);
    final timeText = useState<String>("");
    final postState = ref.watch(allFriendsNotifierProvider);
    void startTimer(DateTime time) {
      final DateTime targetTime = time.add(const Duration(hours: 1));
      timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        final now = DateTime.now();
        final difference = targetTime.difference(now);
        final String minutes =
            difference.inMinutes.remainder(60).toString().padLeft(2, '0');
        final String seconds =
            difference.inSeconds.remainder(60).toString().padLeft(2, '0');
        timeText.value = "$minutes分$seconds秒";
      });
    }

    final post = postState.when(
      data: (value) {
        if (value != null) {
          startTimer(value["time"] as DateTime);
        }
        return value;
      },
      error: (e, s) => null,
      loading: () => null,
    );

    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.black,
      appBar: initialAppBar(context),
      body: Padding(
        padding: xPadding(context),
        child: CustomScrollView(
          slivers: [
            timeWidget(context, post, timeText.value),
            if (post != null) searchResultsWidget(context),
            for (int i = 0; i < 2; i++)
              if (post != null)
                const OnPostWidget(
                  img:
                      "https://i.pinimg.com/474x/f5/0b/96/f50b96edeb0d5492af52386dde13c8ea.jpg",
                ),
            nSliverSizeBox(safeAreaHeight * 0.07),
          ],
        ),
      ),
      bottomNavigationBar: post == null ? bottomNavigator(context) : null,
    );
  }
}
