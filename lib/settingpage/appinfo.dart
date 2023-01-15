import 'package:flutter/material.dart';
import 'package:system_settings/system_settings.dart';


class AppInfo extends StatelessWidget {

  static Route<dynamic> route() =>
      MaterialPageRoute(builder: (context) => AppInfo());

 static app(){
    ElevatedButton(
      child: Text('AppInfo'),
      onPressed: () => SystemSettings.app(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title:  Text('App Info'),
      ),
      body: Container(
      ),

    );
  }
}