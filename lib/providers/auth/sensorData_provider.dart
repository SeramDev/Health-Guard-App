import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:health_guard/models/objects.dart';
import 'package:logger/logger.dart';
import '../../controllers/sensorData_controller.dart';

class SensorDataProvider extends ChangeNotifier {
  //---------local sensorData model
  SensorDataModel? _sensorDataModel;
  //---------get sensorData model
  SensorDataModel? get sensorDataModel => _sensorDataModel;

  //---------store loading state
  bool _isLoading = false;
  //---------get loading state
  bool get isLoading => _isLoading;

  //---------change loading state
  void setLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  //---------fetch sensor data
  Future<void> fetchSensorData() async {
    //print("FetchSensorData called<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
    /*
    <<Sachin fetchData() and called notifyListeners()
    */
    try {
      //start the loader
      setLoading(true);

      await SensorDataController().fetchData().then((value) {
        _sensorDataModel = value;

        notifyListeners();

        //stop the loader
        setLoading(false);
      });
    } catch (e) {
      Logger().e(e);
    }

    /*
    <<The Repeater>>
    */
    if (_sensorDataModel?.status != null) {
      if (_sensorDataModel?.status != "Abnormal") {
        Future.delayed(const Duration(seconds: 15), () {
          fetchSensorData();
        });
      }
    }
  }
}
