import 'dart:convert';
import 'package:http/http.dart';
import 'package:logger/logger.dart';
import '../models/objects.dart';

class SensorDataController {
  final endpointUrl = "http://13.50.246.130/fetch-user-status?uid=123";

  Future<SensorDataModel> fetchData() async {
    Response res;
    try {
      res =
          await get(Uri.parse(endpointUrl)).timeout(const Duration(seconds: 5));
          Logger().i(res.statusCode);
      if (res.statusCode == 200) {
        final json = jsonDecode(res.body);
        return SensorDataModel.fromJson(json['userData']);
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
}
