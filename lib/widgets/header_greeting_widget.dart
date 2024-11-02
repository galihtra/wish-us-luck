// widgets/header_greeting_widget.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HeaderGreetingWidget extends StatelessWidget {
  final String greetingMessage;
  final String userName;

  const HeaderGreetingWidget({
    Key? key,
    required this.greetingMessage,
    required this.userName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$greetingMessage,\n$userName',
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        Text(
          'Connect with like-minded individuals!',
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
