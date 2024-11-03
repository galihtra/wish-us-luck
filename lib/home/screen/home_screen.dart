import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wish_us_luck/auth/your_posts_screen.dart';
import '../../Post.dart';
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
  String displayName = '';
  String greetingMessage = '';
  Timer? _timer;
  String selectedFilter = 'All Posts';
  String selectedTopic = '';
  List<Post> posts = []; // List of Post objects
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _loadUserName();
    _setGreetingMessage();
    refreshPosts();

    _timer = Timer.periodic(Duration(hours: 1), (timer) {
      _setGreetingMessage();
    });
  }

  Future<void> refreshPosts() async {
    final postSnapshot = await _firestore.collection('posts').orderBy('timestamp', descending: true).get();

    setState(() {
      posts = postSnapshot.docs.map((doc) {
        return Post.fromDocument(doc); // Using the fromDocument method of the Post class
      }).toList();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _loadUserName() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      displayName = prefs.getString('fullName') ?? 'User';
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
        color: Color(0xFFD3D3FF),
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
                  // Topic Buttons
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: ['Cancer Type', 'Cancer Stage', 'Mental Wellbeing', 'Treatment']
                        .map((topic) => _buildTopicButton(Icons.local_hospital, topic))
                        .toList(),
                  ),
                  SizedBox(height: 20),
                  // Posts List
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      return _buildPostCard(posts[index]); // Use the Post object directly
                    },
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
                  MaterialPageRoute(builder: (context) => CreatePostScreen(onPostCreated: refreshPosts)),
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

  Widget _buildPostCard(Post post) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(
          post.title,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          post.content,
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

  Widget _buildTopicButton(IconData icon, String topic) {
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
        child: Row(
          children: [
            Icon(icon, size: 16, color: Colors.white),
            SizedBox(width: 4),
            Text(
              topic,
              style: GoogleFonts.poppins(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
