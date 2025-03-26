// import 'package:flutter/material.dart';
// import '../models/product_model.dart';

// class CartProvider with ChangeNotifier {
//   int cartItemsCount = 0;
//   final List<ProductModel> _cartItems = [];

//   List<ProductModel> get cartItems => _cartItems;

//   void addToCart(ProductModel product) {
//     if (cartItems.contains(product.id)) {}
//     _cartItems.add(product);
//     notifyListeners();
//   }

//   void removeCart(ProductModel product) {}

//   int get cartCount {
//     int cartItemsCount = 0;
//     for (var item in _cartItems) {
//       cartItemsCount += item.quantity;
//     }
//     return cartItemsCount;
//   }
// }
