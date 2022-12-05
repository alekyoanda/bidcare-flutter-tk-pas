import 'package:bidcare/screens/home.dart';
import 'package:bidcare/screens/login.dart';
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
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'Open Sans',
        ),
        home: const MyHomePage(title: 'Flutter App'),
        routes: {
          "/login": (BuildContext context) => const MyLoginPage(),
        },
      ),
    );
  }
}
