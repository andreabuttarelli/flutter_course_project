// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
    apiKey: 'AIzaSyB2_1REvsLsnUiXVkZXoqOqLSPyD7oW6Bo',
    appId: '1:256123582413:web:291c092db43c791e667684',
    messagingSenderId: '256123582413',
    projectId: 'daeliminare-c59bb',
    authDomain: 'daeliminare-c59bb.firebaseapp.com',
    storageBucket: 'daeliminare-c59bb.appspot.com',
    measurementId: 'G-PVGFQF55QF',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCBDl35yA-yq2wNC0i6qeLnLJILeqgMFOI',
    appId: '1:256123582413:android:362aaabecce8b9e5667684',
    messagingSenderId: '256123582413',
    projectId: 'daeliminare-c59bb',
    storageBucket: 'daeliminare-c59bb.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDGfSaAQSBmTpV0Mc8-VN0sc9xmsMB1wcY',
    appId: '1:256123582413:ios:25e50f58a7f320ee667684',
    messagingSenderId: '256123582413',
    projectId: 'daeliminare-c59bb',
    storageBucket: 'daeliminare-c59bb.appspot.com',
    iosBundleId: 'com.example.firebaseApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDGfSaAQSBmTpV0Mc8-VN0sc9xmsMB1wcY',
    appId: '1:256123582413:ios:5d8f36dc4e2ff277667684',
    messagingSenderId: '256123582413',
    projectId: 'daeliminare-c59bb',
    storageBucket: 'daeliminare-c59bb.appspot.com',
    iosBundleId: 'com.example.firebaseApp.RunnerTests',
  );
}
