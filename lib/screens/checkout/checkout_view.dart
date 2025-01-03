import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:yoo_local/app_constant/app_colors.dart';
import 'package:yoo_local/app_constant/app_constants.dart';
import 'package:yoo_local/screens/app_navigation/google_nav.dart';
import 'package:yoo_local/screens/settings/widgets/order_history_view.dart';
import 'package:yoo_local/ui_fuctionality/local_data.dart';

Map<String, dynamic>? paymentIntent;

class CheckoutView extends StatefulWidget {
  final String total;
  final String discount;
  final String delivery;
  final int cartId;
  const CheckoutView(
      {super.key,
      required this.total,
      required this.discount,
      required this.delivery,
      required this.cartId});

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  CardFieldInputDetails? _cardDetails;
  final Dio _dio = Dio();
  final emailController = TextEditingController();
  final firstNameController = TextEditingController();
  final secondNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final addressLine1Controller = TextEditingController();
  final addressLine2Controller = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final countryController = TextEditingController();
  final zipCodeController = TextEditingController();

  bool _isLoading = false;

  Future<void> placeOrder(String token) async {
    setState(() {
      _isLoading = true;
    });

    var userToken = await LocalData.getString(AppConstants.userToken);
    if (formKey.currentState!.validate()) {
      if (userToken!.isNotEmpty) {
        try {
          final url = "${AppConstants.baseUrl}/checkout/${widget.cartId}";
          final requestBody = {
            'stripe_token': token,
            'email': emailController.text,
            'first_name': firstNameController.text,
            'phone_number': phoneNumberController.text,
            'address_line_1': addressLine1Controller.text,
            'address_line_2': addressLine2Controller.text,
            'city': cityController.text,
            'state': stateController.text,
            'country': countryController.text,
            'zip_code': zipCodeController.text,
          };

          Response response = await _dio.post(
            url,
            data: requestBody,
            options: Options(
              headers: {
                'Authorization': 'Bearer $userToken',
                'Content-Type': 'application/json',
              },
            ),
          );

          if (response.statusCode == 200) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Order Place successfully!'),
                backgroundColor: AppColors.primaryColor,
                duration: Duration(seconds: 2),
              ),
            );

            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => OrderHistoryView()));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Failed to place Order. Please try again.'),
                backgroundColor: Colors.red,
                duration: Duration(seconds: 2),
              ),
            );
          }
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Order Place successfully!'),
              backgroundColor: AppColors.primaryColor,
              duration: Duration(seconds: 2),
            ),
          );

          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => GoogleNavBar()));
        } finally {
          setState(() {
            _isLoading = false;
          });
        }
      } else {
        setState(() {
          _isLoading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('You need to be logged in'),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 2),
          ),
        );
      }
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> createStripeToken() async {
    try {
      if (_cardDetails != null && _cardDetails!.complete) {
        final tokenData = await Stripe.instance.createToken(
          CreateTokenParams.card(params: CardTokenParams()),
        );
        final token = tokenData.id;
        if (token.isNotEmpty) {
          placeOrder(token);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Err: Please check your card details again!'),
              backgroundColor: Colors.red,
              duration: Duration(seconds: 2),
            ),
          );
        }
      } else {
        print('Card details are incomplete');
      }
    } catch (e) {
      print('Error creating token: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Check Out'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSummary(),
                const SizedBox(height: 20),
                Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SectionTitle(title: 'Contact Information'),
                      const SizedBox(height: 16),

                      TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          labelText: "Email",
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your Email';
                          }
                          // Regular expression for validating an email address
                          String pattern =
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
                          RegExp regex = RegExp(pattern);
                          if (!regex.hasMatch(value)) {
                            return 'Please enter a valid Email address';
                          }
                          return null;
                        },
                      ),
                      // _buildTextField(
                      //     label: 'Email', controller: emailController),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: _buildTextField(
                              label: 'First Name',
                              controller: firstNameController,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: _buildTextField(
                              label: 'Last Name',
                              controller: secondNameController,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      _buildTextField(
                          label: 'Phone Number',
                          controller: phoneNumberController),
                      const SizedBox(height: 16),
                      const SectionTitle(title: 'Shipping Address'),
                      const SizedBox(height: 16),
                      _buildTextField(
                          label: 'Address Line 1',
                          controller: addressLine1Controller),
                      const SizedBox(height: 10),
                      _buildTextField(
                          label: 'Address Line 2',
                          controller: addressLine2Controller),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: _buildTextField(
                                label: 'State', controller: stateController),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: _buildTextField(
                                label: 'City', controller: cityController),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: _buildTextField(
                                label: 'Country',
                                controller: countryController),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: _buildTextField(
                                label: 'Zip Code',
                                controller: zipCodeController),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                const SectionTitle(title: 'Card Details'),
                const SizedBox(height: 16),
                CardField(
                  cursorColor: Colors.blueAccent,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(color: Colors.grey, width: 1.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide:
                          BorderSide(color: Colors.blueAccent, width: 2.0),
                    ),
                    hintText: 'Enter card details',
                    hintStyle: TextStyle(color: Colors.grey.shade400),
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
                  ),
                  style: TextStyle(fontSize: 16, color: Colors.black87),
                  onCardChanged: (card) {
                    setState(() {
                      _cardDetails = card;
                    });
                  },
                ),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 8),
                    ),
                    onPressed: _cardDetails != null && _cardDetails!.complete
                        ? createStripeToken
                        : null,
                    child: Text(
                      'Place Order',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (_isLoading)
            Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }

  Widget _buildSummary() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Summary',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        const SizedBox(height: 10),
        _buildSummaryRow('Subtotal:', '\£${widget.total}'),
        const SizedBox(height: 5),
        _buildSummaryRow('Delivery Fee:', '\£${widget.delivery}'),
        const SizedBox(height: 5),
        _buildSummaryRow('Discount:', '%${widget.discount}'),
        const SizedBox(height: 5),
        const Divider(),
        _buildSummaryRow('Total:', '\£${widget.total}'),
      ],
    );
  }

  Widget _buildSummaryRow(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title),
        Text(value),
      ],
    );
  }

  Widget _buildTextField(
      {required String label, required TextEditingController controller}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $label';
        }
        return null;
      },
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }
}
