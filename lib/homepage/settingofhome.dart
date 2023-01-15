import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:yourhomeyourrent/homepage/profileofhome.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:yourhomeyourrent/helper/AuthServices.dart';
import 'package:toast/toast.dart';
import 'package:yourhomeyourrent/settingpage/Account.dart';
import 'package:yourhomeyourrent/settingpage/appinfo.dart';
import 'package:yourhomeyourrent/settingpage/language.dart';
import 'package:yourhomeyourrent/settingpage/termsandprivacy.dart';

class SettingsOfHome extends StatelessWidget {
  static Route<dynamic> route() =>
      MaterialPageRoute(builder: (context) => SettingsOfHome());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        elevation: 90.0,
      ),
      body: SettingsList(
        sections: [
          SettingsSection(
            tiles: [
              SettingsTile(
                title: 'Profile',
                subtitle: '',
                leading: Icon(Icons.person),
                onPressed: (BuildContext context) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ProfileOfHome()));
                },
              ),
              SettingsTile(
                title: 'Language',
                subtitle: 'English',
                leading: Icon(Icons.language),
                onPressed: (BuildContext context) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Language()));
                },
              ),

        SettingsTile(
                title: 'Noticification',
                subtitle: '',
                leading: Icon(Icons.notifications),
                onPressed: (BuildContext context) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Account.notice()));
                },
              ),

              SettingsTile(
                title: 'Terms And Privacy Policy',
                leading: Icon(Icons.note),
                onPressed: (BuildContext context) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TermsAndPrivacyPolicy()));
                },
              ),
              SettingsTile(
                title: 'App Info',
                leading: Icon(Icons.info),
                onPressed: (BuildContext context) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AppInfo.app()));
                },
              ),
              SettingsTile(
                title: 'Logout',
                subtitle: 'logout',
                leading: Icon(Icons.logout),
                onPressed:  (BuildContext context) async{
                  Toast.show("Please Wait...", context);
                  await DataConnectionChecker().hasConnection
                      ? AuthHelper.signOut(context)
                      : Toast.show(
                      "Please Check Your Internet Connection", context,
                      duration: Toast.LENGTH_LONG,
                      gravity: Toast.TOP,
                      backgroundColor: Colors.redAccent);
                }
              ),
            ],
          ),
        ],
      ),
    );
  }
}
