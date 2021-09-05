import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:telephony/telephony.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Location extends StatefulWidget {
  const Location({Key? key}) : super(key: key);

  @override
  _LocationState createState() => _LocationState();
}

class _LocationState extends State<Location>
    with AutomaticKeepAliveClientMixin {
  //Firebase instance
  final uid = FirebaseAuth.instance.currentUser!.uid.toString();
  //Telephony instance
  Telephony telephony = Telephony.instance;

  var locationMessage = ''; //message variable
  var phoneno = []; //phone going to save in this variable variable
  var uniques = new LinkedHashMap<String,
      bool>(); // to remove duplicates <linkedHashMap> is used
  late String latitude;
  late String longitude;
  // Location function
  void getCurrentLocation() async {
    var position = await Geolocator.getCurrentPosition(
        desiredAccuracy:
            LocationAccuracy.high); //Accuracy is high for accurate location
    var lat = position.latitude;
    var long = position.longitude;
    latitude = "$lat";
    longitude = "$long";
    setState(() {
      locationMessage = "Help! Help! Help!" + "\n" + "I am in Danger." + "\n"
          "Here is my location ->" + 
          "\n"
              "https://www.google.com/maps/search/?api=1&query=$latitude,$longitude"; //the message + google link
    });
    sendSms(); // calling sendSms function after geting user location
  }

  // sendSms function
  void sendSms() async {
    //fetchting contacts from firebase
    await FirebaseFirestore.instance
        .collection('/users')
        .doc(uid)
        .collection('/addedcontacts')
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        setState(() {
          phoneno.add(result['contactno']); // adding contacts in list
        });
      });
    });
    // to removie duplicates
    var unique = phoneno.toSet().toList();
    if (unique.isEmpty) {
      Fluttertoast.showToast(msg: "please add some emergency contacts");
    }
    // run according the no. of contacts are saved
    for (int i = 0; i < unique.length; i++) {
      //telephony intance is used to sendSms
      //telephony intance is used to sendSms

      telephony
          .sendSms(
            to: unique[i].toString(),
            message: locationMessage,
          )
          .whenComplete(() => Fluttertoast.showToast(
              msg: "Location Shared successfully")) // if successful
          .onError((error, stackTrace) =>
              Fluttertoast.showToast(msg: error.toString()));
      // if error
    }
    unique.clear();
    phoneno.clear();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Container(
        constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height,
            minHeight: MediaQuery.of(context).size.width),
        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: [
            Color.fromRGBO(0, 33, 71, 0.9),
            Color.fromRGBO(0, 33, 71, 0.8)
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        )),
        child: Column(
          children: [
            Expanded(
              flex: 4,
              child: Container(
                margin: EdgeInsets.only(top: 20.0),
                child: Image(
                  image: AssetImage('images/locationc.png'),
                ),
              ),
            ),
            Expanded(
                flex: 3,
                child: Container(
                  padding: EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Center(
                    child: Text(
                      'We have developed an application for the safety of every citizen of our country.' + " \n"
                      ' On one Click you can share your current location to your added contacts',
                      style: TextStyle(fontSize: 17.0, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )),
            Expanded(
                flex: 2,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(125, 249, 255, 0.9),
                          borderRadius: BorderRadius.circular(4),
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromRGBO(125, 249, 255, 0.9),
                                offset: Offset(0, 10),
                                blurRadius: 50)
                          ]),
                      child: TextButton(
                        onPressed: () {
                          getCurrentLocation(); //calling getCurrentLocation function
                        },
                        child: Text(
                          'Share Location',
                          style: TextStyle(
                              color: Color.fromRGBO(25, 25, 112, 0.9),
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0),
                        ),
                      ),
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
