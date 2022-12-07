import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';

class MyLelangMainPage extends StatefulWidget {
  const MyLelangMainPage({super.key});

  @override
  State<MyLelangMainPage> createState() => _MyLelangMainPageState();
}

class _MyLelangMainPageState extends State<MyLelangMainPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("Lelang"),
    );
  }
}
