import 'package:flutter/material.dart';
import '../common/logout_utility.dart';

class LogoutButtonPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.exit_to_app),
      onPressed: () {
        LogoutUtility.handleLogout(context); // Pass the context here
      },
    );
  }
}
