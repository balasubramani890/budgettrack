import 'package:flutter/material.dart';
import 'package:budgettrack/loginpage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


Future _saveDetails(String name, String mobileNo, String password) async
{
  var url = "http://192.168.63.202/API/saveData.php";
  final response = await http.post(Uri.parse(url), body: {"name" : name, "mobileno" : mobileNo, "password" : password });
  var result = response.body;
  if(result == "true")
  {
    print("Success");
    return true;
  }
  else
  {
    print("Error Result : " +result);
    return false;
  }
}

class RegistrationPage extends StatefulWidget {
  RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  // RegistrationPage()
  final tName = TextEditingController();
  final tMobileNo = TextEditingController();
  final tPassword = TextEditingController();

  void dispose()
  {
    tName.dispose();
    tMobileNo.dispose();
    tPassword.dispose();
  }

  void clearData()
  {
    tName.clear();
    tMobileNo.clear();
    tPassword.clear();
  }

  Future showOkMessage(BuildContext context, String message) async
  {
    return showDialog(
      context: context,

      builder: (context)=> AlertDialog(
        title: Text(message),

        actions: <Widget>[
          ElevatedButton(
            child: const Text("OK"),
            onPressed: (){
              Navigator.pop(context);
            },
          )

        ],
      ),
    );
  }

  Future showYnMessage(BuildContext context, String message) async
  {
    return showDialog(
      context: context,

      builder: (context)=> AlertDialog(
        title: Text(message),

        actions: <Widget>[
          ElevatedButton(
            child: const Text("Ok"),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>const LoginPage()));
            },
          ),

          ElevatedButton(
            child: const Text("Cancel"),
            onPressed: (){
              Navigator.pop(context);
            },
          )

        ],
      ),
    );
  }

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
                      controller: tName,
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
                        return null;
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
                      controller: tMobileNo,
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
                      controller: tPassword,
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
                            if(_formKey.currentState!.validate())
                            {
                              final resultStatus = await _saveDetails(tName.text, tMobileNo.text, tPassword.text);
                              if(resultStatus==true)
                              {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>const LoginPage()));
                              }
                              else
                              {
                                showYnMessage(context, 'Mobile Number already Exists. Press Ok to Login or Cancel to Continue');
                              }
                            }

                          },
                        ),

                        ElevatedButton(
                            child:  const Text('CLEAR'),
                            onPressed: (){
                              clearData();
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