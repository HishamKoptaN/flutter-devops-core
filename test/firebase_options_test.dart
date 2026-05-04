import 'package:flutter_test/flutter_test.dart';
import '../lib/config/firebase/dev/firebase_options.dart';

void main() {
  group('Firebase Options Tests', () {
    test('Dev Firebase Options are valid', () {
      final options = DevFirebaseOptions.currentPlatform;
      
      // Verify required fields are not empty
      expect(options.projectId, isNotEmpty);
      expect(options.apiKey, isNotEmpty);
      expect(options.appId, isNotEmpty);
      expect(options.messagingSenderId, isNotEmpty);
      
      // Verify project ID matches expected dev project
      expect(options.projectId, 'flutter-devops-core-dev');
      
      print('✅ Dev Firebase Options are valid');
      print('📱 Project ID: ${options.projectId}');
      print('🔑 API Key: ${options.apiKey.substring(0, 10)}...');
      print('🆔 App ID: ${options.appId}');
    });

    test('Dev Firebase Options structure', () {
      final options = DevFirebaseOptions.currentPlatform;
      
      // Verify the structure is complete
      expect(options.storageBucket, contains('flutter-devops-core-dev'));
      expect(options.apiKey.length, greaterThan(20));
      expect(options.appId.length, greaterThan(20));
      
      print('✅ Firebase Options structure is correct');
    });
  });
}
