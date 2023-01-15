import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:yourhomeyourrent/helper/AuthServices.dart';
import 'package:toast/toast.dart';

class CreateNewAccount extends StatefulWidget {
  @override
  _CreateNewAccountState createState() => _CreateNewAccountState();
}

class _CreateNewAccountState extends State<CreateNewAccount> {
  final GlobalKey<FormState> _createNewUserForm = GlobalKey<FormState>();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _pincodeController = TextEditingController();
  TextEditingController _stationController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  String applyForDropdownValue = 'Seller';
  String applyForDropdownHolder = 'Buyer';

  List<String> applyForList = ['Seller', 'Buyer'];

  getApplyForValue() {
    setState(() {
      applyForDropdownHolder = applyForDropdownValue;
    });
  }

  //Name Validator
  final _nameValidator = MultiValidator([
    RequiredValidator(errorText: 'This Field is Mandatory'),
    MinLengthValidator(3, errorText: 'Name must be at least 3 letters long'),
  ]);

  //Phone Number Validator
  final _phoneValidator = MultiValidator([
    RequiredValidator(errorText: 'Number is Mandatory '),
    MinLengthValidator(10,
        errorText: 'Phone Number must be at least 10 digits long'),
    MaxLengthValidator(12, errorText: 'Phone Number must be  10 digits long')
    //MaxLengthValidator
    //PatternValidator(r'(?=.*?[#?!@$%^&*-])', errorText: 'passwords must have at least one special character')
  ]);

  //Email Validator
  final _emailValidator = MultiValidator([
    RequiredValidator(errorText: 'Email is Mandatory'),
    EmailValidator(errorText: 'Enter Valid Email'),
  ]);

  //Pincode Validator
  final _pincodeValidator = MultiValidator([
    // RequiredValidator(errorText: 'Pincode is Mandatory'),
    MinLengthValidator(3, errorText: 'Invalid Pincode'),
    MaxLengthValidator(6, errorText: 'Invalid Pincode')
    //MaxLengthValidator
    //PatternValidator(r'(?=.*?[#?!@$%^&*-])', errorText: 'passwords must have at least one special character')
  ]);

  //Name Validator
  final _stationValidator = MultiValidator([
    //  RequiredValidator(errorText: 'Station is Mandatory'),
    MinLengthValidator(2, errorText: 'Invalid Station Name '),
  ]);

  //Password Validator
  final _passwordValidator = MultiValidator([
    RequiredValidator(errorText: "Password Can't be empty"),
    MinLengthValidator(6, errorText: "Minimum Length of Password is 6"),
    MaxLengthValidator(12, errorText: "Minimum Length of Password is 12"),
  ]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Request"),
      ),
      body: Container(
        color: Colors.blue[800],
        child: ListView(
          children: [
            Column(
              children: [
                Container(
                  // flex: 4,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 56.0, horizontal: 75.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 200.0,
                          height: 150.0,
                          decoration: BoxDecoration(
                              color: Colors.orange,
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage("img/home.png"))),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Container(
              color: Color(0xffFFFFFF),
              child: Form(
                key: _createNewUserForm,
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
                                    "User Information",
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
                                    'Name*',
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
                                  validator: _nameValidator,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  keyboardType: TextInputType.text,
                                  decoration: const InputDecoration(
                                    hintText: "Enter Full Name",
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
                                    'Mobile*',
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
                                  validator: _phoneValidator,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                      hintText: "Enter Mobile Number"),
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
                                    'Email ID*',
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
                                  keyboardType: TextInputType.emailAddress,
                                  validator: _emailValidator,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  decoration: const InputDecoration(
                                      hintText: "Enter Email ID"),
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
                                    'Password*',
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
                                  controller: _passwordController,
                                  keyboardType: TextInputType.emailAddress,
                                  validator: _passwordValidator,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  obscureText: true,
                                  decoration: const InputDecoration(
                                      hintText: "Enter Password"),
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
                                    'Confirm Password*',
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
                                  controller: _confirmPasswordController,
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (value) {
                                    if (value.trim().toString().isEmpty) {
                                      return "Confirm Password is Mandatory";
                                    } else if (value !=
                                        _passwordController.text) {
                                      return "Confirm Password Should Match Password";
                                    }
                                    return null;
                                  },
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  decoration: const InputDecoration(
                                      hintText: "Confirm Password"),
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
                                    'Choose As*',
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
                                    validator: _pincodeValidator,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
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
                                  controller: _stationController,
                                  validator: _stationValidator,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  decoration: const InputDecoration(
                                      hintText: "Enter Station"),
                                  enabled: true,
                                ),
                                flex: 2,
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
                child: new Text("Create"),
                textColor: Colors.white,
                color: Colors.green,
                onPressed: () async {
                  if (_createNewUserForm.currentState.validate()) {
                    // _status = true;
                    if (await DataConnectionChecker().hasConnection) {
                      //  FirestoreHelper().requestToJoin();
                      String _name = _nameController.text.trim().toString();
                      String _phone = _phoneController.text.trim().toString();
                      String _email = _emailController.text.trim().toString();
                      String _password =
                          _passwordController.text.trim().toString();
                      String _cnfPass =
                          _confirmPasswordController.text.trim().toString();
                      String _pincode =
                          _pincodeController.text.trim().toString();
                      String _station =
                          _stationController.text.trim().toString();

                      if (_password != _cnfPass) {
                        Toast.show(
                            "Both Password and Confirm Password Must Be same ",
                            context);
                      }

                      AuthHelper.createNewUser(
                          email: _email,
                          password: _password,
                          context: context,
                          name: _name,
                          phone: _phone,
                          pincode: _pincode,
                          station: _station,
                          role: applyForDropdownHolder.toString());
                    } else {
                      Toast.show("Check Connection", context,
                          duration: Toast.LENGTH_LONG,
                          gravity: Toast.TOP,
                          backgroundColor: Colors.redAccent);
                    }
                  } else {
                    Toast.show("Check Details Again", context,
                        duration: Toast.LENGTH_LONG,
                        gravity: Toast.TOP,
                        backgroundColor: Colors.redAccent);
                  }
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
