import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_core/firebase_core.dart';
import '../lib/config/firebase/firebase_config.dart';
import '../lib/config/firebase/dev/firebase_options.dart';

void main() {
  group('Firebase Connection Tests', () {
    test('Initialize Firebase Dev Environment', () async {
      // Test Firebase initialization for dev environment
      await FirebaseConfig.initialize();
      
      // Verify Firebase app is initialized
      expect(Firebase.apps.isNotEmpty, true);
      
      final app = Firebase.apps.first;
      expect(app.name, isNotEmpty);
      
      print('✅ Firebase initialized successfully for dev');
      print('📱 App Name: ${app.name}');
      print('🔗 Project ID: ${app.options.projectId}');
    });

    test('Verify Dev Firebase Options', () {
      final options = DevFirebaseOptions.currentPlatform;
      
      expect(options.projectId, 'flutter-devops-core-dev');
      expect(options.apiKey, isNotEmpty);
      expect(options.appId, isNotEmpty);
      
      print('🔧 Dev Firebase Options:');
      print('   Project ID: ${options.projectId}');
      print('   API Key: ${options.apiKey.substring(0, 10)}...');
      print('   App ID: ${options.appId}');
    });
  });
}
