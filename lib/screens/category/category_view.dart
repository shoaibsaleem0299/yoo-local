import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:yoo_local/app_constant/app_colors.dart';
import 'package:yoo_local/app_constant/app_constants.dart';
import 'package:yoo_local/screens/login/login_view.dart';
import 'package:yoo_local/ui_fuctionality/local_data.dart';
import 'package:yoo_local/widgets/product_card.dart';
import 'package:yoo_local/widgets/product_view.dart';

class CategoryView extends StatefulWidget {
  const CategoryView({super.key});

  @override
  _CategoryViewState createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  final Dio _dio = Dio();
  List<Map<String, dynamic>> allCategories = [];
  bool isLoading = true; // Loading state

  @override
  void initState() {
    super.initState();
    getCategories();
  }

  Future<void> getCategories() async {
    try {
      String url = "${AppConstants.baseUrl}/category";
      Response response = await _dio.get(url);

      if (response.statusCode == 200 && response.data['data'] != null) {
        setState(() {
          allCategories =
              List<Map<String, dynamic>>.from(response.data['data']['values']);
          isLoading = false; // Stop loading once data is fetched
        });
      } else {
        print(
            "Failed to load categories: Unexpected response format or status code");
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print("Error fetching categories: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Categories'),
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator()) // Show loading indicator
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                itemCount: allCategories.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemBuilder: (context, index) {
                  final category = allCategories[index];

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ResultScreen(
                            productId: category['id'].toString(),
                            name: category['name'],
                          ),
                        ),
                      );
                    },
                    child: CategoryCard(
                      name: category['name']!,
                      imageUrl: category['image'] ?? "unknown",
                      color: const Color.fromARGB(255, 241, 212, 170),
                    ),
                  );
                },
              ),
            ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String name;
  final String imageUrl;
  final Color color;

  const CategoryCard({
    required this.name,
    required this.imageUrl,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: color,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 42),
                child: Image.network(
                  imageUrl,
                  width: 70,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.broken_image,
                        color: Colors.grey, size: 50);
                  },
                ),
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

class ResultScreen extends StatefulWidget {
  final String productId;
  final String name;

  const ResultScreen({
    required this.name,
    required this.productId,
  });

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  List<Map<String, dynamic>> products = [];
  final Dio _dio = Dio();
  bool isLoading = true; // Track loading state

  Future<void> getCategoryProducts(String productId) async {
    try {
      String url = "${AppConstants.baseUrl}/category/$productId";
      Response response = await _dio.get(url);

      if (response.statusCode == 200 && response.data['data'] != null) {
        var productsData = response.data['data']['values']['products'];

        if (productsData is List && productsData.isNotEmpty) {
          var inventories = productsData[0]['inventories'];
          if (inventories is List) {
            setState(() {
              products = List<Map<String, dynamic>>.from(inventories);
              isLoading = false;
            });
          } else if (inventories is String) {
            print(
                "Error: Expected inventories to be a List but got a String: $inventories");
          } else {
            print(
                "Error: Expected inventories to be a List but got ${inventories.runtimeType}");
          }
        } else {
          print("Error: No products found or products is not a List.");
          setState(() {
            isLoading = false;
          });
        }
      } else {
        print(
            "Failed to load categories: Unexpected response format or status code");
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print("Error fetching categories: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getCategoryProducts(widget.productId);
  }

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
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog first
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

  Future<void> addToCart(BuildContext context, String productId) async {
    var token = await LocalData.getString(AppConstants.userToken);
    if (token != null) {
      try {
        final Dio _dio = Dio();
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
        print('Failed to add to cart ${error}');
      }
    } else {
      _showLoginDialog(context);
    }
  }

  // Add to Wishlist Function
  Future<void> addToWishlist(
      BuildContext context, String productId, String inventory_id) async {
    var token = await LocalData.getString(AppConstants.userToken);
    if (token != null) {
      try {
        final Dio _dio = Dio();
        String url = "${AppConstants.baseUrl}/wishlist/add";
        Response response = await _dio.post(url,
            options: Options(headers: {'Authorization': 'Bearer $token'}),
            data: {
              'product_id': productId,
              'inventory_id': inventory_id,
            });

        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text(
                'Item added to wishlist successfully',
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
        print('Failed to add to cart ${error}');
      }
    } else {
      _showLoginDialog(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.name),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : GridView.builder(
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
                  name: product['title'] ?? 'Unknown', // Default value
                  price: product['purchase_price']?.toString() ??
                      '0', // Handle null
                  image: product['image_url'] ??
                      'assets/images/default_image.png', // Default image
                  isFavorite: product['isFavorite'] ?? false, // Default value
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailScreen(
                          inventory_id: product['id'],
                          productId: product['product_id'],
                          name: product['title'] ?? 'Unknown',
                          price: product['purchase_price']?.toString() ??
                              '0', // Handle null
                          image: product['image_url'] ??
                              'assets/images/default_image.png',
                          description: product['description'] ??
                              'No description available.',
                          quatity: 1,
                        ),
                      ),
                    );
                  },
                  onAddToCart: () {
                    addToCart(context, product['id'].toString());
                  },
                  onAddToFavorite: () {
                    addToWishlist(context, product['product_id'].toString(),
                        product['id'].toString());
                  },
                );
              },
            ),
    );
  }
}
