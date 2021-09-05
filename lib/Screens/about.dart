import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class About extends StatefulWidget {
  const About({Key? key}) : super(key: key);

  @override
  _AboutState createState() => _AboutState();
}

const _urlinsta = 'https://www.instagram.com/_u/__sawali__/';

class _AboutState extends State<About> with AutomaticKeepAliveClientMixin {
  launchUrl() {
    launch(_urlinsta);
  }

  final List technical = [
    'images/hrithik.jpeg',
    'images/naman.jpeg',
    'images/ajay.jpeg',
    'images/Suraj.jpeg',
    'images/ketki.jpeg',
    'images/nayan.jpeg',
  ];
  final List content = [
    'images/sakshi.jpeg',
    'images/harshada.jpeg',
  ];
  final List market = [
    'images/sharwani.jpeg',
    'images/purvaja.jpeg',
    'images/prasad.jpeg',
    'images/nitin.jpeg',
    'images/krishna.jpeg',
    'images/chirag.jpeg',
  ];
  final List officer = [
    'images/abhishek.jpeg',
    'images/digvijay.jpeg',
    'images/vaibhav.jpeg',
  ];

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Stack(
      children: [
        ShaderMask(
          shaderCallback: (rect) => LinearGradient(colors: [
            Color.fromRGBO(255, 255, 255, 0.3),
            Color.fromRGBO(255, 255, 255, 0)
          ], begin: Alignment.bottomCenter, end: Alignment.center)
              .createShader(rect),
          blendMode: BlendMode.darken,
          child: Container(
            decoration: BoxDecoration(
              color: Color.fromRGBO(255, 255, 255, 0),
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: ListView(
            children: [
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Team Sawali",
                    style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(0, 33, 71, 0.9)),
                  )
                ],
              ),
              SizedBox(
                height: 5.0,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 15,
                  right: 15,
                  top: 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'We have developed an application for the safety of every citizen and'
                      ' humanity as a whole.',
                      style: GoogleFonts.merriweather(
                        textStyle: TextStyle(
                          color: Colors.black87,
                          letterSpacing: .5,
                          fontSize: 18.0,
                        ),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Column(
                children: [
                  Text(
                    "Contact Details",
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.w600,
                      color: Color.fromRGBO(0, 33, 51, 0.9),
                    ),
                  ),
                  const Divider(
                    height: 3,
                    thickness: 4,
                    indent: 95,
                    endIndent: 95,
                    color: Color.fromRGBO(0, 33, 51, 0.9),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'sawalisafety04@gmail.com',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 2.0,
                  ),
                  Text(
                    'Contact: 9860715106',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    onPressed: launchUrl,
                    icon: Image.asset(
                      'images/insta.png',
                      fit: BoxFit.cover,
                      height: 100.0,
                      width: 100.0,
                    ),
                    iconSize: 60.0,
                  ),
                  Text(
                    "Founder",
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.w600,
                      color: Color.fromRGBO(0, 33, 51, 0.9),
                    ),
                  ),
                  const Divider(
                    height: 3,
                    thickness: 4,
                    indent: 130,
                    endIndent: 130,
                    color: Color.fromRGBO(0, 33, 51, 0.9),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    child: CircleAvatar(
                      backgroundImage: AssetImage("images/dhananjay.jpg"),
                      radius: 100.0,
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Text(
                    'Mr. Dhananjay Ashok Rashinkar',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Technical Team",
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.w600,
                      color: Color.fromRGBO(0, 33, 51, 0.9),
                    ),
                  )
                ],
              ),
              const Divider(
                height: 3,
                thickness: 4,
                indent: 95,
                endIndent: 95,
                color: Color.fromRGBO(0, 33, 51, 0.9),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width,
                ),
                child: CarouselSlider(
                    items: technical
                        .map((e) => Container(
                              child: Image.asset(
                                e,
                                fit: BoxFit.fitWidth,
                              ),
                            ))
                        .toList(),
                    options: CarouselOptions(
                      autoPlay: true,
                      aspectRatio: 2.0,
                      enlargeCenterPage: true,
                    )),
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "O & C officer",
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.w600,
                      color: Color.fromRGBO(0, 33, 51, 0.9),
                    ),
                  )
                ],
              ),
              const Divider(
                height: 3,
                thickness: 4,
                indent: 110,
                endIndent: 110,
                color: Color.fromRGBO(0, 33, 51, 0.9),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width,
                ),
                child: CarouselSlider(
                    items: officer
                        .map((e) => Container(
                              child: Image.asset(
                                e,
                                fit: BoxFit.fitWidth,
                              ),
                            ))
                        .toList(),
                    options: CarouselOptions(
                      autoPlay: true,
                      aspectRatio: 2.0,
                      enlargeCenterPage: true,
                    )),
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Content and Designer Team",
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.w600,
                      color: Color.fromRGBO(0, 33, 51, 0.9),
                    ),
                  )
                ],
              ),
              const Divider(
                height: 3,
                thickness: 4,
                indent: 25,
                endIndent: 25,
                color: Color.fromRGBO(0, 33, 51, 0.9),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width,
                ),
                child: CarouselSlider(
                    items: content
                        .map((e) => Container(
                              child: Image.asset(
                                e,
                                fit: BoxFit.fitWidth,
                              ),
                            ))
                        .toList(),
                    options: CarouselOptions(
                      autoPlay: true,
                      aspectRatio: 2.0,
                      enlargeCenterPage: true,
                    )),
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Marketing Team",
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.w600,
                      color: Color.fromRGBO(0, 33, 51, 0.9),
                    ),
                  )
                ],
              ),
              const Divider(
                height: 3,
                thickness: 4,
                indent: 90,
                endIndent: 90,
                color: Color.fromRGBO(0, 33, 51, 0.9),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width,
                ),
                child: CarouselSlider(
                    items: market
                        .map((e) => Container(
                              child: Image.asset(
                                e,
                                fit: BoxFit.fitWidth,
                              ),
                            ))
                        .toList(),
                    options: CarouselOptions(
                      autoPlay: true,
                      aspectRatio: 2.0,
                      enlargeCenterPage: true,
                    )),
              ),
            ],
          ),
        )
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
