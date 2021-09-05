import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sawali/Screens/home.dart';
import 'package:sawali/Screens/starterscreen.dart';

class GoogleProcessingScreen extends StatefulWidget {
  const GoogleProcessingScreen({Key? key}) : super(key: key);

  @override
  _GoogleProcessingScreenState createState() => _GoogleProcessingScreenState();
}

class _GoogleProcessingScreenState extends State<GoogleProcessingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasData) {
              return Home();
            } else if (snapshot.hasError) {
              return Center(
                child:
                    Text('Something Went Wrong*******************************'),
              );
            } else {
              return Start();
            }
          }),
    );
  }
}
