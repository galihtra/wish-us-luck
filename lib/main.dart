import 'package:flutter/material.dart';
import 'package:wish_us_luck/splash/screen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';

// Define your Firebase options using FirebaseOptions
const FirebaseOptions firebaseOptions = FirebaseOptions(
  apiKey: "AIzaSyA_BTpKGmOWkhHolpQdrQXbVGUn4Pezeok",
  appId: "1:20826632019:web:47ce0fae2f1ff1652a7ba6",
  messagingSenderId: "20826632019",
  projectId: "healthkathon-8f7b5",
  storageBucket: "healthkathon-8f7b5.firebasestorage.app",
  authDomain: "healthkathon-8f7b5.firebaseapp.com",
  measurementId: "G-ZW8EZKH75X",
);

void main() async {
  // Ensure that widget binding is initialized before Firebase is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: firebaseOptions,
  );

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
          titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
          bodyLarge: TextStyle(fontSize: 18, color: Colors.grey[800]),
        ),
      ),
      home: SplashScreen(), // Set your initial screen
    );
  }
}
