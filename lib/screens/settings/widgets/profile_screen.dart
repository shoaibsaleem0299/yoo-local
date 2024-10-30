import 'package:flutter/material.dart';
import 'package:yoo_local/app_constant/app_colors.dart';
import 'package:yoo_local/app_constant/app_constants.dart';
import 'package:yoo_local/screens/app_navigation/google_nav.dart';
import 'package:yoo_local/screens/login/login_view.dart';
import 'package:yoo_local/ui_fuctionality/local_data.dart';
import 'package:yoo_local/widgets/app_button.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var userToken = null;
  var username = null;
  var userEmail = null;
  Future<void> getUserData() async {
    var Token = await LocalData.getString(AppConstants.userToken);
    var name = await LocalData.getString(AppConstants.username);
    var Email = await LocalData.getString(AppConstants.userEmail);
    setState(() {
      userToken = Token;
      username = name;
      userEmail = Email;
    });
  }

  final Map<String, String> profileData = {
    'phone': '0127892245',
    'address': 'Abc, Xyz',
    'imageUrl':
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSwYyWPcL_7bPaAvZqBO0OAwQYxjOsNo-kr8A&s'
  };

  // State for checkboxes
  bool isCashSelected = false;
  bool isCardSelected = false;

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    if (userToken != null) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
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
                  username,
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
                _buildProfileRow(Icons.email, userEmail),
                SizedBox(height: 32.0),
                SizedBox(height: 32.0),
                AppButton(
                    title: "Home",
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => GoogleNavBar()));
                    }),
                SizedBox(height: 16.0),
              ],
            ),
          ),
        ),
      );
    } else {
      return Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Please login"),
            AppButton(
                title: "Login",
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginView()));
                })
          ],
        ),
      );
    }
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
