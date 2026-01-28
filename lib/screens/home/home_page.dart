import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../routes/app_routes.dart';
import '../../widgets/merchverse_bottom_nav.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const _accent = Color(0xFF6DBFFF);
  int _currentIndex = 0;

  final List<Map<String, dynamic>> featuredProducts = [
    {
      'id': 1,
      'image': 'assets/images/banner1.png',
      'title':
          'Hatsune Miku - Hatsune Miku Luminasta Prize Figure (Unshuttered SEKAI Ver.)',
      'description':
          'This figure captures Hatsune Miku’s confidence and artistic energy in stunning detail.',
    },
    {
      'id': 2,
      'image': 'assets/images/banner2.png',
      'title': 'Hatsune Miku - Hatsune Miku Luminasta (Shuttered SEKAI Ver.)',
      'description':
          'Hatsune Miku brings an ethereal, dreamlike presence with intricate details.',
    },
    {
      'id': 3,
      'image': 'assets/images/banner3.png',
      'title':
          'Hatsune Miku - Hatsune Miku Luminasta Prize Figure (Sleepwear Ver.)',
      'description':
          'This prize figure captures Hatsune Miku’s soft, relaxed charm.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const MerchverseBottomNav(currentIndex: 0),
      backgroundColor: Colors.white,

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        automaticallyImplyLeading: false,
        title: const Text(
          'MERCHVERSE',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black,
            letterSpacing: 0.5,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border, color: Colors.black),
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.wishlist);
            },
          ),
          IconButton(
            icon: const Icon(Icons.shopping_bag_outlined, color: Colors.black),
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.cart);
            },
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Banner
            Container(
              width: double.infinity,
              height: 95,
              margin: const EdgeInsets.fromLTRB(16, 12, 16, 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                image: const DecorationImage(
                  image: AssetImage('assets/images/AppBanner.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(height: 10),

            // Title + desc
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Miku Collaboration',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 6, 16, 12),
              child: Text(
                'Celebrate the world of Hatsune Miku with this special collaboration. Explore exclusive merchandise designed to capture her style.',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade700,
                  height: 1.4,
                ),
              ),
            ),

            const SizedBox(height: 6),

            // Featured picks
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Featured Picks',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
              child: Text(
                'The good stuff. Trust me.',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
            ),

            CarouselSlider(
              options: CarouselOptions(
                height: 420,
                viewportFraction: 0.78,
                enlargeCenterPage: false,
                enableInfiniteScroll: true,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 4),
              ),
              items: featuredProducts.map((product) {
                return GestureDetector(
                  onTap: () {
                    // sementara arahkan ke Product Page dulu
                    Navigator.pushNamed(context, AppRoutes.product);
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey.shade200),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                          ),
                          child: Image.asset(
                            product['image'],
                            height: 240,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Container(
                              height: 240,
                              color: Colors.grey.shade200,
                              child: const Icon(Icons.image_not_supported),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(14),
                          child: Column(
                            children: [
                              Text(
                                product['title'],
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 10),
                              Text(
                                product['description'],
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.grey.shade700,
                                  height: 1.4,
                                ),
                                textAlign: TextAlign.center,
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 12),
                              SizedBox(
                                width: double.infinity,
                                height: 42,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: _accent,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(24),
                                    ),
                                    elevation: 0,
                                  ),
                                  onPressed: () {
                                    Navigator.pushNamed(context, AppRoutes.product);
                                  },
                                  child: const Text('View Products'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
