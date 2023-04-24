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

  //! Local States used to implement AlertCancel
  int alertDelay = 0;
  int noOfCancells = 0;
  int totalRepetitionTime = 0;

  ///===========================================================================
  ///===========================================================================
  /*
  *----------------   fetchSensorDataOnStartup  -------------------
  * This method only calls one-time (On app startup only)
  * This method runs repeatedly on startup until status = "Abnormal"
   */
  Future<void> fetchSensorData(Function showAlertCallback) async {
    print(
        "fetchSensorDataOnStartup --------------------------------------------");
    /*
    <<Sachin fetchData() and called notifyListeners()
    */
    try {
      //start the loader
      // here microtask used to avoid calling notifiListner() on widget building
      await Future.microtask(() {
        setLoading(true);
      });

      await SensorDataController().fetchData().then((value) {
        _sensorDataModel = value;
        //stop the loader
        setLoading(false);
        notifyListeners();
      }); //.timeout(const Duration(seconds: 5));
    } catch (e) {
      Logger().e(e);
    }

    /*
    <<The Repeater>>
    */

    if (_sensorDataModel?.status != null) {
      if (_sensorDataModel?.status == "Abnormal") {
        if (noOfCancells == 0) {
          showAlertCallback();
        } else {
          if (totalRepetitionTime > alertDelay) {
            showAlertCallback();
            totalRepetitionTime = 0;
          } else {
            await Future.delayed(const Duration(seconds: 15), () {
              totalRepetitionTime =
                  totalRepetitionTime + 15; // 15 <- is delay time for request
            });
            fetchSensorData(showAlertCallback);
          }
        }
      } else {
        await Future.delayed(const Duration(seconds: 15), () {
          fetchSensorData(showAlertCallback);
        });
      }
    }
  }

  ///===========================================================================
  ///===========================================================================
  /*
   *  This method called when AlertScreen's cancel button was clicked
   */

  Future<void> fetchSensorDataOnAlertCancel(Function showAlertCallback) async {
    noOfCancells++;
    if (noOfCancells == 1) {
      alertDelay = 15;
      fetchSensorData(showAlertCallback);
    } else if (noOfCancells == 2) {
      alertDelay = 30;
      fetchSensorData(showAlertCallback);
    } else if (noOfCancells == 3) {
      alertDelay = 60;
      fetchSensorData(showAlertCallback);
    }
  }
}
