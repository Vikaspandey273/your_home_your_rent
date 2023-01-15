import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yourhomeyourrent/component/houseinfo.dart';
import 'package:yourhomeyourrent/homeofhome/onhometap.dart';


class HomeOfHome extends StatefulWidget {
  @override
  _HomeOfHomeState createState() => _HomeOfHomeState();
}

class _HomeOfHomeState extends State<HomeOfHome> {
  static const TextStyle _textStyle = TextStyle(
      color: Colors.white,
      fontSize: 13.0,
      // fontStyle: FontStyle.italic,
      fontWeight: FontWeight.w500);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Your Home Your Rent'),
        ),
        body: Container(
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("properties")
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData && snapshot.data != null) {
                final docs = snapshot.data.docs;
                return ListView.builder(
                    // physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      final user = docs[index].data();
                      return GestureDetector(
                        onTap: () {
                          print("UID = " + user['uid']);
                          print("Email = " + user['email']);
                          // Navigator.push(Builder:context,MaterialPageRoute=>ReferralsListAdmin())
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HouseInfo()));
                        },
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => OnHomeTap()),
                            );
                          },

                        child: Column(
                        children: [
                          Card(
                          borderOnForeground: true,
                          color: Colors.deepOrangeAccent,
                          shadowColor: Colors.cyanAccent,
                          child: Row(
                            children: [
                              Container(
                                  width: 90.0,
                                  height: 190.0,
                                  decoration: new BoxDecoration(
                                    // color: Colors.orange,
                                    shape: BoxShape.circle,
                                    // backgroundBlendMode: BlendMode.darken,
                                    image: new DecorationImage(
                                      fit: BoxFit.cover,
                                      scale: 20.0,
                                      image: NetworkImage(
                                        user['propertyPicUrl1'] == null
                                            ? 'img/home.png'
                                            : user['propertyPicUrl1'],
                                      ),
                                      matchTextDirection: true,
                                    ),
                                  )),
                              Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,


                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "title: ",
                                          style: _textStyle,
                                        ),
                                        Text(
                                          user['title'] == null
                                              ? 'Loading..'
                                              : user['title'],
                                          style: _textStyle,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      // mainAxisAlignment: MainAxisAlignment.start,
                                      //crossAxisAlignment: CrossAxisAlignment.baseline,
                                      children: [
                                        Text(
                                          "type: ",
                                          style: _textStyle,
                                        ),
                                        Text(
                                          user['type'] == null
                                              ? 'Loading..'
                                              : user['type'],
                                          style: _textStyle,
                                        ),
                                        SizedBox(width: 50,),
                                        Text(
                                          "amount: ",
                                          style: _textStyle,
                                        ),
                                        Text(
                                          user['amount'] == null
                                              ? 'Loading..'
                                              : user['amount'],
                                          style: _textStyle,
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        ]
                        ),
                        ),
                      );
                      //semanticContainer: false,
                    });
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ));
  }
}
