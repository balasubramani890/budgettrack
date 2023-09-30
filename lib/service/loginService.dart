import 'dart:convert';
import 'package:budgettrack/model/loginModel.dart';
import '../model/registrationModel.dart';
import 'package:http/http.dart' as http;

class LoginService
{


  LoginModel loginModel = LoginModel(customerMobile: '', password: '');

  Future<String?> loginUser(LoginModel loginModel) async {
    const String apiUrl = 'http://192.168.77.202:8080/api/registration/login';
    print("loginUser Method Started");
    try{
      print('$apiUrl?customerMobile=${loginModel.customerMobile}&password=${loginModel.password}');
        final response = await http.get(Uri.parse(
            '$apiUrl?customerMobile=${loginModel.customerMobile}&password=${loginModel.password}'),
          headers: <String, String>{'Content-Type': 'application/json'});
        print('Connection Status : ${response.statusCode}');

        if (response != null && response.statusCode == 200) {
          print('Connection Status : OK');
          String customerId = response.body;
          print('Login Result: $customerId');
          return customerId;
        }

      else{
        print('Connection Status : NOT OK');
        return "Invalid Mobile No or Password";
      }
    }
    catch(e)
    {
      print('Exception : loginUser : $e');
    }
    return null;

  }

  Future<String?> getForgottenPassword(String mobileNumber) async {
    const String apiUrl = 'http://192.168.77.202:8080/api/registration/forgetpassword';
    try {
      final response = await http.get(Uri.parse(
          '$apiUrl?customerMobile=${mobileNumber}'),
          headers: <String, String>{'Content-Type': 'application/json'});

      print('$apiUrl?customerMobile=${mobileNumber}');

      if (response != null && response.statusCode == 200) {
        print('Connection Status : OK');
        String password = response.body;
        print('Login Result: $password');
        return password;
      }

      else {
        print('Connection Status : NOT OK');
        return "Invalid Mobile No or Password";
      }
    }
    catch(e)
    {
      print('Exception : getForgottenPassword : $e');
    }
    return null;
  }

}