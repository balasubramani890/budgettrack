import 'dart:convert';
import 'package:budgettrack/controller/login_controller.dart';
import 'package:budgettrack/screen/dashboard.dart';
import 'package:budgettrack/service/login_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:budgettrack/screen/signup_page.dart';
import 'package:http/http.dart' as http;

import '../model/login_model.dart';
import 'forget_password_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  LoginController loginController = LoginController();
  LoginService loginService = LoginService();
  bool _isLoading = false;

  void clearData()
  {
    loginController.mobileController.clear();
    loginController.passwordController.clear();
  }

  Future<void> _handleLogin(BuildContext context) async {
    setState(() {
      _isLoading = true; // Set loading state to true
    });
  try {
  if (loginController.mobileController != null &&
      loginController.passwordController != null) {
    print("Validation");
    final loginData = LoginModel(
      mobileNo: loginController.mobileController.text,
      password: loginController.passwordController.text,
    );

    final result = await loginService.loginUser(loginData);
    print('Login page Result got $result');

    if (result != null && result == "Success") {
      Navigator.push(context,
        MaterialPageRoute(
            builder: (context) => Dashboard()
        ),
      );

     /* showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Login Successful'),
            content: Text('Welcome to your app!'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                  // Navigate to the next screen or perform other actions
                  Navigator.push(context,
                    MaterialPageRoute(
                        builder: (context) => Dashboard()
                    ),
                  );
                },
              ),
            ],
          );
        },
      );*/

    }
    else {
    /*  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please Login'),
      ));*/


      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Login Failed'),
            content: Text('Please check your credentials and try again.'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                 /* ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Please Login'),
                  ));*/
                },
              ),
            ],
          );
        },
      );
    }
    clearData();
  }
}
catch (error) {
 /* ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text('An error occurred. Please try again later.'),
  ));*/

  print("Error on Login Page: $error");
}
finally {
  setState(() {
    _isLoading = false; // Set loading state to false after the API call
  });
}
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
     /* appBar: AppBar(
        title: const Text("Login"),
      ),*/
      body: SingleChildScrollView(
        // child: Center(
        //   child: Card(
        //      margin: const EdgeInsets.all(50.0),
        //     elevation: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[

                Container(
                  padding: EdgeInsets.all(80.0),
                  alignment: Alignment.center,
                  color: Colors.white, // Customize the color according to your preference
                  child: const Center(
                    child: Text('Login',
                      style: TextStyle(
                        color: Colors.red, // Customize the text color
                        fontSize: 30.0, // Customize the font size
                        fontWeight: FontWeight.bold, // Customize the font weight
                      ),
                    ),
                  ),
                ),

                 const Padding(
                    padding: EdgeInsets.all(0.0),
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Mobile Number',
                    hintText: 'Enter Mobile Number',
                    prefixIcon: Icon(Icons.phone, color: Colors.red,),
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
                    SizedBox(
                      width: 200.0,
                      child: ElevatedButton(
                        child: Text('Sign Up'),

                        onPressed: () async {
                            print("Login Button Clicked");
                            //if (_formKey.currentState!.validate()) {
                            _handleLogin(context);
                        }),
                    ),
                 /*   ElevatedButton(
                        child: Text('CLEAR'),
                        onPressed: (){
                          clearData();
                        }
                    ),*/
                  ],
                ),

                const Padding(
                    padding: EdgeInsets.all(50.0)
                ),

                Center(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              // Navigate to Registration Page
                              Navigator.pushNamed(context, '/registration');
                            },
                            child: Text(
                              'Don\'t have an account? Register here',
                              style: TextStyle(
                                color: Colors.blue,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),


                          /*const Text('Don\'t have Account. '),

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
                          ),*/
                          const Padding(
                            padding: EdgeInsets.all(10.0),
                          ),
                        ],
                      ),
                  ),
                ),


                const Padding(
                    padding: EdgeInsets.all(10.0)
                ),

                Center(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            // Navigate to Registration Page
                            Navigator.pushNamed(context, '/forget_password');
                          },
                          child: Text(
                            'Forget Password?',
                            style: TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                       /* const Text('Forget Password? '),

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
                        ),*/
                      ],
                    ),
                  ),
                )

              ],
            ),
          // ),
        // ),
      ),
    );
  }
}