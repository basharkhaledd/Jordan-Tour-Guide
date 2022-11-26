import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tour_guide_app/provider/user_provider.dart';
import 'ViewDestinationPage.dart';
import 'package:tour_guide_app/Services/getWeather.dart';
import 'package:tour_guide_app/Services/getCurrentLocation.dart';

class LoadingScreen extends StatefulWidget {
  LoadingScreen({
    super.key,
    required this.siteName,
    required this.governorate,
  });
  String siteName;
  String governorate;
  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getDestinationWeather();
    getsiteinfo();
  }

  getsiteinfo() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('sites')
        .doc('${widget.siteName}'.trim())
        .get();

    setState(() {
      thisSiteName = (snap.data() as Map<String, dynamic>)['title'];
    });
  }

  String thisSiteName = '';
  void getDestinationWeather() async {
    WeatherModel weatherModel = WeatherModel();
    // var weatherData = await weatherModel.getCityWeather(widget.siteName);
    var weatherData = await weatherModel.getCityWeather(widget.governorate);
    await getsiteinfo();
    print(widget.siteName);
    print(thisSiteName);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) {
          return DestinationPage(
            siteName: widget.siteName.trim(),
            // siteName: thisSiteName,
            locationWeather: weatherData,
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
