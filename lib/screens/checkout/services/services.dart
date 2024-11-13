// import 'package:dio/dio.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';
// import 'package:yoo_local/app_constant/app_constants.dart';

// class StripeService {
//   StripeService._();

//   static final StripeService instance = StripeService._();

//   Future<void> makePayment(String amount) async {
//     try {
//       String? paymentIntentClientSecret =
//           await createPaymentIntent(amount, 'usd');
//       if (paymentIntentClientSecret == null) return;
//       await Stripe.instance.initPaymentSheet(
//         paymentSheetParameters: SetupPaymentSheetParameters(
//             paymentIntentClientSecret: paymentIntentClientSecret,
//             merchantDisplayName: 'YooLocal'),
//       );
//       await _processPayment();
//     } catch (e) {
//       print(e);
//     }
//   }

//   Future<String?> createPaymentIntent(String amount, String currency) async {
//     try {
//       Map<String, dynamic> body = {
//         'amount': _calculateAmount(amount),
//         'currency': currency,
//       };
//       Dio dio = Dio();
//       var response = await dio.post(
//         'https://api.stripe.com/v1/payment_intents',
//         options: Options(headers: {
//           'Authorization': 'Bearer ${AppConstants.stripeSecret}',
//           'Content-Type': 'application/x-www-form-urlencoded',
//         }),
//         data: body,
//       );
//       if (response.data != null) {
//         return response.data['client_secret'];
//       }
//     } catch (e) {
//       print(e);
//     }
//     return null;
//   }

//   Future<void> _processPayment() async {
//     try {
//       await Stripe.instance.presentPaymentSheet();
//       await Stripe.instance.confirmPaymentSheetPayment();
//     } catch (e) {
//       print(e);
//     }
//   }

//   String _calculateAmount(String amount) {
//     final cleanAmount = amount.replaceAll(',', '');
//     final calculatedAmount = (double.parse(cleanAmount) * 100).toInt();
//     return calculatedAmount.toString();
//   }

//   Future<void> createStripeToken() async {
//     try {
//       // Validate if card details are entered correctly
//       final card = CardFieldInputDetails(
//         complete: true,
//       );

//       if (card.complete) {
//         // Create token
//         final tokenData = await Stripe.instance.createToken(
//           // ignore: deprecated_member_use
//           CreateTokenParams(type: TokenType.Card),
//         );

//         // Extract token ID
//         final token = tokenData.id;
//         print("stripe token is: ${token}");
//         // Send `token` to your Laravel backend
//       } else {
//         print('Card details are incomplete');
//       }
//     } catch (e) {
//       print('Error creating token: $e');
//     }
//   }
// }






// import 'package:flutter/material.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';

// class PaymentScreen extends StatefulWidget {
//   @override
//   _PaymentScreenState createState() => _PaymentScreenState();
// }

// class _PaymentScreenState extends State<PaymentScreen> {
//   CardFieldInputDetails? _cardDetails;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Payment')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // Card input field
//             CardField(
//               cursorColor: Colors.blueAccent, // Customize cursor color
//               decoration: InputDecoration(
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8.0),
//                   borderSide: BorderSide(
//                     color: Colors.grey,
//                     width: 1.5,
//                   ),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8.0),
//                   borderSide: BorderSide(
//                     color: Colors.blueAccent,
//                     width: 2.0,
//                   ),
//                 ),
//                 hintText: 'Enter card details',
//                 hintStyle: TextStyle(color: Colors.grey.shade400),
//                 filled: true,
//                 fillColor: Colors.grey.shade100,
//                 contentPadding:
//                     EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
//               ),
//               style: TextStyle(
//                 fontSize: 16,
//                 color: Colors.black87,
//               ), // Customize input text style
//               onCardChanged: (card) {
//                 setState(() {
//                   _cardDetails = card; // Save card details
//                 });
//               },
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _cardDetails != null && _cardDetails!.complete
//                   ? createStripeToken // Enable button if card is complete
//                   : null,
//               child: Text('Pay Now'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Future<void> createStripeToken() async {
//     try {
//       if (_cardDetails != null && _cardDetails!.complete) {
//         // Create a token with the entered card details
//         final tokenData = await Stripe.instance.createToken(
//           CreateTokenParams.card(
//               params: CardTokenParams()), // Uses details from CardField
//         );

//         final token = tokenData.id;
//         print("Stripe token is: $token");
//         // Send `token` to your backend
//       } else {
//         print('Card details are incomplete');
//       }
//     } catch (e) {
//       print('Error creating token: $e');
//     }
//   }
// }
