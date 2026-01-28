import 'package:flutter/material.dart';
import '../../routes/app_routes.dart';
import '../../widgets/merchverse_bottom_nav.dart';


class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  int _currentIndex = 2;

  final List<Map<String, dynamic>> historyItems = [
    {
      'image': 'assets/images/hatsune_miku_1.png',
      'title':
          'Hatsune Miku - Hatsune Miku Trio-Try-IT Prize Figure (Paint Girl Ver.)',
      'price': 310.00,
      'date': '01/15/2025',
      'exclusive': true,
      'collaboration': true,
    },
    {
      'image': 'assets/images/hatsune_miku_2.png',
      'title':
          'Hatsune Miku - Sakura Miku Noodle Stopper Prize Figure (Wink Ver.)',
      'price': 310.00,
      'date': '01/10/2025',
      'exclusive': true,
      'collaboration': false,
    },
    {
      'image': 'assets/images/hatsune_miku_3.png',
      'title':
          'Hatsune Miku - Hatsune Miku Trio-Try-IT Prize Figure (Classical Retro Ver.)',
      'price': 310.00,
      'date': '01/05/2025',
      'exclusive': false,
      'collaboration': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const MerchverseBottomNav(currentIndex: 2),
      backgroundColor: Colors.white,

      // ✅ APPBAR STYLE SAMA HOME
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

      body: ListView(
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
            'Yes, you really bought all of these',
            style: TextStyle(
              fontSize: 12,
              fontFamily: 'Montserrat',
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 20),

          // ✅ LIST ITEM
          ...historyItems.map((item) => _HistoryCard(item: item)).toList(),
        ],
      ),
    );
  }
}

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
            color: Colors.black.withValues(alpha: 0.06),
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
            // image
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                item['image'],
                width: 90,
                height: 110,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(width: 14),

            // text
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
        color: color.withValues(alpha: 0.10),
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
