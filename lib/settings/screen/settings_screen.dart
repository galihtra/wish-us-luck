import 'package:flutter/material.dart';

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
          onPressed: () {},
        ),
        title: const Text(
          "Settings",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            color: const Color(0xFFFFFFFF),
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: const Column(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.grey,
                ),
                SizedBox(height: 10),
                Text(
                  "Melissa L.",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "🇮🇩",
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(width: 5),
                    Text(
                      "Indonesia",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _buildSettingsOption("Edit Profile"),
                const SizedBox(height: 10),
                _buildSettingsOption("Notification Settings"),
                const SizedBox(height: 10),
                _buildSettingsOption("Privacy"),
                const SizedBox(height: 10),
                _buildSettingsOption("Close Account"),
                const SizedBox(height: 10),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: Container(
              color: const Color(0xFFF4F1FF),
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: ListTile(
                leading: const Icon(Icons.logout, color: Colors.black),
                title: const Text(
                  "Log Out",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                onTap: () {
                  // Logic logout
                },
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: Text(
              "Copyright 2024. All Rights Reserved.",
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsOption(String title) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade300),
        ),
        color: const Color(0xFFF4F1FF),
      ),
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        onTap: () {
          // Logic move to another page
        },
      ),
    );
  }
}
