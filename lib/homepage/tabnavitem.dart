import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:yourhomeyourrent/homepage/chatofhome.dart';
import 'package:yourhomeyourrent/homepage/homeofhome.dart';
import 'package:yourhomeyourrent/homepage/profileofhome.dart';
import 'package:yourhomeyourrent/homepage/settingofhome.dart';
import 'package:yourhomeyourrent/homepage/searchofhome.dart';

class TabNavigationItem {
  final Widget page;
  final Widget title;
  final Icon icon;

  TabNavigationItem({
    @required this.page,
    @required this.title,
    @required this.icon,
  });

  static List<TabNavigationItem> get items => [
        TabNavigationItem(
            page: HomeOfHome(), title: Text("Home"), icon: Icon(Icons.home)),
        TabNavigationItem(
            page: SearchOfHome(), title: Text("Home"), icon: Icon(Icons.home)),
        TabNavigationItem(
            page: ChatOfHome(), title: Text("Home"), icon: Icon(Icons.home)),
        TabNavigationItem(
            page: ProfileOfHome(), title: Text("Home"), icon: Icon(Icons.home)),
        TabNavigationItem(
            page: SettingsOfHome(),
            title: Text("Home"),
            icon: Icon(Icons.home)),
      ];
}
