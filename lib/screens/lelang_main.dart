import 'package:flutter/material.dart';

import '../widgets/my_search_bar.dart';

class MyLelangMainPage extends StatefulWidget {
  const MyLelangMainPage({super.key});

  @override
  State<MyLelangMainPage> createState() => _MyLelangMainPageState();
}

class _MyLelangMainPageState extends State<MyLelangMainPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: const [
          MySearchBar(
            hintText: "Cari Barang Lelang..",
            historyKey: "01",
          ),
        ],
      ),
    );
  }
}
