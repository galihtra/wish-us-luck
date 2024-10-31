import 'package:flutter/material.dart';

class CreatePostScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create Post')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              maxLines: 6,
              decoration: InputDecoration(
                hintText: 'Write something...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Implement post submission logic
                Navigator.pop(context);
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
