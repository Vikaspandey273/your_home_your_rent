import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yourhomeyourrent/helper/AuthServices.dart';
import 'package:toast/toast.dart';

class ResetPasswordScreen extends StatefulWidget {
  String email, uid;

  ResetPasswordScreen({Key key, @required this.email, this.uid})
      : super(key: key);

  @override
  _ResetPasswordScreenState createState() =>
      _ResetPasswordScreenState(email, uid);
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  String email, uid;

  _ResetPasswordScreenState(this.email, this.uid);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Account"),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10.0),
              child: Column(
                children: [
                  TextFormField(
                    //controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    //validator: emailValidator,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                        hintText: email,
                        labelText: email,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Color(0xFFe7edeb),
                        prefixIcon: Icon(
                          Icons.email,
                          color: Colors.grey[600],
                        )),
                    enabled: true,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 10.0),
                    child: Container(
                        child: new RaisedButton(
                      child: new Text("Send Reset Password Link"),
                      textColor: Colors.white,
                      color: Colors.green,
                      onPressed: () async {
                        await DataConnectionChecker().hasConnection
                            ? AuthHelper.sendResetPasswordLink(
                                email: email, context: context)
                            : Toast.show(
                                "Please Check Your Internet Connection",
                                context,
                                duration: Toast.LENGTH_LONG,
                                gravity: Toast.TOP,
                                backgroundColor: Colors.redAccent);
                      },
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(20.0)),
                    )),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
