import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'notifications_screen.dart';
import '../../settings/screen/settings_screen.dart';

class CreatePostScreen extends StatefulWidget {
  @override
  _CreatePostScreenState createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  XFile? _image; // Variable to hold the selected image
  final ImagePicker _picker = ImagePicker();
  String selectedTopic = ''; // Store selected topic
  String userName = '';
  String greetingMessage = '';
  final List<String> topics = [
    'Cancer Type',
    'Cancer Stage',
    'Mental Wellbeing',
    'Treatment',
  ];
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  final Map<String, TextEditingController> topicControllers = {};

  @override
  void initState() {
    super.initState();
    _loadUserName();
    _setGreetingMessage();
    for (var topic in topics) {
      topicControllers[topic] = TextEditingController();
    }
  }

  @override
  void dispose() {
    for (var controller in topicControllers.values) {
      controller.dispose();
    }
    titleController.dispose();
    contentController.dispose();
    super.dispose();
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

  Future<void> _pickImage() async {
    final pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = pickedImage;
    });
  }

  Color _getButtonColor(String topic) {
    return selectedTopic == topic ? Color(0xFF8366A9) : Colors.grey[300]!;
  }

  Color _getTextColor(String topic) {
    return selectedTopic == topic ? Colors.white : Colors.black;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFD3D3FF), // Match the background color
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.black),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SettingsScreen()),
            );
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_none, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationsScreen()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Color(0xFFD3D3FF), // Background color
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Text
              Text(
                'Share Your Thoughts',
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              // Title Input
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  hintText: "Title",
                  hintStyle: GoogleFonts.poppins(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: Colors.grey[100],
                ),
              ),
              SizedBox(height: 20),
              // Content Input (including file attachment)
              TextField(
                controller: contentController,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: "Write your content here...",
                  hintStyle: GoogleFonts.poppins(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: Colors.grey[100],
                ),
              ),
              SizedBox(height: 20),
              _image != null
                  ? Image.file(File(_image!.path), height: 200)
                  : SizedBox(),
              ElevatedButton.icon(
                onPressed: _pickImage,
                icon: Icon(Icons.attach_file),
                label: Text("Attach File"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF8366A9),
                ),
              ),
              SizedBox(height: 20),
              // Topic Selection (now below content)
              Text(
                'Add Topics (Optional)',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: topics.map((topic) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedTopic = topic;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: _getButtonColor(topic),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: selectedTopic == topic
                          ? TextField(
                        controller: topicControllers[topic],
                        decoration: InputDecoration(
                          hintText: 'Enter details for $topic',
                          border: InputBorder.none,
                          hintStyle: GoogleFonts.poppins(color: Colors.white),
                        ),
                        style: GoogleFonts.poppins(color: Colors.white),
                      )
                          : Text(
                        topic,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: _getTextColor(topic),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 20),
              // Post Button
              ElevatedButton(
                onPressed: () {
                  // Code to post the content along with the title, selected topic, and image
                },
                child: Text("Post"),
                style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF8366A9)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
