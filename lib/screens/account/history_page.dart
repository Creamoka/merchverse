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

  Stream<List<Map<String, dynamic>>> _getOrdersStream() {
    final user = _auth.currentUser;
    if (user == null) return Stream.value([]);

    debugPrint('Getting orders for user: ${user.uid}');

    return _firestore
        .collection('orders')
        .where('userId', isEqualTo: user.uid)
        .snapshots()
        .map((snapshot) {
          debugPrint('📊 Snapshot received with ${snapshot.docs.length} docs');

          try {
            // Sort manually - handle missing timestamp field
            final docs = snapshot.docs;
            debugPrint('About to sort ${docs.length} docs');

            docs.sort((a, b) {
              try {
                final aData = a.data();
                final bData = b.data();

                final aTime =
                    (aData['timestamp'] as Timestamp?)?.toDate() ??
                    DateTime(1970);
                final bTime =
                    (bData['timestamp'] as Timestamp?)?.toDate() ??
                    DateTime(1970);
                return bTime.compareTo(aTime);
              } catch (e) {
                debugPrint('Error in sort comparison: $e');
                return 0; // fallback
              }
            });

            debugPrint('Sorting done');

            final results = <Map<String, dynamic>>[];

            debugPrint('Starting loop for ${docs.length} docs');

            for (int i = 0; i < docs.length; i++) {
              try {
                debugPrint('Loop iteration $i');
                final doc = docs[i];
                final data = doc.data();
                debugPrint('📄 Order $i: doc.id=${doc.id}');
                debugPrint('   data keys: ${data.keys.toList()}');

                final itemsList = data['items'];
                debugPrint('   items type: ${itemsList.runtimeType}');

                final items = itemsList as List<dynamic>? ?? [];
                debugPrint('   items count: ${items.length}');

                if (items.isEmpty) {
                  debugPrint('   ⏭️  No items, skipping');
                  continue;
                }

                final firstItem = items[0] as Map<dynamic, dynamic>?;
                debugPrint('   firstItem type: ${firstItem.runtimeType}');

                if (firstItem == null) {
                  debugPrint('   ⏭️  firstItem is null, skipping');
                  continue;
                }

                final image = (firstItem['image'] as String?) ?? '';
                final name = (firstItem['name'] as String?) ?? 'Product';
                final price = (data['total'] as num?)?.toDouble() ?? 0.0;

                final timestamp = data['timestamp'] as Timestamp?;
                final date = timestamp != null
                    ? timestamp.toDate().toString().split(' ')[0]
                    : 'N/A';

                debugPrint('   ✅ Mapped: $name - \$$price on $date');

                results.add({
                  'image': image,
                  'title': name,
                  'price': price,
                  'date': date,
                  'exclusive': (firstItem['exclusive'] as bool?) ?? false,
                  'collaboration':
                      (firstItem['collaboration'] as bool?) ?? false,
                });
              } catch (e, st) {
                debugPrint('   ❌ Error at iteration $i: $e');
                debugPrint('   Stack: $st');
              }
            }

            debugPrint('✨ Final results: ${results.length} items');
            return results;
          } catch (e, st) {
            debugPrint('❌ ERROR in stream map: $e');
            debugPrint('Stack: $st');
            return [];
          }
        });
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
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: _getOrdersStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final historyItems = snapshot.data ?? [];

          if (historyItems.isEmpty) {
            return Center(
              child: Text(
                'No orders yet.',
                style: TextStyle(color: Colors.grey[600], fontSize: 14),
              ),
            );
          }

          return ListView(
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
          );
        },
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
