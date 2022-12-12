import 'package:flutter/material.dart';

import '../styles/colors.dart';

import 'package:provider/provider.dart';
 import 'package:pbp_django_auth/pbp_django_auth.dart';



class MyRegisterPage extends StatefulWidget {
  const MyRegisterPage({super.key});

  @override
  State<MyRegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<MyRegisterPage> {
  final _loginFormKey = GlobalKey<FormState>();
  bool isPasswordVisible = false;
  void togglePasswordView() {
    setState(() {
      isPasswordVisible = !isPasswordVisible;
    });
  }
  var list = ['MANDIRI', 'BNI', 'BRI', 'BCA'];
  static String first_name = "";
  static String last_name = "";
  static String email = "";
  static String username = "";
  static String password = "";
  static String nomor_ponsel = "";
  static String nama_bank = 'MANDIRI';
  static String no_rekening = "";
  static String nama_pemilik = "";
  String pesan = "";
  
  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
            backgroundColor: MyColor.whiteGreen,
            appBar: AppBar(
              title: Text('Register'),
              backgroundColor: MyColor.lightGreen2,
            ),
            body: Center(
              child: ListView(
                // crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 70),
                    child: Text(
                      "Register",
                      style: TextStyle(
                        fontSize: 60,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  ),
                  Center(
                    child:Container(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(90.0),
                        ),
                        labelText: 'First Name',
                      ),
                      onChanged: (String? value) {
                            setState(() {
                                first_name = value!;
                            });
                      },
                      onSaved: (String? value) {
                            setState(() {
                                first_name = value!;
                            });
                      },
                    ),
                  ),
                  ),
                  Center(child: 
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(90.0),
                        ),
                        labelText: 'Last Name',
                      ),
                      onChanged: (String? value) {
                            setState(() {
                                last_name= value!;
                            });
                      },
                      onSaved: (String? value) {
                            setState(() {
                                last_name = value!;
                            });
                      },
                    ),
                  ),
                  ),
                  Center(
                    child:
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(90.0),
                        ),
                        labelText: 'Email',
                      ),
                      onChanged: (String? value) {
                            setState(() {
                                email = value!;
                            });
                      },
                      onSaved: (String? value) {
                            setState(() {
                                email = value!;
                            });
                      },
                    ),
                  ),
                  ),
                  Center( child :
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
                  ),
                  Center(child:
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
                            setState(() {
                                password = value!;
                            });
                      },
                      onSaved: (String? value) {
                            setState(() {
                                password = value!;
                            });
                      },
                    ),
                  ),
                  ),
                  Center(child:
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(90.0),
                        ),
                        labelText: 'No Ponsel',
                      ),
                      onChanged: (String? value) {
                            setState(() {
                                nomor_ponsel= value!;
                            });
                      },
                      onSaved: (String? value) {
                            setState(() {
                                nomor_ponsel = value!;
                            });
                      },
                    ),
                  ),
                  ),
                  Center(child:
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: DropdownButton(
                      value: nama_bank,
                      icon: const Icon(Icons.keyboard_arrow_down),   
                      items: list.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                            setState(() {
                                nama_bank= value!;
                            });
                      },
                    ),
                  ),
                  ),
                  Center(child:
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(90.0),
                        ),
                        labelText: 'Nomor Rekening',
                      ),
                      onChanged: (String? value) {
                            setState(() {
                                no_rekening= value!;
                            });
                      },
                      onSaved: (String? value) {
                            setState(() {
                                no_rekening = value!;
                            });
                      },
                    ),
                  ),
                  ),
                  Center(child:
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(90.0),
                        ),
                        labelText: 'Nama Pemilik',
                      ),
                      onChanged: (String? value) {
                            setState(() {
                                nama_pemilik= value!;
                            });
                      },
                      onSaved: (String? value) {
                            setState(() {
                                nama_pemilik = value!;
                            });
                      },
                    ),
                  ),
                  ),
                  Center(child:
                  Container(
                      height: 80,
                      padding: const EdgeInsets.all(20),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(50),
                          backgroundColor: MyColor.darkGreen,
                        ),
                        child: const Text('Register'),
                        onPressed: () async {
                          print("cek");
                          final response = await request.post(
                          'https://bidcare.up.railway.app/register_flutter/',
                          // 'https://ecoist.up.railway.app/flutter_login/', 
                          // "http//127.0.0.1:8000/login_flutter",
                          {
                            'first_name': first_name,
                            'last_name': last_name,
                            'email': email,
                            'username': username,
                            'password': password,
                            'no_ponsel': nomor_ponsel,
                            'nama_bank': nama_bank,
                            'no_rekening': no_rekening,
                            'nama_pemilik': nama_pemilik
                          }
                          ); 
                    
                          print(response['username']);
                          print(response['status']);
                          if (response['status'] == true) {
                            setState(() {
                                pesan = "";
                            });
                            Navigator.pop(context);
                          // Code here will run if the login succeeded.
                          } else {
                            setState(() {
                                pesan = response['message'];
                            });
                          // Code here will run if the login failed (wrong username/password).
                          }
                        },
                      )),),

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