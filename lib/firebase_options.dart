// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show TargetPlatform, defaultTargetPlatform, kIsWeb;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBHYQnLNMJjK8TvqW-sMA_z9KKF4IJnObE',
    appId: '1:601413324687:web:97d7855f333cc15eec45fa',
    messagingSenderId: '601413324687',
    projectId: 'denly-app',
    authDomain: 'denly-app.firebaseapp.com',
    storageBucket: 'denly-app.appspot.com',
    measurementId: 'G-45SQM59WB2',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDSFZ87vErv2ZncFrfFCvqMT3g6g6nconU',
    appId: '1:601413324687:android:a705e49254d8b225ec45fa',
    messagingSenderId: '601413324687',
    projectId: 'denly-app',
    storageBucket: 'denly-app.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC6ykbwsbL2CI5KYwzE0cjgTOkRQv4VHAw',
    appId: '1:601413324687:ios:bec1d949386c612eec45fa',
    messagingSenderId: '601413324687',
    projectId: 'denly-app',
    storageBucket: 'denly-app.appspot.com',
    iosBundleId: 'com.denly',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC6ykbwsbL2CI5KYwzE0cjgTOkRQv4VHAw',
    appId: '1:601413324687:ios:a6daa0a88c39566eec45fa',
    messagingSenderId: '601413324687',
    projectId: 'denly-app',
    storageBucket: 'denly-app.appspot.com',
    iosBundleId: 'com.example.denly.RunnerTests',
  );
}
