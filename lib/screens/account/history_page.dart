import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../routes/app_routes.dart';
import '../../widgets/merchverse_bottom_nav.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  int _currentIndex = 2;

  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  bool _loading = true;
  List<Map<String, dynamic>> historyItems = [];

  @override
  void initState() {
    super.initState();
    _loadUserOrders();
  }

  Future<void> _loadUserOrders() async {
    final user = _auth.currentUser;
    if (user == null) return;

    try {
      final snapshot = await _firestore
          .collection('orders')
          .where('userId', isEqualTo: user.uid)
          .orderBy('timestamp', descending: true) // pakai timestamp
          .get();

      final orders = snapshot.docs.map((doc) {
        final data = doc.data();
        final items = data['items'] as List<dynamic>? ?? [];
        final firstItem = items.isNotEmpty ? items[0] : null;

        return {
          'image': firstItem != null ? firstItem['image'] ?? '' : '',
          'title': firstItem != null ? firstItem['title'] ?? 'Product' : 'Product',
          'price': data['total'] ?? 0.0,
          'date': data['timestamp'] != null
              ? (data['timestamp'] as Timestamp).toDate().toString().split(' ')[0]
              : '',
          'exclusive': firstItem != null && (firstItem['exclusive'] == true),
          'collaboration': firstItem != null && (firstItem['collaboration'] == true),
        };
      }).toList();

      setState(() {
        historyItems = orders;
        _loading = false;
      });
    } catch (e) {
      debugPrint('Error loading orders: $e');
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const MerchverseBottomNav(currentIndex: 2),
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          'MERCHVERSE',
          style: TextStyle(
            fontSize: 16,
            fontFamily: 'Raleway',
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border, color: Colors.black),
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.home); // wishlist
            },
          ),
          IconButton(
            icon: const Icon(Icons.shopping_bag_outlined, color: Colors.black),
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.home); // cart
            },
          ),
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : historyItems.isEmpty
              ? Center(
                  child: Text(
                    'No orders yet.',
                    style: TextStyle(color: Colors.grey[600], fontSize: 14),
                  ),
                )
              : ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
                  children: [
                    const Text(
                      'Order History',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Here are all your previous purchases',
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'Montserrat',
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // LIST ITEM
                    ...historyItems.map((item) => _HistoryCard(item: item)).toList(),
                  ],
                ),
    );
  }
}

// ---------- HISTORY CARD & TAG CHIP ----------

class _HistoryCard extends StatelessWidget {
  final Map<String, dynamic> item;

  const _HistoryCard({required this.item});

  @override
  Widget build(BuildContext context) {
    final bool exclusive = item['exclusive'] == true;
    final bool collaboration = item['collaboration'] == true;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: item['image'] != ''
                  ? Image.network(
                      item['image'],
                      width: 90,
                      height: 110,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        width: 90,
                        height: 110,
                        color: Colors.grey[200],
                        child: Icon(Icons.image, color: Colors.grey[400]),
                      ),
                    )
                  : Container(
                      width: 90,
                      height: 110,
                      color: Colors.grey[200],
                      child: Icon(Icons.image, color: Colors.grey[400]),
                    ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['title'],
                    style: const TextStyle(
                      fontSize: 13,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '\$${(item['price'] as num).toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Date: ${item['date']}',
                    style: TextStyle(
                      fontSize: 11,
                      fontFamily: 'Montserrat',
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      if (exclusive)
                        _TagChip(
                          text: 'Exclusive',
                          color: const Color(0xFF6DBFFF),
                        ),
                      if (collaboration)
                        _TagChip(
                          text: 'Collaboration',
                          color: const Color(0xFF6DBFFF),
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

class _TagChip extends StatelessWidget {
  final String text;
  final Color color;

  const _TagChip({required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color),
        color: color.withOpacity(0.1),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 11,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }
}
