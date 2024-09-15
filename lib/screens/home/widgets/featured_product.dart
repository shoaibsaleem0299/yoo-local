import 'package:flutter/material.dart';
import 'package:yoo_local/widgets/product_card.dart';
import 'package:yoo_local/widgets/product_view.dart';

class FeaturedProduct extends StatelessWidget {
  const FeaturedProduct({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> products = [
      {
        'name': 'Corona Extra Beer',
        'price': '£1.59',
        'image':
            'https://www.gomarket.com.ng/wp-content/uploads/2023/05/2021-08-26-61279756194c8.png',
        'isFavorite': true,
        'description':
            'Corona Extra is a light, crisp Mexican Lager with a pale straw color...',
      },
      {
        'name': 'Budweiser Beer',
        'price': '£2.00',
        'image':
            'https://www.gomarket.com.ng/wp-content/uploads/2023/05/2021-08-26-61279756194c8.png',
        'isFavorite': false,
        'description':
            'Budweiser is a medium-bodied American Lager with a slightly bitter taste...',
      },
      {
        'name': 'Budweiser Beer',
        'price': '£2.00',
        'image':
            'https://www.gomarket.com.ng/wp-content/uploads/2023/05/2021-08-26-61279756194c8.png',
        'isFavorite': false,
        'description':
            'Budweiser is a medium-bodied American Lager with a slightly bitter taste...',
      },
      {
        'name': 'Budweiser Beer',
        'price': '£2.00',
        'image':
            'https://www.gomarket.com.ng/wp-content/uploads/2023/05/2021-08-26-61279756194c8.png',
        'isFavorite': false,
        'description':
            'Budweiser is a medium-bodied American Lager with a slightly bitter taste...',
      },
    ];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        height: 250.0,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return Container(
              margin: const EdgeInsets.only(right: 8.0),
              child: ProductCard(
                name: product['name'],
                price: product['price'],
                image: product['image'],
                isFavorite: product['isFavorite'],
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductDetailScreen(
                        name: product['name'],
                        price: product['price'],
                        image: product['image'],
                        description: product['description'],
                        quatity: 1,
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
