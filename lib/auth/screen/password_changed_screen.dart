import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PasswordChangedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/password_changed.png', // Use an appropriate image for password change confirmation
              height: 100,
              width: 100,
              color: Colors.green[100], // You can adjust the color to your preference
            ),
            SizedBox(height: 20),
            Text(
              'Password Changed Successfully',
              style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Your password has been changed.\nYou can now log in with your new password.',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // Navigate back to the login screen or any other screen
                Navigator.popUntil(context, ModalRoute.withName('/login'));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF8A56AC),
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 2,
              ),
              child: Text(
                'Go to Login',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
