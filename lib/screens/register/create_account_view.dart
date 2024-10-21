import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:yoo_local/app_constant/app_colors.dart';
import 'package:yoo_local/app_constant/app_constants.dart';

class CreateAccountView extends StatelessWidget {
  const CreateAccountView({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController confirmPasswordController =
        TextEditingController();
    final formKey = GlobalKey<FormState>();
    final Dio _dio = Dio();
    String errorMessage = '';

    Future<void> createAccount() async {
      if (formKey.currentState!.validate()) {
        try {
          String url = "${AppConstants.baseUrl}/register";
          Response response = await _dio.post(
            url,
            data: {
              'name': nameController.text,
              'email': emailController.text,
              'username': usernameController.text,
              'password': passwordController.text,
              'confirm_password': confirmPasswordController.text,
            },
          );
          if (response.statusCode == 200) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Center(
                  child: Text(
                    'Registration failed: User Alread Exists',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
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
            Navigator.pop(context);
          }
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Center(
                child: Text(
                  'Registration failed, User alread exists',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
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
                'Create Account',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: AppColors.secondaryColor,
                ),
              ),
              SizedBox(height: 40),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Name',
                        border: UnderlineInputBorder(),
                      ),
                      style: TextStyle(color: AppColors.secondaryColor),
                      controller: nameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your Name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Email Address',
                        border: UnderlineInputBorder(),
                      ),
                      style: TextStyle(color: AppColors.secondaryColor),
                      controller: emailController,
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
                    SizedBox(height: 20),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Username',
                        border: UnderlineInputBorder(),
                      ),
                      style: TextStyle(color: AppColors.secondaryColor),
                      controller: usernameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your Username';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: UnderlineInputBorder(),
                        suffixIcon: Icon(Icons.visibility_off,
                            color: AppColors.secondaryColor),
                      ),
                      obscureText: true,
                      style: TextStyle(color: AppColors.secondaryColor),
                      controller: passwordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your Password';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        border: UnderlineInputBorder(),
                        suffixIcon: Icon(Icons.visibility_off,
                            color: AppColors.secondaryColor),
                      ),
                      obscureText: true,
                      style: TextStyle(color: AppColors.secondaryColor),
                      controller: confirmPasswordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your Confirm Password';
                        }
                        if (confirmPasswordController.text !=
                            passwordController.text) {
                          return 'Password and Confirm Password Not Matched';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: Text(
                        errorMessage,
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.w600),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        createAccount();
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 50),
                        backgroundColor: AppColors.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: Text(
                        'Register',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: Text(
                  "Already have an account?",
                  style: TextStyle(
                      color: AppColors.secondaryColor,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Login",
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
