import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:merchverse/routes/app_routes.dart';
import '../../models/product_model.dart';
import '../../widgets/product_card.dart';
import '../../widgets/merchverse_bottom_nav.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  String _searchQuery = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const MerchverseBottomNav(currentIndex: 1),
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

      body: Column(
        children: [
          // ✅ Search Bar (rapih + 1 placeholder)
          Container(
            margin: const EdgeInsets.fromLTRB(22, 16, 22, 0),
            height: 46,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: TextField(
              onChanged: (value) {
                setState(() => _searchQuery = value.trim().toLowerCase());
              },
              style: const TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 13,
              ),
              decoration: InputDecoration(
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(vertical: 13),

                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,

                hintText: 'Search product',
                hintStyle: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 12,
                  color: Colors.grey.shade500,
                ),

                prefixIcon: Icon(Icons.search, size: 20),
              ),
            ),
          ),

          const SizedBox(height: 18),

          const Text(
            'Products',
            style: TextStyle(
              fontSize: 20,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Welcome to the good stuff',
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),

          const SizedBox(height: 16),

          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('products').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Error: ${snapshot.error}',
                      style: const TextStyle(fontFamily: 'Montserrat'),
                      textAlign: TextAlign.center,
                    ),
                  );
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(
                    child: Text(
                      'No products available',
                      style: TextStyle(fontFamily: 'Montserrat'),
                    ),
                  );
                }

                final allProducts = snapshot.data!.docs.map((doc) {
                  return ProductModel.fromFirestore(
                    doc.id,
                    doc.data() as Map<String, dynamic>,
                  );
                }).toList();

                // ✅ filter berdasarkan name
                final filteredProducts = allProducts.where((p) {
                  if (_searchQuery.isEmpty) return true;
                  return p.title.toLowerCase().contains(_searchQuery);
                }).toList();

                if (filteredProducts.isEmpty) {
                  return const Center(
                    child: Text(
                      'Produk tidak ditemukan',
                      style: TextStyle(fontFamily: 'Montserrat'),
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.fromLTRB(22, 0, 22, 16),
                  itemCount: filteredProducts.length,
                  itemBuilder: (context, index) {
                    return ProductCard(product: filteredProducts[index]);
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
