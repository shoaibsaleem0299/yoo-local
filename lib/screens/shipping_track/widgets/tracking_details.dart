import 'package:flutter/material.dart';

class OrderTrackingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text("Order Tracking Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.teal[300],
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Order Tracking - GB567AXE",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "SHIPPED VIA",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12.0,
                            ),
                          ),
                          Text(
                            "UPS",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "STATUS",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12.0,
                            ),
                          ),
                          Text(
                            "In Transit",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "EXPECTED",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12.0,
                            ),
                          ),
                          Text(
                            "Friday, September 25",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    blurRadius: 10.0,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildStatusItem(
                    icon: Icons.shopping_cart,
                    color: Colors.teal,
                    title: "Order Placed",
                    isCompleted: true,
                  ),
                  Expanded(
                    child: Divider(
                      color: Colors.grey,
                      thickness: 2,
                    ),
                  ),
                  buildStatusItem(
                    icon: Icons.local_shipping,
                    color: Colors.orange,
                    title: "In Transit",
                    isCompleted: true,
                  ),
                  Expanded(
                    child: Divider(
                      color: Colors.grey,
                      thickness: 2,
                    ),
                  ),
                  buildStatusItem(
                    icon: Icons.check_circle,
                    color: Colors.grey,
                    title: "Completed",
                    isCompleted: false,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildStatusItem({
    required IconData icon,
    required Color color,
    required String title,
    required bool isCompleted,
  }) {
    return Column(
      children: [
        Icon(
          icon,
          color: color,
          size: 30.0,
        ),
        SizedBox(height: 8.0),
        Text(
          title,
          style: TextStyle(
            color: isCompleted ? color : Colors.grey,
            fontSize: 12.0,
          ),
        ),
      ],
    );
  }
}
