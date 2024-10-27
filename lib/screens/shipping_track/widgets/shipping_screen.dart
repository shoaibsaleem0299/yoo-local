import 'package:flutter/material.dart';
import 'package:yoo_local/app_constant/app_colors.dart';
import 'package:yoo_local/widgets/app_button.dart';

class OrderTrackingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        
        title: const Text('Top Order Tracking'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Divider(color: AppColors.primaryColor),
                SizedBox(height: 24.0),
                Text(
                  'Enter Tracking Number\nTo Get Your Order Status',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 24.0),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Enter Number',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 8.0),
                    AppButton(title: "Search", onTap: () {})
                  ],
                ),
                SizedBox(height: 32.0),
                Text(
                  'Our Process',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.orange[100],
                      child: Icon(Icons.description, color: Colors.orange),
                    ),
                    SizedBox(width: 8.0),
                    Icon(Icons.arrow_forward, color: Colors.black),
                    SizedBox(width: 8.0),
                    CircleAvatar(
                      backgroundColor: Colors.orange[100],
                      child: Icon(Icons.local_shipping, color: Colors.orange),
                    ),
                    SizedBox(width: 8.0),
                    Icon(Icons.arrow_forward, color: Colors.black),
                    SizedBox(width: 8.0),
                    CircleAvatar(
                      backgroundColor: Colors.orange[100],
                      child: Icon(Icons.check_circle, color: Colors.orange),
                    ),
                  ],
                ),
                SizedBox(height: 32.0),
                Text(
                  '100%',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                      5, (index) => Icon(Icons.star, color: Colors.orange)),
                ),
                SizedBox(height: 8.0),
                Text(
                  "Customer's Satisfaction",
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
