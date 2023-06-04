import 'package:google_maps_flutter/google_maps_flutter.dart';

/*
Raw data get from service layer
*/

abstract class MapUser {
  final LatLng location;
  MapUser({required this.location});
}

class AccidentUser extends MapUser {
  final AccidentUserDetails details;
  AccidentUser({
    required super.location,
    required this.details,
  });
}

class AccidentUserDetails {
  final String name;

  AccidentUserDetails({required this.name});
}

class AmbulanceMapUser extends MapUser {
  AmbulanceMapUser({required super.location});
}

class PoliceMapUser extends MapUser {
  PoliceMapUser({required super.location});
}

class CurrentUser extends MapUser {
  CurrentUser({required super.location});
}

//Now this map has 4 users
List<MapUser> mapUsers = [
  AmbulanceMapUser(location: LatLng(7.959554443388438, 80.74202216913154)),
  PoliceMapUser(location: LatLng(7.994914496066218, 80.25313058833474)),
  PoliceMapUser(location: LatLng(7.886104598780481, 80.65138496595011)),
  AccidentUser(
      location: LatLng(7.349928286785943, 81.66602078443194),
      details: AccidentUserDetails(name: "Tharindu")),
  PoliceMapUser(location: LatLng(8.805589291839963, 80.52905778387552)),
  CurrentUser(location: LatLng(8.073894098484436, 79.8624047795332)),
];
