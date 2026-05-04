import 'package:firebase_core/firebase_core.dart';

abstract class Env {
  String get baseUrl;
  String get envName;
  FirebaseOptions get firebaseOptions;
}
