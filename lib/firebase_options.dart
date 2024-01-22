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
    apiKey: 'AIzaSyDYTRWdSfDHhhzW0mHCbcB8BNgID8q730o',
    appId: '1:834529612881:web:c8751a78f90acb14f61470',
    messagingSenderId: '834529612881',
    projectId: 'herogamescase',
    authDomain: 'herogamescase.firebaseapp.com',
    storageBucket: 'herogamescase.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBKxBZLqzocmfHbFYliudst0ZA8t0ouphg',
    appId: '1:834529612881:android:ed79aae3c774a625f61470',
    messagingSenderId: '834529612881',
    projectId: 'herogamescase',
    storageBucket: 'herogamescase.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB0ZAN0Tw7UsZKxP5opX_lZWM_Nb4oZxzI',
    appId: '1:834529612881:ios:fbad74028c4dc2a6f61470',
    messagingSenderId: '834529612881',
    projectId: 'herogamescase',
    storageBucket: 'herogamescase.appspot.com',
    iosBundleId: 'com.example.heroGamesCase',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB0ZAN0Tw7UsZKxP5opX_lZWM_Nb4oZxzI',
    appId: '1:834529612881:ios:fdf7de676c8e771af61470',
    messagingSenderId: '834529612881',
    projectId: 'herogamescase',
    storageBucket: 'herogamescase.appspot.com',
    iosBundleId: 'com.example.heroGamesCase.RunnerTests',
  );
}