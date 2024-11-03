import 'package:flutter/material.dart';

class SlideMenu extends StatelessWidget {
  final VoidCallback onCommunityTap;
  final VoidCallback onDonationTap;
  final VoidCallback onYourPostsTap;
  final VoidCallback onSettingsTap;
  final VoidCallback onLogoutTap;

  const SlideMenu({
    Key? key,
    required this.onCommunityTap,
    required this.onDonationTap,
    required this.onYourPostsTap,
    required this.onSettingsTap,
    required this.onLogoutTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile Header
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: Color(0xFFD3D3FF)), // Match with NotificationsScreen
            accountName: Text("Melissa L.", style: TextStyle(color: Colors.black)),
            accountEmail: Text("Indonesia", style: TextStyle(color: Colors.black54)),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.grey,
              child: Icon(Icons.person, color: Colors.white),
            ),
          ),

          // Menu Items
          _buildMenuItem(Icons.group, "Community", onCommunityTap),
          _buildMenuItem(Icons.volunteer_activism, "Donation", onDonationTap),
          _buildMenuItem(Icons.post_add, "Your Posts", onYourPostsTap),
          _buildMenuItem(Icons.settings, "Settings", onSettingsTap),

          // Spacer
          Spacer(),

          // Logout Button
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: OutlinedButton.icon(
              onPressed: onLogoutTap, // Call the logout tap callback
              icon: Icon(Icons.logout, color: Colors.black),
              label: Text("Log Out", style: TextStyle(color: Colors.black)),
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Color(0xFF8366A9)), // Match the theme color
      title: Text(title, style: TextStyle(color: Colors.black)),
      onTap: onTap, // Call the respective callback
    );
  }
}
