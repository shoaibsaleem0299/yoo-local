import 'package:flutter/material.dart';
import 'package:yoo_local/widgets/app_button.dart';

class OrderCard extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;
  final Color? color; // Add color parameter

  const OrderCard({
    Key? key,
    required this.title,
    required this.description,
    required this.imageUrl,
    this.color, // Include color in constructor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color, // Use the passed color
      elevation: 4, // Optional elevation for a shadow effect
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        height: 165,
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 12),
                  AppButton(title: "View Deal", onTap: () {})
                ],
              ),
            ),
            const SizedBox(width: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                imageUrl,
                height: 80,
                width: 80,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.error),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
