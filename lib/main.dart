import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:yoo_local/app_constant/app_constants.dart';
import 'package:yoo_local/screens/app_navigation/google_nav.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = AppConstants.stripeKey;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'YooLocal',
      home: GoogleNavBar(),
    );
  }
}
