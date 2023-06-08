/*
-------------------STEPS---------------------
<STATIC PART>
1.  Simple map with hardcoded markers

2.  Add custom icon to markers 

3.  Implement auto updating latlang bounds according to the mark locations
(mapController.animateCamera(CameraUpdate.newLatLngBounds()......)

4.  Add polyline feature

<DYNAMIC/LIVE PART>
5.  Add real location data (remove hardcoded locations)
Implement tauto update user loaction (current user marker) using location plugin package
Implement updating accident location using sensorData provider

 */
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:health_guard/models/objects.dart';
import 'package:health_guard/screens/map/map_model.dart';
import 'package:provider/provider.dart';

enum User { medical, police }

class PoliceMapScreen extends StatelessWidget {
  final User user;
  const PoliceMapScreen({required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              MapSection(
                user: user,
              ),
              MapBottom(),
            ],
          ),
        ),
      ],
    ));
  }
}

class MapSection extends StatefulWidget {
  final User user;
  const MapSection({required this.user, super.key});

  @override
  State<MapSection> createState() => _MapSectionState();
}

class _MapSectionState extends State<MapSection> {
  //
  // TODO : 0,0 after the accident location fixed by scacin
  //!  accidentLocation is harcoded until sachin fix accidentData model (sensorDataProvider)
  // Anuradhapura
  LatLng accidentLocation = LatLng(8.349866389584433, 80.40206109888315);
  //
  LatLng currentUserLocation = const LatLng(0, 0);
  //
  List<LatLng> polylinePoints = [
    const LatLng(0, 0),
    const LatLng(0, 0),
  ];
  //
  bool isMapControllerInitialized = false;

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

  late GoogleMapController mapController;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    isMapControllerInitialized = true;
  }

  @override
  Widget build(BuildContext context) {
    //
    //SensorDataModel data = context.watch<SensorDataProvider>().sensorDataModel;
    //accidentLocation = LatLng(data.latitude, data.longitude);
    //this is needed to make polyLines
    context.read<MapDataModel>().setAccidentLocation(accidentLocation);
    //
    currentUserLocation = context.watch<MapDataModel>().currentUserLocation;
    //
    polylinePoints = context.watch<MapDataModel>().polylineCoordinates;
    //
    updateLatLngBounds(context.watch<MapDataModel>().latLngBounds);
    //
    return GoogleMap(
      zoomControlsEnabled: false,
      trafficEnabled: false,
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(
          target: accidentLocation, //accident loc
          zoom: 9.0),
      markers: {
        // Marker for Accident location / .
        Marker(
            markerId: const MarkerId("accidentLocationMarker"),
            position: accidentLocation,
            infoWindow: const InfoWindow(title: "Accident"),
            icon: accidentIcon),
        // Marker for current app user location (medical/police)
        Marker(
            markerId: const MarkerId("userLocationMarker"),
            position: currentUserLocation,
            infoWindow: const InfoWindow(title: "You"),
            icon: (widget.user == User.medical) ? mediIcon : policeIcon),
      },
      polylines: {
        Polyline(
          polylineId: const PolylineId("route"),
          points: polylinePoints,
          color: const Color.fromARGB(172, 119, 45, 239),
          width: 6,
        ),
      },
    );
    /*
    Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: 30,
            vertical: MediaQuery.of(context).viewPadding.top + 14),
        child: Container(
          decoration: BoxDecoration(
              color: Color.fromARGB(217, 238, 110, 105)!.withOpacity(0.8),
              borderRadius: BorderRadius.all(Radius.circular(30)),
              border: Border.all(width: 2, color: Color.fromARGB(52, 0, 0, 0))),
          width: 220,
          height: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text("No Internet Connection"),
              Icon(Icons.mobiledata_off)
            ],
          ),
        ),
      ),
    );
    */
  }

  void updateLatLngBounds(LatLngBounds? latLngBounds) {
    if (isMapControllerInitialized) {
      if (latLngBounds != null) {
        mapController
            .animateCamera(CameraUpdate.newLatLngBounds(latLngBounds!, 100));
      }
    }
  }
}

class MapBottom extends StatelessWidget {
  const MapBottom({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
        child: Container(
          height: 80,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(20.0)),
            boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(12, 80, 78, 78).withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                  flex: 2,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20.0, 5, 25, 5),
                        child: CircleAvatar(
                          backgroundColor: Colors.grey[300],
                          radius: 28.0,
                        ),
                      ),
                      const Text(
                        "Sachin seram",
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  )),
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5.0, horizontal: 20.0),
                      child: FloatingActionButton(
                        backgroundColor: Color.fromARGB(255, 112, 138, 243),
                        onPressed: () {
                          context
                              .read<MapDataModel>()
                              .updateUserCurrentLocation();
                        },
                        child: const Icon(
                          Icons.directions_outlined,
                          size: 30,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
