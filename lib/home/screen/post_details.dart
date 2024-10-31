import 'package:flutter/material.dart';

class PostDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Post Details')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Post Content
            Text(
              'Post Title',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('Detailed content of the post goes here...'),
            Divider(height: 20),
            // Comments List
            Expanded(
              child: ListView.builder(
                itemCount: 5, // Replace with actual comment count
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('User $index'),
                    subtitle: Text('This is a comment.'),
                  );
                },
              ),
            ),
            // Input for Comment
            TextField(
              decoration: InputDecoration(
                hintText: 'Add a comment...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
