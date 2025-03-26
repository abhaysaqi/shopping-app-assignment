// lib/models/product_model.dart
class ProductModel {
  final int id;
  final String name;
  final String brand;
  final String imageUrl;
  final double price;
  final double originalPrice;
  final double discount;
  int quantity;

  ProductModel({
    required this.id,
    required this.name,
    required this.brand,
    required this.imageUrl,
    required this.price,
    required this.originalPrice,
    required this.discount,
    this.quantity = 0,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    double price = (json['price'] as num).toDouble();
    double discount = (json['discountPercentage'] as num).toDouble();
    double originalPrice = price * (100 / (100 - discount));

    return ProductModel(
      id: json['id'] as int,
      name: json['title'] as String,
      brand: json['brand'] as String,
      imageUrl: json['thumbnail'] ?? '',
      price: price,
      originalPrice: originalPrice,
      discount: discount,
      quantity: json['quantity'] ?? 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': name,
      'brand': brand,
      'thumbnail': imageUrl,
      'price': price,
      'discountPercentage': discount,
      'quantity': quantity,
    };
  }
}
