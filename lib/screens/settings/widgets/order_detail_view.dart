import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yoo_local/app_constant/app_colors.dart';
import 'package:yoo_local/app_constant/app_constants.dart';
import 'package:yoo_local/screens/shipping_track/widgets/tracking_details.dart';
import 'package:yoo_local/ui_fuctionality/local_data.dart';

class OrderDetailView extends StatelessWidget {
  final dynamic order;

  OrderDetailView({required this.order});

  @override
  Widget build(BuildContext context) {
    final dio = Dio();

    Future<Map<String, dynamic>> getUserTrackingDetails(
        BuildContext context, int id) async {
      var userToken = await LocalData.getString(AppConstants.userToken);
      final url = "${AppConstants.baseUrl}/order/tracking/$id";
      Map<String, dynamic> trackingData = {};

      try {
        Response response = await dio.post(
          url,
          options: Options(
            headers: {
              'Authorization': 'Bearer $userToken',
            },
          ),
        );

        if (response.statusCode == 200) {
          trackingData = response.data['data']['values'];
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Order with this ID does not exist'),
              backgroundColor: AppColors.primaryColor,
              duration: Duration(seconds: 2),
            ),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('An error occurred while fetching tracking details'),
            backgroundColor: AppColors.primaryColor,
            duration: Duration(seconds: 2),
          ),
        );
      }

      return trackingData; // Return tracking data
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Order Details'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Order Number: ',
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    order['order_number'].toString(),
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.0),
              Row(
                children: [
                  Text(
                    'Tack Order: ',
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () async {
                      final trackingDetails =
                          await getUserTrackingDetails(context, order['id']);
                      if (trackingDetails.isNotEmpty) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TrackingScreen(
                              userTrackingDetails: trackingDetails,
                            ),
                          ),
                        );
                      }
                    },
                    child: Text(
                      "#${order['id'].toString()}",
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.0),
              Text(
                'Order Date: ${order['updated_at'].substring(0, 10)}',
                style: TextStyle(fontSize: 14.0, color: Colors.grey),
              ),
              SizedBox(height: 16.0),
              Text(
                'Order Information',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text("Customer ID: ",
                                style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold)),
                            Text("${order['customer_id'].toString()}",
                                style: TextStyle(fontSize: 14.0)),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text("Email: ",
                                style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold)),
                            Text('${order['email']}',
                                style: TextStyle(fontSize: 14.0)),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text("Phone: ",
                                style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold)),
                            Text('${order['customer_phone_number']}',
                                style: TextStyle(fontSize: 14.0)),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text("Order Process: ",
                                style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold)),
                            Text('Complete', style: TextStyle(fontSize: 14.0)),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text("Grand Total: ",
                                style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold)),
                            Text(
                                '${double.parse(order['total']).toStringAsFixed(2)}',
                                style: TextStyle(fontSize: 14.0)),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text("Discount: ",
                                style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold)),
                            Text('${(order['discount']).toString()}',
                                style: TextStyle(fontSize: 14.0)),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment:
                              CrossAxisAlignment.start, // Align text to the top
                          children: [
                            Text(
                              "Shipping Address: ",
                              style: TextStyle(
                                  fontSize: 14.0, fontWeight: FontWeight.bold),
                            ),
                            Expanded(
                              child: Text(
                                '${order['shipping_address']}',
                                style: TextStyle(fontSize: 14.0),
                                softWrap: true,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                'Order Items',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: order['order_items'].map<Widget>((item) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text("Product: ",
                                      style: TextStyle(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.bold)),
                                  Text("${item['title']}",
                                      style: TextStyle(fontSize: 14.0)),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text("Quantity: ",
                                      style: TextStyle(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.bold)),
                                  Text('Qty: ${item['pivot']['quantity']}',
                                      style: TextStyle(fontSize: 14.0)),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text("Total Price: ",
                                      style: TextStyle(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.bold)),
                                  Text(
                                      "${(double.parse(item['pivot']['unit_price']) * item['pivot']['quantity']).toStringAsFixed(2)}",
                                      style: TextStyle(fontSize: 14.0)),
                                ],
                              ),
                            ),
                            Divider(
                              color: AppColors.primaryColor,
                            )
                          ],
                        ),
                      );
                    }).toList(),
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
