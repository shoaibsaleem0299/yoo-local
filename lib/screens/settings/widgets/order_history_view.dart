// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:yoo_local/app_constant/app_colors.dart';
// import 'package:yoo_local/app_constant/app_constants.dart';
// import 'package:yoo_local/screens/settings/widgets/order_detail_view.dart';
// import 'package:yoo_local/ui_fuctionality/local_data.dart';

// // ignore: must_be_immutable
// class OrderHistoryView extends StatefulWidget {
//   @override
//   State<OrderHistoryView> createState() => _OrderHistoryViewState();
// }

// final List<Map<String, dynamic>> orders = [
//   {
//     'orderId': 'XT5677A',
//     'date': 'Today',
//     'items': [
//       {'name': 'Air Force One', 'price': '\$110', 'quantity': 1},
//       {'name': 'Air Max 1', 'price': '\$130', 'quantity': 1},
//     ],
//   },
//   {
//     'orderId': 'XT9883X',
//     'date': 'Yesterday',
//     'items': [
//       {'name': 'Under Armour Curry', 'price': '\$160', 'quantity': 1},
//       {'name': 'Puma Clyde', 'price': '\$90', 'quantity': 2},
//     ],
//   },
// ];

// bool isLoading = true;

// bool isLoggedIn = false;

// final Dio _dio = Dio();

// Future<void> getUserOrders() async {
//   var userToken = await LocalData.getString(AppConstants.userToken);
//   if (userToken!.isNotEmpty) {
//     isLoggedIn = true; // User is logged in
//     try {
//       String url = "${AppConstants.baseUrl}/cart/cart_by_user";
//       Response response = await _dio.get(
//         url,
//         options: Options(
//           headers: {
//             'Authorization': 'Bearer $userToken',
//           },
//         ),
//       );
//       if (response.statusCode == 200) {
//         setState(() {});
//       } else {
//         // Handle error if needed
//       }
//     } catch (e) {
//       print(e);
//     } finally {
//       setState(() {
//         isLoading = false;
//       });
//     }
//   } else {
//     isLoggedIn = false;
//     setState(() {
//       isLoading = false;
//     });
//   }
// }

// class _OrderHistoryViewState extends State<OrderHistoryView> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Order History'),
//       ),
//       body: ListView.builder(
//         itemCount: orders.length,
//         itemBuilder: (context, index) {
//           final order = orders[index];
//           return ListTile(
//             leading: Icon(Icons.receipt_long, color: AppColors.primaryColor),
//             title: Text(order['orderId']),
//             subtitle: Text(order['date']),
//             trailing: Text('Details',
//                 style: TextStyle(color: AppColors.primaryColor)),
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => OrderDetailView(order: order),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:yoo_local/app_constant/app_colors.dart';
import 'package:yoo_local/app_constant/app_constants.dart';
import 'package:yoo_local/screens/settings/widgets/order_detail_view.dart';
import 'package:yoo_local/ui_fuctionality/local_data.dart';

// ignore: must_be_immutable
class OrderHistoryView extends StatefulWidget {
  @override
  State<OrderHistoryView> createState() => _OrderHistoryViewState();
}

class _OrderHistoryViewState extends State<OrderHistoryView> {
  List<Map<String, dynamic>> orders = [];
  bool isLoading = true;
  bool isLoggedIn = false;

  final Dio _dio = Dio();

  @override
  void initState() {
    super.initState();
    getUserOrders(); // Fetch user orders when the widget initializes
  }

  Future<void> getUserOrders() async {
    var userToken = await LocalData.getString(AppConstants.userToken);
    if (userToken != null && userToken.isNotEmpty) {
      setState(() {
        isLoggedIn = true; // User is logged in
      });
      try {
        String url = "${AppConstants.baseUrl}/order";
        Response response = await _dio.post(
          url,
          options: Options(
            headers: {
              'Authorization': 'Bearer $userToken',
            },
          ),
        );
        if (response.statusCode == 200) {
          orders =
              List<Map<String, dynamic>>.from(response.data['data']['values']);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Please Login'),
              backgroundColor: AppColors.primaryColor,
              duration: Duration(seconds: 2),
            ),
          );
        }
      } catch (e) {
        print(e);
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    } else {
      setState(() {
        isLoggedIn = false;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order History'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                return ListTile(
                  leading:
                      Icon(Icons.receipt_long, color: AppColors.primaryColor),
                  title: Text(order['order_number']),
                  subtitle: Text(order['updated_at'].substring(0, 10)),
                  trailing: Text('Details',
                      style: TextStyle(color: AppColors.primaryColor)),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OrderDetailView(order: order),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
