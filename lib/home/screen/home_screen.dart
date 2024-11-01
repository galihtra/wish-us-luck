import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../settings/screen/settings_screen.dart';
import 'notifications_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String userName = '';
  String greetingMessage = '';
  String selectedFilter = 'All Posts';
  String selectedTopic = '';
  bool hasPosts = false; // Simulating if there are posts to show

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

  // List of topics
  final List<String> topics = [
    'Cancer Type',
    'Cancer Stage',
    'Mental Wellbeing',
    'Treatment',
  ];

  // Function to determine button color based on selection
  Color _getButtonColor(String topic) {
    return selectedTopic == topic ? Color(0xFF8366A9) : Colors.grey[300]!;
  }

  // Function to determine text color based on selection
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
              // Greeting Text
              Text(
                'Good morning,\n$userName',
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
              SizedBox(height: 20),
              // Background Rectangle for Buttons and Search
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
                ),
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  children: [
                    // Filter Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: ['All Posts', 'Most Recent', 'Recommended', 'Popular']
                          .map((filter) => GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedFilter = filter;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: selectedFilter == filter
                                ? Color(0xFFD3D3FF).withOpacity(0.5)
                                : Colors.grey[300],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            filter,
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: selectedFilter == filter ? Color(0xFF8366A9) : Colors.black,
                            ),
                          ),
                        ),
                      ))
                          .toList(),
                    ),
                    SizedBox(height: 20),
                    // Search by Topic
                    Text(
                      'Search by Topic',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        _buildTopicButton(Icons.local_hospital, 'Cancer Type'),
                        _buildTopicButton(Icons.timeline, 'Cancer Stage'),
                        _buildTopicButton(Icons.psychology, 'Mental Wellbeing'),
                        _buildTopicButton(Icons.medication, 'Treatment'),
                      ],
                    ),
                    SizedBox(height: 20),
                    // Posts List (shown only if there are posts)
                    hasPosts
                        ? ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: 5, // Replace with dynamic post count
                      itemBuilder: (context, index) {
                        return Card(
                          margin: EdgeInsets.symmetric(vertical: 8),
                          child: ListTile(
                            title: Text(
                              'Post Title $index',
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              'Post content goes here...',
                              style: GoogleFonts.poppins(fontSize: 14),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.thumb_up_alt_outlined),
                                  onPressed: () {}, // Like functionality
                                ),
                                IconButton(
                                  icon: Icon(Icons.comment_outlined),
                                  onPressed: () {}, // Navigate to comment section
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    )
                        : Center(
                      child: Text(
                        'No posts to display.',
                        style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey),
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
              // Input Box for New Post
              TextField(
                readOnly: true,
                onTap: () {
                  // Navigate to create post screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CreatePostScreen()),
                  );
                },
                decoration: InputDecoration(
                  hintText: "What's on your mind?",
                  hintStyle: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                  fillColor: Colors.grey[200],
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopicButton(IconData icon, String label) {
    return ElevatedButton.icon(
      onPressed: () {
        setState(() {
          selectedTopic = label; // Set the selected topic
        });
      },
      icon: Icon(icon, color: Colors.purple),
      label: Text(
        label,
        style: GoogleFonts.poppins(fontSize: 14, color: Colors.purple),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: _getButtonColor(label),
        foregroundColor: Colors.purple,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 0,
      ),
    );
  }
}

class CreatePostScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Post', style: GoogleFonts.poppins()),
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              maxLines: 5,
              decoration: InputDecoration(
                hintText: "Write your post here...",
                hintStyle: GoogleFonts.poppins(color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: Colors.grey[100],
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Submit post functionality
              },
              child: Text("Post", style: GoogleFonts.poppins(fontSize: 16)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
