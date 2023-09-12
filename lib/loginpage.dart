import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:budgettrack/registrationpage.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

Future<List> getData() async
{
  print("RegistrationPage:getData(): Started");
  var url = "http://192.168.63.202/API/getdata.php";
  final response = await http.get(Uri.parse(url));
  var dataReceived = json.decode(response.body);
  // print(dataReceived);
  return dataReceived;
}

class _LoginPageState extends State<LoginPage> {
  final tMobileNo = TextEditingController();
  final tPassword = TextEditingController();

  bool _valMobileNo = false;
  bool _valPassword = false;

  void dispose()
  {
    tMobileNo.dispose();
    tPassword.dispose();
  }

  void clearData()
  {
    tMobileNo.clear();
    tPassword.clear();
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
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Mobile Number',
                    hintText: 'Enter Mobile Number',
                    prefixIcon: const Icon(Icons.phone, color: Colors.red,),
                    errorText: _valMobileNo ? 'Please Enter Mobile Number' : null,
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$')),
                  ],
                  controller: tMobileNo,
                ),

                const Padding(
                    padding: EdgeInsets.all(10.0)
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Password',
                    hintText: 'Enter Password',
                    prefixIcon: const Icon(Icons.password, color: Colors.red,),
                    errorText: _valPassword ? 'Please Enter Password' : null,
                  ),
                  controller: tPassword,
                ),
                const Padding(
                    padding: EdgeInsets.all(20.0)
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                  children: <Widget>[
                    ElevatedButton(
                      child: Text('Login'),

                      onPressed: (){
                        setState(() {
                          tMobileNo.text.isEmpty ? _valMobileNo = true : _valMobileNo = false;
                          tPassword.text.isEmpty ? _valPassword = true : _valPassword = false;
                          if(_valMobileNo == false && _valPassword == false)
                          {
                            clearData();
                          }
                        });
                      },
                    ),

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

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text('Don\'t have Account. '),

                    ElevatedButton(
                        child: const Text('Register'),
                        onPressed: (){
                          Navigator.push(context,
                            MaterialPageRoute(
                                builder: (context)=>RegistrationPage()
                            ),
                          );
                        }
                    )



                  ],
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}