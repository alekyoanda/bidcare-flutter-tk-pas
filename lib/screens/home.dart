import 'package:bidcare/styles/colors.dart';
import 'package:flutter/material.dart';

import '../widgets/my_elevated_button.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment(0.8, 1),
            colors: <Color>[
              MyColor.whiteGreen,
              MyColor.lightGreen1,
              MyColor.lightGreen2,
              MyColor.green1
            ], // Gradient from https://learnui.design/tools/gradient-generator.html
            tileMode: TileMode.mirror,
          ),
        ),
        // ignore: sort_child_properties_last
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                flex: 5,
                child: Container(
                  padding: const EdgeInsets.only(top: 64),
                  child: const Text(
                    "Bidcare",
                    style: TextStyle(
                        color: Color(0xFF0D8C54),
                        fontSize: 36,
                        letterSpacing: 2),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 32),
                      child: const Text(
                        "Lelang, menggalang dana, dan berdonasi dalam 1 aplikasi",
                        style: TextStyle(
                          fontSize: 22,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      child: MyElevatedButton(
                        text: const Text("Login"),
                        backgroundColor: const Color(0xFF0D8C54),
                        onPressed: () {
                          Navigator.pushNamed(
                              context, "/dashboard"); // p.s: cuman untuk liat hasil, nanti diganti /login 
                        },
                      ),
                    ),
                    MyElevatedButton(
                      text: const Text("Register"),
                      foregroundColor: const Color.fromARGB(255, 7, 37, 1),
                      backgroundColor: const Color.fromARGB(255, 184, 255, 225),
                      onPressed: () {
                        Navigator.pushNamed(context, "/register");
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
