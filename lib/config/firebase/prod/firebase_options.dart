import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class ProdFirebaseOptions {
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
    apiKey: 'AIzaSyCwZjZnwR123E4x86ACdm6Tr5xTbMD7JuE',
    appId: '1:1054807524869:web:dd04e5243ad8c08269be6c',
    messagingSenderId: '1054807524869',
    projectId: 'flutter-devops-core',
    authDomain: 'flutter-devops-core.firebaseapp.com',
    storageBucket: 'flutter-devops-core.firebasestorage.app',
    measurementId: 'G-DJ71S5D9YG',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBdnpa5jZMfkftNzysIUHzl_R8r0rdsnOk',
    appId: '1:1054807524869:android:ee6e359e8af4a09969be6c',
    messagingSenderId: '1054807524869',
    projectId: 'flutter-devops-core',
    storageBucket: 'flutter-devops-core.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB2KognnY85zM0s6Xtdms3JIY3VfsoosM4',
    appId: '1:1054807524869:ios:729a8b66dd7e6b4d69be6c',
    messagingSenderId: '1054807524869',
    projectId: 'flutter-devops-core',
    storageBucket: 'flutter-devops-core.firebasestorage.app',
    iosBundleId: 'com.example.flutterDevopsCore',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB2KognnY85zM0s6Xtdms3JIY3VfsoosM4',
    appId: '1:1054807524869:ios:729a8b66dd7e6b4d69be6c',
    messagingSenderId: '1054807524869',
    projectId: 'flutter-devops-core',
    storageBucket: 'flutter-devops-core.firebasestorage.app',
    iosBundleId: 'com.example.flutterDevopsCore',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCwZjZnwR123E4x86ACdm6Tr5xTbMD7JuE',
    appId: '1:1054807524869:web:cc080b74e8f9d36c69be6c',
    messagingSenderId: '1054807524869',
    projectId: 'flutter-devops-core',
    authDomain: 'flutter-devops-core.firebaseapp.com',
    storageBucket: 'flutter-devops-core.firebasestorage.app',
    measurementId: 'G-ECLXV4CW7F',
  );
}
