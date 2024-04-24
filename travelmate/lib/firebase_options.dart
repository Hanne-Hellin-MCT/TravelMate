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
    apiKey: 'AIzaSyAP0a7C-ceIpVLh7iCs0IIJpTdTzvPwcZY',
    appId: '1:445887112576:web:30d5cb9dfacfcbb4cf8d65',
    messagingSenderId: '445887112576',
    projectId: 'travelmate-b5dee',
    authDomain: 'travelmate-b5dee.firebaseapp.com',
    storageBucket: 'travelmate-b5dee.appspot.com',
    measurementId: 'G-VSGPZ4S9HP',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBs_PRbG_X7Gvb7x4T1efqHNFVIrOF50QQ',
    appId: '1:445887112576:android:77b5c624889b7a0ccf8d65',
    messagingSenderId: '445887112576',
    projectId: 'travelmate-b5dee',
    storageBucket: 'travelmate-b5dee.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBD2xwMvn6h_GC5p9cixIhDvnf3j0h1mhY',
    appId: '1:445887112576:ios:8b81eda9c5cfb269cf8d65',
    messagingSenderId: '445887112576',
    projectId: 'travelmate-b5dee',
    storageBucket: 'travelmate-b5dee.appspot.com',
    iosClientId: '445887112576-t0febuc7paqshil4qdhd3aosukaa2jm5.apps.googleusercontent.com',
    iosBundleId: 'com.example.travelmate',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBD2xwMvn6h_GC5p9cixIhDvnf3j0h1mhY',
    appId: '1:445887112576:ios:bb40172c23a2ad9acf8d65',
    messagingSenderId: '445887112576',
    projectId: 'travelmate-b5dee',
    storageBucket: 'travelmate-b5dee.appspot.com',
    iosClientId: '445887112576-vod023o6tbgpf19dd14aj1thklbqqo8b.apps.googleusercontent.com',
    iosBundleId: 'com.example.travelmate.RunnerTests',
  );
}