import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key }) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      backgroundColor: Color.fromRGBO(0,33,71,0.9),
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          'Profile',
          style: TextStyle(
            letterSpacing: 1.6,
          ),),
        backgroundColor: Color.fromRGBO(0,33,71,0.9),
          backwardsCompatibility: false,
          systemOverlayStyle: SystemUiOverlayStyle.light,
        centerTitle:true,
        foregroundColor: Colors.white
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 50.0,
                backgroundImage: NetworkImage(user.photoURL!),
                backgroundColor: Colors.grey,
              ),
            ),
            SizedBox(height: 30.0),
            Text(
              'Name :',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 1.4
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              user.displayName!,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                  color: Color.fromRGBO(125,249,255,0.9),
                  letterSpacing: 1.6
              ),
            ),
            
            SizedBox(height: 30.0,),
            Row(
              children: [
                Icon(
                  Icons.email_outlined,
                  color: Colors.white,
                ),
                SizedBox(width: 10.0,),
                Text(
                  'Email :',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1.4,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0,),
            Text(
              user.email!,
              style: TextStyle(
                color: Color.fromRGBO(125,249,255,0.9),
                fontWeight: FontWeight.bold,
                letterSpacing: 1.4,
                fontSize: 15.0,
              ),
            ),
            SizedBox(height: 30.0,),
          ],
        ),
      ),
    );
  }
}
