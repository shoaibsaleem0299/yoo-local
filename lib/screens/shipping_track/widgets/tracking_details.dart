import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:yoo_local/app_constant/app_constants.dart';
import 'package:yoo_local/ui_fuctionality/local_data.dart';

class TrackingScreen extends StatelessWidget {
  final Map userTrackingDetails;
  final dio = Dio();

  TrackingScreen({super.key, required this.userTrackingDetails});

  Future<List<OrderStatus>> getOrderStatues() async {
    var userToken = await LocalData.getString(AppConstants.userToken);
    final url = "${AppConstants.baseUrl}/order/statuses";

    Response response = await dio.get(
      url,
      options: Options(
        headers: {
          'Authorization': 'Bearer $userToken',
        },
      ),
    );

    if (response.statusCode == 200) {
      List<dynamic> data = response.data['data']['values'];
      List<OrderStatus> statuses = data
          .map((json) => OrderStatus.fromJson(json))
          .where((status) => status.id != 7) // Filter out unwanted status ID
          .toList();

      return statuses;
    } else {
      throw Exception('Failed to load order statuses');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Current status sequence order based on userTrackingDetails
    var currentStatusSequenceOrder = userTrackingDetails.isNotEmpty
        ? userTrackingDetails['current_status']['id']
        : 0;

    return Scaffold(
      appBar: AppBar(title: Text("Order Tracking")),
      body: SingleChildScrollView(
        // Wrap entire body with SingleChildScrollView
        child: Column(
          children: [
            // FutureBuilder to fetch and display order statuses
            FutureBuilder<List<OrderStatus>>(
              future: getOrderStatues(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No status available'));
                }

                final statuses = snapshot.data!;
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: statuses.length,
                    itemBuilder: (context, index) {
                      final status = statuses[index];
                      final isActive =
                          status.sequenceOrder <= currentStatusSequenceOrder;

                      return ListTile(
                        leading: Icon(
                          Icons.check_circle,
                          color: isActive ? Colors.green : Colors.grey,
                        ),
                        title: Text(
                          status.name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: isActive ? Colors.black : Colors.grey,
                          ),
                        ),
                        subtitle: Text(
                          status.message,
                          style: TextStyle(
                            color: isActive ? Colors.black87 : Colors.grey,
                          ),
                        ),
                        trailing: isActive
                            ? Icon(Icons.check, color: Colors.green)
                            : Icon(Icons.circle_outlined, color: Colors.grey),
                      );
                    },
                  ),
                );
              },
            ),

            // Padding for History section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "History",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  // Check if history is available in userTrackingDetails
                  userTrackingDetails['history'] != null &&
                          userTrackingDetails['history'].isNotEmpty
                      ? ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: userTrackingDetails['history'].length,
                          itemBuilder: (context, index) {
                            final item = userTrackingDetails['history'][index];
                            final orderStatusId = item['order_status_id'];
                            final updatedAt = item['updated_at'];

                            // Determine the label based on order_status_id
                            String statusLabel;
                            switch (orderStatusId) {
                              case 2:
                                statusLabel = "Packed At";
                                break;
                              case 3:
                                statusLabel = "Dispatched At";
                                break;
                              case 4:
                                statusLabel = "Given to Rider At";
                                break;
                              case 5:
                                statusLabel = "Out For Delivery At";
                                break;
                              case 6:
                                statusLabel = "Delivered At";
                                break;
                              // Add more cases based on your order status ids
                              default:
                                statusLabel = "Status Updated At";
                            }

                            return ListTile(
                              title: Text(
                                "$statusLabel: ${updatedAt.substring(0, 10)}",
                                style: TextStyle(fontSize: 16),
                              ),
                            );
                          },
                        )
                      : Center(child: Text("No history available")),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OrderStatus {
  final int id;
  final String name;
  final String message;
  final String identifier;
  final int sequenceOrder;

  OrderStatus({
    required this.id,
    required this.name,
    required this.message,
    required this.identifier,
    required this.sequenceOrder,
  });

  factory OrderStatus.fromJson(Map<String, dynamic> json) {
    return OrderStatus(
      id: json['id'],
      name: json['name'],
      message: json['message'],
      identifier: json['identifier'],
      sequenceOrder: json['sequence_order'],
    );
  }
}
