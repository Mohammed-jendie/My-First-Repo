import 'package:calculator/calculator_screen.dart';
import 'package:calculator/data/notifiers.dart';
import 'package:calculator/pages/about_page.dart';
import 'package:calculator/pages/bmi_calculator_page.dart';
import 'package:calculator/pages/settings_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: isDarkModeNotifier,
      builder: (context, isDarkmode , child) {
       return MaterialApp(
        
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.blue,
              brightness: isDarkmode ? Brightness.dark : Brightness.light,
            ),
          ),
 
          routes: {
            "Bmi": (BuildContext context) => const BmiCalculatorPage(),
            "Settings": (BuildContext context) => const SettingsPage(),
            "About": (BuildContext context) => const AboutPage(),
            "Calculator": (BuildContext context) => const CalculatorScreen(),
          },

          debugShowCheckedModeBanner: false,  
                   home: const CalculatorScreen(),
        );
      },
    );
  }
}
