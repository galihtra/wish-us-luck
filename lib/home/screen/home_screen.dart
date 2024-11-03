import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wish_us_luck/auth/your_posts_screen.dart';
import '../../donations/donations_screen.dart';
import '../../auth/screen/login_screen.dart';
import '../../settings/screen/settings_screen.dart';
import '../../slide_menu.dart';
import 'create_post_screen.dart';
import 'notifications_screen.dart';
import 'dart:async';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String displayName = ''; // Default user name
  String greetingMessage = '';
  Timer? _timer;
  String selectedFilter = 'All Posts';
  String selectedTopic = '';
  bool hasPosts = false; // Simulating if there are posts to show

  @override
  void initState() {
    super.initState();
    _loadUserName();
    _setGreetingMessage();

    _timer = Timer.periodic(Duration(hours: 1), (timer) {
      _setGreetingMessage();
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  Future<void> _loadUserName() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      displayName = prefs.getString('fullName') ?? 'User'; // Updated variable name
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SliderDrawer(
        appBar: SliderAppBar(
          appBarColor: Color(0xFFD3D3FF),
          drawerIconColor: Colors.black,
          title: Text(''),
          trailing: IconButton(
            icon: Icon(Icons.notifications_none, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationsScreen()),
              );
            },
          ),
        ),
        slider: SlideMenu(
          onCommunityTap: () => _navigateToHome(),
          onDonationTap: () => _navigateToDonations(),
          onYourPostsTap: () => _navigateToYourPosts(),
          onSettingsTap: () => _navigateToSettings(),
          onLogoutTap: () => _navigateToLogin(),
        ),
        child: _buildMainContent(),
      ),
    );
  }

  void _navigateToHome() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
  }

  void _navigateToDonations() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => DonationsScreen()));
  }

  void _navigateToSettings() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsScreen()));
  }

  void _navigateToYourPosts() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => YourPostsScreen()));
  }

  void _navigateToLogin() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  Widget _buildMainContent() {
    return SingleChildScrollView(
      child: Container(
        color: Color(0xFFD3D3FF), // Background color
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Greeting Text
            Text(
              '$greetingMessage,\n$displayName',
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
                    children: topics
                        .map((topic) => _buildTopicButton(Icons.local_hospital, topic))
                        .toList(),
                  ),
                  SizedBox(height: 20),
                  // Posts List (shown only if there are posts)
                  hasPosts
                      ? ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 5, // Replace with dynamic post count
                    itemBuilder: (context, index) {
                      return _buildPostCard(index);
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
    );
  }

  Widget _buildPostCard(int index) {
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
  }

  Widget _buildTopicButton(IconData icon, String label) {
    return ElevatedButton.icon(
      onPressed: () {
        setState(() {
          selectedTopic = label; // Set the selected topic
        });
      },
      icon: Icon(icon, color: Colors.black),
      label: Text(
        label,
        style: GoogleFonts.poppins(fontSize: 14, color: Colors.black),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: _getButtonColor(label),
        foregroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
