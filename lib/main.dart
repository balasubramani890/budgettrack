import 'package:budgettrack/screen/forget_password_page.dart';
import 'package:budgettrack/screen/login_page.dart';
import 'package:budgettrack/screen/signup_page.dart';
import 'package:budgettrack/service/test_signup.dart';
import 'package:flutter/material.dart';

void main()
{
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/', // default route
      routes: {
        '/': (context) => LoginPage(), // Login Page
        '/registration': (context) => RegistrationPage(), // Registration Page
        '/forget_password': (context) => ForgetPasswordPage(), // Forget Password Page
        // Add more routes as needed
      },

      theme: ThemeData(
        primarySwatch: Colors.red
      ),
      // home: const LoginPage(),
    );
  }

}
