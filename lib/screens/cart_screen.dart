import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app_assignment/cubit/product_cubit.dart';
import 'package:shopping_app_assignment/models/product_model.dart';
import 'package:shopping_app_assignment/widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final productCubit = context.read<ProductCubit>();
    // final cartItems = productCubit.cartItems;
    // double totalPrice = productCubit.getTotalPrice();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[100],
        title: const Text('Cart'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: BlocBuilder<ProductCubit, List<ProductModel>>(
        builder: (context, state) {
          final productCubit = context.read<ProductCubit>();
          final cartItems = productCubit.cartItems;
          double totalPrice = productCubit.getTotalPrice();
          return Column(
            children: [
              Expanded(
                child: cartItems.isEmpty
                    ? const Center(
                        child: Text(
                          'Your cart is empty!',
                          style: TextStyle(fontSize: 18, color: Colors.black54),
                        ),
                      )
                    : ListView.builder(
                        itemCount: cartItems.length,
                        itemBuilder: (context, i) {
                          final product = cartItems[i];
                          return CartItem(product: product);
                        },
                      ),
              ),
              if (cartItems.isNotEmpty)
                checkOutWidget(context: context, totlePrice: totalPrice),
              SizedBox(
                height: 20,
              )
            ],
          );
        },
      ),
    );
  }

  Widget checkOutWidget(
      {required BuildContext context, required double totlePrice}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Amount Price',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black54,
                ),
              ),
              Text(
                '₹${totlePrice.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          // Right Side - Check Out Button
          ElevatedButton.icon(
            onPressed: () {
              // Add checkout action
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Checked Out Successfully!")),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.pink.shade600,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            icon: const Icon(Icons.shopping_cart_checkout,
                size: 18, color: Colors.white),
            label: const Text(
              'Check Out',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
