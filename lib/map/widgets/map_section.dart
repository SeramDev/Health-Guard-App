import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:health_guard/map/map_bloc/map_provider.dart';
import 'package:health_guard/map/map_screen.dart';

class MapSection extends ConsumerStatefulWidget {
  final UserType userType;
  const MapSection({required this.userType, super.key});

  @override
  ConsumerState<MapSection> createState() => _MapSectionState();
}

class _MapSectionState extends ConsumerState<MapSection> {
  //========================================================================
  List<LatLng> polylinePoints = [
    const LatLng(0, 0),
    const LatLng(0, 0),
  ];
  //default markes - (not showing on map)
  Set<Marker> markers = {
    const Marker(
        markerId: MarkerId("accidentLocationMarker"),
        position: LatLng(0.0, 0.0),
        infoWindow: InfoWindow(title: "Accident"),
        icon: BitmapDescriptor.defaultMarker),
    // Marker for current app user location (medical/police)
    const Marker(
        markerId: MarkerId("userLocationMarker"),
        position: LatLng(0.0, 0.0),
        infoWindow: InfoWindow(title: "You"),
        icon: BitmapDescriptor.defaultMarker),
    const Marker(
        markerId: MarkerId("ambulanceLocationMarker"),
        position: LatLng(0.0, 0.0),
        infoWindow: InfoWindow(title: "Ambulance"),
        icon: BitmapDescriptor.defaultMarker),
  };
  //========================================================================
  bool isMapControllerInitialized = false;

  @override
  void initState() {
    super.initState();
  }

  late GoogleMapController mapController;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    isMapControllerInitialized = true;
  }

  @override
  Widget build(BuildContext context) {
     print(
        "build****************************************************************************************");
    //--------------State updater-------------------
    var mapNotifier = ref.watch(mapProvider);
    if (mapNotifier is SuccessMapState) {
      markers = mapNotifier.markers;
      print(markers.length);
    }
    //-----------------------------------------------
    return GoogleMap(
      zoomControlsEnabled: false,
      trafficEnabled: false,
      onMapCreated: _onMapCreated,
      initialCameraPosition: const CameraPosition(
          target:
              LatLng(7.358985391103516, 80.65234292851416), //kandy as target
          zoom: 8.0),
      markers: markers,
      polylines: {
        Polyline(
          polylineId: const PolylineId("route"),
          points: polylinePoints,
          color: const Color.fromARGB(172, 119, 45, 239),
          width: 6,
        ),
      },
    );
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

/*class MapBottom extends StatelessWidget {
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
                          // context
                          //     .read<MapDataModel>()
                          //     .updateUserCurrentLocation();
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
*/