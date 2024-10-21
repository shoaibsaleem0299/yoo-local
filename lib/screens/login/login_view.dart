import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:yoo_local/app_constant/app_colors.dart';
import 'package:yoo_local/app_constant/app_constants.dart';
import 'package:yoo_local/screens/register/create_account_view.dart';
import 'package:yoo_local/ui_fuctionality/local_data.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    final Dio _dio = Dio();

    Future<void> login() async {
      if (formKey.currentState!.validate()) {
        try {
          String url = "${AppConstants.baseUrl}/login";
          Response response = await _dio.post(
            url,
            data: {
              'email': emailController.text,
              'password': passwordController.text,
            },
          );
          if (response.statusCode == 200) {
            String token = response.data['data']['token'];
            LocalData.addString(AppConstants.userToken, token);
            String name = response.data['data']['name'];
            LocalData.addString(AppConstants.username, name);
            String email = response.data['data']['email'];
            LocalData.addString(AppConstants.userEmail, email);
            Navigator.pop(context);
          }
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Login failed, Credentials not matched',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              backgroundColor: AppColors.primaryColor,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              duration: Duration(seconds: 3),
            ),
          );
        }
      }
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 64.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40),
              Text(
                'Login',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: AppColors.secondaryColor, // Text color
                ),
              ),
              SizedBox(height: 40),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: 'Email Address',
                        border: UnderlineInputBorder(),
                      ),
                      style: TextStyle(color: AppColors.secondaryColor),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your Email';
                        }
                        String pattern =
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
                        RegExp regex = RegExp(pattern);
                        if (!regex.hasMatch(value)) {
                          return 'Please enter a valid Email address';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: UnderlineInputBorder(),
                        suffixIcon: Icon(Icons.visibility_off,
                            color: AppColors.secondaryColor),
                      ),
                      obscureText: true,
                      style: TextStyle(color: AppColors.secondaryColor),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your Password';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'Forgot Password?',
                  style: TextStyle(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w700),
                ),
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  login();
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  backgroundColor: AppColors.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: Text(
                  'Login',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: Text(
                  "Don't have an account?",
                  style: TextStyle(
                      color: AppColors.secondaryColor,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CreateAccountView()),
                    );
                  },
                  child: Text(
                    "Create Account",
                    style: TextStyle(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
