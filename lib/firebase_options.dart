// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
    apiKey: 'AIzaSyDg9K_vjg6HHZ8AGVtjLh46VE0F0e6dcDw',
    appId: '1:1042956991838:web:2c6763e086c7b91423a3cf',
    messagingSenderId: '1042956991838',
    projectId: 'chat-23e5b',
    authDomain: 'chat-23e5b.firebaseapp.com',
    storageBucket: 'chat-23e5b.appspot.com',
    measurementId: 'G-1CH23RX726',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDotvcElpC-7kQGDpZiTaAmrMO5zZ7Kt0U',
    appId: '1:1042956991838:android:f01e1e7f53f9669123a3cf',
    messagingSenderId: '1042956991838',
    projectId: 'chat-23e5b',
    storageBucket: 'chat-23e5b.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD7Zp0SSoVu0bVuU_0YLXEARVntj-lZxJk',
    appId: '1:1042956991838:ios:6a8c1d64a7646f3e23a3cf',
    messagingSenderId: '1042956991838',
    projectId: 'chat-23e5b',
    storageBucket: 'chat-23e5b.appspot.com',
    iosBundleId: 'com.example.chatMeApp',
  );
}