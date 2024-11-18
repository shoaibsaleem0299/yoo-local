import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:yoo_local/app_constant/app_colors.dart';
import 'package:yoo_local/app_constant/app_constants.dart';
import 'package:yoo_local/screens/login/login_view.dart';
import 'package:yoo_local/ui_fuctionality/local_data.dart';
import 'package:yoo_local/widgets/product_card.dart';
import 'package:yoo_local/widgets/product_view.dart';

class SimilerDeals extends StatefulWidget {
  const SimilerDeals({super.key});

  @override
  State<SimilerDeals> createState() => _SimilerDealsState();
}

class _SimilerDealsState extends State<SimilerDeals> {
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

      if (response.statusCode == 200) {
        if (response.data['data'] != null &&
            response.data['data']['values'] != null) {
          setState(() {
            products = List<Map<String, dynamic>>.from(
                response.data['data']['values']);
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

  Future<void> addToCart(int productId) async {
    var userToken = await LocalData.getString(AppConstants.userToken);
    if (userToken!.isNotEmpty) {
      try {
        String url = "${AppConstants.baseUrl}/cart/addToCart/$productId";
        Response response = await _dio.post(
          url,
          data: {
            'quantity': 1,
          },
          options: Options(headers: {
            'Authorization': 'Bearer $userToken'
          }), // Add token to headers
        );

        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Item added to cart successfully'),
              backgroundColor: AppColors.primaryColor,
              duration: Duration(seconds: 2),
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        height: 250.0,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount:
              products.length > 6 ? 6 : products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return Container(
              margin: const EdgeInsets.only(right: 8.0),
              child: ProductCard(
                name: product['title'] ?? "item",
                price: product['has_offer']
                    ? "£${double.parse(product['offer_price']).toStringAsFixed(2)}"
                    : "£${double.parse(product['sale_price'] ?? "0.0").toStringAsFixed(2)}",
                image: product['image_url'] ??
                    'https://cdn.dribbble.com/users/4231105/screenshots/14089750/404_dribbble.png',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductDetailScreen(
                        name: product['title'] ?? "item",
                        price: product['has_offer']
                    ? "£${double.parse(product['offer_price']).toStringAsFixed(2)}"
                    : "£${double.parse(product['sale_price'] ?? "0.0").toStringAsFixed(2)}",
                        image: (product['images_urls']?.isEmpty ?? true)
                            ? [
                                "https://cdn.dribbble.com/users/4231105/screenshots/14089750/404_dribbble.png",
                                "https://cdn.dribbble.com/users/4231105/screenshots/14089750/404_dribbble.png",
                                "https://cdn.dribbble.com/users/4231105/screenshots/14089750/404_dribbble.png"
                              ]
                            : product['images_urls'],
                        description: product['description'] ?? "No Description",
                        quatity: 1,
                        productId: product['product_id'],
                        inventory_id: product['id'] ?? 1,
                      ),
                    ),
                  );
                },
                onAddToCart: () {
                  addToCart(product['id']);
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
