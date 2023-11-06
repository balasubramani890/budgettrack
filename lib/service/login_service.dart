import 'dart:convert';
import 'package:budgettrack/common/api_service.dart';
import 'package:budgettrack/model/login_model.dart';
import '../common/token_manager.dart';
import '../model/signup_request_dto.dart';
import 'package:http/http.dart' as http;

class LoginService
{
  LoginModel loginModel = LoginModel(mobileNo: '', password: '');
  // static const String apiUrl = 'http://192.168.162.202:8080/api';

  Future<String?> loginUser(LoginModel loginModel) async {

    // ApiService apiService = ApiService(apiUrl);
    ApiService apiService = ApiService();
    print("loginUser Method Started");
    try{
      final loginResponse= await apiService.post("login", loginModel.toJson());

      if(loginResponse != null  && loginResponse.containsKey('data')
          &&loginResponse['data'].containsKey('resultStatus')) {

        return loginResponse['data']['resultStatus'];
        }
    }
    catch(e)
    {
      print('Exception : loginUser : $e');
    }

  }

   Future<String?> forgottenPassword(String mobileNo) async {
    /*const String apiUrl = 'http://192.168.77.202:8080/api/registration/forgetpassword';
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
     return null;*/

     // const String apiUrl = 'http://192.168.77.202:8080/api';
     // ApiService apiService = ApiService(apiUrl);
     ApiService apiService = ApiService();
     print("forget password Method Started");
     try{
       Map<String, dynamic> requestPayload = {
         'mobileNo': mobileNo,
       };
       final loginResponse= await apiService.post("forgetpassword", requestPayload);

       if(loginResponse != null  && loginResponse.containsKey('data')
           && loginResponse['data'].containsKey('resultStatus')) {

         return loginResponse['data']['resultValue'];
       }
     }
     catch(e)
     {
       print('Exception : loginUser : $e');
     }
   }

}