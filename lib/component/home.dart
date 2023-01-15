import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:yourhomeyourrent/homepage/homeofhome.dart';
import 'package:yourhomeyourrent/homepage/searchofhome.dart';
import 'package:yourhomeyourrent/homepage/chatofhome.dart';
import 'package:yourhomeyourrent/homepage/settingofhome.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  int selectIndex = 0;

  List _listScreen = [
    HomeOfHome(),
    SearchOfHome(),
    ChatOfHome(),
    SettingsOfHome(),
  ];

  // String _email = FirebaseAuth.instance.currentUser.email.toString();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _listScreen[selectIndex],
      bottomNavigationBar: FFNavigationBar(
        theme: FFNavigationBarTheme(
          barBackgroundColor: Colors.white,
          selectedItemBorderColor: Colors.lightGreen[400],
          selectedItemBackgroundColor: Colors.lightGreen[600],
          selectedItemIconColor: Colors.white,
          selectedItemLabelColor: Colors.black,
        ),
        selectedIndex: selectIndex,
        onSelectTab: (index) {
          setState(() {
            selectIndex = index;
          });
        },
        items: [
          FFNavigationBarItem(
            iconData: Icons.home,
            label: 'Home',
          ),
          FFNavigationBarItem(
            iconData: Icons.search,
            label: 'Search',
          ),
          FFNavigationBarItem(
            iconData: Icons.chat,
            label: 'Chat',
          ),
          FFNavigationBarItem(
            iconData: Icons.settings,
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
