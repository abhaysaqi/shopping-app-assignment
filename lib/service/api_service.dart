// lib/services/api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product_model.dart';

class ApiService {
  static const String _baseUrl = 'https://dummyjson.com/products';

  static Future<List<ProductModel>> fetchProducts(
      {int skip = 0, int limit = 10}) async {
    try {
      final response =
          await http.get(Uri.parse('$_baseUrl?skip=$skip&limit=$limit'));
      print("Response ${response.statusCode}  And  ${response.body}");

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> products = data['products'];
        return products.map((json) => ProductModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      print("Catch Working");
      throw Exception(e);
    }
  }
}
