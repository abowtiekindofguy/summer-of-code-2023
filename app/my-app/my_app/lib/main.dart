import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:get_storage/get_storage.dart';
import 'functions.dart';
import 'package:flutter/material.dart';
import 'product.dart';
import 'post-product.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'home.dart';
import 'auth.dart';

// function to trigger build when the app is run
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init('Cart');
  GetStorage cartdb = GetStorage('Cart');
  final database = openDatabase(
    join(await getDatabasesPath(), 'local_store.db'),
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE items(id TEXT PRIMARY KEY, type TEXT)',
      );
    },
    version: 1,
  );
  await Firebase.initializeApp();
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/home': (context) => const HomeRoute(),
      '/': (context) => const LoginScreen(),
      '/second': (context) => const SecondRoute(),
      '/third': (context) => const ThirdRoute(),
      '/post-product': (context) => const PostProductForm(),
    },
  )); //MaterialApp
}

class SecondRoute extends StatelessWidget {
  const SecondRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Click Me Page"),
        backgroundColor: Colors.green,
      ), // AppBar
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Back!'),
        ), // ElevatedButton
      ), // Center
    ); // Scaffold
  }
}

class ThirdRoute extends StatelessWidget {
  const ThirdRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tap Me Page"),
        backgroundColor: const Color.fromARGB(255, 58, 185, 63),
      ),
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              openUrl('https://flutter.dev');
            },
            child: const Text('Google')),
      ), // AppBar
    ); // Scaffold
  }
}
