import 'package:firebase_core/firebase_core.dart';
import '../env.dart';
import '../firebase/prod/firebase_options.dart';

class ProdEnv extends Env {
  @override
  String get envName => 'prod';
  @override
  FirebaseOptions get firebaseOptions => ProdFirebaseOptions.currentPlatform;
  @override
  String get baseUrl =>
      'https://hotpink-hyena-564990.hostingersite.com/abujena-dawajen-api/api/';
}
