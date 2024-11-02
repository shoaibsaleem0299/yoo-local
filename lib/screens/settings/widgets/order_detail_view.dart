import 'package:flutter/material.dart';

class OrderDetailView extends StatelessWidget {
  final dynamic order;

  OrderDetailView({required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order ID: ${order['order_number']}',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              'Date: ${order['updated_at'].substring(0, 10)}',
              style: TextStyle(fontSize: 14.0, color: Colors.grey),
            ),
            SizedBox(height: 16.0),
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              "${item['title'].substring(
                                0,
                                6,
                              )}...",
                              style: TextStyle(fontSize: 14.0)),
                          Text(item['sale_price'],
                              style: TextStyle(fontSize: 14.0)),
                          Text('Qty: ${item['stock_quantity']}',
                              style: TextStyle(fontSize: 14.0)),
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
    );
  }
}
