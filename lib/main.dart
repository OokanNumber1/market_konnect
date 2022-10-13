import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:market_connect/market_konnet.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //initialising Firebase Instance
  await Firebase.initializeApp();
  runApp(
    const ProviderScope(child: MarketKonnet()),
  );
}
