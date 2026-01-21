class Product {
  final String id;
  final String name;
  final int price;
  final String imageUrl;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
  });

  factory Product.fromMap(String id, Map<String, dynamic> data) {
    return Product(
      id: id,
      name: data['name'],
      price: data['price'],
      imageUrl: data['imageUrl'],
    );
  }
}
