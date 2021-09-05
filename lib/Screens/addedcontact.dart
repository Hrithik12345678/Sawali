import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sawali/Auth/contactmanager.dart';
import 'package:flutter/services.dart';

class AddedContact extends StatefulWidget {
  const AddedContact({Key? key}) : super(key: key);

  @override
  _AddedContactState createState() => _AddedContactState();
}

class _AddedContactState extends State<AddedContact> {
  final uid = FirebaseAuth.instance.currentUser!.uid.toString();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Added Contacts'),
          backgroundColor: Color.fromRGBO(0, 33, 71, 0.9),
          backwardsCompatibility: false,
          systemOverlayStyle: SystemUiOverlayStyle.light,
          centerTitle: true,
          foregroundColor: Colors.white),
      body: Container(
        constraints: BoxConstraints(
            minWidth: MediaQuery.of(context).size.width,
            minHeight: MediaQuery.of(context).size.height),
        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: [
            Color.fromRGBO(0, 33, 71, 0.9),
            Color.fromRGBO(0, 33, 71, 0.8)
          ],
          begin: Alignment.bottomRight,
          end: Alignment.topLeft,
        )),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('/users')
              .doc(uid)
              .collection('/addedcontacts')
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            return ListView(
              children: snapshot.data!.docs.map((document) {
                String name = document['name'];
                String phone = document['contactno'];
                return Center(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Text(
                        name[0],
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                    ),
                    trailing: GestureDetector(
                      onTap: () {
                        deleteContact(phone);
                      },
                      child: Icon(
                        Icons.delete_outline,
                        color: Colors.white,
                      ),
                    ),
                    title: Text(
                      name,
                      style: TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      phone,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}
