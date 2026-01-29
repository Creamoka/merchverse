import 'package:cloud_firestore/cloud_firestore.dart';

class CartItemModel {
  final String id; // docId cart
  final String productId;
  final String title;
  final double price;
  final String imageUrl;
  final int qty;
  final DateTime? addedAt;

  CartItemModel({
    required this.id,
    required this.productId,
    required this.title,
    required this.price,
    required this.imageUrl,
    required this.qty,
    this.addedAt,
  });

  // Factory dari Firestore doc
  factory CartItemModel.fromFirestore(String id, Map<String, dynamic> data) {
    return CartItemModel(
      id: id,
      productId: data['productId'] ?? '',
      title: data['title'] ?? data['name'] ?? '',
      price: (data['price'] as num?)?.toDouble() ?? 0,
      imageUrl: data['imageUrl'] ?? data['image'] ?? '',
      qty: (data['qty'] as num?)?.toInt() ?? 1,
      addedAt: (data['addedAt'] is Timestamp)
          ? (data['addedAt'] as Timestamp).toDate()
          : null,
    );
  }

  // Convert ke Map untuk Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'productId': productId,
      'name': title,           // supaya sama dengan firestore orders nanti
      'price': price,
      'image': imageUrl,
      'qty': qty,
    };
  }

  // Convert ke Map untuk passing ke OrderSummaryPage / arguments
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'qty': qty,
      'image': imageUrl,
    };
  }

  // Factory dari Map (misal dari arguments route)
  factory CartItemModel.fromMap(Map<String, dynamic> map) {
    return CartItemModel(
      id: map['id'] ?? '',
      productId: map['productId'] ?? '',
      title: map['title'] ?? '',
      price: (map['price'] as num?)?.toDouble() ?? 0,
      imageUrl: map['imageUrl'] ?? '',
      qty: (map['qty'] as num?)?.toInt() ?? 1,
      addedAt: map['addedAt'] != null
          ? DateTime.parse(map['addedAt'])
          : null,
    );
  }
}
