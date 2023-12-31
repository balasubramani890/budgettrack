import 'package:budgettrack/controller/signup_controller.dart';
import 'package:budgettrack/screen/logout_button_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:budgettrack/screen/login_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../model/signup_request_dto.dart';
import '../service/signup_service.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  SignUpController signUpController = SignUpController();
  SignUpService signUpService = SignUpService();
  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Registration"),
        ),
        body:  Form(
          key : _formKey,
          child: SingleChildScrollView(

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
                      decoration: const InputDecoration(
                        labelText: 'User Name',
                        hintText: 'Enter User Name',
                        prefixIcon: Icon(Icons.person, color: Colors.red,),
                        // errorText: _valName ? 'Please Enter Name' : null,
                      ),
                      // inputFormatters: <TextInputFormatter>[
                      //   FilteringTextInputFormatter.allow(RegExp(r'^[a-z A-Z]+$')),
                      // ],
                      controller: signUpController.nameController,
                      onChanged: (value){
                        _formKey.currentState?.validate();
                      },
                      validator: (value){
                        if(value=="")
                        {
                          return 'Please Enter Name';
                        }
                        else if(!RegExp(r'^[a-z A-Z]+$').hasMatch(value!) && value.length < 10 || value.length > 10)
                        {
                          return 'Please Enter Valid Mobile Number';
                        }
                      },

                    ),

                    const Padding(
                        padding: EdgeInsets.all(10.0)
                    ),

                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Mobile Number',
                        hintText: 'Enter Mobile Number',
                        prefixIcon: Icon(Icons.phone, color: Colors.red,),
                        // errorText: _valMobileNo ? 'Please Enter Mobile Number' : null,
                      ),
                      keyboardType: TextInputType.phone,
                      controller: signUpController.mobileController,
                      onChanged: (value){
                        _formKey.currentState?.validate();
                      },
                      validator: (value){
                        if(value!.isEmpty) {
                          return 'Please Enter Mobile Number';
                        }else if(!RegExp(r'^[0-9]{10}$').hasMatch(value) && value.length < 10 || value.length > 10)
                        {
                          return 'Please Enter Valid Mobile Number';
                        }
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
                      controller: signUpController.passwordController,
                      onChanged: (value){
                        _formKey.currentState?.validate();
                      },
                      validator: (value){
                        if(value=="")
                        {
                          return 'Please Enter Password';
                        }
                        return null;
                      },
                    ),

                    const Padding(
                        padding: EdgeInsets.all(15.0)
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                      children: <Widget>[
                        ElevatedButton(
                          child: const Text('SUBMIT'),

                          onPressed: ()  async{
                            print("Submit Button Clicked");
                            if(_formKey.currentState!.validate())
                            {
                              print("Validation");
                              final registrationData = SignUpRequestDTO(
                                userName: signUpController.nameController.text,
                                mobileNo: signUpController.mobileController.text,
                                password: signUpController.passwordController.text,
                              );

                              final result = await signUpService.registerUser(registrationData);
                              print('Login page Result got $result');

                              if(result != null && result == "Success")
                              {
                               /* Navigator.push(context,
                                  MaterialPageRoute(
                                      builder: (context)=>LoginPage()
                                  ));*/

                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Registration Successful'),
                                      content: Text('Welcome to your app!'),
                                      actions: <Widget>[
                                        TextButton(
                                          child: Text('OK'),
                                          onPressed: () {
                                            Navigator.of(context).pop(); // Close the dialog
                                            // Navigate to the next screen or perform other actions
                                            Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (context) => LoginPage()
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                              else{
                               /* ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text('Mobile No Already Exists!')
                                ));*/

                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('User Already Exists'),
                                      content: Text('Mobile No Already Exists!'),
                                      actions: <Widget>[
                                        TextButton(
                                          child: Text('OK'),
                                          onPressed: () {
                                            Navigator.of(context).pop(); // Close the dialog
                                            // Navigate to the next screen or perform other actions
                                            Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (context) => LoginPage()
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }

                            }

                          },
                        ),

                        ElevatedButton(
                            child:  const Text('CLEAR'),
                            onPressed: (){

                            }
                        ),

                        ElevatedButton(
                          child: const Text('LOGIN'),

                          onPressed: (){
                            Navigator.pop(context);
                          },
                        ),

                      ],
                    )

                  ],
                ),

              ),
            ),

          ),
        )
    );
  }
}