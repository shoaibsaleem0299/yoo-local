import 'package:flutter/material.dart';
import 'package:yoo_local/app_constant/app_colors.dart';
import 'package:yoo_local/screens/home/widgets/categories_section.dart';
import 'package:yoo_local/screens/home/widgets/featured_product.dart';
import 'package:yoo_local/screens/home/widgets/home_footer.dart';
import 'package:yoo_local/screens/home/widgets/image_slider.dart';
import 'package:yoo_local/screens/home/widgets/order_section.dart';
import 'package:yoo_local/screens/home/widgets/section_header.dart';
import 'package:yoo_local/widgets/location_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.secondaryColor,
        leading: IconButton(
          icon: const Icon(
            Icons.search,
            color: Colors.white,
            size: 26,
          ),
          onPressed: () {
            // Add your search functionality here
          },
        ),
        title: LocationWidget(),
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
                trailing: "View All",
              ),
              FeaturedProduct(),
              SizedBox(height: 12),
              SectionHeader(
                heading: "Top Selling Products",
                imageURL:
                    "https://cdn-icons-png.flaticon.com/512/771/771222.png",
                trailing: "View All",
              ),
              FeaturedProduct(),
              SizedBox(height: 12),
              SectionHeader(
                heading: "Best Selling Products",
                imageURL:
                    "https://cdn-icons-png.freepik.com/512/8465/8465733.png",
                trailing: "View All",
              ),
              FeaturedProduct(),
              SizedBox(height: 6),
              SingleImageWidget()
            ],
          ),
        ),
      ),
    );
  }
}
