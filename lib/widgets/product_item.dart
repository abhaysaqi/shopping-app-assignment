import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app_assignment/cubit/product_cubit.dart';
import '../models/product_model.dart';

class ProductItem extends StatelessWidget {
  final ProductModel product;

  const ProductItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final productCubit = context.read<ProductCubit>();
    return Card(
      shadowColor: Colors.white,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(8)),
              child: SizedBox(
                  height: 140,
                  child: Stack(children: [
                    CachedNetworkImage(
                        imageUrl: product.imageUrl,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) => Center(
                                  child: SizedBox(
                                      height: 40,
                                      width: 40,
                                      child: CircularProgressIndicator(
                                          color: Colors.pink.shade600,
                                          value: downloadProgress.progress)),
                                ),
                        errorWidget: (context, url, error) {
                          debugPrint("Error while using Network Image");
                          return CachedNetworkImage(
                            imageUrl:
                                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTVLDP5s2j9u1x86fOb7kNKXanJeMn8zZ30ZQ&s",
                            width: double.infinity,
                            fit: BoxFit.cover,
                          );
                        }),
                    Positioned(
                        bottom: 10,
                        right: 10,
                        child: GestureDetector(
                          onTap: () => productCubit.addToCart(product),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            child: Text(
                              "Add",
                              style: TextStyle(color: Colors.pink),
                            ),
                          ),
                        )),
                  ])),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product.name,
                    maxLines: 1,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold)),
                Text(product.category,
                    style: TextStyle(fontSize: 12, color: Colors.black87)),
                SizedBox(
                  height: 5,
                ),
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
