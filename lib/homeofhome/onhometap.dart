import 'package:flutter/material.dart';

class OnHomeTap extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
   return _OnHomeState();
  }
}

class _OnHomeState extends State<OnHomeTap>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Home Your Rent"),
      ),
      body: Container(
        child: Text("Hey"),
      ),
    );
  }

}