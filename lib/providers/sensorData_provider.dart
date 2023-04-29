import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:health_guard/models/objects.dart';
import 'package:logger/logger.dart';
import '../controllers/sensorData_controller.dart';

enum DashBoardStatus { active, disabled }

abstract class SensorData {}

class InitSensorData extends SensorData {}

class LoadingSensorData extends SensorData {}

class FetchedSensorData extends SensorData {
  final SensorDataModel sensorData;

  FetchedSensorData({required this.sensorData});
}

class SensorDataNotifier extends ChangeNotifier {
  DashBoardStatus dashBoardStatus = DashBoardStatus.active;
  SensorData fetchSensorData = InitSensorData();
  bool _isFetchRunning = false;

  void startFetching() {
    if (_isFetchRunning == false) {
      _repeatFetching();
    }
    
  }

  void _repeatFetching() async {
    if (dashBoardStatus == DashBoardStatus.active) {
      _isFetchRunning = true;
      _runFetching();
    } else {
      _isFetchRunning = false;
    }
  }

  Future<void> _runFetching() async {
    SensorDataModel result;
    try {
      fetchSensorData = LoadingSensorData();
      notifyListeners();

      result = await SensorDataController().fetchData();
      fetchSensorData = FetchedSensorData(sensorData: result);
      notifyListeners();
    } catch (e) {
      Logger().e(e);
      if (kDebugMode) {
        print("Error -> SensorDataController().fetchData() throw an error !");
      }
    }
    await Future.delayed(const Duration(seconds: 15));
    _repeatFetching();
  }
}





/*enum FetchSensorDataStatus { disabled, active }

class SensorDataProvider extends ChangeNotifier {
  //---------local sensorData model
  SensorDataModel? _sensorDataModel;
  //---------get sensorData model
  SensorDataModel? get sensorDataModel => _sensorDataModel;

  //---------store loading state
  bool _isLoading = false;
  //---------get loading state
  bool get isLoading => _isLoading;

//! ********************************************************************************************************************************
// TODO ============================================================================================================================
// Todo :  For very state / or local state , plz write who are its getters and setters like below, easy to debug and make changes
//
  /*
  <SETTERS>
  --disabled--
  This set to disbled when auto naviagtes to AlertScreen 
  (by showAlertOrNot() method)

  --active--
  This will active by AlertScreen's cancel button when clicked
  (by AlertScreen cancel button)

  <Getters>
  This value used by this class itself inside fetchSensorData() method.
   */
  FetchSensorDataStatus fetchSensorDataStatus = FetchSensorDataStatus.active;

  //---------change loading state
  void setLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  void setFetchDataStatus(FetchSensorDataStatus status) {
    fetchSensorDataStatus = status;
  }

  /*
  * This method only calls one-time (On app startup only)
  * This method runs repeatedly on startup until FetchDataStatus.disbled setted.
   */
  Future<void> fetchSensorData() async {
    if (fetchSensorDataStatus == FetchSensorDataStatus.active) {
      onActive();
    }
  }

  void onActive() async {
    /*
    Part 01 - FetchData() and called notifyListeners()
    */
    SensorDataModel result;
    try {
      //start the loader
      // here microtask used to avoid calling notifiListner() on widget building and avoid markNeedsToRebuilt error
      await Future.microtask(() {
        setLoading(true);
      });

      result = await SensorDataController().fetchData(); //.then((value) {
      _sensorDataModel = result;
      //stop the loader
      setLoading(false);
      notifyListeners();
      //});
    } catch (e) {
      Logger().e(e);
      if (kDebugMode) {
        print("Error -> SensorDataController().fetchData() throw an error !");
      }
    }

    /*
    Part 02 - The Repeater (delayed function recursion)
    */
    await Future.delayed(const Duration(seconds: 20), () {
      fetchSensorData();
    });
  }
}
*/