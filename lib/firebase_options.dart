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
        return macos;
      case TargetPlatform.windows:
        return windows;
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
    apiKey: 'AIzaSyAOPz6c7eyOcgHGGM803N20mW6BoJOgjdI',
    appId: '1:267711461675:web:9a41354c7408a8e53ded6e',
    messagingSenderId: '267711461675',
    projectId: 'to-do-list-f04a9',
    authDomain: 'to-do-list-f04a9.firebaseapp.com',
    storageBucket: 'to-do-list-f04a9.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCiKPkig2JlzyPDxRQ1JzZzg7dBgYpb1N4',
    appId: '1:267711461675:android:e4fa863617c38a1b3ded6e',
    messagingSenderId: '267711461675',
    projectId: 'to-do-list-f04a9',
    storageBucket: 'to-do-list-f04a9.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDL7zF7w8_aQDpMPl2TCjZS6-8DiViFyTs',
    appId: '1:267711461675:ios:0cac9c0b467cb00d3ded6e',
    messagingSenderId: '267711461675',
    projectId: 'to-do-list-f04a9',
    storageBucket: 'to-do-list-f04a9.appspot.com',
    androidClientId: '267711461675-v1e22853o0d4q18qeocer0p10e2sfhrs.apps.googleusercontent.com',
    iosClientId: '267711461675-nifa9nudn6nuj7g0ockdnisfa2ltqd4i.apps.googleusercontent.com',
    iosBundleId: 'com.example.newtestefierbase',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDL7zF7w8_aQDpMPl2TCjZS6-8DiViFyTs',
    appId: '1:267711461675:ios:0cac9c0b467cb00d3ded6e',
    messagingSenderId: '267711461675',
    projectId: 'to-do-list-f04a9',
    storageBucket: 'to-do-list-f04a9.appspot.com',
    androidClientId: '267711461675-v1e22853o0d4q18qeocer0p10e2sfhrs.apps.googleusercontent.com',
    iosClientId: '267711461675-nifa9nudn6nuj7g0ockdnisfa2ltqd4i.apps.googleusercontent.com',
    iosBundleId: 'com.example.newtestefierbase',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAOPz6c7eyOcgHGGM803N20mW6BoJOgjdI',
    appId: '1:267711461675:web:d248b80981ef38f93ded6e',
    messagingSenderId: '267711461675',
    projectId: 'to-do-list-f04a9',
    authDomain: 'to-do-list-f04a9.firebaseapp.com',
    storageBucket: 'to-do-list-f04a9.appspot.com',
  );

}