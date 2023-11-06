import 'package:budgettrack/screen/signup_page.dart';
import 'package:budgettrack/service/login_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../controller/login_controller.dart';
import '../model/login_model.dart';
import 'login_page.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  LoginController loginController = LoginController();
  LoginService loginService = LoginService();

  void clearData()
  {
    loginController.mobileController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Forget Password"),
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
                    padding: EdgeInsets.all(20.0)
                ),


                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                  children: <Widget>[
                    ElevatedButton(
                      child: Text('Get Password'),
                      onPressed: () async {
                        if (loginController.mobileController != null) {
                          String mobileNo = loginController.mobileController.text;
                          try {
                            String? password = await loginService.forgottenPassword(mobileNo);
                            if (password != null) {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text('Your password: $password'),
                              ));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text('Mobile number not available'),
                              ));
                            }
                            clearData();
                          } catch (e) {
                            print('Error: $e');
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Failed to retrieve forgotten password'),
                            ));
                          }
                        }
                      },
                    ),

                    ElevatedButton(
                        child: Text('CLEAR'),
                        onPressed: (){
                          clearData();
                        }
                    ),

                    ElevatedButton(
                        child: Text('Login'),
                        onPressed: (){
                          Navigator.push(context,
                            MaterialPageRoute(
                                builder: (context)=>LoginPage()
                            ),
                          );
                          clearData();
                        }
                    ),

                  ],
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
