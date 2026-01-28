import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/product_model.dart';

class WishlistService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Subcollection: users/{userId}/wishlist/{productId}
  CollectionReference<Map<String, dynamic>> _wishlistRef(String userId) {
    return _firestore.collection('users').doc(userId).collection('wishlist');
  }

  // Stream untuk real-time update wishlist
  Stream<QuerySnapshot<Map<String, dynamic>>> getWishlistStream(String userId) {
    return _wishlistRef(userId).snapshots();
  }

  // Tambah product ke wishlist
  Future<void> addToWishlist(String userId, ProductModel product) async {
    await _wishlistRef(userId).doc(product.id).set(product.toFirestore());
  }

  // Hapus product dari wishlist
  Future<void> removeFromWishlist(String userId, String productId) async {
    await _wishlistRef(userId).doc(productId).delete();
  }

  // Cek apakah product sudah ada di wishlist
  Future<bool> isInWishlist(String userId, String productId) async {
    final doc = await _wishlistRef(userId).doc(productId).get();
    return doc.exists;
  }
}
