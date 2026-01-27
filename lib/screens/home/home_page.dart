import 'package:flutter/material.dart';
import '../../routes/app_routes.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  // Model untuk featured products
  final List<Map<String, dynamic>> featuredProducts = [
    {
      'id': 1,
      'image': 'assets/images/banner1.png',
      'title':
          'Hatsune Miku - Hatsune Miku Luminasta Prize Figure (Unshuttered SEKAI Ver.)',
      'description':
          'This figure captures Hatsune Miku’s confidence and artistic energy in stunning detail, celebrating her signature charm and captivating presence.',
    },
    {
      'id': 2,
      'image': 'assets/images/banner2.png',
      'title': 'Hatsune Miku - Hatsune Miku Luminasta (Shuttered SEKAI Ver.)',
      'description':
          'Hatsune Miku brings an ethereal, dreamlike presence, captured through intricate details and a hauntingly beautiful aesthetic.',
    },
    {
      'id': 3,
      'image': 'assets/images/banner3.png',
      'title':
          'Hatsune Miku - Hatsune Miku Luminasta Prize Figure (Sleepwear Ver.)',
      'description':
          'This Luminasta prize figure captures Hatsune Miku’s soft, relaxed charm, proving she’s just as iconic even offstage.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            const Text(
              'MERCHVERSE',
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Raleway',
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border, color: Colors.black),
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.home); // wish list page
            },
          ),
          IconButton(
            icon: const Icon(Icons.shopping_bag_outlined, color: Colors.black),
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.home); // cart page
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Banner Image
            Container(
              width: double.infinity,
              height: 85,
              margin: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(0),
                image: const DecorationImage(
                  image: AssetImage('assets/images/AppBanner.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // Miku Collaboration Section
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 22.0,
                vertical: 8.0,
              ),
              child: Column(
                children: [
                  // Title
                  const Text(
                    'Miku Collaboration',
                    style: TextStyle(
                      fontSize: 22,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 16),

                  // Description
                  Text(
                    'Celebrate the world of Hatsune Miku with this special collaboration. Explore exclusive merchandise designed to capture her music, style, and vibrant personality.',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Montserrat',
                      color: Colors.grey[700],
                      height: 1.6,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 18),
                ],
              ),
            ),

            // Featured Picks Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  // Section Title
                  const Text(
                    'Featured Picks',
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'The good stuff. Trust me.',
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'Montserrat',
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Carousel Slider with Cards
                  CarouselSlider(
                    options: CarouselOptions(
                      height: 450,
                      viewportFraction: 0.75,
                      enlargeCenterPage: false,
                      enableInfiniteScroll: true,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 4),
                      autoPlayAnimationDuration: const Duration(
                        milliseconds: 800,
                      ),
                      autoPlayCurve: Curves.easeInOut,
                      onPageChanged: (index, reason) {
                        setState(() {});
                      },
                    ),
                    items: featuredProducts.map((product) {
                      return Builder(
                        builder: (BuildContext context) {
                          return GestureDetector(
                            onTap: () {
                              // Navigate ke halaman detail produk
                              Navigator.pushNamed(
                                context,
                                AppRoutes
                                    .home, // Ganti dengan route detail produk
                                arguments: product['id'],
                              );
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              margin: const EdgeInsets.symmetric(
                                horizontal: 6.0,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.1),
                                    blurRadius: 8,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                    ),
                                    child: Image.asset(
                                      product['image'],
                                      height: 240,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                            return Container(
                                              height: 220,
                                              color: Colors.grey[300],
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.image_outlined,
                                                    size: 60,
                                                    color: Colors.grey[500],
                                                  ),
                                                  const SizedBox(height: 8),
                                                  Text(
                                                    'Product Image',
                                                    style: TextStyle(
                                                      color: Colors.grey[600],
                                                      fontFamily: 'Montserrat',
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                    ),
                                  ),
                                  // Product Info
                                  Padding(
                                    padding: const EdgeInsets.all(14.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        // Title
                                        Text(
                                          product['title'],
                                          style: const TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Montserrat',
                                            color: Colors.black87,
                                          ),
                                          textAlign: TextAlign.center,
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 2),

                                        // Diamond Decoration
                                        Image.asset(
                                          'assets/images/Diamond.png',
                                          width: 60,
                                          height: 60,
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                                return Icon(
                                                  Icons.diamond,
                                                  size: 12,
                                                  color: Colors.grey[600],
                                                );
                                              },
                                        ),
                                        const SizedBox(height: 1),

                                        // Description
                                        Text(
                                          product['description'],
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontFamily: 'Montserrat',
                                            color: Colors.grey[700],
                                            height: 1.4,
                                          ),
                                          textAlign: TextAlign.center,
                                          maxLines: 4,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });

          switch (index) {
            case 0:
              // Already on Home
              break;
            case 1:
              Navigator.pushNamed(context, AppRoutes.home); // product page
              break;
            case 2:
              Navigator.pushNamed(context, AppRoutes.home); // history page
              break;
            case 3:
              Navigator.pushNamed(context, AppRoutes.home); // account page
              break;
          }
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF6DBFFF),
        unselectedItemColor: Colors.grey,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined),
            activeIcon: Icon(Icons.shopping_bag),
            label: 'Product',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long_outlined),
            activeIcon: Icon(Icons.receipt_long),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Account',
          ),
        ],
      ),
    );
  }
}
