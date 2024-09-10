import 'package:flutter/material.dart';
import 'package:yoo_local/screens/home/widgets/custom_order_card.dart';

class OrderSection extends StatelessWidget {
  const OrderSection({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> apiData = [
      {
        'title': 'Organic Vegetables',
        'description': 'Get 20% Off On All Vegetables',
        'imageUrl':
            'https://wallpapers.com/images/hd/grocery-shopping-bag-fullof-fresh-food-iebmo2f309090ukz.jpg',
        'color': Colors.green[100], // Background color for this card
      },
      {
        'title': 'Fresh Fruits',
        'description': 'Get 10% Off On All Fruits',
        'imageUrl':
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSbFJy9KW4xgU1W11uJF4knxx0bkyh5nN9COw&s',
        'color': Colors.orange[100], // Background color for this card
      },
      {
        'title': 'Dairy Products',
        'description': 'Get 15% Off On All Dairy',
        'imageUrl': 'https://cdn-icons-png.flaticon.com/512/1509/1509470.png',
        'color': Colors.blue[100], // Background color for this card
      },
    ];

    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: apiData.map((item) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: SizedBox(
                width:
                    MediaQuery.of(context).size.width * 0.8, // Adjust the width
                child: OrderCard(
                  title: item['title']!,
                  description: item['description']!,
                  imageUrl: item['imageUrl']!,
                  color: item['color'], // Pass the color to the OrderCard
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
