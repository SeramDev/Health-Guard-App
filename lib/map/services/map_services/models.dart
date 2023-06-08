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

//"heartRate":
//"oxygenSaturation":
//"temperature":
//"diastolicBloodPressure":
class AccidentUserDetails {
  final String name;
  final String imgUrl;
  final String heartRate;
  final String oxygenSaturation;
  final String temperature;
  final String diastolicBloodPressure;

  AccidentUserDetails({
    required this.name,
    required this.imgUrl,
    required this.heartRate,
    required this.oxygenSaturation,
    required this.temperature,
    required this.diastolicBloodPressure,
  });
}

class AmbulanceMapUser extends MapUser {
  AmbulanceMapUser({required super.location});
}

class PoliceMapUser extends MapUser {
  PoliceMapUser({required super.location});
}



/*
//Harcoded values used for testing purposes
AmbulanceMapUser ambulanceMapUser =
    AmbulanceMapUser(location: LatLng(7.145040100796313, 80.01434708275534));

PoliceMapUser policeMapUser =
    PoliceMapUser(location: LatLng(7.994914496066218, 80.25313058833474));

AccidentUser accidentUser = AccidentUser(
    location: LatLng(7.349928286785943, 81.66602078443194),
    details: AccidentUserDetails(
      name: "Tharindu",
      imgUrl: "url",
      heartRate: "33",
      oxygenSaturation: "44",
      temperature: "34",
      diastolicBloodPressure: "445"
    ));
//Now this map has 4 users
*/