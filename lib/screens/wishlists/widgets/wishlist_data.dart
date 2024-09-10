import 'package:dio/dio.dart';
import 'package:yoo_local/models/product_model.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<List<Product>> fetchWishlist() async {
    final response = await _dio.get('https://your-api-url.com/wishlist');

    if (response.statusCode == 200) {
      List<Product> wishlist = (response.data as List).map((item) {
        return Product(
          name: item['name'],
          imageUrl: item['imageUrl'],
          price: item['price'],
          isInStock: item['isInStock'],
        );
      }).toList();
      return wishlist;
    } else {
      throw Exception('Failed to load wishlist');
    }
  }
}
