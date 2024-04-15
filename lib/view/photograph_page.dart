import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:camera/camera.dart';
import 'package:denly/component/app_bar.dart';
import 'package:denly/component/component.dart';
import 'package:denly/component/loading.dart';
import 'package:denly/constant/constant.dart';
import 'package:denly/constant/img.dart';
import 'package:denly/model/model.dart';
import 'package:denly/utility/permission_handler_utility.dart';
import 'package:denly/view_model/post_data.dart';
import 'package:denly/weidget/photograph_page_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shake/shake.dart';

CameraController? cameraController;
// ShakeDetector? detector;
GlobalKey repaintBoundaryKey = GlobalKey();

class PhotographPage extends HookConsumerWidget {
  const PhotographPage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final safeAreaHeight = safeHeight(context);
    final safeAreaWidth = MediaQuery.of(context).size.width;
    final isFlash = useState<bool>(false);
    final isFrontCamera = useState<bool>(false);
    final isLoading = useState(false);
    final picture = useState<Uint8List?>(null);
    final isTakePictureLoading = useState<bool>(false);
    final shotingType = useState<int>(0);
    final camControllerState =
        useState<CamControllerState>(CamControllerState.unInitialize);
    useEffect(
      () {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          try {
            cameraControllerInitialize(
              context,
              camControllerState,
              isFrontCamera,
            );

            ShakeDetector.autoStart(
              shakeThresholdGravity: 1.2,
              shakeSlopTimeMS: 1000,
              onPhoneShake: () => takePicture(context, picture, isLoading),
            );
          } catch (e) {
            return;
          }
        });
        return () {
          cameraController?.dispose();
          // detector.stopListening();
        };
      },
      [],
    );

    return Stack(
      children: [
        Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.black,
          appBar: nAppBar(
            context,
            customTitle: nContainer(
              height: safeAreaHeight * 0.06,
              width: safeAreaWidth * 0.15,
              image: assetImg("logo.png"),
            ),
          ),
          body: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: yPadding(context),
                  child: AspectRatio(
                    aspectRatio: 3 / 4,
                    child: Stack(
                      children: [
                        SizedBox(
                          child: picture.value != null
                              ? afterTakingPhoto(
                                  context,
                                  picture.value!,
                                  cancelOnTap: () => picture.value = null,
                                  saveOnTap: () => saveImageToGallery(
                                    context,
                                    picture.value!,
                                    isLoading,
                                  ),
                                )
                              : () {
                                  switch (camControllerState.value) {
                                    case CamControllerState.success:
                                      return ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                          40,
                                        ),
                                        child: RepaintBoundary(
                                          key: repaintBoundaryKey,
                                          child: CameraPreview(
                                            cameraController!,
                                          ),
                                        ),
                                      );
                                    case CamControllerState.systemError:
                                      return const SizedBox();
                                    case CamControllerState.accessError:
                                      return const SizedBox();
                                    case CamControllerState.unInitialize:
                                      return const SizedBox();
                                  }
                                }(),
                        ),
                        if (picture.value == null)
                          AnimatedOpacity(
                            duration: const Duration(milliseconds: 100),
                            opacity: isTakePictureLoading.value ? 1 : 0,
                            child: nContainer(
                              height: double.infinity,
                              color: Colors.black,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                if (picture.value == null)
                  photographShootingButtonWidget(
                    context,
                    isAccess:
                        camControllerState.value == CamControllerState.success,
                    isFlash: isFlash,
                    flashTapEvent: (value) {
                      final flashMode = value ? FlashMode.torch : FlashMode.off;
                      cameraController?.setFlashMode(flashMode);
                    },
                    returnTapEvent: () => cameraControllerInitialize(
                      context,
                      camControllerState,
                      isFrontCamera,
                    ),
                    shootingTapEvent: () => takePicture(
                      context,
                      picture,
                      isTakePictureLoading,
                    ),
                    shootingType: shotingType,
                  ),
                if (picture.value != null)
                  photographPostButtonWidget(
                    context,
                    picture: picture,
                    postTapEvent: () async {
                      isLoading.value = true;
                      final allFriendsNotifier =
                          ref.read(allFriendsNotifierProvider.notifier);
                      await allFriendsNotifier.upData(
                          {"img": picture.value, "time": DateTime.now()},);
                      isLoading.value = false;
                      // ignore: use_build_context_synchronously
                      Navigator.pop(context);
                    },
                  ),
              ],
            ),
          ),
        ),
        loadinPage(
          context: context,
          isLoading: isLoading.value,
          text: "アップロード中です...",
        ),
      ],
    );
  }

  Future<void> cameraControllerInitialize(
    BuildContext context,
    ValueNotifier<CamControllerState> camControllerState,
    ValueNotifier<bool> isFrontCamera,
  ) async {
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      final isPermission = await checkCameraPermission();
      if (!context.mounted) return;
      if (!isPermission) {
        camControllerState.value = CamControllerState.accessError;
        return;
      }
      final cameras = await availableCameras();
      if (!context.mounted) return;
      try {
        if (!isFrontCamera.value) {
          final frontCamera = cameras.firstWhere(
            (camera) => camera.lensDirection == CameraLensDirection.front,
            orElse: () => cameras.first,
          );
          cameraController =
              CameraController(frontCamera, ResolutionPreset.medium);
          await cameraController?.initialize();
          isFrontCamera.value = true;
        } else {
          cameraController =
              CameraController(cameras.first, ResolutionPreset.medium);
          await cameraController?.initialize();
          isFrontCamera.value = false;
        }

        camControllerState.value = CamControllerState.success;
      } catch (error) {
        camControllerState.value = CamControllerState.systemError;
        cameraController?.dispose();
      }
    });
  }

  Future<void> takePicture(
    BuildContext context,
    ValueNotifier<Uint8List?> picture,
    ValueNotifier<bool> isLoading,
  ) async {
    try {
      isLoading.value = true;
      final RenderRepaintBoundary boundary = repaintBoundaryKey.currentContext!
          .findRenderObject()! as RenderRepaintBoundary;
      final ui.Image image = await boundary.toImage();
      final ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      if (!context.mounted) return;
      if (byteData == null) {
        isLoading.value = false;
        return;
      }
      isLoading.value = false;
      picture.value = byteData.buffer.asUint8List();
    } catch (e) {
      isLoading.value = false;
      return;
    }
  }

  Future<void> saveImageToGallery(
    BuildContext context,
    Uint8List imageBytes,
    ValueNotifier<bool> isLoading,
  ) async {
    // try {
    //   isLoading.value = true;
    //   final isPermission = await checkPhotoPermission();
    //   if (!context.mounted) return;
    //   if (!isPermission) {
    //     isLoading.value = false;
    //     showAlertDialog(
    //       context,
    //       title: "カメラへのアクセス権がありません。",
    //       subTitle: eMessageNotPhotoPermission,
    //       rightButtonText: "設定画面へ",
    //       leftButtonText: "キャンセル",
    //       rightButtonOnTap: () => openAppSettings(),
    //     );
    //     return;
    //   }
    //   await ImageGallerySaver.saveImage(imageBytes);
    //   if (!context.mounted) return;
    //   isLoading.value = false;
    //   showAlertDialog(
    //     context,
    //     title: "保存が完了しました",
    //     leftButtonText: "とじる",
    //   );
    // } catch (e) {
    //   isLoading.value = false;
    //   errorAlertDialog(context, subTitle: eMessageSystem);
    //   return;
    // }
  }

  // Future<void> postEvent(
  //   BuildContext context,
  //   WidgetRef ref,
  //   Uint8List imageBytes,
  //   ValueNotifier<bool> isLoading,
  //   String nowState,
  //   bool isWakeUp,
  // ) async {
  //   try {
  //     isLoading.value = true;
  //     final nowTime = DateTime.now();
  //     final File file = await localFile("captured_image.png");
  //     await file.writeAsBytes(
  //       imageBytes,
  //     );
  //     final compressedFile = await FlutterImageCompress.compressAndGetFile(
  //       file.absolute.path,
  //       "${file.absolute.path}_bubu.jpg",
  //       quality: 60,
  //     );
  //     if (!context.mounted) return;
  //     if (compressedFile == null) {
  //       isLoading.value = false;
  //       errorAlertDialog(context, subTitle: eMessageSystem);
  //       return;
  //     }
  //     final fileImg = File(compressedFile.path);
  //     final postUpload = isWakeUp
  //         ? await dbStorageWakeUpPostUpload(
  //             id: myProfile.openId,
  //             img: fileImg,
  //             onError: () {
  //               errorAlertDialog(context, subTitle: eMessageSystem);
  //             },
  //           )
  //         : await dbStoragePostUpload(
  //             nowTime: nowTime,
  //             id: myProfile.openId,
  //             img: fileImg,
  //             nowState: nowState,
  //             onTimeOut: () {
  //               isLoading.value = false;
  //               errorAlertDialog(
  //                 context,
  //                 subTitle: "投稿時間が過ぎてしまいました。次の投稿時間までお待ちください。",
  //               );
  //             },
  //             onError: () {
  //               isLoading.value = false;
  //               errorAlertDialog(context, subTitle: eMessageSystem);
  //             },
  //           );
  //     if (!context.mounted || postUpload == null) return;
  //     final postTimeType =
  //         isWakeUp ? PostTimeType.wakeUp : getPostTimeType(nowTime)!;
  //     final postListData = postListTypeUpDate(
  //       myProfile.postList,
  //       postTimeType,
  //       PostType(
  //         postImg: postUpload,
  //         postDateTime: nowTime,
  //         doing: nowState,
  //       ),
  //     );

  //     final userDataNotifier = ref.read(userDataNotifierProvider.notifier);
  //     await userDataNotifier.userDataUpDate(
  //       userTypeUpDate(myProfile, postListType: postListData),
  //     );
  //     await localWritePastPostData(
  //       postTimeType,
  //       PastPostType(
  //         postImgPath: fileImg.path,
  //         doing: nowState,
  //         postDateTime: nowTime,
  //       ),
  //     );
  //     if (!context.mounted) return;
  //     isLoading.value = false;
  //     Navigator.pop(context);
  //     successSnackbar(context, "投稿のアップロードに成功しました！");
  //   } catch (e) {
  //     if (!context.mounted) return;
  //     isLoading.value = false;
  //     errorAlertDialog(context, subTitle: eMessageSystem);
  //   }
  // }
}
