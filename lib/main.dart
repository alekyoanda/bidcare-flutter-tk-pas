import 'package:bidcare/providers/all_barang_lelang.dart';
import 'package:bidcare/screens/Testimoni/testmoni_page.dart';
import 'package:bidcare/screens/dashboard.dart';
import 'package:bidcare/screens/home.dart';
import 'package:bidcare/screens/login.dart';
import 'package:bidcare/screens/register.dart';
import 'package:bidcare/screens/tes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) {
        CookieRequest request = CookieRequest();
        return request;
      },
      child: ChangeNotifierProvider(
        create: (context) {
          return AllBarangLelang();
        },
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'BidCare',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            fontFamily: 'Open Sans',
          ),
          home: const MyHomePage(title: 'BidCare'),
          routes: {
            "/login": (BuildContext context) => const MyLoginPage(),
            "/register": (BuildContext context) => const MyRegisterPage(),
            "/dashboard": (BuildContext context) => MyDashboardPage(),
            "/testimoni": (BuildContext context) => const TestimoniPage(),
          },
        ),
      ),
    );
  }
}
