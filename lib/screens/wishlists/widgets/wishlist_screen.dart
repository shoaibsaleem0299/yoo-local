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
    if (userToken != null && userToken!.isNotEmpty) {
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

  Future<void> addToCart(int productId, int inventoryId) async {
    var token = await LocalData.getString(AppConstants.userToken);
    try {
      String url = "${AppConstants.baseUrl}/cart/addToCart/$productId";
      Response response = await _dio.post(
        url,
        data: {'quantity': 1},
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
              'Item added to cart successfully',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            backgroundColor: AppColors.primaryColor,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            duration: const Duration(seconds: 3),
          ),
        );
        removeWishlist(inventoryId, productId);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
              'Network Error. Please Try Again',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            backgroundColor: AppColors.primaryColor,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            duration: const Duration(seconds: 3),
          ),
        );
      }
    } catch (error) {
      print('Failed to add to cart $error');
    }
  }

  Future<void> removeWishlist(int productId, int inventoryId) async {
    var token = await LocalData.getString(AppConstants.userToken);
    try {
      String url = "${AppConstants.baseUrl}/wishlist";
      Response response = await _dio.delete(
        url,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
        data: {
          'product_id': productId,
          'inventory_id': inventoryId,
        },
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
              'Item deleted from wishlist successfully',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            backgroundColor: AppColors.primaryColor,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            duration: const Duration(seconds: 3),
          ),
        );
        await getUserWishlist(); // Refresh wishlist after item is removed
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
              'Network Error. Please Try Again',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            backgroundColor: AppColors.primaryColor,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            duration: const Duration(seconds: 3),
          ),
        );
      }
    } catch (error) {
      print('Failed to remove from wishlist $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Wishlist'),
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
                                      IconButton(
                                          onPressed: () {
                                            removeWishlist(
                                                inventory['product_id'],
                                                inventory['id']);
                                          },
                                          icon: Icon(Icons.remove_circle)),
                                      Image.network(
                                        inventory['image_url'] ??
                                            'https://cdn.dribbble.com/users/4231105/screenshots/14089750/404_dribbble.png',
                                        width: 60,
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
                                                '£${inventory['has_offer'] ? double.parse(inventory['offer_price']).toStringAsFixed(2) : double.parse(inventory['sale_price'] ?? "0.0").toStringAsFixed(2)}',
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
                                                    addToCart(
                                                        inventory['id'],
                                                        inventory[
                                                            'product_id']);
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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.favorite_border,
                            color: Colors.grey,
                            size: 60,
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'Your Wishlist is Empty',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'Explore our products and add them to your wishlist!',
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
                                MaterialPageRoute(
                                    builder: (context) => CategoryView()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryColor,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 12),
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
                    )
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.favorite_border,
                        color: Colors.grey,
                        size: 60,
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'No Wishlist Found',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Please log in to view your wishlist.',
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
                            MaterialPageRoute(
                                builder: (context) => LoginView()),
                          ).then((_) {
                            setState(() {
                              isLoading = true;
                              getUserWishlist();
                            });
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 12),
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
}
