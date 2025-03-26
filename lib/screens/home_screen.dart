import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app_assignment/cubit/product_cubit.dart';
import 'package:shopping_app_assignment/screens/cart_screen.dart';
import '../models/product_model.dart';
import '../widgets/product_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pink[100],
          title: const Text('Catalogue'),
          centerTitle: true,
          actions: [
            BlocBuilder<ProductCubit, List<ProductModel>>(
              builder: (context, state) {
                int totalQuantity =
                    context.watch<ProductCubit>().totalProductQuantity;
                return Stack(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.shopping_cart),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => CartScreen()),
                        );
                      },
                    ),
                    if (totalQuantity > 0)
                      Positioned(
                        right: 6,
                        top: 6,
                        child: CircleAvatar(
                          backgroundColor: Colors.red,
                          radius: 8,
                          child: Text(
                            totalQuantity.toString(),
                            style: const TextStyle(
                                fontSize: 12, color: Colors.white),
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
          ],
        ),
        body: BlocBuilder<ProductCubit, List<ProductModel>>(
            builder: (context, products) {
          if (products.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          return GridView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: products.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.65,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemBuilder: (context, i) => ProductItem(product: products[i]),
          );
        }));
  }
}
