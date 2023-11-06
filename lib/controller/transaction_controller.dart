import 'package:budgettrack/model/signup_request_dto.dart';
import 'package:flutter/material.dart';

class TransactionController
{

  TextEditingController tDateController = TextEditingController();
  TextEditingController tDescription = TextEditingController();
  TextEditingController tAmount = TextEditingController();
  TextEditingController tCategory = TextEditingController();
  TextEditingController tPaymentMethod = TextEditingController();

  void dispose() {
    tDateController.dispose();
    tDescription.dispose();
    tAmount.dispose();
    tCategory.dispose();
    tPaymentMethod.dispose();
  }
}