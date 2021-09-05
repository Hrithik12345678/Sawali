import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sawali/Auth/googleprocessor.dart';
import 'package:sawali/Auth/googlesign.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  AwesomeNotifications().initialize(
      // set the icon to null if you want to use the default app icon
      'resource://mipmap/ic_launcher',
      [
        NotificationChannel(
            channelKey: 'key',
            channelName: 'Savali',
            channelDescription: 'Send Location',
            defaultColor: Colors.white,
            ledColor: Colors.white,
            playSound: true,
            locked: true)
      ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: ChangeNotifierProvider(
        create: (BuildContext context) => GoogleSignInProvider(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Sawali',
          theme: ThemeData(
            primarySwatch: Colors.cyan,
          ),
          home: GoogleProcessingScreen(),
        ),
      ),
    );
  }
}
