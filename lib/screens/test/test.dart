import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:yoo_local/app_constant/app_constants.dart';

class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final _formKey = GlobalKey<FormState>();
  final _cardNumberController = TextEditingController();
  final _expiryMonthController = TextEditingController();
  final _expiryYearController = TextEditingController();
  final _cvcController = TextEditingController();

  Map<String, dynamic>? paymentIntent;

  

  Future<void> makePayment() async {
    if (_formKey.currentState!.validate()) {
      try {
        // STEP 1: Create Payment Intent
        paymentIntent = await createPaymentIntent('100', 'USD');

        // Extract the 'id' from paymentIntent to send it to the backend developer
        final paymentId = paymentIntent!['id'];
        print('Payment ID: $paymentId');

        // STEP 2: Create a token from the card details
        final token = await Stripe.instance.createToken(CreateTokenParams.card(
          params: CardTokenParams(
            // Optional: Add additional info here
            type: TokenType.Card,
          ),
          // This is where you'll create the token from the card fields
        ));

        print(
            '==================================Token: ${token.id}'); // Send this token to your backend for processing

        // STEP 3: Initialize Payment Sheet
        await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret: paymentIntent!['client_secret'],
            style: ThemeMode.light,
            merchantDisplayName: 'Ikay',
          ),
        );

        // STEP 4: Display Payment sheet
        await displayPaymentSheet();
      } catch (err) {
        print('Error in makePayment: $err');
        throw Exception(err);
      }
    }
  }

  Future<Map<String, dynamic>> createPaymentIntent(
      String amount, String currency) async {
    try {
      // Request body
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
      };

      // Initialize Dio
      Dio dio = Dio();

      // Make post request to Stripe
      final response = await dio.post(
        'https://api.stripe.com/v1/payment_intents',
        options: Options(
          headers: {
            'Authorization': 'Bearer ${AppConstants.stripeSecret}',
            'Content-Type': 'application/x-www-form-urlencoded',
          },
        ),
        data: body,
      );

      return response.data; // Return the response data
    } catch (err) {
      print('Error in createPaymentIntent: $err');
      throw Exception(err.toString());
    }
  }

  Future<void> displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet();
      paymentIntent = null; // Clear paymentIntent after successful payment
    } on StripeException catch (e) {
      print('Stripe Error: ${e}');
    } catch (e) {
      print('General Error: $e');
    }
  }

  int calculateAmount(String amount) {
    return (int.parse(amount) * 100); // Converts dollars to cents
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Payment')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _cardNumberController,
                decoration: InputDecoration(labelText: 'Card Number'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter card number';
                  }
                  return null;
                },
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _expiryMonthController,
                      decoration:
                          InputDecoration(labelText: 'Expiry Month (MM)'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter expiry month';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: _expiryYearController,
                      decoration:
                          InputDecoration(labelText: 'Expiry Year (YY)'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter expiry year';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              TextFormField(
                controller: _cvcController,
                decoration: InputDecoration(labelText: 'CVC'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter CVC';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: makePayment,
                child: Text('Make Payment'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
