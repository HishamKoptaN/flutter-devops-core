import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'config/env_config.dart';

class FirebaseDebugScreen extends StatefulWidget {
  const FirebaseDebugScreen({super.key});

  @override
  State<FirebaseDebugScreen> createState() => _FirebaseDebugScreenState();
}

class _FirebaseDebugScreenState extends State<FirebaseDebugScreen> {
  bool _isInitialized = false;
  String? _errorMessage;
  FirebaseApp? _app;

  @override
  void initState() {
    super.initState();
    _initializeFirebase();
  }

  Future<void> _initializeFirebase() async {
    try {
      await Firebase.initializeApp();
      setState(() {
        _isInitialized = Firebase.apps.isNotEmpty;
        _app = Firebase.apps.isNotEmpty ? Firebase.apps.first : null;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isInitialized = Firebase.apps.isNotEmpty;
        _app = Firebase.apps.isNotEmpty ? Firebase.apps.first : null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firebase Debug - ${EnvConfig.currentEnv}'),
        backgroundColor: EnvConfig.isDev ? Colors.blue : Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Environment Info
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Environment Info',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  Text('Current ENV: ${EnvConfig.currentEnv}'),
                  Text('Is Dev: ${EnvConfig.isDev}'),
                  Text('Is Prod: ${EnvConfig.isProd}'),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Firebase Status
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _isInitialized ? Colors.green[50] : Colors.red[50],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Firebase Status',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  if (_isInitialized) ...[
                    const Row(
                      children: [
                        Icon(Icons.check_circle, color: Colors.green),
                        SizedBox(width: 8),
                        Text('✅ Firebase Initialized'),
                      ],
                    ),
                    if (_app != null) ...[
                      Text('App Name: ${_app!.name}'),
                      Text('Project ID: ${_app!.options.projectId}'),
                      Text('App ID: ${_app!.options.appId}'),
                    ],
                  ] else ...[
                    const Row(
                      children: [
                        Icon(Icons.error, color: Colors.red),
                        SizedBox(width: 8),
                        Text('❌ Firebase Not Initialized'),
                      ],
                    ),
                    if (_errorMessage != null) Text('Error: $_errorMessage'),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Test Connection Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _testConnection,
                child: const Text('Test Connection'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _testConnection() async {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Testing Firebase connection...'),
        duration: Duration(seconds: 2),
      ),
    );

    try {
      // Use Firebase helper methods
      final isInitialized = Firebase.apps.isNotEmpty;
      final app = Firebase.apps.isNotEmpty ? Firebase.apps.first : null;

      if (isInitialized && app != null) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('✅ Connected to ${app.options.projectId}'),
              backgroundColor: Colors.green,
            ),
          );
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                  '⚠️ Firebase not initialized - this is normal in test/debug mode'),
              backgroundColor: Colors.orange,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('❌ Connection failed: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}
