import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreatePostScreen extends StatefulWidget {
  @override
  _CreatePostScreenState createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  XFile? _image;
  final ImagePicker _picker = ImagePicker();
  String selectedTopic = '';
  String userName = '';
  String greetingMessage = '';
  String specificTopic = '';
  final List<String> topics = ['Cancer Type', 'Cancer Stage', 'Mental Wellbeing', 'Treatment'];
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  final TextEditingController specificTopicController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserName();
    _setGreetingMessage();
  }

  Future<void> _loadUserName() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('userName') ?? 'User';
    });
  }

  void _setGreetingMessage() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      greetingMessage = 'Good Morning';
    } else if (hour < 18) {
      greetingMessage = 'Good Afternoon';
    } else {
      greetingMessage = 'Good Evening';
    }
  }

  Future<void> _postContent() async {
    await FirebaseFirestore.instance.collection('posts').add({
      'title': titleController.text,
      'content': contentController.text,
      'topic': selectedTopic,
      'specificTopic': specificTopic,
      'image': _image != null ? _image!.path : null,
      'userName': userName,
      'timestamp': FieldValue.serverTimestamp(),
    });

    titleController.clear();
    contentController.clear();
    specificTopicController.clear();
    setState(() {
      selectedTopic = '';
      specificTopic = '';
      _image = null;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Post created successfully!')),
    );
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = pickedFile;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE4DAFF), // Keep the purple background
      appBar: AppBar(
        backgroundColor: Color(0xFFE4DAFF),
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_none, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Container(
          color: Colors.white, // Set the container color to white
          padding: EdgeInsets.all(16), // Add padding to the white container
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "$greetingMessage, $userName",
                style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text("Connect with like-minded individuals!", style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[600])),
              SizedBox(height: 20),
              Text(
                'Share Your Thoughts',
                style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  hintText: "Write a title...",
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: contentController,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: "Share your thoughts...",
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Topic',
                style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: topics.map((topic) {
                  return ChoiceChip(
                    label: Text(topic, style: TextStyle(color: selectedTopic == topic ? Colors.white : Colors.black)),
                    selected: selectedTopic == topic,
                    onSelected: (isSelected) {
                      setState(() {
                        selectedTopic = isSelected ? topic : '';
                        specificTopic = ''; // Clear the specific topic when a new topic is selected
                        specificTopicController.clear(); // Clear the text field for specific topic
                      });
                    },
                    selectedColor: Color(0xFF8366A9),
                    backgroundColor: Colors.grey[300],
                  );
                }).toList(),
              ),
              SizedBox(height: 8),
              if (selectedTopic.isNotEmpty)
                TextField(
                  controller: specificTopicController,
                  decoration: InputDecoration(
                    hintText: "Enter specific $selectedTopic...",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      specificTopic = value; // Update specific topic input
                    });
                  },
                ),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: Icon(Icons.attach_file),
                  onPressed: _pickImage,
                  color: Color(0xFF8366A9),
                ),
              ),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.bottomRight,
                child: FloatingActionButton(
                  onPressed: _postContent,
                  backgroundColor: Color(0xFF8366A9),
                  child: Icon(Icons.send),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
