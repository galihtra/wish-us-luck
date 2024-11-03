import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class YourPostsScreen extends StatefulWidget {
  @override
  _YourPostsScreenState createState() => _YourPostsScreenState();
}

class _YourPostsScreenState extends State<YourPostsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<Map<String, dynamic>> userPosts = [];
  List<String> userComments = [];
  bool dataLoaded = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    loadUserData();
  }

  Future<void> loadUserData() async {
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      userPosts = [
        {
          'title': "Hi everyone",
          'content': "I recently got diagnosed with Stage I cancer... It is quite shocking to me... 😢",
          'supportCount': 9,
          'commentCount': 5,
        },
        {
          'title': "Chemo updates",
          'content': "Just underwent my first chemo 🙌 Thanks for all the support! 💪💪",
          'supportCount': 10,
          'commentCount': 12,
        }
      ];

      userComments = [
        "Much love for you! ❤️",
        "I think you should consult a doctor for safety.",
      ];

      dataLoaded = true;
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget _buildPostCard({
    required String title,
    required String content,
    required int supportCount,
    required int commentCount,
  }) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPostHeader(),
            SizedBox(height: 12),
            Text(title, style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 16)),
            SizedBox(height: 8),
            Text(content, style: GoogleFonts.poppins(fontSize: 14)),
            SizedBox(height: 12),
            _buildPostStats(supportCount, commentCount),
          ],
        ),
      ),
    );
  }

  Widget _buildPostHeader() {
    return Row(
      children: [
        CircleAvatar(backgroundColor: Colors.grey[300], radius: 20),
        SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("You", style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
            Text("10 mins ago", style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey)),
          ],
        ),
      ],
    );
  }

  Widget _buildPostStats(int supportCount, int commentCount) {
    return Row(
      children: [
        Icon(Icons.favorite_border, color: Colors.grey),
        SizedBox(width: 4),
        Text('$supportCount people supported', style: GoogleFonts.poppins(fontSize: 12)),
        SizedBox(width: 16),
        Icon(Icons.comment, color: Colors.grey),
        SizedBox(width: 4),
        Text('$commentCount comments', style: GoogleFonts.poppins(fontSize: 12)),
      ],
    );
  }

  Widget _buildCommentCard({required String commentContent}) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(backgroundColor: Colors.grey[300], radius: 20),
            SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("You commented:", style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                  SizedBox(height: 4),
                  Text(commentContent, style: GoogleFonts.poppins(fontSize: 14)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF3EBFF),
      appBar: AppBar(
        backgroundColor: Color(0xFFD3D3FF),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
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
      ),
      body: dataLoaded
          ? TabBarView(
        controller: _tabController,
        children: [
          _buildPostsTab(),
          _buildCommentsTab(),
        ],
      )
          : Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildPostsTab() {
    return userPosts.isNotEmpty
        ? ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: userPosts.length,
      itemBuilder: (context, index) {
        final post = userPosts[index];
        return _buildPostCard(
          title: post['title'],
          content: post['content'],
          supportCount: post['supportCount'],
          commentCount: post['commentCount'],
        );
      },
    )
        : Center(
      child: Text("You haven’t posted anything yet.", style: GoogleFonts.poppins(color: Colors.grey)),
    );
  }

  Widget _buildCommentsTab() {
    return userComments.isNotEmpty
        ? ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: userComments.length,
      itemBuilder: (context, index) {
        return _buildCommentCard(commentContent: userComments[index]);
      },
    )
        : Center(
      child: Text("You haven’t left any comments yet.", style: GoogleFonts.poppins(color: Colors.grey)),
    );
  }
}
