import 'package:budgettrack/model/signup_request_dto.dart';
import 'package:flutter/material.dart';

class SignUpController
{

  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController passwordController = TextEditingController();


  void dispose() {
    nameController.dispose();
    mobileController.dispose();
    passwordController.dispose();
  }
}