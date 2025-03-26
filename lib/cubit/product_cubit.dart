// lib/cubits/product_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app_assignment/service/api_service.dart';
import '../models/product_model.dart';

class ProductCubit extends Cubit<List<ProductModel>> {
  ProductCubit() : super([]);
  final List<ProductModel> _cartItems = [];

  Future<void> fetchProducts() async {
    final products = await ApiService.fetchProducts();
    emit(products);
  }

  void addToCart(ProductModel product) {
    int index = _cartItems.indexWhere((item) => item.id == product.id);

    if (index != -1) {
      _cartItems[index].quantity++;
    } else {
      _cartItems.add(product);
    }
    emit(List.from(state));
  }

  void removeFromCart(ProductModel product) {
    int index = _cartItems.indexWhere((item) => item.id == product.id);
    if (index != -1) {
      if (_cartItems[index].quantity > 1) {
        _cartItems[index].quantity--;
      } else {
        _cartItems.removeAt(index);
      }
      emit(List.from(state));
    }
  }

  int get totalProductQuantity {
    int totalQuantity = 0;
    for (var item in _cartItems) {
      totalQuantity += item.quantity;
    }
    return totalQuantity;
  }

  double getTotalPrice() {
    double total = 0.0;
    for (var product in _cartItems) {
      total += (product.price * product.quantity);
    }
    return total;
  }

  List<ProductModel> get cartItems => List.from(_cartItems);
}
