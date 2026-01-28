import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:merchverse/models/cart_item_model.dart';
import 'package:merchverse/models/product_model.dart';

class CartService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String get _uid {
    final user = _auth.currentUser;
    if (user == null) throw Exception("User belum login");
    return user.uid;
  }

  CollectionReference<Map<String, dynamic>> _cartItemsRef() {
    return _db.collection('carts').doc(_uid).collection('items');
  }

  // stream cart items realtime
  Stream<List<CartItemModel>> streamCartItems() {
    return _cartItemsRef()
        .orderBy('addedAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => CartItemModel.fromFirestore(doc.id, doc.data()))
          .toList();
    });
  }

  // add to cart (anti double)
  Future<void> addToCart(ProductModel product, {int qty = 1}) async {
    final docRef = _cartItemsRef().doc(product.id);

    await _db.runTransaction((tx) async {
      final doc = await tx.get(docRef);

      if (doc.exists) {
        final currentQty = (doc.data()?['qty'] as num?)?.toInt() ?? 1;
        tx.update(docRef, {
          'qty': currentQty + qty,
          'addedAt': FieldValue.serverTimestamp(),
        });
      } else {
        tx.set(docRef, {
          'productId': product.id,
          'title': product.title,
          'price': product.price,
          'imageUrl': product.imageUrl,
          'qty': qty,
          'addedAt': FieldValue.serverTimestamp(),
        });
      }
    });
  }

  Future<void> removeItem(String cartItemId) async {
    await _cartItemsRef().doc(cartItemId).delete();
  }

  Future<void> clearCart() async {
    final snapshot = await _cartItemsRef().get();
    final batch = _db.batch();
    for (final doc in snapshot.docs) {
      batch.delete(doc.reference);
    }
    await batch.commit();
  }

  // kalau lu mau "gapake quantity", ini helper buat set qty jadi 1 terus
  Future<void> setQty(String cartItemId, int qty) async {
    await _cartItemsRef().doc(cartItemId).update({'qty': qty});
  }
}
