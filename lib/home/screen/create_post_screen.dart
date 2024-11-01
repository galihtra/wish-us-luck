import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CreatePostScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Create Post',
          style: GoogleFonts.poppins(color: Colors.black),
        ),
        backgroundColor: Color(0xFFD3D3FF), // Match the background color from HomeScreen
        elevation: 0, // Remove elevation for a flat look
      ),
      body: Container(
        color: Color(0xFFD3D3FF), // Set the body background to match HomeScreen
        padding: const EdgeInsets.all(20.0), // Padding for the container
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title for Create Post
            Text(
              'Create Post',
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            // Text field for writing the post
            TextField(
              maxLines: 6,
              decoration: InputDecoration(
                hintText: 'Write something...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Theme.of(context).primaryColor), // Use theme color for border
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Submit button
            ElevatedButton(
              onPressed: () {
                // Implement post submission logic
                Navigator.pop(context); // Go back after submission
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor, // Use theme color
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Submit',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary, // Ensure text color contrasts with button color
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
