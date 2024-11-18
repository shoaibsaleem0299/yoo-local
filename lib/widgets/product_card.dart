import 'package:flutter/material.dart';
import 'package:yoo_local/app_constant/app_colors.dart';

class ProductCard extends StatelessWidget {
  final String name;
  final String price;
  final String image;
  final VoidCallback onTap;
  final VoidCallback onAddToCart;
  final VoidCallback onAddToFavorite;

  const ProductCard({
    super.key,
    required this.name,
    required this.price,
    required this.image,
    required this.onTap,
    required this.onAddToCart,
    required this.onAddToFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: 160,
        child: InkWell(
          onTap: onTap,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 160,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.white, // Adds a clean background for the image
                  border: Border.all(
                    color: AppColors.primaryColor,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primaryColor.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 8,
                      offset: Offset(0, 4), // Positioned the shadow
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.circular(10), // Matches the container radius
                  child: Padding(
                    padding: const EdgeInsets.all(
                        8.0), // Adds padding around the image
                    child: Image.network(
                      image,
                      width:
                          140, // Slightly less than container width for padding effect
                      height: 130, // Adjusts height to avoid overflow
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
              ),

              const SizedBox(height: 8),
              // Wrap the Row in an Expanded widget
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              price,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.add_circle,
                          color: AppColors.primaryColor,
                          size: 30,
                        ),
                        onPressed: () {
                          onAddToCart();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
