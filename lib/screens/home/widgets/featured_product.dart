import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:yoo_local/app_constant/app_colors.dart';
import 'package:yoo_local/app_constant/app_constants.dart';
import 'package:yoo_local/screens/login/login_view.dart';
import 'package:yoo_local/ui_fuctionality/local_data.dart';
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
    final Dio _dio = Dio();

    Future<void> addToCart(String productId) async {
      var userToken = await LocalData.getString(AppConstants.userToken);
      if (userToken != null) {
        try {
          String url = "${AppConstants.baseUrl}/cart/addToCart";
          Response response = await _dio.post(
            url,
            data: {
              'product_id': productId,
              'quantity': 1,
            },
          );
          if (response.statusCode == 200) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Center(
                  child: Text(
                    'Item added to cart',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                backgroundColor: AppColors.primaryColor,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                duration: Duration(seconds: 3),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Center(
                  child: Text(
                    'Try Again: Network Error',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                backgroundColor: AppColors.primaryColor,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                duration: Duration(seconds: 3),
              ),
            );
          }
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Try Again: Network Error',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              backgroundColor: AppColors.primaryColor,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              duration: Duration(seconds: 3),
            ),
          );
        }
      } else {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginView()));
      }
    }

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
                onAddToCart: () {
                  addToCart(product['id']);
                },
                onAddToFavorite: () {},
              ),
            );
          },
        ),
      ),
    );
  }
}
