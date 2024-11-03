import 'package:flutter/material.dart';
import 'package:wish_us_luck/auth/screen/verification_sent_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _termsAccepted = false;
  bool _dataConsent = false;
  bool _isLoading = false;

  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  String? _selectedContinent;

  Future<void> _register() async {
    final String email = _emailController.text.trim();
    final String password = _passwordController.text.trim();
    final String fullName = _fullNameController.text.trim();

    // Validation
    if (fullName.isEmpty) {
      _showError('Full name is required.');
      return;
    }
    if (email.isEmpty) {
      _showError('Email is required.');
      return;
    }
    if (password.isEmpty || _confirmPasswordController.text.trim().isEmpty) {
      _showError('Password is required.');
      return;
    }
    if (password != _confirmPasswordController.text.trim()) {
      _showError('Passwords do not match.');
      return;
    }
    if (!_termsAccepted || !_dataConsent) {
      _showError('You must accept the terms and data consent.');
      return;
    }
    if (_selectedContinent == null) {
      _showError('Please select a continent.');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final existingUser = (await FirebaseAuth.instance.fetchSignInMethodsForEmail(email)).isNotEmpty;
      if (existingUser) {
        _showError('Email already in use.');
        return;
      }

      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('fullName', fullName);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => VerificationEmailSentScreen()),
      );
    } catch (e) {
      _showError('Registration failed. Please try again.');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar(); // Dismiss any active SnackBar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

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
              child: Text(
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
            const SizedBox(height: 10),
            TextFormField(
              controller: _fullNameController,
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
            const SizedBox(height: 10),
            TextFormField(
              controller: _emailController,
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
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: _selectedContinent,
              items: [
                'Africa',
                'Asia',
                'Europe',
                'North America',
                'Oceania',
                'South America'
              ].map((continent) => DropdownMenuItem(
                child: Text(continent, style: TextStyle(fontFamily: 'Poppins')),
                value: continent,
              )).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedContinent = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Continent',
                labelStyle: TextStyle(fontFamily: 'Poppins', color: Colors.black),
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
            const SizedBox(height: 10),
            TextFormField(
              controller: _passwordController,
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
            const SizedBox(height: 10),
            TextFormField(
              controller: _confirmPasswordController,
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

            // Terms and Data Consent Checkboxes
            Row(
              children: [
                Checkbox(
                  value: _termsAccepted,
                  onChanged: (value) {
                    setState(() {
                      _termsAccepted = value!;
                    });
                  },
                ),
                const Text("I accept the terms and conditions"),
              ],
            ),
            Row(
              children: [
                Checkbox(
                  value: _dataConsent,
                  onChanged: (value) {
                    setState(() {
                      _dataConsent = value!;
                    });
                  },
                ),
                const Text("I consent to data collection"),
              ],
            ),
            const SizedBox(height: 20),

            // Submit Button
            ElevatedButton(
              onPressed: _isLoading ? null : _register,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF8A56AC),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 2,
              ),
              child: _isLoading
                  ? CircularProgressIndicator(color: Colors.white)
                  : const Text(
                "I'm Ready",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
