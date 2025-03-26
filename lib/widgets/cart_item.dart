import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app_assignment/cubit/product_cubit.dart';
import '../models/product_model.dart';

class CartItem extends StatelessWidget {
  final ProductModel product;

  const CartItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final productCubit = context.watch<ProductCubit>();
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CachedNetworkImage(
              imageUrl: product.imageUrl,
              height: 150,
              width: 130,
              fit: BoxFit.cover,
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  Center(
                child: SizedBox(
                    height: 40,
                    width: 40,
                    child: CircularProgressIndicator(
                        color: Colors.pink.shade600,
                        value: downloadProgress.progress)),
              ),
              errorWidget: (context, error, stackTrace) {
                return CachedNetworkImage(
                  imageUrl:
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTVLDP5s2j9u1x86fOb7kNKXanJeMn8zZ30ZQ&s',
                  height: 150,
                  width: 140,
                  fit: BoxFit.cover,
                );
              },
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(product.name,
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold)),
                  Text(product.brand,
                      style: TextStyle(fontSize: 12, color: Colors.black87)),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "₹${product.originalPrice.toStringAsFixed(2)}",
                        style: const TextStyle(
                          fontSize: 12,
                          decoration: TextDecoration.lineThrough,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        " ₹${product.price.toStringAsFixed(2)}",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 13),
                      ),
                    ],
                  ),
                  Text(
                    "${product.discount.toStringAsFixed(2)}% OFF",
                    style: const TextStyle(color: Colors.red, fontSize: 12),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 0),
                        constraints: const BoxConstraints(
                          minHeight: 30,
                          maxHeight: 36,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              padding: EdgeInsets.zero, // Remove button padding
                              constraints:
                                  const BoxConstraints(), // Remove extra button space
                              icon: const Icon(Icons.remove, size: 18),
                              onPressed: () {
                                productCubit.removeFromCart(product);
                              },
                            ),
                            Text(
                              '${product.quantity}',
                              style: const TextStyle(
                                fontSize: 16, // Slightly reduce font size
                                color: Colors.pink,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            IconButton(
                              padding: EdgeInsets.zero, // Remove button padding
                              constraints:
                                  const BoxConstraints(), // Remove extra button space
                              icon: const Icon(Icons.add, size: 18),
                              onPressed: () {
                                productCubit.addToCart(product);
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
