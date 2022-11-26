import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tour_guide_app/Screens/GoogleMap.dart';
import 'ViewDestinationPage.dart';
import 'package:tour_guide_app/Services/getWeather.dart';
import 'package:tour_guide_app/Services/getCurrentLocation.dart';

class MapsLoadingScreen extends StatefulWidget {
  final String siteName;
  MapsLoadingScreen({
    required this.siteName,
    super.key,
  });

  @override
  State<MapsLoadingScreen> createState() => _MapsLoadingScreenState();
}

class _MapsLoadingScreenState extends State<MapsLoadingScreen> {
  @override
  getsiteLng() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('sites')
        .doc(widget.siteName)
        .get();

    setState(() {
      sitelat = (snap.data() as Map<String, dynamic>)['latitude'];
    });
    print('sitelat is $sitelat');
  }

  getStielat() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('sites')
        .doc(widget.siteName)
        .get();

    setState(() {
      sitelon = (snap.data() as Map<String, dynamic>)['longitude'];
    });
    print('sitelon is $sitelon');
  }

  double sitelat = 1;
  double sitelon = 1;

  void initState() {
    super.initState();
    getCurrentLocation();
    getsiteLng();
    getStielat();
  }

  Future<dynamic> getCurrentLocation() async {
    Location location = Location();
    await location.getLocation();
    await getsiteLng();
    await getStielat();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) {
          return GoogleMapNavigator(
            CurrentLocationLat: location.latitude,
            CurrentLocationLon: location.longitude,
            siteName: widget.siteName,
            sitelat: sitelat,
            sitelon: sitelon,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
