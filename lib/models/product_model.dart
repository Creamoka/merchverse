class ProductModel {
  final String id;

  // UI fields (dipakai Home / Detail / Product Page)
  final String title;
  final String description;
  final double price;
  final String imageUrl;

  // flags
  final bool exclusive;
  final bool collaboration;

  // meta
  final String releaseDate;

  ProductModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.exclusive,
    required this.collaboration,
    required this.releaseDate,
  });

  factory ProductModel.fromFirestore(
    String id,
    Map<String, dynamic> data,
  ) {
    return ProductModel(
      id: id,

      // 🔥 support 2 versi key:
      // - versi baru: title, description, imageUrl
      // - versi lama: name, image
      title: data['title'] ?? data['name'] ?? '',
      description: data['description'] ?? '',
      price: (data['price'] as num?)?.toDouble() ?? 0.0,
      imageUrl: data['imageUrl'] ?? data['image'] ?? '',

      exclusive: data['exclusive'] ?? false,
      collaboration: data['collaboration'] ?? false,
      releaseDate: data['releaseDate'] ?? '',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'exclusive': exclusive,
      'collaboration': collaboration,
      'releaseDate': releaseDate,
    };
  }
}
