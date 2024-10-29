import 'package:flutter/material.dart';
import 'package:yoo_local/app_constant/app_colors.dart';
import 'package:yoo_local/screens/category/category_view.dart';

class CategoryCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String productId;

  const CategoryCard({
    Key? key,
    required this.title,
    required this.imageUrl,
    required this.productId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ResultScreen(productId: productId, name: title),
          ),
        );
      },
      child: Column(
        children: [
          Container(
            width: 80,
            height: 70,
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.primaryColor,
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
            ),
            child: Center(
              child: Image.network(
                imageUrl,
                width: 40,
                height: 40,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
                    Icons.broken_image,
                    size: 40,
                    color: Colors.grey,
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title.length > 10 ? '${title.substring(0, 7)}...' : title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
