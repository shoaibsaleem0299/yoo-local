import 'package:flutter/material.dart';
import 'package:yoo_local/app_constant/app_colors.dart';
import 'package:yoo_local/widgets/app_button.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final Map<String, String> profileData = {
    'name': 'Parker',
    'phone': '0127892245',
    'address': 'Abc, Xyz',
    'email': 'abc@gmail.com',
    'imageUrl':
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSwYyWPcL_7bPaAvZqBO0OAwQYxjOsNo-kr8A&s'
  };

  // State for checkboxes
  bool isCashSelected = false;
  bool isCardSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Padding(
            padding: const EdgeInsets.all(8.0),
            child: const Icon(
              Icons.search,
              color: Colors.black,
              size: 32,
            ),
          ),
          onPressed: () {
            // Add your search functionality here
          },
        ),
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Divider(color: AppColors.primaryColor),
              SizedBox(height: 16.0),
              CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(profileData['imageUrl']!),
              ),
              SizedBox(height: 16.0),
              Text(
                profileData['name']!,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.0),
              _buildProfileRow(Icons.phone, profileData['phone']!),
              SizedBox(height: 16.0),
              _buildProfileRow(Icons.location_on, profileData['address']!),
              SizedBox(height: 16.0),
              _buildProfileRow(Icons.email, profileData['email']!),
              SizedBox(height: 32.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Checkbox(
                    activeColor: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    value: isCashSelected,
                    onChanged: (bool? value) {
                      setState(() {
                        isCashSelected = value!;
                      });
                    },
                  ),
                  Column(
                    children: [
                      Icon(Icons.money, color: Colors.black),
                      SizedBox(height: 8.0),
                      Text('Cash'),
                    ],
                  ),
                  SizedBox(width: 32.0),
                  Checkbox(
                    activeColor: AppColors.primaryColor,
                    value: isCardSelected,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    onChanged: (bool? value) {
                      setState(() {
                        isCardSelected = value!;
                      });
                    },
                  ),
                  Column(
                    children: [
                      Icon(Icons.credit_card, color: Colors.black),
                      SizedBox(height: 8.0),
                      Text('Card'),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 32.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppButton(title: "Home", onTap: () {}),
                  SizedBox(width: 16.0),
                  AppButton(title: "Sign Out", onTap: () {}),
                ],
              ),
              SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileRow(IconData icon, String data) {
    return Row(
      children: [
        Icon(icon, color: Colors.black),
        SizedBox(width: 16.0),
        Expanded(
          child: TextFormField(
            initialValue: data,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
        ),
        SizedBox(width: 16.0),
        Icon(Icons.edit, color: Colors.black),
      ],
    );
  }
}
