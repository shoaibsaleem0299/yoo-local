import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:yoo_local/app_constant/app_colors.dart';
import 'package:yoo_local/screens/home/widgets/featured_product.dart';
import 'package:yoo_local/screens/home/widgets/section_header.dart';
import 'package:yoo_local/widgets/app_button.dart';

class ProductDetailScreen extends StatelessWidget {
  final String name;
  final String price;
  final String image;
  final String description;
  final int quatity;

  const ProductDetailScreen({
    super.key,
    required this.name,
    required this.price,
    required this.image,
    required this.description,
    required this.quatity,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        actions: [
          IconButton(icon: Icon(Icons.search), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Divider(color: AppColors.primaryColor),
            SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  image,
                  height: 120,
                  width: 120,
                  fit: BoxFit.cover,
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(price,
                          style: TextStyle(fontSize: 18, color: Colors.orange)),
                      SizedBox(height: 8),
                      Text(
                        description,
                        style: TextStyle(fontSize: 16),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            // Quantity and Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.remove_circle,
                        color: AppColors.primaryColor,
                        size: 26,
                      ),
                      onPressed: () {
                        // Decrease quantity functionality here
                      },
                    ),
                    Text(
                      quatity.toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.add_circle,
                        color: AppColors.primaryColor,
                        size: 26,
                      ),
                      onPressed: () {
                        // Increase quantity functionality here
                      },
                    ),
                  ],
                ),
                ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text(
                      "Add To Cart",
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    )),
                ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text(
                      "Add Wishlist",
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    )),
              ],
            ),
            SizedBox(height: 16),
            // Categories
            Text("Categories",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Wrap(
              spacing: 8.0,
              children: [
                Chip(label: Text("Beer")),
                Chip(label: Text("Spirits")),
                Chip(label: Text("Chocolates")),
                Chip(label: Text("Crisps")),
              ],
            ),
            SizedBox(height: 16),
            SectionHeader(
              heading: "Similar",
              imageURL:
                  "https://cdn4.iconfinder.com/data/icons/flat-color-sale-tag-set/512/Accounts_label_promotion_sale_tag_3-512.png",
            ),
            SizedBox(height: 16),
            FeaturedProduct(),
          ],
        ),
      ),
    );
  }
}
