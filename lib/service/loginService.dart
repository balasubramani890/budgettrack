import 'dart:convert';
import 'package:budgettrack/model/loginModel.dart';
import '../model/registrationModel.dart';
import 'package:http/http.dart' as http;

class LoginService
{
  final String apiUrl = 'http://192.168.77.202:8080/api/registration/login';

  LoginModel loginModel = LoginModel(customerMobile: '', password: '');

  Future<String?> loginUser(LoginModel loginModel) async {
    print("loginUser Method Started");
    try{
      print('$apiUrl?customerMobile=${loginModel.customerMobile}&password=${loginModel.password}');
        final response = await http.get(Uri.parse(
            '$apiUrl?customerMobile=${loginModel.customerMobile}&password=${loginModel.password}'),
          headers: <String, String>{'Content-Type': 'application/json'});
        print('Connection Status : ${response.statusCode}');

        if (response != null && response.statusCode == 200) {
          print('Connection Status : OK');
          String result = response.body;
          print('Login Result: $result');
          return result;
        }

      else{
        print('Connection Status : NOT OK');
        return "Invalid Mobile No or Password";
      }
    }
    catch(e)
    {
      print('Exception : $e');
    }

  }

}