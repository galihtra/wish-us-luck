import 'package:flutter/material.dart';

class NotificationsScreen extends StatefulWidget {
  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Simulated data
  List<String> allNotifications = [
    "You have a new message.",
    "Your post received a comment.",
    "You were mentioned in a post."
  ];
  List<String> unreadNotifications = [
    "Your post received a comment."
  ];
  List<String> mentionNotifications = [
    "You were mentioned in a post."
  ];

  // Flag to check if notifications have been loaded
  bool notificationsLoaded = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _loadNotifications();
  }

  // Simulated data loading function
  Future<void> _loadNotifications() async {
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      notificationsLoaded = true; // Set to true after loading
    });
  }

  Widget _buildNotificationList(List<String> notifications) {
    if (notifications.isEmpty) {
      return Center(
        child: Text("No notifications available.", style: TextStyle(fontSize: 18)),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: notifications.length,
      itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.symmetric(vertical: 8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          color: Colors.white,
          child: ListTile(
            title: Text(notifications[index]),
            leading: Icon(Icons.notifications, color: Colors.deepPurple),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFD3D3FF),
        title: Text(
          'Notifications',
          style: TextStyle(color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        bottom: TabBar(
          controller: _tabController,
          labelColor: Color(0xFF8366A9),
          unselectedLabelColor: Colors.grey,
          indicatorColor: Color(0xFF8366A9),
          tabs: [
            Tab(
              text: 'All (${notificationsLoaded ? allNotifications.length : 0})',
            ),
            Tab(
              text: 'Unread (${notificationsLoaded ? unreadNotifications.length : 0})',
            ),
            Tab(
              text: 'Mentions (${notificationsLoaded ? mentionNotifications.length : 0})',
            ),
          ],
        ),
      ),
      body: notificationsLoaded
          ? TabBarView(
        controller: _tabController,
        children: [
          // All notifications tab
          _buildNotificationList(allNotifications),

          // Unread notifications tab
          _buildNotificationList(unreadNotifications),

          // Mentions notifications tab
          _buildNotificationList(mentionNotifications),
        ],
      )
          : Center(
        child: CircularProgressIndicator(), // Show loading indicator while loading
      ),
    );
  }
}
