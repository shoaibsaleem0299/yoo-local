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
                      name: category['name'] ?? "item",
                      imageUrl: category['image_url'] ?? "unknown",
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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 8,
      shadowColor: Colors.black.withOpacity(0.15),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFf5f7fa), Color(0xFFc3cfe2)], // Subtle gradient
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryColor.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 6,
              offset: Offset(0, 2), // Positioned the shadow
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
          child: Column(
            mainAxisSize:
                MainAxisSize.min, // Set to min to fit content flexibly
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 2,
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(
                          Icons.broken_image,
                          color: Colors.grey[400],
                          size: 40,
                        );
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                name.length > 10 ? '${name.substring(0, 7)}...' : name,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: Color(0xFF333333), // Darker text for better contrast
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
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
    if (token!.isNotEmpty) {
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
    if (token!.isNotEmpty) {
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
    if (products.isNotEmpty) {
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
                    price: product['has_offer']
                        ? double.parse(product['offer_price'])
                            .toStringAsFixed(2)
                        : double.parse(product['sale_price'] ?? "0.0")
                            .toStringAsFixed(2),
                    image: product['image_url'] ??
                        'https://cdn.dribbble.com/users/4231105/screenshots/14089750/404_dribbble.png',
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
                            image: (product['images_urls']?.isEmpty ?? true)
                                ? [
                                    "https://cdn.dribbble.com/users/4231105/screenshots/14089750/404_dribbble.png",
                                    "https://cdn.dribbble.com/users/4231105/screenshots/14089750/404_dribbble.png",
                                    "https://cdn.dribbble.com/users/4231105/screenshots/14089750/404_dribbble.png"
                                  ]
                                : product['images_urls'],
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
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text("Category Items"),
          centerTitle: true,
        ),
        body: Center(
          child: Text("No Item Found"),
        ),
      );
    }
  }
}
