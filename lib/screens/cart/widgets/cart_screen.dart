import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:yoo_local/app_constant/app_colors.dart';
import 'package:yoo_local/app_constant/app_constants.dart';
import 'package:yoo_local/screens/category/category_view.dart';
import 'package:yoo_local/screens/checkout/checkout_view.dart';
import 'package:yoo_local/screens/login/login_view.dart';
import 'package:yoo_local/ui_fuctionality/local_data.dart';
import 'package:yoo_local/widgets/app_button.dart';

class CartScreen extends StatefulWidget {
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final Dio _dio = Dio();
  Map userCartData = {};
  List userCartItems = [];
  bool isLoading = true;
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    getUserCart();
  }

  Future<void> getUserCart() async {
    var userToken = await LocalData.getString(AppConstants.userToken);
    if (userToken != null && userToken!.isNotEmpty) {
      isLoggedIn = true; // User is logged in
      try {
        String url = "${AppConstants.baseUrl}/cart/cart_by_user";
        Response response = await _dio.get(
          url,
          options: Options(
            headers: {
              'Authorization': 'Bearer $userToken',
            },
          ),
        );
        if (response.statusCode == 200) {
          setState(() {
            userCartData = response.data['data']['data'][0];
            userCartItems = userCartData['items'];
          });
        } else {
          // Handle error if needed
        }
      } catch (e) {
        print(e);
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    } else {
      isLoggedIn = false; // User is not logged in
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> removeItemFromCart(String cartId, String inventoryId) async {
    var userToken = await LocalData.getString(AppConstants.userToken);

    if (userToken!.isNotEmpty) {
      try {
        String url = "https://yoolocal.co.uk/api/cart/removeItem";

        final requestBody = {
          'cart_id': cartId,
          'inventory_id': inventoryId,
        };

        // Send the POST request
        Response response = await _dio.post(
          url,
          data: requestBody,
          options: Options(
            headers: {
              'Authorization': 'Bearer $userToken',
              'Content-Type': 'application/json',
            },
          ),
        );

        // Check the response status code
        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Item removed successfully!'),
              backgroundColor: AppColors.primaryColor,
              duration: Duration(seconds: 2),
            ),
          );
          getUserCart();
        } else {
          // Handle error case
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to remove item. Please try again.'),
              backgroundColor: Colors.red,
              duration: Duration(seconds: 2),
            ),
          );
        }
      } catch (e) {
        print(e);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('An error occurred: ${e.toString()}'),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 2),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('You need to log in to remove items.'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      getUserCart();
      return Center(child: CircularProgressIndicator());
    }

    if (!isLoggedIn) {
      getUserCart();
      // If user is not logged in
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text('Cart', style: TextStyle(color: Colors.black)),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.shopping_cart_outlined,
                color: Colors.grey,
                size: 60,
              ),
              const SizedBox(height: 20),
              const Text(
                'No Cart Found',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Please log in to view your cart.',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginView()),
                  ).then((_) {
                    setState(() {
                      isLoading = true;
                      getUserCart();
                    });
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                icon: const Icon(
                  Icons.login,
                  color: Colors.white,
                ),
                label: const Text(
                  'Log In',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    // If user is logged in and cart items are empty
    if (userCartItems.isEmpty && userCartData.isEmpty) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text('Cart'),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.shopping_cart_outlined,
                color: Colors.grey,
                size: 60,
              ),
              const SizedBox(height: 20),
              const Text(
                'Your Cart is Empty',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Explore our products and start shopping!',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CategoryView()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'Explore to Shop',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    // If user is logged in and there are items in the cart
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
                  itemCount: userCartItems.length,
                  itemBuilder: (context, index) {
                    final product = userCartItems[index];
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
                                  product['image_url'] ??
                                      "https://cdn.dribbble.com/users/4231105/screenshots/14089750/404_dribbble.png",
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
                                  product['slug'] ?? 'unknown',
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  product['description'] ?? 'unknown',
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    Text(
                                      '£${product['total'] ?? '0.0'}',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      '(${product['quantity'] ?? '1'})',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
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
                                  removeItemFromCart(
                                      userCartData['id'].toString(),
                                      product['id'].toString());
                                },
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
            // Show total and checkout button
            Column(
              children: [
                Divider(color: AppColors.primaryColor),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Subtotal :', style: TextStyle(fontSize: 16)),
                    Text('£${userCartData['grand_total']}',
                        style: const TextStyle(fontSize: 16)),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Delivery Fee :',
                        style: TextStyle(fontSize: 16)),
                    Text('£${userCartData['shipping']}',
                        style: const TextStyle(fontSize: 16)),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Discount :', style: TextStyle(fontSize: 16)),
                    Text('%${userCartData['discount']}',
                        style: const TextStyle(fontSize: 16)),
                  ],
                ),
                const SizedBox(height: 16),
                AppButton(
                  title: 'Check Out For £${userCartData['grand_total']}',
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CheckoutView(
                                  cartId: userCartData['id'],
                                  total: userCartData['grand_total'],
                                  discount: userCartData['discount'],
                                  delivery: userCartData['shipping'],
                                )));
                  },
                ),
                const SizedBox(height: 16),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
