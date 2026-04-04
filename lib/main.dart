import 'package:flutter/material.dart';

class AppConfig {
  final String flavor;
  final String appName;
  final Color primaryColor;

  const AppConfig({
    required this.flavor,
    required this.appName,
    required this.primaryColor,
  });
}

late final AppConfig appConfig;

void mainCommon(AppConfig config) {
  appConfig = config;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
  const MyHomePage({super.key, required this.title});
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
          mainAxisAlignment: .center,
          children: [
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
