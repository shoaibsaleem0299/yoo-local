import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:yoo_local/app_constant/app_constants.dart';
import 'package:yoo_local/models/data.dart';
import 'package:yoo_local/widgets/product_card.dart';
import 'package:yoo_local/widgets/product_view.dart';

class CategoryView extends StatefulWidget {
  const CategoryView({super.key});

  @override
  _CategoryViewState createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  List<Map<String, dynamic>> categories = SampleData.categories;

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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          itemCount: categories.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemBuilder: (context, index) {
            final category = categories[index];

            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ResultScreen(
                      productId: category['data'],
                      name: category['name'],
                    ),
                  ),
                );
              },
              child: CategoryCard(
                name: category['name']!,
                imageUrl: category['image']!,
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

// class ResultScreen extends StatefulWidget {
//   final String productId;
//   final String name;

//   const ResultScreen({
//     required this.name,
//     required this.productId,
//   });

//   @override
//   State<ResultScreen> createState() => _ResultScreenState();
// }

// class _ResultScreenState extends State<ResultScreen> {
//   List<Map<String, dynamic>> products = [];
//   final Dio _dio = Dio();

//   Future<void> getCategoryProducts(String productId) async {
//     try {
//       String url = "${AppConstants.baseUrl}/category/${productId}";
//       Response response = await _dio.get(url);

//       if (response.statusCode == 200 && response.data['data'] != null) {
//         setState(() {
//           products = List<Map<String, dynamic>>.from(
//               response.data['data']['values']['products']['inventories']);
//         });
//       } else {
//         print(
//             "Failed to load categories: Unexpected response format or status code");
//       }
//     } catch (e) {
//       print("Error fetching categories: $e");
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     getCategoryProducts(widget.productId);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text(widget.name),
//       ),
//       body: GridView.builder(
//         padding: const EdgeInsets.all(10),
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//           crossAxisSpacing: 10,
//           mainAxisSpacing: 10,
//           childAspectRatio: 0.75,
//         ),
//         itemCount: products.length,
//         itemBuilder: (context, index) {
//           final product = products[index];
//           return ProductCard(
//             name: product['title'],
//             price: product['purchase_price'],
//             image: product['image'],
//             isFavorite: product['isFavorite'],
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => ProductDetailScreen(
//                     name: product['name'],
//                     price: product['price'],
//                     image: product['image'],
//                     description: product['description'],
//                     quatity: 1,
//                   ),
//                 ),
//               );
//             },
//             onAddToCart: () {},
//             onAddToFavorite: () {},
//           );
//         },
//       ),
//     );
//   }
// }
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

      // Log the entire response to understand its structure
      print("API Response: ${response.data}");

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.name),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator()) // Show loading indicator
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
                  image: product['image'] ??
                      'assets/images/default_image.png', // Default image
                  isFavorite: product['isFavorite'] ?? false, // Default value
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailScreen(
                          inventory_id : product['id'],
                          productId : product['product_id'],
                          name: product['title'] ?? 'Unknown', // Default value
                          price: product['purchase_price']?.toString() ??
                              '0', // Handle null
                          image: product['image'] ??
                              'assets/images/default_image.png', // Default image
                          description: product['description'] ??
                              'No description available.', // Default value
                          quatity: 1,
                        ),
                      ),
                    );
                  },
                  onAddToCart: () {},
                  onAddToFavorite: () {},
                );
              },
            ),
    );
  }
}
