import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String title;
  final String content;
  final String topic;
  final String specificTopic;
  final String? image; // Nullable field for image
  final String displayName;
  final int supportCount;
  final int commentCount;
  final Timestamp timestamp;

  Post({
    required this.title,
    required this.content,
    required this.topic,
    required this.specificTopic,
    this.image,
    required this.displayName,
    required this.supportCount,
    required this.commentCount,
    required this.timestamp,
  });

  // Method to create a Post from a Map
  factory Post.fromMap(Map<String, dynamic> data) {
    return Post(
      title: data['title'] ?? '',
      content: data['content'] ?? '',
      topic: data['topic'] ?? '',
      specificTopic: data['specificTopic'] ?? '',
      image: data['image'], // Directly use nullable image field
      displayName: data['displayName'] ?? '',
      supportCount: data['supportCount'] is int ? data['supportCount'] : 0, // Type check for int
      commentCount: data['commentCount'] is int ? data['commentCount'] : 0, // Type check for int
      timestamp: data['timestamp'] is Timestamp ? data['timestamp'] : Timestamp.now(), // Type check for Timestamp
    );
  }

  // Method to create a Post from a Firestore DocumentSnapshot
  factory Post.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Post.fromMap(data);
  }

  // Method to convert a Post to a Map for saving back to Firestore
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'content': content,
      'topic': topic,
      'specificTopic': specificTopic,
      'image': image, // Nullable field
      'displayName': displayName,
      'supportCount': supportCount,
      'commentCount': commentCount,
      'timestamp': timestamp, // Directly use Timestamp
    };
  }

  // Optional: Convert to JSON format if needed
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'content': content,
      'topic': topic,
      'specificTopic': specificTopic,
      'image': image,
      'displayName': displayName,
      'supportCount': supportCount,
      'commentCount': commentCount,
      'timestamp': timestamp.toDate().toIso8601String(), // Convert Timestamp to ISO format
    };
  }
}
