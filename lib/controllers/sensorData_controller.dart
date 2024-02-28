import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:logger/logger.dart';
import '../models/objects.dart';

class SensorDataController {
  final endpointUrl = "http://13.50.246.130/new/fetch-user-status?uid=123";

  Future<SensorDataModel> fetchData() async {
    Response res;
    try {
      res =
          await get(Uri.parse(endpointUrl)).timeout(const Duration(seconds: 5));
      //Below logger causes asynchronous suspension
      //Logger().i(res.statusCode);
      if (res.statusCode == 200) {
        //final json = jsonDecode(res.body);
        //return SensorDataModel.fromJson(json['userData']);

        // Use the compute function to run parseJson in a separate isolate.
        Logger().i(res.toString());
        return compute(parseJson, res);
      } else {
        throw Exception('Failed to load user data');
      }
    } catch (e) {
      throw Exception('Cannot fetch data from server');
    }
    /*
    await Future.delayed(const Duration(seconds: 5));
    return SensorDataModel(1, 1, 1, 1, 1, 1, 1, "Abnormal");
    */
  }

  // A function that converts a response body into a SensorModel in a seperate isolate
  SensorDataModel parseJson(Response response) {
    final parsedJson = jsonDecode(response.body);

    Logger().i(SensorDataModel.fromJson(parsedJson));
    return SensorDataModel.fromJson(parsedJson);
  }
}
