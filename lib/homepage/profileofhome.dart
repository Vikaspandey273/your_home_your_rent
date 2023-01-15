import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yourhomeyourrent/helper/FirestoreDatabaseServices.dart';
import 'package:toast/toast.dart';

class ProfileOfHome extends StatefulWidget {
  @override
  MapScreenState createState() => MapScreenState();
}

class MapScreenState extends State<ProfileOfHome>
    with SingleTickerProviderStateMixin {
  User user = FirebaseAuth.instance.currentUser;

  String profilePicUrl;
  String name, email, phone, pinCode, station;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _pincodeController = TextEditingController();
  TextEditingController _stationController = TextEditingController();

  final GlobalKey<FormState> _formProfileKey = GlobalKey<FormState>();

  final ImagePicker _picker = ImagePicker();
  File _image;
  String imgDownloadUrl;

  //var pickedFile;
  Future selectFromGalary() async {
    final pickedFile = await _picker.getImage(source: ImageSource.gallery);

    if (pickedFile.path == null) {
      print("empty");
    }

    if (pickedFile.path.isNotEmpty) {
      setState(() async {
        _image = File(pickedFile.path.trim().toString());
        print("picked path" + pickedFile.path.trim().toString());

        if (await DataConnectionChecker().hasConnection) {
          var storeImg = FirebaseStorage.instance
              .ref()
              .child(user.email)
              .child("profile_pic");
          var imgTask = storeImg.putFile(_image);
          imgDownloadUrl = await (await imgTask.whenComplete(() => null))
              .ref
              .getDownloadURL();
          print("down url" + imgDownloadUrl);
          if (imgDownloadUrl.isNotEmpty) {
            await FirestoreHelper().updateProfilePicUrl(imgDownloadUrl);
          }
        } else {
          Toast.show("please check your connection", context,
              backgroundColor: Colors.red);
          Toast.show("Failed to Update Your picture", context,
              backgroundColor: Colors.red, duration: Toast.LENGTH_LONG);
        }
      });
    }
  }

  bool _status = true;
  final FocusNode myFocusNode = FocusNode();

  getUserDetails() async {
    //FirebaseFirestore.instance.collection("Users").doc(user.uid).snapshots();
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection("Users")
        .doc(user.uid)
        .get();

    //Name
    name = documentSnapshot.get('name');
    _nameController.text = name;

    //E-mail
    email = documentSnapshot.get('email');
    _emailController.text = email;

    //Phone
    phone = documentSnapshot.get('mobile').toString();
    _phoneController.text = phone;

    //Pincode
    pinCode = documentSnapshot.get('pincode').toString();
    _pincodeController.text = pinCode;

    //Station
    station = documentSnapshot.get('station');
    _stationController.text = station;


    profilePicUrl = documentSnapshot.get('profilePicUrl').toString();
  }

  @override
  void initState() {
    super.initState();

    getUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text("Profile"),
          elevation: 90.0,
        ),
        body: new Container(
          color: Colors.blue[800],
          child: new ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  new Container(
                    color: Colors.blue[600],
                    height: MediaQuery.of(context).size.height*0.40,
                    child: new Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 30.0),
                          child:
                              new Stack(fit: StackFit.loose, children: <Widget>[
                            new Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new Container(
                                    width: 200.0,
                                    height: 200.0,
                                    decoration: new BoxDecoration(
                                      color: Colors.orange,
                                      shape: BoxShape.circle,
                                      // backgroundBlendMode: BlendMode.darken,
                                      image: new DecorationImage(
                                        fit: BoxFit.cover,
                                        image: _image != null
                                            ? FileImage(_image)
                                            : NetworkImage(
                                                profilePicUrl != null
                                                    ? profilePicUrl
                                                    : 'http://www.loansfirstsolution.com/images/logo.png',
                                              ),
                                      ),
                                    )),
                              ],
                            ),
                            Padding(
                                padding:
                                    EdgeInsets.only(top: 100.0, right: 190.0),
                                child: new Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    new CircleAvatar(
                                      backgroundColor: Colors.red,
                                      radius: 25.0,
                                      child: new IconButton(
                                        //enableFeedback: false,
                                        icon: Icon(Icons.insert_photo_rounded),
                                        //  Icons.insert_photo_rounded,
                                        color: Colors.white,
                                        onPressed: () async {
                                          selectFromGalary();
                                          print("Galary Icon tapped");
                                          },
                                      ),
                                    ),
                                  ],
                                )),
                          ]),
                        )
                      ],
                    ),
                  ),
                  new Container(
                    color: Color(0xffFFFFFF),
                    child: Form(
                      key: _formProfileKey,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 25.0),
                        child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                                padding: EdgeInsets.only(
                                    left: 25.0, right: 25.0, top: 25.0),
                                child: new Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    new Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        new Text(
                                          'Personal Information',
                                          style: TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    new Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        _status
                                            ? _getEditIcon()
                                            : new Container(),
                                      ],
                                    )
                                  ],
                                )),
                            Padding(
                                padding: EdgeInsets.only(
                                    left: 25.0, right: 25.0, top: 25.0),
                                child: new Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    new Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        new Text(
                                          'Name',
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ],
                                )),
                            Padding(
                                padding: EdgeInsets.only(
                                    left: 25.0, right: 25.0, top: 2.0),
                                child: new Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    new Flexible(
                                      child: new TextFormField(
                                        controller: _nameController,
                                        keyboardType: TextInputType.text,
                                        decoration: const InputDecoration(
                                          hintText: "Enter Your Name",
                                        ),
                                        enabled: false,
                                        autofocus: !_status,
                                      ),
                                    ),
                                  ],
                                )),
                            Padding(
                                padding: EdgeInsets.only(
                                    left: 25.0, right: 25.0, top: 25.0),
                                child: new Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    new Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        new Text(
                                          'Email ID',
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ],
                                )),
                            Padding(
                                padding: EdgeInsets.only(
                                    left: 25.0, right: 25.0, top: 2.0),
                                child: new Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    new Flexible(
                                      child: new TextFormField(
                                        controller: _emailController,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        decoration: const InputDecoration(
                                            hintText: "Enter Email ID"),
                                        enabled: false,
                                      ),
                                    ),
                                  ],
                                )),
                            Padding(
                                padding: EdgeInsets.only(
                                    left: 25.0, right: 25.0, top: 25.0),
                                child: new Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    new Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        new Text(
                                          'Mobile',
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ],
                                )),
                            Padding(
                                padding: EdgeInsets.only(
                                    left: 25.0, right: 25.0, top: 2.0),
                                child: new Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    new Flexible(
                                      child: new TextFormField(
                                        controller: _phoneController,
                                        keyboardType: TextInputType.number,
                                        decoration: const InputDecoration(
                                            hintText: "Enter Mobile Number"),
                                        enabled: !_status,
                                      ),
                                    ),
                                  ],
                                )),
                            Padding(
                                padding: EdgeInsets.only(
                                    left: 25.0, right: 25.0, top: 25.0),
                                child: new Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Expanded(
                                      child: Container(
                                        child: new Text(
                                          'Pin Code',
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      flex: 2,
                                    ),
                                    Expanded(
                                      child: Container(
                                        child: new Text(
                                          'NearBy Station',
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      flex: 2,
                                    ),
                                  ],
                                )),
                            Padding(
                                padding: EdgeInsets.only(
                                    left: 25.0, right: 25.0, top: 2.0),
                                child: new Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Flexible(
                                      child: Padding(
                                        padding: EdgeInsets.only(right: 10.0),
                                        child: new TextFormField(
                                          controller: _pincodeController,
                                          keyboardType: TextInputType.number,
                                          decoration: const InputDecoration(
                                              hintText: "Enter Pin Code"),
                                          enabled: !_status,
                                        ),
                                      ),
                                      flex: 2,
                                    ),
                                    Flexible(
                                      child: new TextFormField(
                                        controller: _stationController,
                                        decoration: const InputDecoration(
                                            hintText: "Enter Station"),
                                        enabled: !_status,
                                      ),
                                      flex: 2,
                                    ),
                                  ],
                                )),
                            !_status ? _getActionButtons() : new Container(),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ));
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myFocusNode.dispose();
    super.dispose();
  }

  Widget _getActionButtons() {
    return Padding(
      padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 45.0),
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Container(
                  child: new RaisedButton(
                child: new Text("Save"),
                textColor: Colors.white,
                color: Colors.green,
                onPressed: () async {
                  setState(() async {
                    _status = true;
                    if (await DataConnectionChecker().hasConnection) {
                      String phoneNo = _phoneController.text.trim().toString();
                      String pincodeOf =
                          _pincodeController.text.trim().toString();
                      String stationOf =
                          _stationController.text.trim().toString();
                      await FirestoreHelper().updateProfileDetail(
                          phoneNo, pincodeOf, stationOf, context);
                      FocusScope.of(context).requestFocus(new FocusNode());
                    } else {
                      Toast.show("Check Connection", context,
                          duration: Toast.LENGTH_LONG,
                          gravity: Toast.TOP,
                          backgroundColor: Colors.redAccent);
                    }
                  });
                },
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(20.0)),
              )),
            ),
            flex: 2,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Container(
                  child: new RaisedButton(
                child: new Text("Cancel"),
                textColor: Colors.white,
                color: Colors.red,
                onPressed: () {
                  setState(() {
                    _status = true;
                    FocusScope.of(context).requestFocus(new FocusNode());
                  });
                },
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(20.0)),
              )),
            ),
            flex: 2,
          ),
        ],
      ),
    );
  }

  Widget _getEditIcon() {
    return new GestureDetector(
      child: new CircleAvatar(
        backgroundColor: Colors.blue[600],
        radius: 20.0,
        child: new Icon(
          Icons.edit_outlined,
          color: Colors.white,
          size: 20.0,
        ),
      ),
      onTap: () {
        setState(() {
          _status = false;
        });
      },
    );
  }
}
