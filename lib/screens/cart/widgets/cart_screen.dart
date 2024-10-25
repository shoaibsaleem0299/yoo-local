import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:yoo_local/app_constant/app_colors.dart';
import 'package:yoo_local/app_constant/app_constants.dart';
import 'package:yoo_local/screens/checkout/checkout_view.dart';
import 'package:yoo_local/screens/login/login_view.dart';
import 'package:yoo_local/ui_fuctionality/local_data.dart';
import 'package:yoo_local/widgets/app_button.dart';
import 'package:yoo_local/widgets/counter.dart';

class CartScreen extends StatefulWidget {
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
  }

  final Dio _dio = Dio();

  Future<List<Map<String, dynamic>>> getUserCart() async {
    var userToken = await LocalData.getString(AppConstants.userToken);
    if (userToken != null) {
      try {
        String url = "${AppConstants.baseUrl}/cart/cart_by_user";
        Response response = await _dio.post(
          url,
          options: Options(
            headers: {
              'Authorization': 'Bearer $userToken',
            },
          ),
        );
        if (response.statusCode == 200) {}
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Login failed, Credentials not matched',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            backgroundColor: AppColors.primaryColor,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            duration: Duration(seconds: 3),
          ),
        );
      }
    } else {
      Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Please Login"),
            AppButton(
                title: "Login",
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginView()));
                })
          ],
        ),
      );
    }

    return [];
  }

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

  final double discount = 10;

  final double totalPrice = 10.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
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
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CheckoutView()));
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
