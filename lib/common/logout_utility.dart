import 'package:budgettrack/common/token_manager.dart';
import 'package:budgettrack/screen/login_page.dart';
import 'package:flutter/material.dart';

import 'api_service.dart';

class LogoutUtility {
  static void handleLogout(BuildContext context) async{
    // Implement your logout logic here
    print('Logout button pressed');
    // Add logic to navigate to the login page or perform any other actions after logout.
    try {
       await ApiService().logout();
      // Navigate to the login screen or any other screen after successful logout
      // Navigator.pushReplacementNamed(context, '/login');
      Navigator.push(context,
        MaterialPageRoute(
            builder: (context) => LoginPage()
        ),
      );
    } catch (e) {
      print('Error during logout: $e');
      // Handle logout error if necessary
    }
  }
}