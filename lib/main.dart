import 'package:flutter/material.dart';
import 'package:wish_us_luck/splash/screen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  // Ensure that widget binding is initialized before Firebase is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Warriors',
      theme: ThemeData(
        primaryColor: Color(0xFF8366A9), // Set your primary color
        colorScheme: ColorScheme.light(
          primary: Color(0xFF8366A9), // Primary color for elevated buttons
          onPrimary: Colors.white, // Text color on primary button
          background: Colors.white, // Background color
          onBackground: Colors.black, // Text color on background
        ),
        // Define the text theme with font family and styles
        textTheme: TextTheme(
          // Add your text styles here if needed
        ),
      ),
      home: SplashScreen(), // Set your initial screen
    );
  }
}
