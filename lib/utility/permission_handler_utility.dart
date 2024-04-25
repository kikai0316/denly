import 'package:permission_handler/permission_handler.dart';

Future<bool> checkCameraPermission() async {
  final cameraStatus = await Permission.camera.status;
  if (cameraStatus.isGranted) {
    return true;
  } else if (cameraStatus.isDenied) {
    final requested = await Permission.camera.request();
    return requested.isGranted;
  } else if (cameraStatus.isPermanentlyDenied) {
    return false;
  } else {
    final requested = await Permission.camera.request();
    return requested.isGranted;
  }
}
