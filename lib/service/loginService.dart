import 'dart:convert';
import 'package:budgettrack/model/loginModel.dart';
import '../model/SignUpRequestDTO.dart';
import 'package:http/http.dart' as http;

class LoginService
{
  LoginModel loginModel = LoginModel(mobileNo: '', password: '');

  Future<String?> loginUser(LoginModel loginModel) async {
    const String apiUrl = 'http://192.168.77.202:8080/api/login';
    final String jsonBody = jsonEncode(loginModel.toJson());
        print("loginUser Method Started");
    try{
      final response = await http.post(Uri.parse(apiUrl),
          headers: <String, String>{'Content-Type': 'application/json'},
      body: jsonBody);
        print('Connection Status : ${response.statusCode}');

         if (response != null && response.statusCode == 200) {

          print('Connection Status : OK');
          final Map<String, dynamic> responseData = json.decode(response.body);
          String accessToken = responseData['data']['accessToken'];
          print('Login Result: body : ${accessToken}');
          return response.body;
        }

      else{
        print('Connection Status : NOT OK');
        print('fail :response body : ${response.body}');
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