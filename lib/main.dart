import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'config/env_config.dart';
import 'firebase_debug_screen.dart';

class AppConfig {
  final String flavor;
  final String appName;
  final Color primaryColor;
  AppConfig({
    required this.flavor,
    required this.appName,
    required this.primaryColor,
  });
}

late final AppConfig appConfig;
void main() async {
  const flavor = String.fromEnvironment('ENV', defaultValue: 'dev');
  final config = switch (flavor) {
    'prod' => AppConfig(
        flavor: 'prod',
        appName: 'DevOps',
        primaryColor: Colors.deepPurple,
      ),
    _ => AppConfig(
        flavor: 'dev',
        appName: 'DevOps Dev',
        primaryColor: Colors.blue,
      ),
  };

  appConfig = config;

  await Firebase.initializeApp(options: EnvConfig.config.firebaseOptions);

  if (kDebugMode) {
    print('🚀 Running in ${config.flavor} flavor');
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appConfig.appName,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: appConfig.primaryColor),
        useMaterial3: true,
      ),
      home: MyHomePage(title: appConfig.appName),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: _incrementCounter,
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 8),
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return FirebaseDebugScreen();
                  },
                ),
              );
            },
            tooltip: 'Firebase Debug',
            backgroundColor: Colors.orange,
            child: const Icon(Icons.bug_report),
          ),
        ],
      ),
    );
  }
}
