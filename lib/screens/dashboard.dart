import 'package:bidcare/screens/dashboard/dashboard_main.dart';
import 'package:bidcare/screens/lelang/lelang_main.dart';
import 'package:bidcare/screens/Galang/galang_main.dart';
import 'package:bidcare/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

import '../widgets/my_elevated_button.dart';
import 'Testimoni/testmoni_page.dart';
import 'profile.dart';

class MyDashboardPage extends StatefulWidget {
  @override
  _MyDashboardPageState createState() => _MyDashboardPageState();
}

class _MyDashboardPageState extends State<MyDashboardPage> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    DashboardMainPage(),
    MyLelangMainPage(),
    MyGalangMainPage(),
    ProfilePage(),
    // Text(
    //   'Profile: Di profile nanti ada button untuk FAQ',
    //   style: optionStyle,
    //   textAlign: TextAlign.center,
    // ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.whiteGreen,
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: MyColor.lightGreen2,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.15),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: MyColor.lightGreen1,
              hoverColor: MyColor.lightGreen1,
              gap: 8,
              activeColor: Colors.black,
              iconSize: 24,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
              duration: const Duration(milliseconds: 400),
              tabBackgroundColor: MyColor.whiteGreen,
              color: Colors.black,
              tabs: const [
                GButton(
                  icon: Icons.home,
                  text: 'Dashboard',
                ),
                GButton(
                  icon: Icons.gavel_rounded,
                  text: 'Lelang',
                ),
                GButton(
                  icon: Icons.monetization_on_rounded,
                  text: 'Galang Dana',
                ),
                GButton(
                  icon: Icons.person,
                  text: 'Profile',
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
