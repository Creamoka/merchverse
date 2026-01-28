class ProductModel {
  final String id;
  final String name;
  final double price;
  final String image;
  final bool exclusive;
  final bool collaboration;
  final String releaseDate; // 🔥 STRING DULU

  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
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
      name: data['name'] ?? '',
      price: (data['price'] as num).toDouble(), // 🔥 AMAN
      image: data['image'] ?? '',
      exclusive: data['exclusive'] ?? false,
      collaboration: data['collaboration'] ?? false,
      releaseDate: data['releaseDate'] ?? '',
    );
  }

  get description => null;
}
