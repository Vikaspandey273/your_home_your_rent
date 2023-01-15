import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

class Message extends StatelessWidget {
  static Route<dynamic> route() =>
      MaterialPageRoute(builder: (context) => Message());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Messages"),
        elevation: 90.0,
      ),
      body: SettingsList(
        sections: [
          SettingsSection(
            tiles: [
              SettingsTile(
                title: 'Wallpaper',
                subtitle: 'set wallpaper',
                leading: Icon(Icons.wallpaper),
                onPressed: (BuildContext context) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Message()));
                },
              ),
              SettingsTile(
                title: 'Backup Chat',
                subtitle: 'upload chat to drive',
                leading: Icon(Icons.history),
                onPressed: (BuildContext context) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Message()));
                },
              ),
              SettingsTile(
                title: 'Theme',
                subtitle: 'dark/light',
                leading: Icon(Icons.nightlight_round),
                onPressed: (BuildContext context) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Message()));
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
