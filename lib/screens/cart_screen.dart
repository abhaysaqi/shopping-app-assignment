import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:shopping_app_assignment/cubit/product_cubit.dart';
import 'package:shopping_app_assignment/models/product_model.dart';
import 'package:shopping_app_assignment/screens/items_screen.dart';
import 'package:shopping_app_assignment/widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                checkOutWidget(
                  context: context,
                  totlePrice: totalPrice,
                ),
              SizedBox(
                height: 20,
              )
            ],
          );
        },
      ),
    );
  }

  Widget checkOutWidget({
    required BuildContext context,
    required double totlePrice,
  }) {
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
          ElevatedButton.icon(
            onPressed: () {
              showCongratsDialog(context);
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

  void showCongratsDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          alignment: Alignment.center,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Lottie.asset('assets/lotties/congrats.json',
                    animate: true,
                    width: 300,
                    height: 200,
                    fit: BoxFit.cover,
                    repeat: true),
                const Text(
                  'Congrats!',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () {
                    context.read<ProductCubit>().clearCarts();
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ItemsScreen(),
                      ),
                      (route) => false,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink[400],
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Continue',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
