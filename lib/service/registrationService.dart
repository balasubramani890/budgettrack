import 'dart:convert';


import '../model/registrationModel.dart';
import 'package:http/http.dart' as http;

class RegistrationService
{
  final String apiUrl = 'http://192.168.77.202:8080/api/registration/save';
  RegistrationModel registrationModel = RegistrationModel(customerName: '', customerMobile: '', password: '');

  Future<bool?> registerUser(RegistrationModel registrationModel) async {
    print("registerUser Method Started");
    try{
      final response = await http.post(Uri.parse(apiUrl), headers: <String, String>{"Content-Type" : "application/json"},
          body: jsonEncode({"customerName" : registrationModel.customerName, "customerMobile" : registrationModel.customerMobile, "password" : registrationModel.password }));
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