import 'dart:convert';
import 'package:http/http.dart';
import 'package:logger/logger.dart';
import '../models/objects.dart';

class SensorDataController {
  final endpointUrl = "http://10.0.2.2:5000/fetch-user-status?uid=123";

  Future<SensorDataModel> fetchData() async {
    Response res = await get(Uri.parse(endpointUrl));

    Logger().i(res.statusCode);
    if (res.statusCode == 200) {
      final json = jsonDecode(res.body);
      return SensorDataModel.fromJson(json['userData']);
    } else {
      throw Exception('Failed to load user data');
    }

    /*
    await Future.delayed(const Duration(seconds: 2));
    return SensorDataModel(1, 1, 1, 1, 1, 1, 1, "Abnormal");
    */
  }
}
