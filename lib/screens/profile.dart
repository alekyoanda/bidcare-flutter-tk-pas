import 'package:flutter/material.dart';

import '../widgets/my_elevated_button.dart';
import '../widgets/my_search_bar.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        child: Align(
          alignment: Alignment.center,
          child: MyElevatedButton(
          text: const Text("Lihat FAQ"),
          backgroundColor: const Color(0xFF0D8C54),
          onPressed: () {
            Navigator.pushNamed(
                context, "/faq_page"); // nebeng dulu buat ngetes
          },
          )
        )
      ),
    );
  }
}
