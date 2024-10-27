import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:yoo_local/app_constant/app_colors.dart';
import 'package:yoo_local/app_constant/app_constants.dart';
import 'package:yoo_local/screens/login/login_view.dart';
import 'package:yoo_local/ui_fuctionality/local_data.dart';
import 'package:yoo_local/widgets/product_card.dart';
import 'package:yoo_local/widgets/product_view.dart';

class FeaturedProduct extends StatefulWidget {
  const FeaturedProduct({super.key});

  @override
  State<FeaturedProduct> createState() => _FeaturedProductState();
}

class _FeaturedProductState extends State<FeaturedProduct> {
  @override
  void initState() {
    super.initState();
    getProducts();
  }

  final Dio _dio = Dio();
  List<Map<String, dynamic>> products = [];
  Future<void> getProducts() async {
    try {
      String url = "${AppConstants.baseUrl}/inventory";
      Response response = await _dio.get(url);

      // Print the entire response for debugging
      print("API Response: ${response.data}");

      if (response.statusCode == 200) {
        // Check if the response has the expected structure
        if (response.data['data'] != null &&
            response.data['data']['values'] != null) {
          setState(() {
            products = List<Map<String, dynamic>>.from(
                response.data['data']['values']);
            print(
                "Parsed Products: $products"); // Print parsed products for further debugging
          });
        } else {
          print("Error: 'data' or 'values' is null in the response");
        }
      } else {
        print(
            "Failed to load products: ${response.statusCode} ${response.statusMessage}");
      }
    } catch (e) {
      print("Error fetching products: $e");
    }
  }

  Future<void> addToCart(String productId) async {
    var userToken = await LocalData.getString(AppConstants.userToken);
    if (userToken != null) {
      try {
        String url = "${AppConstants.baseUrl}/cart/addToCart/$productId";
        Response response = await _dio.post(
          url,
          options: Options(headers: {
            'Authorization': 'Bearer $userToken'
          }), // Add token to headers
        );

        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Item added to cart successfully'),
              backgroundColor: AppColors.primaryColor,
            ),
          );
        } else {
          print(
              "Failed to add item to cart: ${response.statusCode} ${response.statusMessage}");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to add to cart, please try again'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } catch (e) {
        print("Error adding to cart: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Network error, please try again'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } else {
      // Navigate to login if user is not authenticated
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginView()));
    }
  }

  Future<void> addToCheck(String productId) async {
    print("Attempting to add product $productId to cart");
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        height: 250.0,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return Container(
              margin: const EdgeInsets.only(right: 8.0),
              child: ProductCard(
                name: product['title'],
                price: product['purchase_price'],
                image: product['feature_image']['path'],
                isFavorite: false,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductDetailScreen(
                        name: product['name'],
                        price: product['price'],
                        image: product['image'],
                        description: product['description'],
                        quatity: 1,
                        productId: product['product_id'],
                        inventory_id: product['inventory_id'],
                      ),
                    ),
                  );
                },
                onAddToCart: () {
                  print(
                      "Inventory ID in callback: ${product['inventory_id']}"); // Check this line
                  addToCart(product['inventory_id']);
                },
                onAddToFavorite: () {},
              ),
            );
          },
        ),
      ),
    );
  }
}
