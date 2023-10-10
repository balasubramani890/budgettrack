import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

class LoginModel
{
  String? mobileNo;
  String? password;


  LoginModel({
    required this.mobileNo,
    required this.password
  });

  Map<String, dynamic> toJson() {
    return {
      'mobileNo': mobileNo,
      'password': password,
    };
  }

}