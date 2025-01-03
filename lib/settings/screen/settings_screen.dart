import 'package:flutter/material.dart';
import '../../onboarding/screen/onboarding_screen.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFFE5E1FA),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Settings", style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          _buildProfileHeader(),
          Expanded(child: _buildSettingsList()),
          _buildLogoutButton(context),
          _buildCopyright(),
        ],
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      color: const Color(0xFFFFFFFF),
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          const CircleAvatar(radius: 40, backgroundColor: Colors.grey),
          const SizedBox(height: 10),
          const Text("Melissa L.", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text("🇮🇩", style: TextStyle(fontSize: 16)),
              SizedBox(width: 5),
              Text("Indonesia", style: TextStyle(fontSize: 16, color: Colors.grey)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsList() {
    final settingsOptions = [
      "Edit Profile",
      "Notification Settings",
      "Privacy",
      "Close Account",
    ];

    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 10),
      itemCount: settingsOptions.length,
      separatorBuilder: (context, index) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        return _buildSettingsOption(settingsOptions[index]);
      },
    );
  }

  Widget _buildSettingsOption(String title) {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
        color: const Color(0xFFF4F1FF),
      ),
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        onTap: () {
          // Logic to navigate to another page can be added here
        },
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Container(
        color: const Color(0xFFF4F1FF),
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: ListTile(
          leading: const Icon(Icons.logout, color: Colors.black),
          title: const Text(
            "Log Out",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
          onTap: () => _showLogoutDialog(context),
        ),
      ),
    );
  }

  Widget _buildCopyright() {
    return const Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Text(
        "Copyright 2024. All Rights Reserved.",
        style: TextStyle(fontSize: 12, color: Colors.grey),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(
              color: Color(0xFF8E44AD), // Purple background color
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Are you sure?",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(height: 20),
                _buildLogoutDialogButtons(context),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildLogoutDialogButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextButton(
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => OnboardingScreen()),
                  (Route<dynamic> route) => false,
            );
          },
          style: TextButton.styleFrom(
            backgroundColor: const Color(0xFFD3D3FF), // Light purple button
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: const Text(
            "Yes",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          style: TextButton.styleFrom(
            backgroundColor: Colors.red, // Red button
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: const Text(
            "No",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
