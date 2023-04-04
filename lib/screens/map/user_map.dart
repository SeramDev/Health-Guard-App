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

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;


  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
           //Must be "User" location
          target: LatLng(6.9270786,79.861243),
          // Change zoom level as you need (relative to target/user_location)
          zoom: 11.0,   
        ),
        markers: {
            // Demo: Marker for Accident location
            Marker(
              markerId: MarkerId("accidentLocationMarker"),   //colombo
              position: LatLng(6.9270786,79.861243)
            ),
            // Demo: Marker for a Police point.
            Marker(
                markerId: MarkerId("policeMarker"),
                position: LatLng(6.909172137362226, 79.93693838878633) //Srilak sea food
            ),
            // Demo: Marker for a Medical point
            Marker(
                markerId: MarkerId("mediMarker"),
                position: LatLng(6.891394774653336, 79.876261773337) //a hospital
            )
          },
      ),
    );
  }
}
