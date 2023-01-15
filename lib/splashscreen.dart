import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:yourhomeyourrent/component/home.dart';
import 'package:yourhomeyourrent/login_screen.dart';
import 'package:yourhomeyourrent/onboarding.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'component/adminhome.dart';

void main() => runApp(new MyApp());

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            return StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('Users')
                    .doc(snapshot.data.uid)
                    .snapshots(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData && snapshot != null) {
                    final user = snapshot.data.data();
                    if (user['role'] == 'Seller') {
                      return AdminHome();
                    } else {
                      return Home();
                    }
                  }
                  return Material(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                });
          } else {
            return LoginScreen();
          }
        });
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      color: Colors.lightGreen[600],
      home: new Splash(),
    );
  }
}

class Splash extends StatelessWidget {
  static FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  User _user = _firebaseAuth.currentUser;

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 2,
      navigateAfterSeconds: _user == null ? Onboarding() : MainScreen(),
      image: new Image(
        image: AssetImage('img/home.png'),
      ),
      loadingText: Text("Loading"),
      photoSize: 100.0,
      loaderColor: Colors.blue,
    );
  }
}
