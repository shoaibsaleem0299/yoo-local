import 'package:flutter/material.dart';
import 'package:yoo_local/widgets/app_button.dart';

class CheckoutView extends StatelessWidget {
  final String total;
  final String discount;
  final String delivery;
  const CheckoutView(
      {super.key,
      required this.total,
      required this.discount,
      required this.delivery});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Check Out'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSummary(), // Added summary widget
            const SizedBox(height: 20),
            const SectionTitle(title: 'Contact Information'),
            const SizedBox(height: 10),
            _buildTextField(label: 'Email'),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(child: _buildTextField(label: 'First Name')),
                const SizedBox(width: 10),
                Expanded(child: _buildTextField(label: 'Last Name')),
              ],
            ),
            const SizedBox(height: 10),
            _buildTextField(label: 'Phone Number'),
            const SizedBox(height: 10),
            Row(
              children: [
                Checkbox(
                  value: false,
                  onChanged: (bool? value) {},
                ),
                const Text('Email Me With News And Offers'),
              ],
            ),
            const SizedBox(height: 20),
            const SectionTitle(title: 'Shipping Address'),
            const SizedBox(height: 10),
            _buildTextField(label: 'Address'),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(child: _buildTextField(label: 'Country, State')),
                const SizedBox(width: 10),
                Expanded(child: _buildTextField(label: 'City')),
              ],
            ),
            const SizedBox(height: 10),
            _buildTextField(label: 'Apartment, Suite, Room'),
            const SizedBox(height: 10),
            _buildTextField(label: 'Street'),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(child: _buildTextField(label: 'Post Code')),
                const SizedBox(width: 10),
                Expanded(child: _buildTextField(label: 'Phone Number')),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Checkbox(
                  value: false,
                  onChanged: (bool? value) {},
                ),
                const Text('My Shipping Address As Billing Address'),
              ],
            ),
            const SizedBox(height: 20),
            const SectionTitle(title: 'Payment Methods'),
            const SizedBox(height: 10),
            _buildPaymentMethods(),
            const SizedBox(height: 20),
            Center(child: AppButton(title: "Place Order", onTap: () {}))
          ],
        ),
      ),
    );
  }

  Widget _buildSummary() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Summary',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        const SizedBox(height: 10),
        _buildSummaryRow('Subtotal:', '\£${total}'),
        const SizedBox(height: 5),
        _buildSummaryRow('Delivery Fee:', '\£${delivery}'),
        const SizedBox(height: 5),
        _buildSummaryRow('Discount:', '%${discount}'),
        const SizedBox(height: 5),
        const Divider(),
        _buildSummaryRow(
          'Total:',
          '\£${total}',
          isTotal: true,
        ),
      ],
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            fontSize: isTotal ? 16 : 14,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            fontSize: isTotal ? 16 : 14,
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({required String label}) {
    return TextField(
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
    );
  }

  Widget _buildPaymentMethods() {
    return Column(
      children: [
        RadioListTile(
          value: 'cod',
          groupValue: 'paymentMethod',
          onChanged: (String? value) {},
          title: const Text('Cash On Delivery'),
        ),
        RadioListTile(
          value: 'card',
          groupValue: 'paymentMethod',
          onChanged: (String? value) {},
          title: Text('Credit/Debit Card'),
        ),
        const SizedBox(height: 10),
        _buildTextField(label: 'Card Number'),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(child: _buildTextField(label: 'Expiration Month')),
            const SizedBox(width: 10),
            Expanded(child: _buildTextField(label: 'Expiration Year')),
          ],
        ),
        const SizedBox(height: 10),
        _buildTextField(label: 'CVV'),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const [
            IconButton(
              icon: Image(
                  width: 80,
                  image: NetworkImage(
                      'https://static1.howtogeekimages.com/wordpress/wp-content/uploads/2020/11/Google-Pay-hero.png')),
              onPressed: null,
            ),
            IconButton(
              icon: Image(
                  width: 80,
                  image: NetworkImage(
                    'https://s38924.pcdn.co/wp-content/uploads/2021/09/Stripe-1-scaled-1-1360x692.jpg',
                  )),
              onPressed: null,
            ),
            IconButton(
              icon: Image(
                  width: 80,
                  image: NetworkImage(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRmEndUO8CpOCPFxBp1y6CLv3n4ESeXCKlgfA&s')),
              onPressed: null,
            ),
          ],
        ),
      ],
    );
  }

  Widget buildBottomButtons() {
    return Align(
      alignment: Alignment.center,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 20),
          backgroundColor: Colors.orange,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: const Text(
          'Check Out',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
    );
  }
}
