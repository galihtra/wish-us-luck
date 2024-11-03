import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Add this for date formatting
import '../../Post.dart';

class PostDetailsScreen extends StatelessWidget {
  final Post post;

  // Constructor to receive a Post object
  PostDetailsScreen({required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Post Title
            Text(
              post.title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            // Display the timestamp in a friendly format
            Text(
              DateFormat('MMM d, yyyy - h:mm a').format(post.timestamp.toDate()),
              style: TextStyle(color: Colors.grey[600], fontSize: 12),
            ),
            Divider(height: 20),
            // Post Content
            Text(
              post.content,
              style: TextStyle(fontSize: 16),
            ),
            Divider(height: 20),
            // Display Comments Section Title
            Text(
              'Comments',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            // Comments List
            Expanded(
              child: ListView.builder(
                itemCount: post.commentCount, // Use the actual comment count
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('User $index'), // Placeholder, replace with actual user data
                    subtitle: Text('This is a comment.'),
                  );
                },
              ),
            ),
            // Input for Comment
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Add a comment...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () {
                      // Add your comment submission logic here
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
