import 'package:flutter/material.dart';

class VerificationSentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Verification Email Sent',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              Image.asset(
                'assets/images/ribbon.png', // Replace with your image asset
                height: 100,
                width: 100,
                color: Colors
                    .purple[100], // Match the color as per your image style
              ),
              const SizedBox(height: 20),
              const Text(
                'Please check your email.\nOr check your Junk/Spam...',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
