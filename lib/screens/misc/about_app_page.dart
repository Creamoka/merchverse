import 'package:flutter/material.dart';

class AboutAppPage extends StatelessWidget {
  const AboutAppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        foregroundColor: Colors.black,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            const Text(
              'Merchverse • Hatsune Miku',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Disclaimer
            _buildSection(
              'Before anything else, I want to make this clear: this collaboration is not official. This app is just a fun, personal project.\n\nI\'m the Project Owner of this app, handling most of the development myself, with some help from friends during the process.',
            ),
            const SizedBox(height: 20),

            // App Description
            _buildSection(
              'This app might not look as polished as other apps you\'ve used to and that\'s totally fine. It may take time a small productive project to improve my skills. I wasn\'t sure what theme to go with, so I thought, "what if I make a merch app and \'collaborate\' with Hatsune Miku?" And yeah, that\'s how this happened!',
            ),
            const SizedBox(height: 20),

            // Products disclaimer
            _buildSection(
              'Most of the products and other assets used in this app are taken from the internet, since I\'m still learning and not very good at creating assets from scratch yet. I tried to give credit wherever possible, but I knew it might still look like I used some things without permission. Oops. Sorry about that. This project is made purely for fun and learning purposes.',
            ),
            const SizedBox(height: 20),

            // Contact info
            _buildSection(
              'If this app causes any issues or problems, feel free to DM me on Discord and I\'ll take it down right away. Let\'s keep things chill and friendly.',
            ),
            const SizedBox(height: 30),

            // Team Section
            const Text(
              'Team',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            _buildTeamMember(
              'Arya Maulana Yusuf',
              'Project Owner, App Designer',
            ),
            _buildTeamMember('Arrah Hilmi', 'Developer'),
            _buildTeamMember('Moch Cahyahadi F', 'Developer'),
            _buildTeamMember('Rizal', 'Developer'),
            _buildTeamMember('Syihab', 'Developer'),

            const SizedBox(height: 30),

            // Character Image Placeholder
            Center(
              child: Image.asset(
                'assets/images/image_22.png',
                width: 150,
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Text(
                'Hatsune Miku',
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String text) {
    return Text(
      text,
      style: TextStyle(fontSize: 13, color: Colors.grey[700], height: 1.6),
    );
  }

  Widget _buildTeamMember(String name, String role) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        '$name - $role',
        style: TextStyle(fontSize: 13, color: Colors.grey[700], height: 1.6),
      ),
    );
  }
}
