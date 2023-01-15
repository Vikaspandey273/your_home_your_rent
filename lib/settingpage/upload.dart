import 'dart:io';

import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toast/toast.dart';
import 'package:yourhomeyourrent/helper/FirestoreDatabaseServices.dart';


class UploadPage extends StatefulWidget {
  @override
  _UploadState createState() => _UploadState();
}

class _UploadState extends State<UploadPage> {

  String uid =  FirebaseAuth.instance.currentUser.uid;
  String email =  FirebaseAuth.instance.currentUser.email;
  String propertyPicUrl;
   String description,type,title,amount,pincode,nearByStation,listedFor,area,fullAddress,landmark,localeArea;




  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _typeController = TextEditingController();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _pincodeController = TextEditingController();
  TextEditingController _nearByStationController = TextEditingController();
  TextEditingController _amountController = TextEditingController();
  TextEditingController _areaController = TextEditingController();
  TextEditingController _fullAddressController = TextEditingController();
  TextEditingController _landmarkController = TextEditingController();
  TextEditingController _localeAreaController = TextEditingController();

  String applyForDropdownValue = 'Sell';
  String applyForDropdownHolder = 'sell';


  List<String> applyForList = ['Sell', 'Rent'];

  getApplyForValue() {
    setState(() {
      applyForDropdownHolder = applyForDropdownValue;
    });
  }

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
          Toast.show("Uploading propety PIcture",context);
          var storeImg = FirebaseStorage.instance
              .ref()
              .child("property_pic");
          var imgTask = storeImg.putFile(_image);
          imgDownloadUrl = await (await imgTask.whenComplete(() => null))
              .ref
              .getDownloadURL();
          print("down url" + imgDownloadUrl);
          if (imgDownloadUrl.isNotEmpty) {
            Toast.show("Uploaded Succesuflly",context);
            setState(){
              propertyPicUrl=imgDownloadUrl;
            }
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







  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Upload"),
      ),
      body: Container(
        color: Colors.blue[800],
        child: ListView(
          children: [
            Column(
              children: [
                Container(
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
                                  width: 330.0,
                                  height: 220.0,
                                  decoration: new BoxDecoration(
                                    color: Colors.orange,
                                    shape: BoxShape.rectangle,
                                    // backgroundBlendMode: BlendMode.darken,
                                    image: new DecorationImage(
                                      fit: BoxFit.cover,
                                      image: _image != null
                                          ? FileImage(_image)
                                          : AssetImage(
                                        propertyPicUrl != null
                                            ? propertyPicUrl
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
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  new CircleAvatar(
                                    backgroundColor: Colors.green,
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
              ],
            ),
            Container(
              color: Color(0xffFFFFFF),
              child: Form(

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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              new Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  new Text(
                                    "Property Information",
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
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
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  new Text(
                                    'Title*',
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
                                  controller: _titleController,
                                  decoration: const InputDecoration(
                                    hintText: "Enter Full title",
                                  ),
                                  enabled: true,
                                  //autofocus: !_status,
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
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  new Text(
                                    'Type*',
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
                                  controller: _typeController,
                                  decoration: const InputDecoration(
                                      hintText: "Ex shops, room, flat, plot etc."),
                                  enabled: true,
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
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  new Text(
                                    'Size(area)*',
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
                                  controller: _areaController,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                      hintText: "Enter size/area of your property"),
                                  enabled: true,
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
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  new Text(
                                    'Amount*',
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
                                  controller: _amountController,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                      hintText: "Enter amount on which u wanna sell/rent"),
                                  enabled: true,
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
                                  //padding: EdgeInsets.only(bottom: 10.0),
                                  child: new Text(
                                    'Listing for*',
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
                                child: _applyListDropdown(),
                                flex: 2,
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
                                    enabled: true,
                                  ),
                                ),
                                flex: 2,
                              ),
                              Flexible(
                                child: new TextFormField(
                                  controller: _nearByStationController,
                                  decoration: const InputDecoration(
                                      hintText: "Enter Station"),
                                  enabled: true,
                                ),
                                flex: 2,
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
                                    'Landmark',
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
                                    'Local Area',
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
                                    controller: _landmarkController,
                                    decoration: const InputDecoration(
                                        hintText: "Enter landmark"),
                                    enabled: true,
                                  ),
                                ),
                                flex: 2,
                              ),
                              Flexible(
                                child: new TextFormField(
                                  controller: _localeAreaController,
                                  decoration: const InputDecoration(
                                      hintText: "Enter local area"),
                                  enabled: true,
                                ),
                                flex: 2,
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
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  new Text(
                                    'Address*',
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
                                  controller: _fullAddressController,
                                  decoration: const InputDecoration(
                                      hintText: "Enter full address of your property"),
                                  enabled: true,
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
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  new Text(
                                    'Description*',
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
                                  controller: _descriptionController,
                                 decoration: const InputDecoration(
                                      hintText: "Enter Full description of your property"),
                                  enabled: true,
                                ),
                              ),
                            ],
                          )),
                      _getActionButtons()
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _applyListDropdown() {
    return DropdownButton(
      dropdownColor: Colors.white,
      value: applyForDropdownValue,
      icon: Icon(Icons.arrow_drop_down),
      iconSize: 24.0,
      elevation: 16,
      focusColor: Colors.white,
      style: TextStyle(
          color: Colors.black,
          fontSize: 18.0,
          // fontStyle: FontStyle.italic,
          fontWeight: FontWeight.w400),
      underline: Container(
        height: 1,
        width: double.infinity,
        color: Colors.black38,
      ),
      onChanged: (String data) {
        setState(() {
          applyForDropdownValue = data;
          getApplyForValue();
        });
      },
      items: applyForList.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
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
                    child: new Text("Submit"),
                    textColor: Colors.white,
                    color: Colors.green,
                    onPressed: () async {
                      String _description = _descriptionController.text.trim().toString();
                      String _title = _titleController.text.trim().toString();
                      String _type = _typeController.text.trim().toString();
                      String _amount = _amountController.text.trim().toString();
                      String _area = _areaController.text.trim().toString();
                      String _pincode = _pincodeController.text.trim().toString();
                      String _station = _nearByStationController.text.trim().toString();
                      String _fullAddress = _fullAddressController.text.trim().toString();
                      String _landmark = _landmarkController.text.trim().toString();
                      String _localeArea = _localeAreaController.text.trim().toString();
                      Toast.show(_description+_title+_type+_amount+_area+_pincode+_station+_fullAddress+_landmark+_localeArea,context);

                        if (await DataConnectionChecker().hasConnection) {
                          //  FirestoreHelper().requestToJoin();
                          String _description = _descriptionController.text.trim().toString();
                          String _title = _titleController.text.trim().toString();
                          String _type = _typeController.text.trim().toString();
                          String _amount = _amountController.text.trim().toString();
                          String _area = _areaController.text.trim().toString();
                          String _pincode = _pincodeController.text.trim().toString();
                          String _station = _nearByStationController.text.trim().toString();
                          String _fullAddress = _fullAddressController.text.trim().toString();
                          String _landmark = _landmarkController.text.trim().toString();
                          String _localeArea = _localeAreaController.text.trim().toString();



  Upload.uploadProperty(
      context: context,
      pincode: _pincode,
      nearByStation: _station,
      description: _description,
      title: _title,
      amount: _amount,
      type: _type,
      area: _area,
      fullAddress: _fullAddress,
      landmark: _landmark,
      localArea: _localeArea,
      currentUserEmail: email,
      currentUserUid: uid,
      propertyPicUrl: propertyPicUrl,
      listedFor: applyForDropdownHolder.toString());


                        } else {
                          Toast.show("Check Connection", context,
                              duration: Toast.LENGTH_LONG,
                              gravity: Toast.TOP,
                              backgroundColor: Colors.redAccent);
                        }


                      new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(20.0));
                    })
              ),
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
                        //_status = true;
                        Navigator.pop(context);
                        //FocusScope.of(context).requestFocus(new FocusNode());
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
}
