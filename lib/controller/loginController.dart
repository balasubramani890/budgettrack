import 'package:budgettrack/model/SignUpRequestDTO.dart';
import 'package:flutter/material.dart';

class LoginController
{

  TextEditingController mobileController = TextEditingController();
  TextEditingController passwordController = TextEditingController();


  void dispose() {
    mobileController.dispose();
    passwordController.dispose();
  }
}