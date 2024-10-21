import 'package:flutter/material.dart';
import 'package:yoo_local/screens/app_navigation/google_nav.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'YooLocal',
      home: GoogleNavBar(),
    );
  }
}
