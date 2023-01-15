import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class FirestoreHelper {
  User currentUser = FirebaseAuth.instance.currentUser;



  updateProfilePicUrl(String url) async {
    print("come to upload url");
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(currentUser.uid)
        .update({'profilePicUrl': url});
  }



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
            () => {Toast.show("Detailed Saved Successfully...", context)});
  }
}
