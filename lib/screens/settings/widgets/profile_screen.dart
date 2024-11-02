import 'package:flutter/material.dart';
import 'package:yoo_local/app_constant/app_colors.dart';
import 'package:yoo_local/app_constant/app_constants.dart';
import 'package:yoo_local/screens/app_navigation/google_nav.dart';
import 'package:yoo_local/screens/login/login_view.dart';
import 'package:yoo_local/screens/settings/widgets/order_history_view.dart';
import 'package:yoo_local/screens/shipping_track/widgets/shipping_screen.dart';
import 'package:yoo_local/ui_fuctionality/local_data.dart';
import 'package:yoo_local/widgets/app_button.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? userToken = '';
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

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    if (userToken != null && userToken!.isNotEmpty) {
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
                SizedBox(height: 6.0),
                Text(
                  userEmail,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 32.0),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OrderHistoryView()));
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                    backgroundColor: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Text(
                    'Order History',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 32.0),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OrderTrackingScreen()));
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                    backgroundColor: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Text(
                    'Order Tracking',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 32.0),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => GoogleNavBar()));
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                    backgroundColor: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Text(
                    'Home',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 32.0),
                ElevatedButton(
                  onPressed: () async {
                    await LocalData.addString(AppConstants.userToken, "");
                    getUserData();
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                    backgroundColor: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Text(
                    'Log Out',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
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
              },
            ),
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
