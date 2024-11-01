import 'package:flutter/material.dart';
import 'package:wish_us_luck/auth/screen/verification_sent_screen.dart';

class RegisterScreen extends StatefulWidget  {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _termsAccepted = false;
  bool _dataConsent = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: ListView(
          children: [
            const SizedBox(height: 20),
            const Center(
              child: const Text(
                'Become a Warrior.',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 30),

            // Full Name Field
            const Text(
              "Full Name",
              style: TextStyle(
                fontFamily: 'Poppins',
                color: Colors.grey,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'Full name',
                hintStyle: TextStyle(fontFamily: 'Poppins', color: Colors.grey),
                filled: true,
                fillColor: Color(0xFFF0F0F0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 16),

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
            const SizedBox(
              height: 10,
            ),
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
            const SizedBox(height: 16),

            // Continent Dropdown
            const Text(
              "Continent",
              style: TextStyle(
                fontFamily: 'Poppins',
                color: Colors.grey,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            DropdownButtonFormField(
              items: [
                'Africa',
                'Asia',
                'Europe',
                'North America',
                'Oceania',
                'South America'
              ]
                  .map((continent) => DropdownMenuItem(
                        child: Text(continent,
                            style: TextStyle(fontFamily: 'Poppins')),
                        value: continent,
                      ))
                  .toList(),
              onChanged: (value) {},
              decoration: InputDecoration(
                labelStyle:
                    TextStyle(fontFamily: 'Poppins', color: Colors.black),
                filled: true,
                fillColor: Color(0xFFF0F0F0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 16),

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
            const SizedBox(
              height: 10,
            ),
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
            const SizedBox(height: 16),

            // Confirm Password Field
            const Text(
              "Confirm Password",
              style: TextStyle(
                fontFamily: 'Poppins',
                color: Colors.grey,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'Confirm Password',
                hintStyle: TextStyle(fontFamily: 'Poppins', color: Colors.grey),
                filled: true,
                fillColor: const Color(0xFFF0F0F0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 20),

            // Checkbox for Terms and Conditions
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Checkbox(
                  value: _termsAccepted,
                  onChanged: (value) {
                    setState(() {
                      _termsAccepted = value!;
                    });
                  },
                  activeColor: const Color(0xFF8A56AC),
                ),
                Expanded(
                  child: RichText(
                    text: const TextSpan(
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.black,
                        fontSize: 14,
                      ),
                      children: [
                        TextSpan(text: 'I agree to the '),
                        TextSpan(
                          text: 'Terms & Conditions',
                          style: TextStyle(
                            color: Color(0xFF8A56AC),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Checkbox for Consent
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Checkbox(
                  value: _dataConsent,
                  onChanged: (value) {
                    setState(() {
                      _dataConsent = value!;
                    });
                  },
                  activeColor: const Color(0xFF8A56AC),
                ),
                Expanded(
                  child: RichText(
                    text: const TextSpan(
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.black,
                        fontSize: 14,
                      ),
                      children: [
                        TextSpan(
                            text:
                                'I consent to my data being used for research purposes. '),
                        TextSpan(
                          text: 'Learn More',
                          style: TextStyle(
                            color: Color(0xFF8A56AC),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),

            // Submit Button
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => VerificationEmailSentScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF8A56AC),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 2,
              ),
              child: const Text(
                "I'm Ready to be a Warrior!",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.white,
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
