import 'package:flutter/material.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';
// import 'package:yoo_local/app_constant/app_constants.dart';
import 'package:yoo_local/screens/app_navigation/google_nav.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // Stripe.publishableKey = AppConstants.stripeKey;

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
