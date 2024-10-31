import 'package:flutter/material.dart';
import 'package:wish_us_luck/home/screen/home_screen.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: ListView(
          children: [
            const SizedBox(height: 100),
            const Center(
              child: Text(
                'Welcome Back.',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 20),

            // Email Field
            const Text(
              "Email",
              style: TextStyle(
                fontFamily: 'Poppins',
                color: Colors.grey,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                hintText: 'Email',
                hintStyle: TextStyle(fontFamily: 'Poppins', color: Colors.grey),
                filled: true,
                fillColor: Color(0xFFF0F0F0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 16),

            // Password Field
            const Text(
              "Password",
              style: TextStyle(
                fontFamily: 'Poppins',
                color: Colors.grey,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                hintText: 'Password',
                hintStyle: TextStyle(fontFamily: 'Poppins', color: Colors.grey),
                filled: true,
                fillColor: Color(0xFFF0F0F0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
              obscureText: true,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed: () {},
                child: Text(
                  'Forgot Password?',
                  style: TextStyle(color: Color(0xFF8A56AC)),
                ),
              ),
            ),
            SizedBox(height: 20),

            // "Join the Community" button
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => HomeScreen()),
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
                'Dive back in!',
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
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => LoginScreen()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 30),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
              ),
              child: const Text('No account yet? Be a Warrior!',
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
