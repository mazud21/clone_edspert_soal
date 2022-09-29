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
    apiKey: 'AIzaSyDz0xQ1Bgwh4qYCn7fQ0sHm5Dzt0C3Q4V4',
    appId: '1:572216125665:web:142a54f6d7eee7a89d6fa0',
    messagingSenderId: '572216125665',
    projectId: 'edspertclone',
    authDomain: 'edspertclone.firebaseapp.com',
    storageBucket: 'edspertclone.appspot.com',
    measurementId: 'G-VYNHSQWHHY',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAbUu9heE8oXDZcvhiChIICYMSZOAHAEag',
    appId: '1:572216125665:android:55937ac557b22dcf9d6fa0',
    messagingSenderId: '572216125665',
    projectId: 'edspertclone',
    storageBucket: 'edspertclone.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyANnChnV3PYkh730beo02B7jcbd6Cxy_8Q',
    appId: '1:572216125665:ios:e10ae241fd169f389d6fa0',
    messagingSenderId: '572216125665',
    projectId: 'edspertclone',
    storageBucket: 'edspertclone.appspot.com',
    androidClientId: '572216125665-1b1smivn8ufc9sqhhclfnqe11m0sc8l6.apps.googleusercontent.com',
    iosClientId: '572216125665-44kju8qqdbkf77576s1dgth7p5m7992i.apps.googleusercontent.com',
    iosBundleId: 'com.cloneedspertsoal.cloneEdspertSoal',
  );
}