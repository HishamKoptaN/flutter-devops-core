import 'package:firebase_core/firebase_core.dart';
import '../env.dart';
import '../firebase/dev/firebase_options.dart';

class DevEnv extends Env {
  @override
  String get envName => 'dev';
  @override
  FirebaseOptions get firebaseOptions => DevFirebaseOptions.currentPlatform;
  @override
  String get baseUrl =>
      'https://hotpink-gnu-383634.hostingersite.com/abujena-dawajen-api/api/';
}
