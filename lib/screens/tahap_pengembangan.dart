import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class MyTahapPengembanganPage extends StatelessWidget {
  const MyTahapPengembanganPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Coming Soon"),
        ),
        body: Center(
          child: Text(
            "Maaf, fitur ini masih dalam tahap pengembangan :)",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 32),
          ),
        ));
  }
}
