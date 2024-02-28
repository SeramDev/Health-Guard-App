import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

import 'geolocator.dart';

abstract class ServiceResult {}

abstract class LocationDetails {}

class UserLocation extends LocationDetails {
  final double latitude;
  final double longitude;

  UserLocation({required this.latitude, required this.longitude});

  factory UserLocation.fromJson(Map<String, dynamic> parsedJson) {
    return UserLocation(
        latitude: parsedJson['latitude'] as double,
        longitude: parsedJson['longitude'] as double);
  }
}

class PoliceLocation extends LocationDetails {
  final double latitude;
  final double longitude;

  PoliceLocation({required this.latitude, required this.longitude});

  factory PoliceLocation.fromJson(Map<String, dynamic> parsedJson) {
    return PoliceLocation(
        latitude: parsedJson['latitude'], longitude: parsedJson['longitude']);
  }
}

class AmbulanceLocation extends LocationDetails {
  final double latitude;
  final double longitude;

  AmbulanceLocation({required this.latitude, required this.longitude});

  factory AmbulanceLocation.fromJson(Map<String, dynamic> parsedJson) {
    return AmbulanceLocation(
        latitude: parsedJson['latitude'], longitude: parsedJson['longitude']);
  }
}

//
class SuccessResult extends ServiceResult {
  final UserLocation userLocation;
  final PoliceLocation policeLocation;
  final AmbulanceLocation ambulanceLocation;

  SuccessResult(
      {required this.userLocation,
      required this.policeLocation,
      required this.ambulanceLocation});

  factory SuccessResult.fromJson(Map<String, dynamic> parsedJson) {
    return SuccessResult(
        userLocation: UserLocation.fromJson(parsedJson),
        policeLocation: PoliceLocation.fromJson(parsedJson),
        ambulanceLocation: AmbulanceLocation.fromJson(parsedJson));
  }
}

//
enum ErrorTypes { connectionError, serverError, jsonDecodeError }

class ErrorResult extends ServiceResult {
  final ErrorTypes errorType;

  ErrorResult({required this.errorType});
}

Future<ServiceResult> updateAndRequestLoacations({required String uid}) async {
  // 1 get curent user location using Geolocattoer package
  try {
    Position position = await currentUserPosition();
    Map<String, dynamic> requestBody = {
      "uid": uid,
      "longitude": position.longitude,//80.56773775671876, //position.longitude,
      "latitude": position.latitude//6.00807814077084   //position.latitude
    };
   
    String jsonString = await compute(encodeJson, requestBody);

    var url = Uri.parse('http://13.50.246.130/new/store-user-location');
    var response = await http.post(
      url,
      body: jsonString,
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonModel = await compute(decodeJson, response.body);
      AmbulanceLocation.fromJson(jsonModel['456']);
      return SuccessResult(
          userLocation: UserLocation.fromJson(jsonModel['123']),
          policeLocation: PoliceLocation.fromJson(jsonModel['456']),
          ambulanceLocation: AmbulanceLocation.fromJson(jsonModel['789']));
    } else {
      return ErrorResult(errorType: ErrorTypes.serverError);
    }
  } catch (e) {
    log("Catch error by -> (updateAndRequestLoacations)");
    return ErrorResult(errorType: ErrorTypes.connectionError);
  }
}

String encodeJson(Map<String, dynamic> model) {
  final String jsonString = jsonEncode(
      model); //.map((key, value) => null)//.cast<Map<String, dynamic>>();
  return jsonString;
}

Map<String, dynamic> decodeJson(String jsonString) {
  final Map<String, dynamic> parsedJson = jsonDecode(jsonString);
  return parsedJson;
}
