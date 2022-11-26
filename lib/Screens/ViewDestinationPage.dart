import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:tour_guide_app/Firebase_Services/firestore_methods.dart';

import 'package:tour_guide_app/Screens/MapsLoadingScreen.dart';
import 'package:tour_guide_app/Screens/post_comment_screen.dart';
import 'package:tour_guide_app/Services/GetWeather.dart';

import 'package:tour_guide_app/homepage.dart';
import 'package:tour_guide_app/utils/utils.dart';

import '../widgets/weatherWidget.dart';

class DestinationPage extends StatefulWidget {
  final String siteName;
  final locationWeather;
  const DestinationPage(
      {super.key, required this.siteName, required this.locationWeather});

  @override
  State<DestinationPage> createState() => _DestinationPageState();
}

class _DestinationPageState extends State<DestinationPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateUi(widget.locationWeather);
    getSiteDescription();
    getSiteImageList();
    print(imageList);
    getUsername();
  }

  addFavourite() async {
    try {
      await FireStoreMethods().addFavourite('${widget.siteName}'.trim());
    } catch (err) {
      showSnackBar(
        context,
        err.toString(),
      );
    }
  }

  WeatherModel weather = WeatherModel();
  late double temp;
  late String weatherIcon;
  void updateUi(dynamic weatherData) {
    if (weatherData == null) {
      temp = 0;
      weatherIcon = '';
      return;
    }
    setState(() {
      temp = weatherData['main']['temp'];
      var condition = weatherData['weather'][0]['id'];
      weatherIcon = weather.getWeatherIcon(condition);
    });
  }

  Color mycolor = Color.fromARGB(255, 245, 245, 244);
  Color mycolorr = Color.fromARGB(255, 243, 5, 5);

  List<bool> expanded = [false, false, false, false];

  getSiteDescription() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('sites')
        .doc('${widget.siteName}'.trim())
        .get();

    setState(() {
      description = (snap.data() as Map<String, dynamic>)['description'];
    });
    print(snap.data());
  }

  getSiteImageList() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('sites')
        .doc('${widget.siteName}'.trim())
        .get();

    setState(() {
      imageList = (snap.data() as Map<String, dynamic>)['imageList'];
    });
    // print(snap.data());
  }

  getUsername() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    setState(() {
      username = (snap.data() as Map<String, dynamic>)['username'];
    });
    print(snap.data());
  }

  String description = '';
  List imageList = [];
  String username = '';
  @override
  Widget build(BuildContext context) {
    // User userProvider = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.siteName}'.trim()),
        leading: InkWell(
          onTap: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(),
                ));
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                if (mycolor == Color.fromARGB(255, 245, 245, 244)) {
                  mycolor = Color.fromARGB(255, 243, 5, 5);
                } else {
                  mycolor = Color.fromARGB(255, 245, 245, 244);
                }
              });
              addFavourite();
            },
            icon: Icon(Icons.favorite),
            color: mycolor,
          ),
          SizedBox(
            width: 0,
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MapsLoadingScreen(
                        siteName: '${widget.siteName}'.trim()),
                  ));
            },
            icon: Icon(Icons.map),
          ),
        ],

        // backgroundColor: Color.fromARGB(221, 68, 59, 59),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 10, top: 10),
              child: CarouselSlider(
                options: CarouselOptions(
                    enlargeCenterPage: true,
                    enableInfiniteScroll: false,
                    autoPlay: true),
                items: imageList
                    .map((e) => ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Stack(
                            fit: StackFit.expand,
                            children: <Widget>[
                              Image.network(
                                e,
                                width: 1050,
                                height: 350,
                                fit: BoxFit.cover,
                              )
                            ],
                          ),
                        ))
                    .toList(),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 40, right: 40, top: 50, bottom: 50),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                      child: Container(
                        margin: EdgeInsets.only(right: 5),
                        // child: Text(mysiteStorage.getSiteDescription(
                        //     siteName: widget.siteName)),
                        child: ReadMoreText(
                          '$description',
                          style: TextStyle(fontSize: 15),
                          trimLines: 5,
                          colorClickableText: Colors.black,
                          trimMode: TrimMode.Line,
                          trimCollapsedText: '...Read more',
                          trimExpandedText: ' Less',
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                      child: Container(
                    child: Weather(
                        icon: weatherIcon, tempreure: temp.toInt().toString()),
                  )),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 40, right: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return CommentsScreen(
                                siteName: '${widget.siteName}'.trim());
                          },
                        ),
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: const ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                        ),
                        color: Colors.grey,
                      ),
                      child: Text(" reviews and comments "),
                    ),
                  ),

                  // ExpansionPanelList(
                  //     animationDuration: Duration(milliseconds: 500),
                  //     dividerColor: Colors.black87,
                  //     elevation: 1,
                  //     children: [
                  //       ExpansionPanel(
                  //         headerBuilder: (context, isExpanded) {
                  //           return Text("What to see");
                  //         },
                  //         body: Text(description),
                  //         isExpanded: expanded[0],
                  //       ),
                  //       ExpansionPanel(
                  //         headerBuilder: (context, isExpanded) {
                  //           return Text("Activites");
                  //         },
                  //         body: Text(
                  //             " An inscription written by “Abdomanchos”, indicates that the tomb was to be used for himself and his family, probably in the reign of Malichus II (40- 70 AD)."),
                  //         isExpanded: expanded[1],
                  //       ),
                  //       ExpansionPanel(
                  //         headerBuilder: (context, isExpanded) {
                  //           return Text("Reviews");
                  //         },
                  //         body: InkWell(
                  //           onTap: () {
                  //             Navigator.push(
                  //               context,
                  //               MaterialPageRoute(
                  //                 builder: (context) {
                  //                   return CommentsScreen(
                  //                       siteName:
                  //                           '${widget.siteName}'.trim());
                  //                 },
                  //               ),
                  //             );
                  //           },
                  //           child: Text(" click here to see reviews"),
                  //         ),
                  //         isExpanded: expanded[2],
                  //       ),
                  //       ExpansionPanel(
                  //         headerBuilder: (context, isExpanded) {
                  //           return Text("Guides to help you");
                  //         },
                  //         body: TextButton(
                  //           child: Text(
                  //             "press here",
                  //             style: TextStyle(color: Colors.white),
                  //           ),
                  //           onPressed: () {
                  //             Navigator.of(context)
                  //                 .push(MaterialPageRoute(builder: (context) {
                  //               return Guide();
                  //             }));
                  //           },
                  //         ),
                  //         isExpanded: expanded[3],
                  //       ),
                  //     ],
                  //     expansionCallback: (panelIndex, isExpanded) {
                  //       setState(() {
                  //         expanded[panelIndex] = !isExpanded;
                  //       });
                  //     }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
