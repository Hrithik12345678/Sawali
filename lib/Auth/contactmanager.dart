import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future<void> addContact(String name,String phone) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  String uid = auth.currentUser!.uid.toString();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final collectionReference = _firestore.collection('/users').doc(uid).collection('/addedcontacts').doc(phone);

  collectionReference.set({
    "name":name, "contactno":phone
  }).whenComplete(() => Fluttertoast.showToast(msg: "Contact ia Successfully Added"))
      .onError((error, stackTrace) => Fluttertoast.showToast(msg: error.toString()));
}

Future<void> deleteContact(String phone) async{
  FirebaseAuth auth = FirebaseAuth.instance;
  String uid = auth.currentUser!.uid.toString();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final collectionReference  =  _firestore.collection('/users').doc(uid).collection('/addedcontacts').doc(phone);
  collectionReference.delete().whenComplete(() => Fluttertoast.showToast(msg: 'Contact Deleted Successfully.'))
      .onError((error, stackTrace) => Fluttertoast.showToast(msg: error.toString()));
  return;
}