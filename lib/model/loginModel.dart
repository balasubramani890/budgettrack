import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';
// part 'login_model.g.dart';

@JsonSerializable()
class LoginModel
{
  String? mobileNo;
  String? password;


  LoginModel({
    required this.mobileNo,
    required this.password
  });

  // Factory method to create a User instance from JSON
  // factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() {
    return {
      'mobileNo': mobileNo,
      'password': password,
    };
  }
  //  factory LoginModel.fromJson(Map<String, dynamic> json) => _$LoginModelFromJson(json);

}