import 'package:flutter/material.dart';

class AboutAppPage extends StatelessWidget {
  const AboutAppPage({super.key});

  static const _accent = Color(0xFF6DBFFF);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        scrolledUnderElevation: 0,
        foregroundColor: Colors.black,
        title: const Text(
          'MERCHVERSE',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black,
            letterSpacing: 0.5,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'About App',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Merchverse • Hatsune Miku',
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey.shade600,
              ),
            ),

            const SizedBox(height: 20),

            _buildSection(
              'Before anything else, I want to make this clear: this collaboration is not official. '
              'This app is just a fun, personal project.\n\n'
              'I\'m the Project Owner of this app, handling most of the development myself, with some help from friends during the process.',
            ),

            const SizedBox(height: 16),

            _buildSection(
              'This app might not look as polished as other apps you\'ve used to and that\'s totally fine. '
              'It may take time a small productive project to improve my skills. '
              'I wasn\'t sure what theme to go with, so I thought, "what if I make a merch app and \'collaborate\' with Hatsune Miku?" '
              'And yeah, that\'s how this happened!',
            ),

            const SizedBox(height: 16),

            _buildSection(
              'Most of the products and other assets used in this app are taken from the internet, since I\'m still learning and not very good at creating assets from scratch yet. '
              'I tried to give credit wherever possible, but I knew it might still look like I used some things without permission. '
              'Oops. Sorry about that. This project is made purely for fun and learning purposes.',
            ),

            const SizedBox(height: 16),

            _buildSection(
              'If this app causes any issues or problems, feel free to DM me on Discord and I\'ll take it down right away. '
              'Let\'s keep things chill and friendly.',
            ),

            const SizedBox(height: 26),

            const Text(
              'Team',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),

            _buildTeamMember('Arya Maulana Yusuf', 'Project Owner, App Designer, Developer'),
            _buildTeamMember('Arrah Hilmi', 'Developer'),
            _buildTeamMember('Moch Cahyahadi F', 'Developer'),
            _buildTeamMember('Rizal', 'Developer'),
            _buildTeamMember('Syihab', 'Developer'),

            const SizedBox(height: 26),

            Center(
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        'assets/images/image_22.png',
                        width: 150,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Hatsune Miku',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: _accent.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'Made for fun & learning',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: _accent,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 13,
        color: Colors.grey.shade700,
        height: 1.6,
      ),
    );
  }

  Widget _buildTeamMember(String name, String role) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        '$name — $role',
        style: TextStyle(
          fontSize: 13,
          color: Colors.grey.shade700,
          height: 1.6,
        ),
      ),
    );
  }
}
