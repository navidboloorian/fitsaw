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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        return web;
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
    apiKey: 'AIzaSyCE336qsVIlKwIcx3ZLsHpuHDOVH4gI1xc',
    appId: '1:514263577912:web:835b75173c61d17dac3dcd',
    messagingSenderId: '514263577912',
    projectId: 'fitsaw',
    authDomain: 'fitsaw.firebaseapp.com',
    storageBucket: 'fitsaw.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD0M7AOPax7tkGPqExpexmjlOrqj-36k0Y',
    appId: '1:514263577912:android:5c9bf69b48c9f6afac3dcd',
    messagingSenderId: '514263577912',
    projectId: 'fitsaw',
    storageBucket: 'fitsaw.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB0oLRPpBBiOgDKbM1GHof05UW80yXkXPQ',
    appId: '1:514263577912:ios:e43697e6707e7fd8ac3dcd',
    messagingSenderId: '514263577912',
    projectId: 'fitsaw',
    storageBucket: 'fitsaw.appspot.com',
    iosBundleId: 'com.example.fitsaw',
  );
}