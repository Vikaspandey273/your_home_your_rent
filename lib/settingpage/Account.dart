import 'package:flutter/material.dart';
import 'package:system_settings/system_settings.dart';


class Account extends StatelessWidget {

  static Route<dynamic> route() =>
      MaterialPageRoute(builder: (context) => Account());

  static notice(){
    ElevatedButton(
      child: Text('Notification'),
      onPressed: () => SystemSettings.appNotifications(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notification"),
        elevation: 90.0,
      ),
      body: Center(
      ),
    );
  }
}
