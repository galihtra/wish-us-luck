import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'password_changed_screen.dart'; // Ensure you have this screen created

class ChangePasswordEmailSentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/email_sent.png', // Update the asset to an appropriate image for the change password email
              height: 100,
              width: 100,
              color: Colors.purple[100],
            ),
            SizedBox(height: 20),
            Text(
              'Change Password Email Sent',
              style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Please check your email for the link to change your password.\nOr check your Junk/Spam...',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PasswordChangedScreen()), // Update to the next screen after password change
                );
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
                'I Changed My Password!',
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
