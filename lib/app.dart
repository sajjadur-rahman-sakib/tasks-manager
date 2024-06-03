import 'package:flutter/material.dart';
import 'package:sakib/ui/screens/splash_screen.dart';
import 'package:sakib/ui/utility/app_colors.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      theme: lightThemeData(),
    );
  }

  ThemeData lightThemeData() {
    return ThemeData(
        inputDecorationTheme: InputDecorationTheme(
            fillColor: Colors.white,
            filled: true,
            hintStyle: TextStyle(color: Colors.grey.shade400),
            border: const OutlineInputBorder(borderSide: BorderSide.none)),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.themeColor,
                padding: const EdgeInsets.symmetric(vertical: 12),
                foregroundColor: AppColors.white,
                fixedSize: const Size.fromWidth(double.maxFinite),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)))),
        textTheme: const TextTheme(
            titleLarge: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black)));
  }
}
