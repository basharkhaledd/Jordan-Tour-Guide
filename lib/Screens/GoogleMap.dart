import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tour_guide_app/Services/getCurrentLocation.dart';

class GoogleMapNavigator extends StatefulWidget {
  final double? CurrentLocationLat;
  final double? CurrentLocationLon;
  final String siteName;
  final double? sitelat;
  final double? sitelon;
  GoogleMapNavigator({
    Key? key,
    required this.sitelat,
    required this.sitelon,
    required this.CurrentLocationLat,
    required this.CurrentLocationLon,
    required this.siteName,
  }) : super(key: key);

  @override
  State<GoogleMapNavigator> createState() => GoogleMapNavigatorState();
}

class GoogleMapNavigatorState extends State<GoogleMapNavigator> {
  // Future<dynamic> getCurrentLocationLat() async {
  //   Location location = Location();
  //   await location.getLocation();
  //   return [location.longitude,location.longitude];
  // }

  final Completer<GoogleMapController> _controller = Completer();

  late LatLng sourceLocation =
      LatLng(widget.CurrentLocationLat!, widget.CurrentLocationLon!);
  late LatLng destination = LatLng(widget.sitelat!, widget.sitelon!);

  List<LatLng> polylineCoordinates = [];

  void getpolypoints() async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      "AIzaSyD7tckf0pB9D87IZPD2-BDzPTr1QPoZNJU",
      PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
      PointLatLng(destination.latitude, destination.longitude),
    );

    if (result.points.isNotEmpty) {
      result.points.forEach(
        (PointLatLng point) => polylineCoordinates.add(
          LatLng(point.latitude, point.longitude),
        ),
      );
      setState(() {});
    }
  }

  @override
  void initState() {
    print('site lat is ${widget.sitelat}');
    print('site lon is ${widget.sitelon}');
    print(widget.CurrentLocationLat);
    print(widget.CurrentLocationLon);
    // getsiteLng();
    // getStielat();
    getpolypoints();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${widget.siteName}'.trim(),
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
      ),
      body: GoogleMap(
          polylines: {
            Polyline(
              polylineId: PolylineId('route'),
              points: polylineCoordinates,
              width: 6,
            )
          },
          initialCameraPosition:
              CameraPosition(target: sourceLocation, zoom: 15),
          markers: {
            Marker(markerId: MarkerId("source"), position: sourceLocation),
            Marker(markerId: MarkerId("Destination"), position: destination),
          }),
    );
  }
}
