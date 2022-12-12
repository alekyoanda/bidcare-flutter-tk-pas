import 'package:bidcare/screens/Testimoni/testmoni_page.dart';
import 'package:bidcare/screens/dashboard/lihat_lelang.dart';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

import '../../styles/colors.dart';
import '../../widgets/my_elevated_button.dart';
import 'lihat_galang.dart';

class DashboardMainPage extends StatefulWidget {
  const DashboardMainPage({super.key});

  @override
  State<DashboardMainPage> createState() => _DashboardMainPageState();
}

class _DashboardMainPageState extends State<DashboardMainPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
          Container(
              margin: const EdgeInsets.only(bottom: 80, left: 15, right: 15),
              child: Column(
                children: [
                  Center(
                    child: Text(
                      "Selamat Datang di Bidcare :)",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: MyColor.darkGreen,
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        "Aplikasi ini bertujuan untuk membantu masyarakat yang membutuhkan donasi berupa uang, dimana uang donasinya didapatkan melalui hasil lelang barang. Selain itu, aplikasi ini juga dapat menjadi platform jual beli barang lelang yang 70% hasil dari penjualan barang lelang akan disumbangkan kepada galang dana yang dipilih.",
                        style:
                            TextStyle(fontSize: 14, color: MyColor.darkGreen),
                      ),
                    ),
                  )
                ],
              )),
          Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    width: 250,
                    margin:
                        const EdgeInsets.only(bottom: 16, left: 15, right: 15),
                    child: Align(
                        alignment: Alignment.center,
                        child: MyElevatedButton(
                          text: const Text("Lihat Lelang Saya"),
                          backgroundColor: const Color(0xFF0D8C54),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const LihatLelang())); // nebeng dulu buat ngetes
                          },
                        ))),
                Container(
                    width: 250,
                    margin: const EdgeInsets.only(bottom: 16),
                    child: Align(
                        alignment: Alignment.center,
                        child: MyElevatedButton(
                          text: const Text("Lihat Galang Saya"),
                          backgroundColor: const Color(0xFF0D8C54),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const LihatGalang())); // nebeng dulu buat ngetes
                          },
                        ))),
              ]),
          Container(
              margin: const EdgeInsets.only(top: 50, left: 15, right: 15),
              child: MyElevatedButton(
                text: const Text("Lihat Testimoni"),
                backgroundColor: const Color(0xFF0D8C54),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const TestimoniPage())); // nebeng dulu buat ngetes
                },
              )),
        ])));
  }
}
