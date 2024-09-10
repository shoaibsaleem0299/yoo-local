import 'package:flutter/material.dart';
import 'package:yoo_local/app_constant/app_colors.dart';
import 'package:yoo_local/widgets/app_button.dart';

class WishlistScreen extends StatelessWidget {
  final List<Map<String, dynamic>> wishlistData = [
    {
      'name': 'Jack Daniel 330ML',
      'imageUrl':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRobRe99qQP9ROENUffatFxgDPFnigcXiKr4A&s',
      'price': 1.59,
      'isInStock': true,
    },
    {
      'name': 'Heineken 330ML',
      'imageUrl':
          'https://www.gomarket.com.ng/wp-content/uploads/2023/05/2021-08-26-61279756194c8.png',
      'price': 1.59,
      'isInStock': false,
    },
    {
      'name': 'Jack Daniel 330ML',
      'imageUrl':
          'https://www.gomarket.com.ng/wp-content/uploads/2023/05/2021-08-26-61279756194c8.png',
      'price': 1.59,
      'isInStock': true,
    },
    {
      'name': 'Jack Daniel 330ML',
      'imageUrl':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRobRe99qQP9ROENUffatFxgDPFnigcXiKr4A&s',
      'price': 1.59,
      'isInStock': true,
    },
    {
      'name': 'Heineken 330ML',
      'imageUrl':
          'https://www.gomarket.com.ng/wp-content/uploads/2023/05/2021-08-26-61279756194c8.png',
      'price': 1.59,
      'isInStock': false,
    },
    {
      'name': 'Jack Daniel 330ML',
      'imageUrl':
          'https://www.gomarket.com.ng/wp-content/uploads/2023/05/2021-08-26-61279756194c8.png',
      'price': 1.59,
      'isInStock': true,
    },
    {
      'name': 'Jack Daniel 330ML',
      'imageUrl':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRobRe99qQP9ROENUffatFxgDPFnigcXiKr4A&s',
      'price': 1.59,
      'isInStock': true,
    },
    {
      'name': 'Heineken 330ML',
      'imageUrl':
          'https://www.gomarket.com.ng/wp-content/uploads/2023/05/2021-08-26-61279756194c8.png',
      'price': 1.59,
      'isInStock': false,
    },
    {
      'name': 'Jack Daniel 330ML',
      'imageUrl':
          'https://www.gomarket.com.ng/wp-content/uploads/2023/05/2021-08-26-61279756194c8.png',
      'price': 1.59,
      'isInStock': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Padding(
            padding: const EdgeInsets.all(8.0),
            child: const Icon(
              Icons.search,
              color: Colors.black,
              size: 32,
            ),
          ),
          onPressed: () {
            // Add your search functionality here
          },
        ),
        title: const Text('Wish List'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Divider(color: AppColors.primaryColor),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Product',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('Unit Price',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('Stock Status',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                itemCount: wishlistData.length,
                separatorBuilder: (context, index) =>
                    Divider(color: AppColors.primaryColor),
                itemBuilder: (context, index) {
                  final product = wishlistData[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Row(
                      children: [
                        Icon(Icons.remove_circle,
                            color: AppColors.primaryColor),
                        const SizedBox(width: 4),
                        Image.network(product['imageUrl'],
                            width: 80, height: 120),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product['name'],
                              ),
                              Text('£${product['price'].toStringAsFixed(2)}',
                                  style: const TextStyle(color: Colors.green)),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              product['isInStock']
                                  ? 'Available\nIn Stock'
                                  : 'Out Of\nStock',
                              style: TextStyle(
                                color: product['isInStock']
                                    ? Colors.green
                                    : Colors.red,
                              ),
                              textAlign: TextAlign.right,
                            ),
                            ElevatedButton(
                              onPressed: product['isInStock']
                                  ? () {
                                      // Add to cart functionality here
                                    }
                                  : null,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primaryColor,
                                disabledBackgroundColor: Colors.orange.shade200,
                              ),
                              child: const Text(
                                'Add To Cart',
                                style: TextStyle(
                                    fontSize: 10, color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: AppButton(title: "View More Products", onTap: () {}),
            )
          ],
        ),
      ),
    );
  }
}
