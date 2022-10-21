import 'package:flutter/material.dart';

class MarketKonnetColor {
  static const primary = Colors.brown;
}

class MarketKonnetTheme {
  //static ThemeData get currentTheme => lightTheme;

  static ThemeData get lightTheme => ThemeData(
        primaryColor: MarketKonnetColor.primary,
        brightness: Brightness.light,
        primarySwatch: MarketKonnetColor.primary,
        inputDecorationTheme: InputDecorationTheme(
          fillColor: Colors.brown[50],
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: MarketKonnetColor.primary[300],
        ),
        textTheme: ThemeData.light().textTheme,
        buttonTheme: ButtonThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      );
  static ThemeData get darkTheme => ThemeData(
        primaryColor: MarketKonnetColor.primary,
        brightness: Brightness.dark,
        primarySwatch: MarketKonnetColor.primary,
        appBarTheme: AppBarTheme(
          backgroundColor: MarketKonnetColor.primary[300],
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.brown[200],
        ),
        inputDecorationTheme: InputDecorationTheme(
          fillColor: Colors.brown[200],
          labelStyle: const TextStyle(color: Colors.white),
        ),
        textTheme: ThemeData.dark().textTheme,
        buttonTheme: ButtonThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      );
}
