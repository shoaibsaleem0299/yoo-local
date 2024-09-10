import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final String name;
  final String imageUrl;
  final Color color;
  final VoidCallback onTap;

  const CustomCard({
    required this.name,
    required this.imageUrl,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: color,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.network(imageUrl, height: 100, width: 100),
            Text(name, style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
