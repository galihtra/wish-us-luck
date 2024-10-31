import 'package:flutter/material.dart';
import 'package:wish_us_luck/auth/screen/login_screen.dart';
import 'package:wish_us_luck/auth/screen/register_screen.dart';

class OnboardingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Top Ribbon Image
            Image.asset(
              'assets/images/bg-img.png',
              width: 300,
              height: 300,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),

            // "You are not alone" text
            const Text(
              'You are not alone.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 25,
                color: Colors.grey,
              ),
            ),
            // "You are a warrior" row
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'You are a ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 30,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),

                // Ribbon icon
                Image.asset(
                  'assets/images/splash.png',
                  width: 150,
                  height: 150,
                  fit: BoxFit.contain,
                ),
              ],
            ),

            const SizedBox(height: 80),

            // "Join the Community" button
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => RegisterScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF8366A9),
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 64),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: const Text(
                'Join the Community',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            const SizedBox(height: 10),

            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => LoginScreen()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 30),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
              ),
              child: const Text('Have an account? Dive back in!',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Color(0xFF363636),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
