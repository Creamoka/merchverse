import 'package:flutter/material.dart';
import '../../widgets/merchverse_appbar.dart';
import 'edit_profile_page.dart';
import '../misc/about_app_page.dart';
import '../../widgets/merchverse_bottom_nav.dart';


class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  bool _isLoggedIn = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    bottomNavigationBar: const MerchverseBottomNav(currentIndex: 3),
      appBar: MerchverseAppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: _isLoggedIn ? _buildLoggedInView() : _buildNotLoggedInView(),
    );
  }

  Widget _buildLoggedInView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _profileHeader(
            name: 'Username',
            email: 'user@email.com',
            address:
                'Jl. Mekar Indah No. 27, Jln DARMO DE Sukaranda, Jawa Kabupaten, Jawa Barat 4023, Indonesia',
          ),
          const SizedBox(height: 18),
          _menuSection(children: [
            _menuTile(
              icon: Icons.edit_outlined,
              label: 'Edit Profile',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const EditProfilePage()),
                );
              },
            ),
            _menuTile(
              icon: Icons.info_outline,
              label: 'About App',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AboutAppPage()),
                );
              },
            ),
            _menuTile(
              icon: Icons.logout,
              label: 'Logout',
              iconColor: Colors.red,
              onTap: () => _showSignOutDialog(context),
            ),
          ]),
        ],
      ),
    );
  }

  Widget _buildNotLoggedInView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _profileHeader(
            name: 'Guest',
            email: 'Not signed in',
            address: '',
            isGuest: true,
          ),
          const SizedBox(height: 18),
          _menuSection(children: [
            _menuTile(
              icon: Icons.login,
              label: 'Sign In / Sign Up',
              onTap: () => Navigator.pushNamed(context, '/sign-in'),
            ),
            _menuTile(
              icon: Icons.info_outline,
              label: 'About App',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AboutAppPage()),
                );
              },
            ),
          ]),
        ],
      ),
    );
  }

  Widget _profileHeader({
    required String name,
    required String email,
    required String address,
    bool isGuest = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 32,
            backgroundColor: isGuest ? Colors.grey.shade300 : Colors.blue.shade100,
            child: Icon(
              Icons.person,
              size: 34,
              color: isGuest ? Colors.grey.shade600 : Colors.white,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  email,
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
                if (address.isNotEmpty) ...[
                  const SizedBox(height: 6),
                  Text(
                    address,
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 11,
                      height: 1.4,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _menuSection({required List<Widget> children}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: children,
      ),
    );
  }

  Widget _menuTile({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    Color? iconColor,
  }) {
    return ListTile(
      leading: Icon(icon, color: iconColor ?? Colors.grey[700]),
      title: Text(
        label,
        style: const TextStyle(fontFamily: 'Montserrat', fontSize: 13),
      ),
      trailing: const Icon(Icons.chevron_right, size: 20),
      onTap: onTap,
    );
  }

  void _showSignOutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() => _isLoggedIn = false);
            },
            child: const Text('Logout', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
