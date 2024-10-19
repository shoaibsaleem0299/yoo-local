import 'package:flutter/material.dart';
import 'package:yoo_local/app_constant/app_colors.dart';
import 'package:yoo_local/screens/checkout/checkout_view.dart';
import 'package:yoo_local/screens/login/login_view.dart';
import 'package:yoo_local/widgets/app_button.dart';
import 'package:yoo_local/widgets/counter.dart';

class CartScreen extends StatelessWidget {
  final List<Map<String, dynamic>> cartData = [
    {
      'name': 'Corona Extra Beer',
      'imageUrl':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRobRe99qQP9ROENUffatFxgDPFnigcXiKr4A&s',
      'price': 1.59,
      'quantity': 1,
      'description': '6 Cans In 1 Pack',
    },
    {
      'name': 'Corona Extra Beer',
      'imageUrl':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRobRe99qQP9ROENUffatFxgDPFnigcXiKr4A&s',
      'price': 1.59,
      'quantity': 1,
      'description': '6 Cans In 1 Pack',
    },
    {
      'name': 'Corona Extra Beer',
      'imageUrl':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRobRe99qQP9ROENUffatFxgDPFnigcXiKr4A&s',
      'price': 1.59,
      'quantity': 1,
      'description': '6 Cans In 1 Pack',
    },
    {
      'name': 'Corona Extra Beer',
      'imageUrl':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRobRe99qQP9ROENUffatFxgDPFnigcXiKr4A&s',
      'price': 1.59,
      'quantity': 1,
      'description': '6 Cans In 1 Pack',
    },
    {
      'name': 'Corona Extra Beer',
      'imageUrl':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRobRe99qQP9ROENUffatFxgDPFnigcXiKr4A&s',
      'price': 1.59,
      'quantity': 1,
      'description': '6 Cans In 1 Pack',
    },
    {
      'name': 'Corona Extra Beer',
      'imageUrl':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRobRe99qQP9ROENUffatFxgDPFnigcXiKr4A&s',
      'price': 1.59,
      'quantity': 1,
      'description': '6 Cans In 1 Pack',
    },
    {
      'name': 'Corona Extra Beer',
      'imageUrl':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRobRe99qQP9ROENUffatFxgDPFnigcXiKr4A&s',
      'price': 1.59,
      'quantity': 1,
      'description': '6 Cans In 1 Pack',
    },
  ];

  final double subtotal = 6.89;
  final double deliveryFee = 4.9;
  final double discount = 10; // in percentage
  final double totalPrice = 10.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Padding(
            padding: const EdgeInsets.all(8.0),
            child: const Icon(
              Icons.search,
              color: Colors.black,
              size: 32,
            ),
          ),
          onPressed: () {
            // Add your search functionality here
          },
        ),
        title: const Text('Cart'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22.0),
        child: Column(
          children: [
            Divider(color: AppColors.primaryColor),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ListView.builder(
                  itemCount: cartData.length,
                  itemBuilder: (context, index) {
                    final product = cartData[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: AppColors.primaryColor,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Center(
                                child: Image.network(
                                  product['imageUrl'],
                                  width: 60,
                                  height: 80,
                                  fit: BoxFit.contain,
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Icon(
                                      Icons.broken_image,
                                      size: 40,
                                      color: Colors.grey,
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  product['name'],
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  product['description'],
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  '£${product['price'].toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.delete_sweep_outlined,
                                  size: 28,
                                  color: AppColors.primaryColor,
                                ),
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content:
                                          Text('Item deleted successfully!'),
                                      duration: Duration(seconds: 2),
                                      action: SnackBarAction(
                                        label: 'Undo',
                                        onPressed: () {
                                          // Undo delete action if necessary
                                        },
                                      ),
                                    ),
                                  );
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 18),
                                child: ItemCounter(initialQuantity: 1),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
            Column(
              children: [
                Divider(color: AppColors.primaryColor),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Subtotal :', style: TextStyle(fontSize: 16)),
                    Text('£${subtotal.toStringAsFixed(2)}',
                        style: const TextStyle(fontSize: 16)),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Delivery Fee :',
                        style: TextStyle(fontSize: 16)),
                    Text('£${deliveryFee.toStringAsFixed(1)}',
                        style: const TextStyle(fontSize: 16)),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Discount :', style: TextStyle(fontSize: 16)),
                    Text('%${discount.toString()}',
                        style: const TextStyle(fontSize: 16)),
                  ],
                ),
                const SizedBox(height: 16),
              ],
            ),
            const SizedBox(height: 8),
            AppButton(
              title: 'Check Out For £$totalPrice',
              onTap: () {
                Navigator.push(
                    context,
                    // MaterialPageRoute(builder: (context) => CheckoutView()));
                    MaterialPageRoute(builder: (context) => LoginView()));
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
