import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class FirestoreHelper {
  User currentUser = FirebaseAuth.instance.currentUser;

  updateProfileDetail(String phone, String pincode, String station,
      BuildContext context) async {
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(currentUser.uid)
        .update({
      'mobile': phone,
      'pincode': pincode,
      'station': station
    }).whenComplete(
            () => {Toast.show("Details Saved Successfully..", context)});
  }

  updateProfilePicUrl(String url) async {
    print("came to update url");
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(currentUser.uid)
        .update({'profilePicUrl': url});
  }

  updateStatus(String status, String docId) async {
    print("Came to update status");
    await FirebaseFirestore.instance
        .collection("Referrals")
        .doc(docId)
        .update({'status': status});
  }

  requestToJoin(String name, String phone, String email, String post,
      String pincode, String station, BuildContext context) {
    try {
      final FirebaseFirestore _instance = FirebaseFirestore.instance;
      DocumentReference documentReference =
          _instance.collection('Requests').doc();
      documentReference.set({
        'name': name,
        'phone': phone,
        'email': email,
        'post': post,
        'pincode': pincode,
        'station': station,
        'dateApplied': DateTime.now().month.toString() +
            "-" +
            DateTime.now().day.toString() +
            "-" +
            DateTime.now().year.toString(),
        'docId': documentReference.id,
      }).whenComplete(() => {
            Toast.show(
                "Request Submitted Successfully.We'll Contact You On Call Soon...",
                context,
                duration: Toast.LENGTH_LONG,
                backgroundColor: Colors.green)
          });
    } catch (e) {
      print("Error is: " + e);
      print(e.code);
    }
  }
}

class NewUserDetails {
  saveNewUserData(
      {String email,
      String name,
      String phone,
      String manager,
      String uid,
      String coordinator,
      String station,
      String pincode,
      String role,
      BuildContext context}) async {
    try {
      await FirebaseFirestore.instance.collection("Users").doc(uid).set({
        'uid': uid,
        'email': email,
        'name': name,
        'mobile': phone,
        'manager': manager,
        'coordinator': coordinator,
        'station': station,
        'pincode': pincode,
        'role': role,
        'profilePicUrl': null
      }).whenComplete(() => () {
            Toast.show("User data added successfully", context);
          });
    } catch (e) {
      print(e);
    }
  }
}


//Upload Page
class Upload {
  static FirebaseAuth _firebaseAuth = FirebaseAuth.instance;


  String currentUserUid = _firebaseAuth.currentUser.uid.toString();
  String currentUserEmail = _firebaseAuth.currentUser.email.toString();

  static uploadProperty({
    String currentUserUid,
    String propertyPicUrl,
    String currentUserEmail,
    String description,
    String type,
    BuildContext context,
    String title,
    String amount,
    String pincode,
    String nearByStation,
    String listedFor,
    String area,
    String fullAddress,
    String landmark,
    String localArea,
  }) async {
    try {
      await FirebaseFirestore.instance.collection("properties").add({
        'uid': currentUserUid ,
        'email': currentUserEmail ,
        'station': nearByStation,
        'pincode': pincode,
        'description': description,
        'title': title,
        'amount': amount,
        'type': type,
        'area': area,
        'fullAddress': fullAddress,
        'landmark': landmark,
        'localArea': localArea,
        'propertyPicUrl1': propertyPicUrl
      }).whenComplete(() => () {
            Toast.show("User data added successfully", context);
          });
    } catch (e) {
      print(e);
    }
  }
}