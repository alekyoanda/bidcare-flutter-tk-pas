import 'package:bidcare/screens/lelang_main.dart';
import 'package:bidcare/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

class MyDashboardPage extends StatefulWidget {
  @override
  _MyDashboardPageState createState() => _MyDashboardPageState();
}

class _MyDashboardPageState extends State<MyDashboardPage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Dashboard: Di dashboard nanti ada button untuk testimoni',
      style: optionStyle,
      textAlign: TextAlign.center,
    ),
    MyLelangMainPage(),
    Text(
      'Galang Dana',
      style: optionStyle,
      textAlign: TextAlign.center,
    ),
    Text(
      'Profile: Di profile nanti ada button untuk FAQ',
      style: optionStyle,
      textAlign: TextAlign.center,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.whiteGreen,
      body: Container(
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
                  icon: LineIcons.home,
                  text: 'Dashboard',
                ),
                GButton(
                  icon: LineIcons.alternateWavyMoneyBill,
                  text: 'Lelang',
                ),
                GButton(
                  icon: LineIcons.donate,
                  text: 'Galang Dana',
                ),
                GButton(
                  icon: LineIcons.user,
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
