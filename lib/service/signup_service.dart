import 'dart:convert';


import 'package:budgettrack/common/token_manager.dart';

import '../common/api_service.dart';
import '../model/signup_request_dto.dart';
import 'package:http/http.dart' as http;

class SignUpService
{

  SignUpRequestDTO signUpRequestDTO = SignUpRequestDTO(userName: '', mobileNo: '', password: '');

  Future<String?> registerUser(SignUpRequestDTO signUpRequestDTO) async {
    // final String apiUrl = 'http://192.168.77.202:8080/api';
    // ApiService apiService = ApiService(apiUrl);
    ApiService apiService = ApiService();
    print("registerUser Method Started");
    try{
      final registerResponse= await apiService.post("signup",signUpRequestDTO.toJson());
     /* if(response != null && response.containsKey('data')) {
        print("signup response $response");
        var data = response['data'];
        if (data.containsKey('accessToken')) {
          var accessToken = data['accessToken'];
          print('Access Token: $accessToken');
          // Save the access token securely
          await TokenManager().saveToken('access_token', accessToken.toString());
          return accessToken.toString();
        }
        }
      else {
        print('Invalid Response: $response');
        return null;
      }*/
      if(registerResponse != null  && registerResponse.containsKey('data')
          &&registerResponse['data'].containsKey('resultStatus')) {
        return registerResponse['data']['resultStatus'];
      }
    }
    catch(e)
    {
      print('Exception : registerUser : $e');
    }

  }

}