import 'package:denly/component/button.dart';
import 'package:denly/component/component.dart';
import 'package:denly/constant/color.dart';
import 'package:denly/constant/constant.dart';
import 'package:denly/constant/img.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class OnPostWidget extends HookConsumerWidget {
  const OnPostWidget({super.key, required this.img});
  final String img;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final safeAreaWidth = MediaQuery.of(context).size.width;
    final isLike = useState<bool>(false);
    return SizedBox(
      width: safeAreaWidth * 0.45,
      child: AspectRatio(
        aspectRatio: 3 / 4,
        child: CustomAnimatedOpacityButton(
          onTap: () {},
          child: nContainer(
            color: Colors.grey.withOpacity(0.2),
            border: mainBorder(),
            image: networkImg(img),
            radius: 20,
            child: Stack(
              alignment: Alignment.center,
              children: [
                nText(
                  "17:00",
                  fontSize: safeAreaWidth / 30,
                  shadows: mainBoxShadow(shadow: 1),
                ),
                drunkennessBar(context),
                likeWidget(context, isLike),
              ],
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
        child: nContainer(
          alignment: Alignment.centerLeft,
          height: safeAreaHeight * 0.004,
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
      ),
    );
  }

  Widget likeWidget(BuildContext context, ValueNotifier<bool> isLike) {
    final safeAreaWidth = MediaQuery.of(context).size.width;
    return Align(
      alignment: const Alignment(1.02, 1.02),
      child: CustomAnimatedOpacityButton(
        onTap: () => isLike.value = !isLike.value,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: EdgeInsets.all(safeAreaWidth * 0.025),
          alignment: Alignment.bottomRight,
          // height: safeAreaWidth * 0.14,
          // width: safeAreaWidth * 0.14,
          height: safeAreaWidth * 0.4,
          width: safeAreaWidth * 0.4,
          decoration: BoxDecoration(
            borderRadius: mainCustomBorderRadius(
              20,
              customTopLeft: 200,
              isBottomRight: true,
              isTopLeft: true,
            ),
            gradient: mainGradation(),
          ),
          child: Icon(
            Icons.favorite,
            color: Colors.white.withOpacity(0.5),
          ),
        ),
      ),
    );
  }
}
