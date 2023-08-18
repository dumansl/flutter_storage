import 'package:flutter/material.dart';
import 'package:flutter_storage/services/local_stroge_service.dart';
import 'package:flutter_storage/services/secure_storage_services.dart';
import 'package:flutter_storage/shared_pref_use.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void setup() {
  WidgetsFlutterBinding.ensureInitialized();
  setup();
  locator.registerLazySingleton<LocalStorageService>(() =>SecureStorageService());
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Storage',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Storage Islemleri'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SharedPreferenceUse()));
              },
              child: const Text('Shared Preference / Secure Storage Kullanımı'),
              style: ElevatedButton.styleFrom(primary: Colors.red),
            )
          ],
        ),
      ),
    );
  }
}
