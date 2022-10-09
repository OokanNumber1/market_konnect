import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:market_connect/src/views/login_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //initialising Firebase Instance
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Market Konnect',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: const LoginView(),
    );
  }
}
