import 'package:flutter/material.dart';

import '../styles/colors.dart';
import '../widgets/my_elevated_button.dart';
import 'package:provider/provider.dart';
 import 'package:pbp_django_auth/pbp_django_auth.dart';

class MyLoginPage extends StatefulWidget {
  const MyLoginPage({super.key});

  @override
  State<MyLoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<MyLoginPage> {
  final _loginFormKey = GlobalKey<FormState>();
  bool isPasswordVisible = false;
  void togglePasswordView() {
    setState(() {
      isPasswordVisible = !isPasswordVisible;
    });
  }

  String username = "";
  String password1 = "";
  String pesan = "";
  
  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
            backgroundColor: MyColor.whiteGreen,
            appBar: AppBar(
              title: Text('Login'),
              backgroundColor: MyColor.lightGreen2,
            ),
            body: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 70),
                    child: Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 60,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(90.0),
                        ),
                        labelText: 'Username',
                      ),
                      onChanged: (String? value) {
                            setState(() {
                                username = value!;
                            });
                      },
                      onSaved: (String? value) {
                            setState(() {
                                username = value!;
                            });
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(90.0),
                        ),
                        labelText: 'Password',
                      ),
                      onChanged: (String? value) {
                            print(value);
                            setState(() {
                                password1 = value!;
                            });
                      },
                      onSaved: (String? value) {
                            print(value);
                            setState(() {
                                password1 = value!;
                            });
                      },
                    ),
                  ),
                  Container(
                      height: 80,
                      padding: const EdgeInsets.all(20),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(50),
                          backgroundColor: MyColor.darkGreen,
                        ),
                        child: const Text('Login'),
                        onPressed: () async {
                          print("cek");
                          final response = await request.post(
                          'https://bidcare.up.railway.app/login_flutter/',
                          // 'https://ecoist.up.railway.app/flutter_login/', 
                          // "http//127.0.0.1:8000/login_flutter",
                          {
                            'username': username,
                            'password': password1,
                          }
                          ); 
                    
                          print(response['status']);
                          if (response['status'] == true) {
                            setState(() {
                                pesan = "";
                            });
                            Navigator.pushNamed(context, "/dashboard");
                          // Code here will run if the login succeeded.
                          } else {
                            setState(() {
                                pesan = response['message'];
                            });
                          // Code here will run if the login failed (wrong username/password).
                          }
                        },
                      )),

                  Text(
                    pesan,
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Register?',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ),
                ],
              ),
            ));
  }
}