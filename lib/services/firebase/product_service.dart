import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:merchverse/models/product_model.dart';

class ProductService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<ProductModel>> streamFeaturedProducts() {
    return _db
        .collection('products')
        .where('isFeatured', isEqualTo: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              return ProductModel.fromFirestore(
                doc.id,
                doc.data(),
              );
            }).toList());
  }
}
