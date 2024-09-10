import 'package:flutter/material.dart';

class CategoryResultsScreen extends StatelessWidget {
  final String category;

  const CategoryResultsScreen({required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$category Results'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0.5,
      ),
      body: Center(
        child: Text('Results for $category'),
        // Implement your results view here based on the category
      ),
    );
  }
}
