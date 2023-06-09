import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:health_guard/map/bloc/map/user_map_provider.dart';
import 'package:health_guard/map/ui_controllers/controllers.dart';
import 'package:health_guard/map/widgets/map_bottom.dart';

enum UserType { user, police, ambulance }

class MapSection extends ConsumerStatefulWidget {
  const MapSection({super.key, required this.userType});

  final UserType userType;

  @override
  ConsumerState<MapSection> createState() => _MapSectionState();
}

class _MapSectionState extends ConsumerState<MapSection> {
  List<LatLng> polylinePoints = [
    const LatLng(0, 0),
    const LatLng(0, 0),
  ];

  //default markes - (not showing on map)
  BitmapDescriptor mediIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor policeIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor accidentIcon = BitmapDescriptor.defaultMarker;

  bool isMapControllerInitialized = false;

  Timer? timer;

  @override
  void initState() {
    var mapNotifier = ref.read(userMapProvider.notifier);
    String user = "123";
    if (widget.userType == UserType.user) {
      user = "123";
    } else if (widget.userType == UserType.police) {
      user = "456";
    } else {
      user = "789";
    }
    // 1st time
    mapInitialize(uid: user);

    // 2nd up (For periodic)
    timer = Timer.periodic(const Duration(seconds: 15), (timer) {
      mapNotifier.updateMapMarkers(uid: user);
    });
    super.initState();
  }

  late GoogleMapController mapController;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    isMapControllerInitialized = true;
  }

  @override
  Widget build(BuildContext context) {
    UserMapState mapDetails = ref.watch(userMapProvider) as UserMapState;

    LatLng userLoacation = LatLng(
        mapDetails.userLocation.latitude, mapDetails.userLocation.longitude);
    LatLng policeLocation = LatLng(mapDetails.policeLocation.latitude,
        mapDetails.policeLocation.longitude);

    LatLng ambulanceLoacation = LatLng(mapDetails.ambulanceLocation.latitude,
        mapDetails.ambulanceLocation.longitude);

    Set<Marker> markers = {
      /*
      (widget.userType != UserType.user) ? Marker(
          markerId: const MarkerId("userLocationMarker"),
          position: userLoacation,
          infoWindow: const InfoWindow(title: "User"),
          icon: accidentIcon,
          onTap: () {
            //isUserMarkerTapped.value = true;
            showBottomSheet(
              context: context,
              builder: (context) {
                return MapBottom();
              },
            );
          }) : const Marker(
          markerId: MarkerId("none"),
          position: LatLng(0.0, 0.0),
          ),
       */
      // Marker for current app user location (medical/police)
      Marker(
          markerId: const MarkerId("userLocationMarker"),
          position: userLoacation,
          infoWindow: const InfoWindow(title: "User"),
          icon: accidentIcon,
          onTap: () {
            //isUserMarkerTapped.value = true;
            showBottomSheet(
              context: context,
              builder: (context) {
                return const MapBottom();
              },
            );
          }),
      (widget.userType != UserType.ambulance)
          ? Marker(
              markerId: const MarkerId("pl"),
              position: policeLocation,
              infoWindow: const InfoWindow(title: "Police"),
              icon: policeIcon)
          : const Marker(
              markerId: MarkerId("none"),
              position: LatLng(0.0, 0.0),
            ),
      (widget.userType != UserType.police)
          ? Marker(
              markerId: const MarkerId("amb"),
              position:
                  ambulanceLoacation, //LatLng(80.29098364808792, 7.98490269331092),//ambulanceLoacation,
              infoWindow: const InfoWindow(title: "Ambulance"),
              icon: mediIcon)
          : const Marker(
              markerId: MarkerId("none"),
              position: LatLng(0.0, 0.0),
            ),
    };

    return GoogleMap(
      zoomControlsEnabled: false,
      trafficEnabled: false,
      onMapCreated: _onMapCreated,
      initialCameraPosition: const CameraPosition(
          target:
              LatLng(7.358985391103516, 80.65234292851416), //kandy as target
          zoom: 8.0),
      markers: markers,
      /*polylines: {
        Polyline(
          polylineId: const PolylineId("route"),
          points: polylinePoints,
          color: const Color.fromARGB(172, 119, 45, 239),
          width: 6,
        ),
      },*/
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  /*void updateLatLngBounds(LatLngBounds? latLngBounds) {
    if (isMapControllerInitialized) {
      if (latLngBounds != null) {
        mapController
            .animateCamera(CameraUpdate.newLatLngBounds(latLngBounds!, 100));
      }
    }
  }*/
  void mapInitialize({required String uid}) async {
    // 1 set value notifie r to LOADING
    try {
      await intializeIcons().timeout(const Duration(seconds: 2));
      bool result =
          await ref.read(userMapProvider.notifier).updateMapMarkers(uid: uid);
      if (result == true) {
        // set value notifier SUCCESS
        isMapLoaded.value = true;
      } else {
        // set value to ERROR
      }
    } catch (e) {
      // set value notifier to ERROR
    }
  }

  Future<bool> intializeIcons() async {
    try {
      policeIcon = await BitmapDescriptor.fromAssetImage(
          const ImageConfiguration(
              //This size is not working, so you have to change size of physical image
              size: Size(20, 20)),
          "assets/map/police128.png");

      mediIcon = await BitmapDescriptor.fromAssetImage(
          const ImageConfiguration(
              //This size is not working, so you have to change size of physical image
              size: Size(20, 20)),
          "assets/map/medi128.png");

      accidentIcon = await BitmapDescriptor.fromAssetImage(
          const ImageConfiguration(
              //This size is not working, so you have to change size of physical image
              size: Size(20, 20)),
          "assets/map/accident128.png");
      return true;
    } catch (e) {
      return false;
    }
  }
}
