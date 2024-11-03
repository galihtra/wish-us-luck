import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Post.dart';
import '../home/screen/create_post_screen.dart';

class YourPostsScreen extends StatefulWidget {
  @override
  _YourPostsScreenState createState() => _YourPostsScreenState();
}

class _YourPostsScreenState extends State<YourPostsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool isLoading = true;
  List<Post> posts = []; // Define the list to hold posts

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    loadUserData();
    refreshPosts();
  }

  Future<void> loadUserData() async {
    // Simulate loading data
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      isLoading = false; // Set loading to false after simulating data load
    });
  }

  Future<void> refreshPosts() async {
    // Fetch posts from Firestore
    final postSnapshot = await FirebaseFirestore.instance.collection('posts').orderBy('timestamp', descending: true).get();

    setState(() {
      posts = postSnapshot.docs.map((doc) => Post.fromDocument(doc)).toList();
    });
  }


  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF3EBFF),
      appBar: AppBar(
        backgroundColor: Color(0xFFD3D3FF),
        elevation: 0,
        title: Text("Your Posts", style: GoogleFonts.poppins(color: Colors.black)),
        bottom: TabBar(
          controller: _tabController,
          labelColor: Color(0xFF8366A9),
          unselectedLabelColor: Colors.grey,
          indicatorColor: Color(0xFF8366A9),
          tabs: [
            Tab(text: "Posts"),
            Tab(text: "Comments"),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CreatePostScreen(
                    onPostCreated: (Map<String, dynamic> newPost) {
                      // Handle the new post data here
                      setState(() {
                        // Update the posts list with the new post
                        posts.insert(0, Post.fromMap(newPost)); // Insert the new post at the start of the list
                      });
                    },
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : TabBarView(
        controller: _tabController,
        children: [
          _buildPostsTab(),
          _buildCommentsTab(),
        ],
      ),
    );
  }

  Widget _buildPostsTab() {
    if (posts.isEmpty) {
      // If there are no posts, show a message
      return Center(
        child: Text("You haven’t posted anything yet.", style: GoogleFonts.poppins(color: Colors.grey)),
      );
    }
    // If there are posts, display them
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final post = posts[index];
        return ListTile(
          title: Text(post.title, style: GoogleFonts.poppins()),
          subtitle: Text(post.content, style: GoogleFonts.poppins(color: Colors.grey)),
        );
      },
    );
  }

  Widget _buildCommentsTab() {
    // Placeholder for future comments logic
    return Center(
      child: Text("You haven’t left any comments yet.", style: GoogleFonts.poppins(color: Colors.grey)),
    );
  }
}
