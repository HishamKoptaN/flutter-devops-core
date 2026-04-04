import 'package:firebase_core/firebase_core.dart';
import 'dev/firebase_options.dart' as dev;
import 'prod/firebase_options.dart' as prod;

class FirebaseConfig {
  static Future<void> initialize() async {
    const String env = String.fromEnvironment('ENV', defaultValue: 'dev');

    final options = env == 'prod'
        ? prod.ProdFirebaseOptions.currentPlatform
        : dev.DevFirebaseOptions.currentPlatform;

    await Firebase.initializeApp(options: options);
  }
}
