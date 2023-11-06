import 'dart:convert';
import 'package:http/http.dart' as http;
import 'token_manager.dart';

class ApiService {
  // final String baseUrl ='http://192.168.77.202:8080/api';
  final String baseUrl ='http://192.168.162.202:8080/api';

  // ApiService(this.baseUrl);

  /*Future<Map<String, dynamic>> signUp(Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse('$baseUrl/signup'), // Replace with your signup endpoint
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );
    return _handleSignUpResponse(response);
  }

  Future<Map<String, dynamic>> login(Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'), // Replace with your login endpoint
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );
    return _handleLoginResponse(response);
  }*/

 /* Future<Map<String, dynamic>> _handleSignUpResponse(http.Response response) async {
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      // Extract and set the access token during signup
      String? accessToken = jsonResponse['data']['accesstoken'];
      if (accessToken != null) {
        await TokenManager().saveToken('access_token', accessToken);
      }
      return jsonResponse;
    } else {
      throw Exception('Failed to sign up');
    }
  }

  Future<Map<String, dynamic>> _handleLoginResponse(http.Response response) async {
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      // Extract and set the access token during login
      String? accessToken = jsonResponse['data']['accesstoken'];
      if (accessToken != null) {
        await TokenManager().saveToken('access_token', accessToken);
      }
      return jsonResponse;
    } else {
      throw Exception('Failed to log in');
    }
  }*/

  Future<Map<String, dynamic>> get(String endpoint) async {
    final response = await http.get(
      Uri.parse('$baseUrl/$endpoint'),
      headers: await _buildHeaders(),
    );
    return _handleResponse(response);
  }

  Future<Map<String, dynamic>> post(String endpoint, Map<String, dynamic> body) async {
    final response = await http.post(
      Uri.parse('$baseUrl/$endpoint'),
      headers: await _buildHeaders(),
      body: jsonEncode(body),
    );

    return _handleResponse(response);
  }

  Future<Map<String, String>> _buildHeaders() async {
    Map<String, String> headers = {'Content-Type': 'application/json'};
    final accessToken = await _getAccessToken();
    if (accessToken != null) {
      // print("Access Token : $accessToken");
      headers['authorization'] = '$accessToken';
    }
    return headers;
  }

  Future<String?> _getAccessToken() async {
    return TokenManager().getToken('access_token');
  }

  Future<Map<String, dynamic>> _handleResponse(http.Response response) async {
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      // Extract and set the access token during login
      Map<String, dynamic> tokenCheckMap = jsonResponse['data'];
        print("handle response started");
        if (tokenCheckMap.containsKey('accessToken')) {
          print('accesstoken apiservice');
          await TokenManager().saveToken('access_token', tokenCheckMap['accessToken']);
          return jsonResponse;
        }
       else {
          return jsonResponse;
        }
    }
    else {
      print('Connection Error : $response.statusCode');
      throw Exception('$response.statusCode');
    }
  }

  Future<void> logout() async {
    print("Logout Method");
    try {
      final deleteToken = await TokenManager().getToken('access_token');
      if (deleteToken != null && deleteToken.isNotEmpty) {
        await TokenManager().deleteToken(deleteToken as String);
        print("Token Cleared");
      }
      else {
        print("Token is null or empty. Not cleared.");
        // Handle the case where the token is null or empty if necessary
      }
    }
    catch(e)
    {
      print("Error during logout: $e");
    }

    }



}
