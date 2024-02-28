import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class UserDetailModel {
  final int diastolicBloodPressure;
  final double heartRate;
  final bool isEmergencyButtonPressed;
  final double oxygenSaturation;
  final String status;
  final int systolicBloodPressure;
  final double temperature;

  UserDetailModel({
    required this.diastolicBloodPressure,
    required this.heartRate,
    required this.isEmergencyButtonPressed,
    required this.oxygenSaturation,
    required this.status,
    required this.systolicBloodPressure,
    required this.temperature,
  });

  factory UserDetailModel.fromJson(Map<String, dynamic> parsedJson) {
    return UserDetailModel(
      diastolicBloodPressure: parsedJson['diastolicBloodPressure'],
      heartRate: parsedJson['heartRate'],
      isEmergencyButtonPressed: parsedJson['isEmergencyButtonPressed'],
      oxygenSaturation: parsedJson['oxygenSaturation'],
      status: parsedJson['status'],
      systolicBloodPressure: parsedJson['systolicBloodPressure'],
      temperature: parsedJson['temperature'],
    );
  }
}

//============== service result ==================
abstract class UserDetailServiceResult {}

class SuccessUserDetailServiceResult extends UserDetailServiceResult {
  final UserDetailModel userDetailModel;

  SuccessUserDetailServiceResult({required this.userDetailModel});
}

class ErrorUserDetailServiceResult extends UserDetailServiceResult {}

Future<UserDetailServiceResult> getUserDetails() async {
  // 1 get curent user location using Geolocattoer package
  try {
    var url = Uri.parse('http://13.50.246.130/new/fetch-user-status?uid=123');
    var response = await http.get(
      url,
    );

    if (response.statusCode == 200) {
      log(response.body.toString());
      Map<String, dynamic> jsonModel = await compute(decodeJson, response.body);
      
      var details = UserDetailModel.fromJson(jsonModel);
      
      return SuccessUserDetailServiceResult(userDetailModel: details);
    } else {
      return ErrorUserDetailServiceResult();
    }
  } catch (e) {
    log("Catch error by -> (getUserDetails)");
    return ErrorUserDetailServiceResult();
  }
}

Map<String, dynamic> decodeJson(String jsonString) {
  final Map<String, dynamic> parsedJson = jsonDecode(jsonString);
  return parsedJson;
}
