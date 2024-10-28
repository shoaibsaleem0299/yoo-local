import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:yoo_local/app_constant/app_colors.dart';
import 'package:yoo_local/app_constant/app_constants.dart';
import 'package:yoo_local/screens/category/category_view.dart' as category_view;
import 'package:yoo_local/screens/home/widgets/custon_category_card.dart'
    as custom_category_card;

class CategoriesSection extends StatefulWidget {
  const CategoriesSection({super.key});

  @override
  State<CategoriesSection> createState() => _CategoriesSectionState();
}

class _CategoriesSectionState extends State<CategoriesSection> {
  @override
  void initState() {
    super.initState();
    getCategories();
  }

  final Dio _dio = Dio();
  List<Map<String, dynamic>> allCategories = [];

  Future getCategories() async {
    try {
      String url = "${AppConstants.baseUrl}/category";
      Response response = await _dio.get(url);

      if (response.statusCode == 200 && response.data['data'] != null) {
        setState(() {
          allCategories =
              List<Map<String, dynamic>>.from(response.data['data']['values']);
        });
      } else {
        print(
            "Failed to load categories: Unexpected response format or status code");
      }
    } catch (e) {
      print("Error fetching categories: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 0, right: 0, top: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: allCategories.take(3).map((category) {
              return custom_category_card.CategoryCard(
                title: category['name'] ?? "item",
                imageUrl:
                    category['image_url'] ?? 'assets/images/default_image.png',
                productId: category['id'].toString(),
              );
            }).toList(),
          ),
          const SizedBox(height: 10),
          const Center(
            child: Divider(
              color: Colors.grey,
              thickness: 2,
              indent: 160,
              endIndent: 160,
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => category_view.CategoryView(),
                  ));
            },
            child: Text(
              "View All",
              style: TextStyle(
                color: AppColors.primaryColor,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
