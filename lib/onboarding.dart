import 'package:flutter/material.dart';
import 'package:yourhomeyourrent/create_new_account_admin.dart';

import 'login_screen.dart';

class Onboarding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.lightBlueAccent,
        alignment: Alignment.bottomCenter,
        child:
            Visibility(
              visible: true,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RaisedButton(
                color: Colors.white,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
                child: Text("Login Here", ),
              ),
              SizedBox(height: 30,),
              RaisedButton(
                color: Colors.white,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CreateNewAccount()),
                  );
                },
                child: Text("Resister Here"),
              ),
              ]
            ),

        ),
      ),
    );
  }
}
