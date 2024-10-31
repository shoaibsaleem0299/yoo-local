// import 'package:dio/dio.dart'; // For Dio
// import 'package:flutter/material.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';
// import 'package:yoo_local/app_constant/app_constants.dart';

// Map<String, dynamic>? paymentIntent;

// Future<void> makePayment() async {
//   try {
//     // STEP 1: Create Payment Intent
//     paymentIntent = await createPaymentIntent('100', 'USD');

//     // STEP 2: Initialize Payment Sheet
//     await Stripe.instance.initPaymentSheet(
//       paymentSheetParameters: SetupPaymentSheetParameters(
//         paymentIntentClientSecret:
//             paymentIntent!['client_secret'], // Gotten from payment intent
//         style: ThemeMode.light,
//         merchantDisplayName: 'Ikay',
//       ),
//     );

//     // STEP 3: Display Payment sheet
//     await displayPaymentSheet();
//   } catch (err) {
//     print('Error in makePayment: $err');
//     throw Exception(err);
//   }
// }

// Future<Map<String, dynamic>> createPaymentIntent(
//     String amount, String currency) async {
//   try {
//     // Request body
//     Map<String, dynamic> body = {
//       'amount': calculateAmount(amount),
//       'currency': currency,
//     };

//     // Initialize Dio
//     Dio dio = Dio();

//     // Make post request to Stripe
//     final response = await dio.post(
//       'https://api.stripe.com/v1/payment_intents',
//       options: Options(
//         headers: {
//           'Authorization': 'Bearer ${AppConstants.stripeSecret}',
//           'Content-Type': 'application/x-www-form-urlencoded',
//         },
//       ),
//       data: body,
//     );

//     return response.data; // Return the response data
//   } catch (err) {
//     print('Error in createPaymentIntent: $err');
//     throw Exception(err.toString());
//   }
// }

// Future<void> displayPaymentSheet() async {
//   try {
//     await Stripe.instance.presentPaymentSheet();
//     paymentIntent = null; // Clear paymentIntent after successful payment
//   } on StripeException catch (e) {
//     print('Stripe Error: ${e}');
//   } catch (e) {
//     print('General Error: $e');
//   }
// }

// int calculateAmount(String amount) {
//   return (int.parse(amount) * 100); // Converts dollars to cents
// }

// // Example Flutter app to call makePayment

// class TestView extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Payment')),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () async {
//             await makePayment();
//           },
//           child: Text('Make Payment'),
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   Stripe.publishableKey =
//       'your-publishable-key'; // Replace with your Stripe publishable key
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Stripe Payment Example',
//       home: PaymentScreen(),
//     );
//   }
// }

// class PaymentScreen extends StatefulWidget {
//   @override
//   _PaymentScreenState createState() => _PaymentScreenState();
// }

// class _PaymentScreenState extends State<PaymentScreen> {
//   late CardFieldInputDetails _cardDetails;

//   Future<void> _handlePayment() async {
//     try {
//       // Step 1: Call backend to create Payment Intent
//       final response = await http.post(
//         Uri.parse('https://your-backend-url.com/create-payment-intent'),
//         headers: {'Content-Type': 'application/json'},
//         body: json.encode({
//           'amount': 1000,
//           'currency': 'usd'
//         }), // Replace with actual amount and currency
//       );

//       final paymentIntentData = json.decode(response.body);
//       final clientSecret = paymentIntentData['client_secret'];

//       // Step 2: Confirm Payment on the frontend
//       await Stripe.instance.confirmPayment(
//         clientSecret,
//         PaymentMethodParams.card(
//           paymentMethodData: PaymentMethodData(
//             billingDetails: BillingDetails(
//               email: 'test@example.com',
//               phone: '+1234567890',
//               address: Address(
//                 city: 'San Francisco',
//                 country: 'US',
//                 line1: '123 Street',
//                 line2: '',
//                 state: 'CA',
//                 postalCode: '94107',
//               ),
//             ),
//           ),
//         ),
//       );

//       // Payment succeeded
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Payment successful!')),
//       );
//     } catch (error) {
//       // Payment failed
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Payment failed: $error')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Stripe Payment')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             CardField(
//               onCardChanged: (cardDetails) {
//                 setState(() {
//                   _cardDetails = cardDetails!;
//                 });
//               },
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _cardDetails.complete ? _handlePayment : null,
//               child: Text('Pay Now'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
