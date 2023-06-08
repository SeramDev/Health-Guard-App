// ignore_for_file: prefer_const_constructors
/*
User map only shows the markers
Markers:
  1.  User location
  2.  Ambulances locations
  3.  Police locations
 */
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class UserMapScreen extends StatefulWidget {
  const UserMapScreen({super.key});

  @override
  State<UserMapScreen> createState() => _UserMapScreenState();
}

class _UserMapScreenState extends State<UserMapScreen> {
  late GoogleMapController mapController;


  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  BitmapDescriptor mediIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor policeIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor accidentIcon = BitmapDescriptor.defaultMarker;

  @override
  void initState() {
    super.initState();
    BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(
                //This size is not working, so you have to change size of physical image
                size: Size(20, 20)),
            "assets/map/police128.png")
        .then((onValue) {
      setState(() {
        policeIcon = onValue;
      });
    });
    BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(
                //This size is not working, so you have to change size of physical image
                size: Size(20, 20)),
            "assets/map/medi128.png")
        .then((onValue) {
      setState(() {
        mediIcon = onValue;
      });
    });
    BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(
                //This size is not working, so you have to change size of physical image
                size: Size(20, 20)),
            "assets/map/accident128.png")
        .then((onValue) {
      setState(() {
        accidentIcon = onValue;
      });
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
           //Must be "User" location
          target: LatLng(6.920142888929199, 79.8873646472766),
          // Change zoom level as you need (relative to target/user_location)
          zoom: 13.0,   
        ),
        markers: {
            // Demo: Marker for Accident location
            Marker(
              markerId: MarkerId("accidentLocationMarker"),   //colombo
              position: LatLng(6.9270786,79.861243),
              icon: accidentIcon
            ),
            // Demo: Marker for a Police point.
            Marker(
                markerId: MarkerId("policeMarker"),
                position: LatLng(6.943216367864845, 79.90579207982185), 
                icon: policeIcon,

            ),
            // Demo: Marker for a Medical point
            Marker(
                markerId: MarkerId("mediMarker"),
                position: LatLng(6.891394774653336, 79.876261773337), //a hospital
                icon: mediIcon
            )
          },
      ),
    );
  }
}
