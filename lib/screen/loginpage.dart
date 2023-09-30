import 'dart:convert';
import 'package:budgettrack/controller/loginController.dart';
import 'package:budgettrack/screen/dashboard.dart';
import 'package:budgettrack/service/loginService.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:budgettrack/screen/registrationpage.dart';
import 'package:http/http.dart' as http;

import '../model/loginModel.dart';
import 'forgetPasswordPage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  LoginController loginController = LoginController();
  LoginService loginService = LoginService();

  void clearData()
  {
    loginController.mobileController.clear();
    loginController.passwordController.clear();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Card(
            margin: const EdgeInsets.all(25.0),
            elevation: 0,

            child: Column(
              children: <Widget>[
                const Padding(
                    padding: EdgeInsets.all(10.0)
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Mobile Number',
                    hintText: 'Enter Mobile Number',
                    prefixIcon: const Icon(Icons.phone, color: Colors.red,),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$')),
                  ],
                  controller: loginController.mobileController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter mobile number';
                    }
                    return null;
                  },
                ),

                const Padding(
                    padding: EdgeInsets.all(10.0)
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    hintText: 'Enter Password',
                    prefixIcon: Icon(Icons.password, color: Colors.red,),
                  ),
                  controller: loginController.passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter password';
                    }
                    return null;
                  },
                ),
                const Padding(
                    padding: EdgeInsets.all(20.0)
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                  children: <Widget>[
                    ElevatedButton(
                      child: Text('Login'),

                      onPressed: () async {
                          print("Login Button Clicked");
                          //if (_formKey.currentState!.validate()) {
                          if(loginController.mobileController != null && loginController.passwordController != null){
                            print("Validation");
                            final loginData = LoginModel(
                              customerMobile: loginController.mobileController.text,
                              password: loginController.passwordController.text,
                            );

                            final result = await loginService.loginUser(loginData);
                            print('Change page $result');

                            if(result != null && int.tryParse(result) != null && int.parse(result) > 0)
                              {
                                Navigator.push(context,
                                  MaterialPageRoute(
                                      builder: (context)=>Dashboard()
                                  ),
                                );
                              }
                            else{
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text('Please Login'),
                              ));

                            }

                            print("Result : $result");
                            clearData();

                          }
                      }),

                    ElevatedButton(
                        child: Text('CLEAR'),
                        onPressed: (){
                          clearData();
                        }
                    ),

                  ],
                ),

                const Padding(
                    padding: EdgeInsets.all(10.0)
                ),

                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text('Don\'t have Account. '),

                      ElevatedButton(
                        child: const Text('Register'),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RegistrationPage(),
                            ),
                          );
                          clearData();
                        },
                      ),
                      const Padding(
                        padding: EdgeInsets.all(10.0),
                      ),
                    ],
                  ),
                ),

                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text('Forget Password? '),

                      ElevatedButton(
                        child: const Text('Forget Password'),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ForgetPasswordPage(),
                            ),
                          );
                          clearData();
                        },
                      ),
                    ],
                  ),
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}