import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sawali/Auth/googlesign.dart';
import 'package:google_fonts/google_fonts.dart';

class Start extends StatefulWidget {
  const Start({Key? key}) : super(key: key);

  @override
  _StartState createState() => _StartState();
}

class _StartState extends State<Start> {
  @override
  Widget build(BuildContext context) {
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
              flex: 7,
              child: Padding(
                padding: EdgeInsets.only(top: 80.0, right: 10.0, left: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Hi, We Are ",
                          style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w400,
                              color: Colors.white),
                        ),
                        Text(
                          "Sawali ",
                          style: GoogleFonts.merriweather(
                            textStyle: TextStyle(
                              fontSize: 20.0,
                              color: Color.fromRGBO(125, 249, 255, 0.9),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text("We are here to give you absolute Protection",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.merriweather(
                          textStyle:
                              TextStyle(color: Colors.white, fontSize: 15.0),
                        )),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: Text(
                        "We have come up with something beneficial for the safety of every citizen and mankind as a whole.",
                        style: GoogleFonts.merriweather(
                          textStyle: TextStyle(
                            fontSize: 15.0,
                            color: Colors.white,
                          ),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 5.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "The ",
                                  style: GoogleFonts.merriweather(
                                    textStyle: TextStyle(
                                        color: Colors.white, fontSize: 15.0),
                                  ),
                                ),
                                Text(
                                  "StartUp ",
                                  style: GoogleFonts.merriweather(
                                    textStyle: TextStyle(
                                        color: Colors.red, fontSize: 15.0),
                                  ),
                                ),
                                Text("we're working on is",
                                    style: GoogleFonts.merriweather(
                                      textStyle: TextStyle(
                                          color: Colors.white, fontSize: 15.0),
                                    ))
                              ])
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        "Sawali-Freedom not feardom.",
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(125, 249, 255, 0.9)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 10.0),
                      child: Text(
                        "Through this we're aiming to ensure the safety of the human race using technology.",
                        style: GoogleFonts.merriweather(
                          textStyle:
                              TextStyle(fontSize: 15.0, color: Colors.white),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Image(
                      image: AssetImage('images/_location.png'),
                      height: 180,
                    )
                  ],
                ),
              ),
            ),
            Expanded(
                flex: 2,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 250.0,
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(125, 249, 255, 0.9),
                            borderRadius: BorderRadius.circular(100),
                            boxShadow: [
                              BoxShadow(
                                  color: Color.fromRGBO(0, 33, 71, 0.9),
                                  offset: Offset(0, 10),
                                  blurRadius: 7)
                            ]),
                        child: TextButton(
                          onPressed: () {
                            final provider = Provider.of<GoogleSignInProvider>(
                                context,
                                listen: false);
                            provider.googleLogin();
                          },
                          child: Text(
                            'Login To Share Location',
                            style: TextStyle(
                                color: Color.fromRGBO(25, 25, 112, 0.9),
                                fontWeight: FontWeight.bold,
                                fontSize: 15.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
