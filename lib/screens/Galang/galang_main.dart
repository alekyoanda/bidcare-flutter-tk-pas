import 'package:bidcare/screens/Galang/buat_galang.dart';
import 'package:bidcare/screens/Galang/daftar_galang.dart';
import 'package:bidcare/styles/colors.dart';
import 'package:flutter/material.dart';

import '../../widgets/my_elevated_button.dart';

class MyGalangMainPage extends StatefulWidget {
  const MyGalangMainPage({super.key});

  @override
  State<MyGalangMainPage> createState() => _MyGalangMainPageState();
}

class _MyGalangMainPageState extends State<MyGalangMainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.whiteGreen,
      body: Container(
        // ignore: sort_child_properties_last
        child: SafeArea(
          child: Column(
            children: [
              Container(
                  padding: const EdgeInsets.only(top: 200),
                  child: Image.asset('assets/imageGalang/helpp.png',
                    height: 50,
                    scale: 2.5,
                    opacity: const AlwaysStoppedAnimation<double>(0.5)
                ),
              ), 
              Expanded(
                // flex: 5,
                child: Container(
                  padding: const EdgeInsets.only(top: 10),
                  child: const Text(
                    "#SayaButuhBantuan",
                    style: TextStyle(
                        color: Color(0xFF0D8C54),
                        fontSize: 24,
                        letterSpacing: 2),
                        textAlign: TextAlign.center,
                  ),
                ),
              ),
              Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      child: MyElevatedButton(
                        text: const Text("Daftar Galang Dana"),
                        backgroundColor: const Color(0xFF0D8C54),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const MyDaftarGalangPage()));
                        },
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 200),
                      child: MyElevatedButton(
                      text: const Text("Buat Galang Dana"),
                      foregroundColor: const Color.fromARGB(255, 7, 37, 1),
                      backgroundColor: const Color.fromARGB(255, 184, 255, 225),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const MyBuatGalangPage()));
                        },
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
