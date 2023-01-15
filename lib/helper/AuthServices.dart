import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:yourhomeyourrent/helper/FirestoreDatabaseServices.dart';
import 'package:toast/toast.dart';

import '../login_screen.dart';
import '../splashscreen.dart';

class AuthHelper {
  static FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  //Create New User
  static createNewUser({
    String email,
    String password,
    BuildContext context,
    String name,
    String phone,
    String pincode,
    String station,
    String role,
  }) async {
    String errorMessageC;
    try {
      FirebaseApp secondApp = await Firebase.initializeApp(
          name: 'sApp', options: Firebase.app().options);
      UserCredential userCredential =
          await FirebaseAuth.instanceFor(app: secondApp)
              .createUserWithEmailAndPassword(email: email, password: password);
      String newUid = userCredential.user.uid.trim().toString();
      if (newUid != null) {
        NewUserDetails().saveNewUserData(
            email: email,
            name: name,
            phone: phone,
            uid: newUid,
            station: station,
            pincode: pincode,
            role: role,
            context: context);
      }

      await secondApp.delete();
      Navigator.pop(context);
    } catch (error) {
      print(error);
      switch (error.code) {
        case "invalid-email":
          errorMessageC = "Your email address appears to be wrong.";
          break;
        case "email-already-in-use":
          errorMessageC = "Email Already Used By Another Person";
          break;
        default:
          errorMessageC = "An undefined Error has been occurred.";
      }

      if (errorMessageC != null) {
        Toast.show(errorMessageC, context,
            duration: Toast.LENGTH_LONG,
            gravity: Toast.CENTER,
            backgroundColor: Colors.redAccent);
      }
    }

    if (errorMessageC != null) {
      return Future.error(errorMessageC);
    }
  }

  //SignIN With Email
  static signInWithEmail(
      {String email, String password, BuildContext context}) async {
    String errorMessage;

    try {
      final _res = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password)
          .whenComplete(() => {
                Toast.show("Successfully Logged In.\n Please Press back button",
                    context,
                    duration: Toast.LENGTH_LONG, backgroundColor: Colors.green),
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MainScreen()),
                )
              });
      final User _user = _res.user;
      return _user;
    } catch (error) {
      print(error.code);
      print(error);
      switch (error.code) {
        case "invalid-email":
          errorMessage = "Your email address appears to be wrong.";
          break;
        case "wrong-password":
          errorMessage = "Invalid password ";
          break;
        case "user-not-found":
          errorMessage = "User doesn't exist.";
          break;
        case "user-disabled":
          errorMessage =
              "Your Account Has been disabled,Please Contact To Your Seniors.";
          break;
        case "too-many-requests":
          errorMessage = "Too many attempts.Try again After Some Time.";
          break;
        case "operation-not-allowed":
          errorMessage = "Signing in with Email and Password is not enabled.";
          break;
        default:
          errorMessage = "An undefined Error has been occurred.";
      }

      if (errorMessage != null) {
        Toast.show(errorMessage, context,
            duration: Toast.LENGTH_LONG,
            gravity: Toast.CENTER,
            backgroundColor: Colors.redAccent);
      }
    }

    if (errorMessage != null) {
      return Future.error(errorMessage);
    }
  }

  //Get Current User
  static Future<String> getCurrentUser() async {
    return FirebaseAuth.instance.currentUser.email;
  }

  //SignOut
  static signOut(BuildContext context) {
    Toast.show("Logging Out Please Wait...", context);
    try {
      return _firebaseAuth.signOut().whenComplete(() => {
            Toast.show("Successfully Logged Out....", context,
                duration: Toast.LENGTH_LONG),
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
            )
          });
    } catch (e) {
      print("This is error:" + e);
      Toast.show(e.message.toString(), context);
    }
  }

  //Send Reset Password Link
  static sendResetPasswordLink({String email, BuildContext context}) {
    Toast.show("Please Wait", context);
    _firebaseAuth.sendPasswordResetEmail(email: email).whenComplete(() => {
          Toast.show("Reset Email Sent Successfully", context,
              duration: Toast.LENGTH_LONG, backgroundColor: Colors.green),
          Navigator.pop(context)
        });
  }
}
