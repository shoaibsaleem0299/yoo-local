import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:yoo_local/app_constant/app_colors.dart';
import 'package:yoo_local/app_constant/app_constants.dart';
import 'package:yoo_local/screens/home/widgets/categories_section.dart';
import 'package:yoo_local/screens/home/widgets/featured_product.dart';
import 'package:yoo_local/screens/home/widgets/home_footer.dart';
import 'package:yoo_local/screens/home/widgets/image_slider.dart';
import 'package:yoo_local/screens/home/widgets/order_section.dart';
import 'package:yoo_local/screens/home/widgets/search_products.dart';
import 'package:yoo_local/screens/home/widgets/section_header.dart';
import 'package:yoo_local/screens/home/widgets/similer_deals.dart';
import 'package:yoo_local/widgets/location_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();

  void _toggleSearch() {
    setState(() {
      _isSearching = !_isSearching;
      _searchController.clear();
    });
  }

  Future<void> _performSearch() async {
    String searchText = _searchController.text.trim();

    if (searchText.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please Enter Search Value'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }
    try {
      final response = await searchProduct(searchText);
      if (response != null) {
        print(response);
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SearchProductsView(products: response)),
        );
      }
    } catch (error) {
      print('Search error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.secondaryColor,
        leading: IconButton(
          icon: Icon(
            _isSearching ? Icons.arrow_back : Icons.search,
            color: Colors.white,
            size: 26,
          ),
          onPressed: _toggleSearch,
        ),
        title: _isSearching
            ? TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  hintText: 'Search...',
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.white70),
                ),
                style: const TextStyle(color: Colors.white),
                onSubmitted: (_) =>
                    _performSearch(), // Trigger search on enter key
              )
            : LocationWidget(),
        actions: _isSearching
            ? [
                IconButton(
                  icon: Icon(Icons.search, color: Colors.white),
                  onPressed:
                      _performSearch, // Button to trigger search function
                ),
              ]
            : [],
      ),
      body: const SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ImageSlider(),
              SizedBox(height: 16),
              SectionHeader(
                heading: "Categories",
                imageURL:
                    "https://cdn-icons-png.freepik.com/256/9710/9710991.png?semt=ais_hybrid",
              ),
              SizedBox(height: 18),
              CategoriesSection(),
              SectionHeader(
                heading: "Deals",
                imageURL:
                    "https://cdn4.iconfinder.com/data/icons/flat-color-sale-tag-set/512/Accounts_label_promotion_sale_tag_3-512.png",
              ),
              SizedBox(height: 22),
              OrderSection(),
              SizedBox(height: 32),
              SectionHeader(
                heading: "Featured Products",
                imageURL:
                    "https://cdn-icons-png.freepik.com/256/8510/8510223.png?semt=ais_hybrid",
              ),
              FeaturedProduct(),
              SizedBox(height: 12),
              SectionHeader(
                heading: "Top Selling Products",
                imageURL:
                    "https://cdn-icons-png.freepik.com/512/8465/8465733.png",
              ),
              SimilerDeals(), // SizedBox(height: 12),
              // SectionHeader(
              //   heading: "Best Selling Products",
              //   imageURL:
              //       "https://cdn-icons-png.freepik.com/512/8465/8465733.png",
              // ),
              // FeaturedProduct(),
              SizedBox(height: 6),
              SingleImageWidget()
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> searchProduct(String query) async {
    final Dio _dio = Dio();

    try {
      String url = '${AppConstants.baseUrl}/inventory';
      Response response = await _dio.get(url, data: {"search": query});
      if (response.statusCode == 200) {
        print(response.data['data']['values']);
        return response.data['data']['values'];
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Product Not Found'),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Product Not Found'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}
