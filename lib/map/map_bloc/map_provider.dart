import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:health_guard/map/detail_bloc/detail_provider.dart';
import 'package:health_guard/map/map_screen.dart';
import 'package:health_guard/map/map_screen.dart';
import 'package:health_guard/map/service/data.dart';
import 'package:riverpod/riverpod.dart';

abstract class MapState {}

class LoadingMapState extends MapState {}

class SuccessMapState extends MapState {
  final Set<Marker> markers;
  SuccessMapState({required this.markers});
}

class ErrorMapState extends MapState {}

class MapNotifier extends StateNotifier {
  final Ref ref;

  MapNotifier(this.ref) : super(LoadingMapState());

  BitmapDescriptor mediIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor policeIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor accidentIcon = BitmapDescriptor.defaultMarker;

  late UserType currentUserType;

  // This method call on TOP of initState
  void intilizeMap(UserType userType) async {
    // 1 set userType
    currentUserType = userType;
    // initialize icons
    await intializeIcons();
    // call update makers
    updateMapMarkers();
  }

  // This method is called by location bloc
  void updateMapMarkers() async {
    List<MapUser> mapUsersList = mapUsers;
    // 1 - call async services and get data
    await Future.delayed(Duration(seconds: 5));                  //PLZ ADD TIMEOUT
    // if error -> state =  ErrorMapState()
    //else below
    Set<Marker> markers = {};
    for (int i = 0; i < mapUsersList.length; i++) {
      if (mapUsersList[i] is AccidentUser) {
        if (currentUserType == UserType.accidentUser) {
          //nothing
        } else {
          markers.add(Marker(
            markerId: MarkerId("$i"),
            position: mapUsersList[i]
                .location, //LatLng(8.349866389584433, 80.40206109888315),
            infoWindow: const InfoWindow(title: "Accident"),
            icon: accidentIcon,
            onTap: () {
              ref.read(detailProvider.notifier).state = ShowDetailState(
                  accidentUserDetails:
                      (mapUsersList[i] as AccidentUser).details);
            },
          ));
        }
      } else if (mapUsersList[i] is CurrentUser) {
        markers.add(Marker(
          markerId: MarkerId("$i"),
          position: mapUsersList[i]
              .location, //LatLng(8.349866389584433, 80.40206109888315),
          infoWindow: const InfoWindow(title: "Accident"),
          icon: BitmapDescriptor.defaultMarker,
          onTap: null,
        ));
      } else if (mapUsersList[i] is PoliceMapUser) {
        markers.add(Marker(
            markerId: MarkerId("$i"),
            position: mapUsersList[i]
                .location, //LatLng(7.974423067485081, 81.04502894477059),
            infoWindow: const InfoWindow(title: "Police"),
            icon: policeIcon,
            onTap: null));
      } else {
        markers.add(Marker(
          markerId: MarkerId("$i"),
          position: mapUsersList[i]
              .location, //LatLng(7.241228693707071, 79.92176429361847),
          infoWindow: const InfoWindow(title: "Ambulance"),
          icon: mediIcon,
          onTap: null,
        ));
      }
    }
    state = SuccessMapState(markers: markers);
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

final mapProvider = StateNotifierProvider((ref) => MapNotifier(ref));
