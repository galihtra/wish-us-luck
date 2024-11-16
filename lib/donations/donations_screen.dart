import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../slide_menu.dart';

class DonationsScreen extends StatelessWidget {
  final CollectionReference donations =
      FirebaseFirestore.instance.collection('donations');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: SlideMenu(
          onCommunityTap: () {
            Navigator.pushNamed(
                context, '/community'); // Navigate to Community screen
          },
          onDonationTap: () {
            Navigator.of(context).pop(); // Close the drawer, stay on Donations
          },
          onYourPostsTap: () {
            Navigator.pushNamed(
                context, '/your_posts'); // Navigate to Your Posts
          },
          onSettingsTap: () {
            Navigator.pushNamed(context, '/settings'); // Navigate to Settings
          },
          onLogoutTap: () {
            // Handle logout action
          },
        ),
      ),
      appBar: AppBar(
        title: Text("Donations Page"),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_outlined),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text("Notifications"),
                    content: Text("No new notifications."),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text("Close"),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: DonationsContent(donations: donations),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context,
                '/create_donation'); // Navigate to a screen to create a new donation
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            padding: EdgeInsets.symmetric(vertical: 16),
          ),
          child: Text(
            "Start a Donation",
            style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
          ),
        ),
      ),
    );
  }
}

class DonationsContent extends StatefulWidget {
  final CollectionReference donations;

  const DonationsContent({Key? key, required this.donations}) : super(key: key);

  @override
  _DonationsContentState createState() => _DonationsContentState();
}

class _DonationsContentState extends State<DonationsContent> {
  String? selectedCategory;

  void updateCategory(String category) {
    setState(() {
      selectedCategory = category;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search bar
          TextField(
            decoration: InputDecoration(
              hintText: "Search for a cause...",
              prefixIcon:
                  Icon(Icons.search, color: Theme.of(context).primaryColor),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.grey[200],
            ),
          ),
          SizedBox(height: 16),

          // Category filter
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CategoryIcon(
                label: "Fundraising",
                icon: Icons.volunteer_activism,
                color: Theme.of(context).primaryColor,
                isSelected: selectedCategory == "Fundraising",
                onTap: () => updateCategory("Fundraising"),
              ),
              CategoryIcon(
                label: "Chemotherapy",
                icon: Icons.medical_services,
                color: Theme.of(context).primaryColor,
                isSelected: selectedCategory == "Chemotherapy",
                onTap: () => updateCategory("Chemotherapy"),
              ),
              CategoryIcon(
                label: "Organ Donation",
                icon: Icons.favorite,
                color: Theme.of(context).primaryColor,
                isSelected: selectedCategory == "Organ Donation",
                onTap: () => updateCategory("Organ Donation"),
              ),
            ],
          ),
          SizedBox(height: 16),

          Text(
            "Emergency Help for Fundraising",
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),

          // StreamBuilder for category-specific campaigns
          // StreamBuilder<QuerySnapshot>(
          //   // stream: widget.donations
          //   //     .where('category', isEqualTo: selectedCategory ?? 'Emergency')
          //   //     .orderBy('remainingDays') // Sort by remainingDays
          //   //     .snapshots(),
          //   // builder: (context, snapshot) {
          //   //   if (snapshot.connectionState == ConnectionState.waiting) {
          //   //     return Center(child: CircularProgressIndicator());
          //   //   }
          //   //   if (snapshot.hasError) {
          //   //     return Center(child: Text('Error: ${snapshot.error}'));
          //   //   }

          //   //   final docs = snapshot.data?.docs ?? [];
          //   //   if (docs.isEmpty) {
          //   //     return Center(child: Text("No campaigns available."));
          //   //   }
          //     // return SizedBox(
          //     //   height: 180,
          //     //   child: PageView.builder(
          //     //     itemCount: docs.length,
          //     //     itemBuilder: (context, index) {
          //     //       final data = docs[index].data() as Map<String, dynamic>;
          //     //       return CampaignCard(data: data);
          //     //     },
          //     //   ),
          //     // );
              
          //   },
          // ),
          Center(child: Text("No campaigns available.")),
          SizedBox(height: 16),

          // All Campaigns Section
          Text(
            "Latest Fundraising Campaigns",
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: widget.donations.snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                final docs = snapshot.data?.docs ?? [];
                return ListView.builder(
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    final data = docs[index].data() as Map<String, dynamic>;
                    return CampaignCard(data: data);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryIcon extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryIcon({
    Key? key,
    required this.label,
    required this.icon,
    required this.color,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor:
                isSelected ? Color(0xFF8366A9) : color.withOpacity(0.2),
            child: Icon(icon, color: color),
          ),
          SizedBox(height: 4),
          Text(label, style: TextStyle(color: Colors.black)),
        ],
      ),
    );
  }
}

class CampaignCard extends StatelessWidget {
  final Map<String, dynamic> data;

  const CampaignCard({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String amountRaised = data['amountRaised']?.toString() ?? 'Rp0';
    String imageUrl = data['imageURL'] ?? 'https://via.placeholder.com/280';
    "https://images.unsplash.com/photo-1496449903678-68ddcb189a24?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D";
    String posterName = data['posterName'] ?? 'Unknown';
    String remainingDays = data['remainingDays']?.toString() ?? 'N/A';
    String title = data['title'] ?? 'No Title';
    String percentageFilled = data['percentageFilled']?.toString() ?? '0%';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        width: 280,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.network(
                imageUrl,
                height: 120,
                width: double.infinity,
                fit: BoxFit.cover,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  } else {
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                (loadingProgress.expectedTotalBytes ?? 1)
                            : null,
                      ),
                    );
                  }
                },
                errorBuilder: (context, error, stackTrace) {
                  return Center(child: Text('Image failed to load'));
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    posterName,
                    style: TextStyle(color: Colors.grey),
                  ),
                  SizedBox(height: 4),
                  Text(
                    amountRaised,
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "remainingDays: $remainingDays",
                    style: TextStyle(color: Colors.grey),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "$percentageFilled filled",
                    style: TextStyle(color: Colors.grey),
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // Navigate to donation detail or confirm donation action
                          Navigator.pushNamed(context, '/donation_detail',
                              arguments: data);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                        child: Text("Donate",
                            style: TextStyle(
                                color:
                                    Theme.of(context).colorScheme.onPrimary)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
