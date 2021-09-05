import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:sawali/Auth/googlesign.dart';
import 'package:sawali/Screens/about.dart';
import 'package:sawali/Screens/addedcontact.dart';
import 'package:sawali/Screens/contact.dart';
import 'package:sawali/Screens/location.dart';
import 'package:sawali/Screens/profile.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:telephony/telephony.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final storage = new FlutterSecureStorage();

  PageController _pageController = PageController();

  int currentindex = 0;
  var currenttab = [Location(), About(), Contact()];
  @override
  void initState() {
    getPermissions();
    super.initState();
  }

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
      if (unique.isEmpty) {
        AlertDialog(
          actions: <Widget>[
            TextButton(
              child: Text("Saved"),
              onPressed: () {},
            )
          ],
        );
      }
      telephony
          .sendSms(
            to: unique[i].toString(),
            message: locationMessage,
          )
          .whenComplete(() => Fluttertoast.showToast(
              msg: "Location Shared successfully")) // if successful
          .onError((error, stackTrace) =>
              Fluttertoast.showToast(msg: error.toString())); // if error
    }
    unique.clear();
    phoneno.clear();
  }

  getPermissions() async {
    if (await Permission.location.request().isGranted) {
      await AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: 1,
            channelKey: 'key',
            title: 'SAWALI',
            body: 'Share your location',
            autoCancel: false),
        actionButtons: [
          NotificationActionButton(
            key: 'abc',
            label: 'Share Location',
            autoCancel: false,
          )
        ],
      );
      AwesomeNotifications().actionStream.listen((event) {
        getCurrentLocation();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      appBar: AppBar(
          title: Text('Sawali'),
          backgroundColor: Color.fromRGBO(0, 33, 71, 0.9),
          backwardsCompatibility: false,
          systemOverlayStyle: SystemUiOverlayStyle.light,
          centerTitle: true,
          foregroundColor: Colors.white),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentindex,
        fixedColor: Color.fromRGBO(0, 50, 100, 1),
        onTap: (index) {
          setState(() {
            currentindex = index;
            _pageController.animateToPage(index,
                duration: Duration(milliseconds: 50), curve: Curves.easeIn);
            FocusManager.instance.primaryFocus?.unfocus();
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.location_on_outlined), label: 'Share location'),
          BottomNavigationBarItem(
            icon: Icon(Icons.supervisor_account),
            label: 'About Us',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.contacts_outlined), label: 'Add Contacts'),
        ],
      ),
      body: PageView(
        children: currenttab,
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            currentindex = index;
            FocusManager.instance.primaryFocus?.unfocus();
          });
        },
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountEmail: Text(
                user.email!,
                style: TextStyle(color: Colors.white),
              ),
              accountName: Text(
                user.displayName!,
                style: TextStyle(color: Colors.white),
              ),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(user.photoURL!),
                backgroundColor: Colors.black87,
              ),
              decoration: BoxDecoration(
                color: Color.fromRGBO(0, 33, 71, 0.9),
              ),
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Profile'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Profile()));
              },
            ),
            ListTile(
              leading: Icon(Icons.library_books),
              title: Text('Added Contacts'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddedContact()));
              },
            ),
            Divider(
              thickness: 2,
            ),
            ListTile(
              leading: Icon(Icons.power_settings_new),
              title: Text('Log Out'),
              onTap: () async {
                final provider =
                    Provider.of<GoogleSignInProvider>(context, listen: false);
                provider.logOut();
              },
            ),
          ],
        ),
      ),
    );
  }

  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
