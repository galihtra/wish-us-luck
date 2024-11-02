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
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        // Profile Header
        UserAccountsDrawerHeader(
          decoration: BoxDecoration(color: Colors.purple.shade100),
          accountName: Text("Melissa L.", style: TextStyle(color: Colors.black)),
          accountEmail: Text("Indonesia"),
          currentAccountPicture: CircleAvatar(
            backgroundColor: Colors.grey,
            child: Icon(Icons.person, color: Colors.white),
          ),
        ),

        // Menu Items
        ListTile(
          leading: Icon(Icons.group),
          title: Text("Community"),
          onTap: onCommunityTap, // Call the community tap callback
        ),
        ListTile(
          leading: Icon(Icons.volunteer_activism),
          title: Text("Donation"),
          onTap: onDonationTap, // Call the donation tap callback
        ),
        ListTile(
          leading: Icon(Icons.post_add),
          title: Text("Your Posts"),
          onTap: onYourPostsTap, // Call the your posts tap callback
        ),
        ListTile(
          leading: Icon(Icons.settings),
          title: Text("Settings"),
          onTap: onSettingsTap, // Call the settings tap callback
        ),

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
    );
  }
}
