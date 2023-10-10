import 'dart:convert';


import '../model/SignUpRequestDTO.dart';
import 'package:http/http.dart' as http;

class RegistrationService
{
  final String apiUrl = 'http://192.168.77.202:8080/api/signup';
  SignUpRequestDTO signUpRequestDTO = SignUpRequestDTO(userName: '', mobileNo: '', password: '');

  Future<bool?> registerUser(SignUpRequestDTO signUpRequestDTO) async {
    print("registerUser Method Started");
    try{
      String jsonBody = jsonEncode(signUpRequestDTO.toJson());
      final response = await http.post(Uri.parse(apiUrl), headers: <String, String>{"Content-Type" : "application/json"},
          body: jsonBody);
      if(response.statusCode == 200)
        {
          print('Connection Status : OK');
          var result = response.body;
          if(result == "true")
          {
            print("Success : $result");
            return true;
          }
          else
          {
            print("Failed Due to : $result");
            return false;
          }
        }
      else{
        print('Connection Status : NOT OK');
      }
    }
    catch(e)
    {
      print('Exception : $e');
    }

  }

}