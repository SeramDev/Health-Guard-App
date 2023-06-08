import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
/*
Each method in this changeNotifier class runs in "Chainged manner" / "one after another"
01 -> 02 -> 03 -> 04
 */
class MapDataModel extends ChangeNotifier {
  LatLng accidentLocation = const LatLng(0, 0);

  LatLng currentUserLocation = const LatLng(0, 0);

  LatLngBounds? latLngBounds;

  List<LatLng> polylineCoordinates = [];

  void updateUserCurrentLocation() {
    _getLocationPermissions();
  }

  //This method call by ui to pass accident location inside to this changeNotifier class
  void setAccidentLocation(LatLng accidentLoc) {
    accidentLocation = accidentLoc;
  }

  /*
  
  01 Part

   */
  Future<void> _getLocationPermissions() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    runLocationTask();
  }

  /*
  
  02 Part

   */
  runLocationTask() async {
    Location location = Location();
    LocationData locationData;

    // When "show direction" button clicked
    /*try {
      locationData =
          await location.getLocation().timeout(const Duration(seconds: 2));
      if (locationData.latitude != null && locationData.longitude != null) {
        currentUserLocation =
            LatLng(locationData.latitude!, locationData.longitude!);
        notifyListeners();
        updateBoundsFromLatLngList([accidentLocation, currentUserLocation]);
      }
    } catch (e) {
      //
    }*/

    // Registerd for live user location updates
    location.onLocationChanged.listen((LocationData currentLocation) {
      if (currentLocation.latitude != null &&
          currentLocation.longitude != null) {
        /*
        THis if condtion used to avoid unwanted polyline drwaings (optionl)
        Without this polyline redraw in every location plugin listen updates,
        */
        if (currentUserLocation.latitude != currentLocation.latitude! ||
            currentUserLocation.longitude != currentLocation.longitude!) {
          currentUserLocation =
              LatLng(currentLocation.latitude!, currentLocation.longitude!);
        } else {
          return;
        }
        print("Live updates*************************************************");
        //Below methods are called only when currentUser location really changed,
        // due to help of above condition
        updateBoundsFromLatLngList([currentUserLocation, accidentLocation]);
        notifyListeners();
        getPolyPoints();
      }
    });
  }

  /*
  
  03
  
   */
  void updateBoundsFromLatLngList(List<LatLng> list) {
    double? x0, x1, y0, y1;
    for (LatLng latLng in list) {
      if (x0 == null || x1 == null || y0 == null || y1 == null) {
        x0 = x1 = latLng.latitude;
        y0 = y1 = latLng.longitude;
      } else {
        if (latLng.latitude > x1) x1 = latLng.latitude;
        if (latLng.latitude < x0) x0 = latLng.latitude;
        if (latLng.longitude > y1) y1 = latLng.longitude;
        if (latLng.longitude < y0) y0 = latLng.longitude;
      }
    }
    //Failed assertion: line 81 pos 16: 'southwest.latitude <= northeast.latitude': is not true.
    if (x0 !<= x1!)  {
      latLngBounds =
        LatLngBounds(northeast:LatLng(x1!, y1!) , southwest: LatLng(x0!, y0!),);
        notifyListeners();
    }
  }

  /*
  
  04
  
   */
  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();
    //! MUSTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT
    /**
     * Otherwise markers changed but this still showing for old marker location,
     * Bcz this take some time to run (async)
     */
    polylineCoordinates = [];
    //
    PolylineResult result;

    try {
      result = await polylinePoints.getRouteBetweenCoordinates(
        //!<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>
        //!  Warning remove this before publish to github
        "AIzaSyCVs3r5DveLreJRV-4JqdbzXAEJwZo2hYE",
        //!<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>
        PointLatLng(accidentLocation.latitude, accidentLocation.longitude),
        PointLatLng(
            currentUserLocation.latitude, currentUserLocation.longitude),
      );
      if (result.points.isNotEmpty) {
        for (int i = 0; i < result.points.length; i++) {
          polylineCoordinates.add(
              LatLng(result.points[i].latitude, result.points[i].longitude));
        }
        notifyListeners();
      }
    } catch (e) {
      /*
       * Due to wrong map key no errors are throwed (only empty list returned)
       * But due to network error, error will be throwed 
       */
    }
  }
}
