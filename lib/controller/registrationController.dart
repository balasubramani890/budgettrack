import 'package:budgettrack/model/registrationModel.dart';
import 'package:flutter/material.dart';

class RegistrationController
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