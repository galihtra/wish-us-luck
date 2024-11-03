import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String id;
  final String title;
  final String content;
  final Timestamp timestamp;

  Post({
    required this.id,
    required this.title,
    required this.content,
    required this.timestamp,
  });

  // Factory method to create a Post object from Firestore document
  factory Post.fromDocument(DocumentSnapshot doc) {
    return Post(
      id: doc.id, // Get the document ID
      title: doc['title'] ?? 'Untitled Post', // Handle missing fields gracefully
      content: doc['content'] ?? 'No content available',
      timestamp: doc['timestamp'] ?? Timestamp.now(), // Default to current time if not present
    );
  }

  // Optionally, you can add a method to convert a Post to a Map for saving back to Firestore
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'content': content,
      'timestamp': timestamp,
    };
  }
}
