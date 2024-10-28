import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:yoo_local/app_constant/app_colors.dart';
import 'package:yoo_local/app_constant/app_constants.dart';
import 'package:yoo_local/screens/category/category_view.dart';
import 'package:yoo_local/screens/login/login_view.dart';
import 'package:yoo_local/ui_fuctionality/local_data.dart';
import 'package:yoo_local/widgets/app_button.dart';

class WishlistScreen extends StatefulWidget {
  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  final Dio _dio = Dio();
  List<Map<String, dynamic>> wishlist = [];
  bool isLoading = true;
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    getUserWishlist();
  }

  Future<void> getUserWishlist() async {
    var userToken = await LocalData.getString(AppConstants.userToken);
    if (userToken != null) {
      setState(() {
        isLoggedIn = true;
      });

      try {
        String url = "${AppConstants.baseUrl}/wishlist";
        Response response = await _dio.get(
          url,
          options: Options(headers: {
            'Authorization': 'Bearer $userToken',
          }),
        );

        if (response.statusCode == 200 && response.data['data'] != null) {
          setState(() {
            wishlist = List<Map<String, dynamic>>.from(
                response.data['data']['values']);
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to load wishlist data. Please try again.'),
              backgroundColor: AppColors.primaryColor,
              duration: Duration(seconds: 3),
            ),
          );
        }
      } catch (e) {
        print("Error fetching wishlist: $e");
      }
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Wish List'),
        centerTitle: true,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : isLoggedIn
              ? wishlist.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          Divider(color: AppColors.primaryColor),
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 16, horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Product',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                Text('Unit Price',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                Text('Stock Status',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                          Expanded(
                            child: ListView.separated(
                              itemCount: wishlist.length,
                              separatorBuilder: (context, index) =>
                                  Divider(color: AppColors.primaryColor),
                              itemBuilder: (context, index) {
                                final product = wishlist[index];
                                final inventory = product['inventory'];
                                final inStock = inventory['stock_quantity'] > 0;

                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 12),
                                  child: Row(
                                    children: [
                                      Icon(Icons.remove_circle,
                                          color: AppColors.primaryColor),
                                      const SizedBox(width: 4),
                                      Image.network(
                                        inventory['image_url'] ?? 'unknown',
                                        width: 80,
                                        height: 120,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return const Icon(
                                            Icons.broken_image,
                                            size: 40,
                                            color: Colors.grey,
                                          );
                                        },
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              inventory['title'] ?? "item",
                                            ),
                                            Text(
                                                '£${inventory['sale_price'] ?? "0.0"}',
                                                style: const TextStyle(
                                                    color: Colors.green)),
                                          ],
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            inStock
                                                ? 'Available\nIn Stock'
                                                : 'Out Of\nStock',
                                            style: TextStyle(
                                              color: inStock
                                                  ? Colors.green
                                                  : Colors.red,
                                            ),
                                            textAlign: TextAlign.right,
                                          ),
                                          ElevatedButton(
                                            onPressed: inStock
                                                ? () {
                                                    // Add to cart functionality here
                                                  }
                                                : null,
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  AppColors.primaryColor,
                                              disabledBackgroundColor:
                                                  Colors.orange.shade200,
                                            ),
                                            child: const Text(
                                              'Add To Cart',
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: AppButton(
                                title: "View More Products",
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CategoryView()),
                                  );
                                }),
                          )
                        ],
                      ),
                    )
                  : Center(
                      child: Text(
                        'Wishlist is empty',
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                    )
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Please log in to view your wishlist',
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginView())).then((_) {
                            setState(() {
                              isLoading = true;
                              getUserWishlist();
                            });
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                        ),
                        child: const Text(
                          'Log In',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }
}
