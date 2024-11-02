import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../slide_menu.dart';

class DonationsScreen extends StatelessWidget {
  final CollectionReference donationCauses = FirebaseFirestore.instance.collection('donationCauses');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: SlideMenu(
          onCommunityTap: () {
            // Define the action for community tap
          }, onDonationTap: () {  }, onYourPostsTap: () {  }, onSettingsTap: () {  }, onLogoutTap: () {  },
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.purple.shade100,
        title: Text("Donations Page", style: TextStyle(color: Colors.black)),
        iconTheme: IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_outlined),
            onPressed: () {
              // Define notification action
            },
          ),
        ],
      ),
      body: DonationsContent(donationCauses: donationCauses),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            // Start donation action
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.purple,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            padding: EdgeInsets.symmetric(vertical: 16),
          ),
          child: Text(
            "Start a Donation",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class DonationsContent extends StatelessWidget {
  final CollectionReference donationCauses;

  DonationsContent({required this.donationCauses});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: donationCauses.snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }

              final docs = snapshot.data!.docs;

              return ListView.builder(
                itemCount: docs.length,
                itemBuilder: (context, index) {
                  final data = docs[index].data() as Map<String, dynamic>;
                  return ListTile(
                    title: Text(data['name'] ?? 'No Name'),
                    subtitle: Text(data['description'] ?? 'No Description'),
                    trailing: Icon(Icons.arrow_forward),
                    onTap: () {
                      // Define action on tap, maybe navigate to details
                    },
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
