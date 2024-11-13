import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:yoo_local/app_constant/app_colors.dart';
import 'package:yoo_local/app_constant/app_constants.dart';
import 'package:yoo_local/screens/login/login_view.dart';
import 'package:yoo_local/ui_fuctionality/local_data.dart';
import 'package:yoo_local/widgets/product_card.dart';
import 'package:yoo_local/widgets/product_view.dart';

class SearchProductsView extends StatelessWidget {
  final List products;
  const SearchProductsView({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    int quantity = 1;

    void _showLoginDialog(BuildContext context) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Please Login'),
            content: const Text('You need to be logged in to continue.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginView()));
                },
                child: const Text('Login'),
              ),
            ],
          );
        },
      );
    }

    Future<void> addToCart(BuildContext context, int inventoryId) async {
      var token = await LocalData.getString(AppConstants.userToken);
      if (token!.isNotEmpty) {
        try {
          final Dio _dio = Dio();
          String url = "${AppConstants.baseUrl}/cart/addToCart/${inventoryId}";
          Response response = await _dio.post(
            url,
            data: {'quantity': quantity},
            options: Options(headers: {'Authorization': 'Bearer $token'}),
          );

          if (response.statusCode == 200) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text(
                  'Item added to cart successfully',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
                backgroundColor: AppColors.primaryColor,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                duration: const Duration(seconds: 3),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text(
                  'Network Error. Please Try Again',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
                backgroundColor: AppColors.primaryColor,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                duration: const Duration(seconds: 3),
              ),
            );
          }
        } catch (error) {
          print('Failed to add to cart ${error}');
        }
      } else {
        _showLoginDialog(context);
      }
    }

    // Add to Wishlist Function
    Future<void> addToWishlist(
        BuildContext context, int inventoryId, int productId) async {
      var token = await LocalData.getString(AppConstants.userToken);
      if (token!.isNotEmpty) {
        try {
          final Dio _dio = Dio();
          String url = "${AppConstants.baseUrl}/wishlist/add";
          Response response = await _dio.post(url,
              options: Options(headers: {'Authorization': 'Bearer $token'}),
              data: {
                'inventory_id': inventoryId,
                'product_id': productId,
              });

          if (response.statusCode == 200) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text(
                  'Item added to wishlist successfully',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
                backgroundColor: AppColors.primaryColor,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                duration: const Duration(seconds: 3),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text(
                  'Network Error. Please Try Again',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
                backgroundColor: AppColors.primaryColor,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                duration: const Duration(seconds: 3),
              ),
            );
          }
        } catch (error) {
          print('Failed to add to cart ${error}');
        }
      } else {
        _showLoginDialog(context);
      }
    }

    if (products.length != 0) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: Text("Search Items"),
        ),
        body: GridView.builder(
          padding: const EdgeInsets.all(10),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.75,
          ),
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return ProductCard(
              name: product['title'] ?? 'Unknown',
              price: product['has_offer']
                  ? double.parse(product['offer_price']).toStringAsFixed(2)
                  : double.parse(product['sale_price'] ?? "0.0")
                      .toStringAsFixed(2),
              image: product['image_url'] ?? 'assets/images/default_image.png',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductDetailScreen(
                      inventory_id: product['id'],
                      productId: product['product_id'],
                      name: product['title'] ?? 'Unknown',
                      price: product['has_offer']
                          ? double.parse(product['offer_price'])
                              .toStringAsFixed(2)
                          : double.parse(product['sale_price'] ?? "0.0")
                              .toStringAsFixed(2),
                      image: product['images_urls'] ?? [],
                      description:
                          product['description'] ?? 'No description available.',
                      quatity: 1,
                    ),
                  ),
                );
              },
              onAddToCart: () {
                addToCart(context, product['id']);
              },
              onAddToFavorite: () {
                addToWishlist(context, product['id'], product['product_id']);
              },
            );
          },
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text("Search Items"),
          centerTitle: true,
        ),
        body: Center(
          child: Text("No Item Found"),
        ),
      );
    }
  }
}
