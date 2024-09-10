import 'package:flutter/material.dart';

class CategoryResultScreen extends StatelessWidget {
  final String categoryTitle;

  const CategoryResultScreen({
    Key? key,
    required this.categoryTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
        backgroundColor: Colors.blue, // Customize as needed
      ),
      body: Center(
        child: Text(
          'Results for $categoryTitle',
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
