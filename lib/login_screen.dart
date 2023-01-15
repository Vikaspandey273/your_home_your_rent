import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:yourhomeyourrent/helper/AuthServices.dart';
import 'package:toast/toast.dart';
import 'package:yourhomeyourrent/reset_password_admin.dart';


class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  //Validate Password Field
  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'password is required'),
    MinLengthValidator(6, errorText: 'password must be at least 6 digits long'),
    //PatternValidator(r'(?=.*?[#?!@$%^&*-])', errorText: 'passwords must have at least one special character')
  ]);

  //Validate Email Field
  final emailValidator = MultiValidator([
    RequiredValidator(errorText: 'Email is required'),
    EmailValidator(errorText: 'Enter Valid Email'),
  ]);

  TextStyle optionStyle = TextStyle(
    fontSize: 28.0,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height,
          maxWidth: MediaQuery.of(context).size.width,
        ),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.blue[800], Colors.blue[600]],
                begin: Alignment.topLeft,
                end: Alignment.centerRight)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 4,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 56.0, horizontal: 75.0),
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
            Expanded(
              flex: 5,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    )),
                child: Padding(
                  padding: EdgeInsets.all(30.0),
                  child: Form(
                    key: _formKey,

                    // ignore: deprecated_member_use
                    //autovalidate: true,
                    //autovalidateMode: AutovalidateMode.always,

                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TextFormField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            validator: emailValidator,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
                                hintText: "abc@email.com",
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
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          TextFormField(
                            controller: _passwordController,
                            obscureText: true,
                            validator: passwordValidator,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
                                hintText: "Password",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                fillColor: Color(0xFFe7edeb),
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: Colors.grey[600],
                                )),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Container(
                            width: double.infinity,
                            child: MaterialButton(
                              hoverElevation: 50.0,
                              hoverColor: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16.0,
                                  //horizontal:
                                ),
                                child: Text(
                                  "Login",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              color: Colors.blue[700],
                              onPressed: () async {
                                //checkValidated
                                if (_formKey.currentState.validate()) {
                                  String email =
                                      _emailController.text.trim().toString();
                                  String password = _passwordController.text
                                      .trim()
                                      .toString();

                                  print("Email= " + email);
                                  print("Password= " + password);

                                  try {
                                    Toast.show(
                                        "Login Started Please Wait..", context);
                                    final user =
                                        await AuthHelper.signInWithEmail(
                                            email: email,
                                            password: password,
                                            context: context);

                                    if (user != null) {
                                      print("Login Successfull");
                                    }
                                  } catch (e) {
                                    print(e);
                                  }
                                } else {
                                  print("UnScuccessfull");
                                }
                              },
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          InkWell(
                            child: Text("Forget Password?"),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ResetPasswordScreen(
                                          email: null,
                                        )),
                              );
                            },
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                        ]),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
