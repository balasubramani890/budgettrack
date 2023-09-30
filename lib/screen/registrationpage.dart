import 'package:budgettrack/controller/registrationController.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:budgettrack/screen/loginpage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../model/registrationModel.dart';
import '../service/registrationService.dart';

class RegistrationPage extends StatefulWidget {
  RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  RegistrationController registrationController = RegistrationController();
  RegistrationService registrationService = RegistrationService();
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
                      controller: registrationController.nameController,
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
                      controller: registrationController.mobileController,
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
                      controller: registrationController.passwordController,
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
                              final registrationData = RegistrationModel(
                                customerName: registrationController.nameController.text,
                                customerMobile: registrationController.mobileController.text,
                                password: registrationController.passwordController.text,
                              );

                              final result = await registrationService.registerUser(registrationData);

                              print("Result : $result");

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