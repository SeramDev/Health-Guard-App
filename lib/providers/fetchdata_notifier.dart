// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:health_guard/controllers/sensorData_controller.dart';
// import 'package:health_guard/models/objects.dart';
// import 'package:logger/logger.dart';

// abstract class FetchData {}

// class LoadingFetchData extends FetchData {}

// class LoadedFetchData extends FetchData {
//   final SensorDataModel sensorData;

//   LoadedFetchData({required this.sensorData});
// }

// class UpdateFetchDataWithoutNavigation extends LoadedFetchData {
//   UpdateFetchDataWithoutNavigation({required super.sensorData});
//   //final SensorDataModel sensorData;

//   //UpdateFetchDataWithoutNavigation({required this.sensorData});
// }

// class UpdateFetchDataWithNaviagtion extends LoadedFetchData {
//   UpdateFetchDataWithNaviagtion({required super.sensorData});
//   //final SensorDataModel sensorData;

//   //UpdateFetchDataWithNaviagtion({required this.sensorData});
// }

// class UpdateFetchDataWithResetNotification extends LoadedFetchData {
//   UpdateFetchDataWithResetNotification({required super.sensorData});
// }

// enum RepeatFetch { allow, stop }

// class FetchDataNotifierOld extends ChangeNotifier {
//   // Public state
//   FetchData fetchData = LoadingFetchData();
//   // Private states
//   RepeatFetch repeatFetch = RepeatFetch.allow;
//   int abnormalFetchCount = 0;
//   int cancelCount = 0;

//   //Public method - 1  (on Mapscreen WillPop)
//   void backFromMapScreen() {
//     repeatFetch = RepeatFetch.allow;
//     startFetching();
//   }

//   //Public method - 2
//   void onCancell() {
//     if (cancelCount <= 3) {
//       cancelCount++;
//     } else {
//       if (cancelCount > 80) {
//         //resetted after 80 fetchings
//         cancelCount = 0;
//       } else {
//         cancelCount++;
//       }
//     }
//     repeatFetch = RepeatFetch.allow;
//     startFetching();
//   }

//   //Public method - 3
//   void startFetching() {
//     _runFetching();
//   }

//   //!-------------------------------------------------------------------
//   Future<void> _runFetching() async {
//     SensorDataModel result;
//     try {
//       notifyLoadingFetchData();
//       result = await SensorDataController()
//           .fetchData()
//           .timeout(Duration(seconds: 5));
//       // 2
//       firstDecision(result);
//     } catch (e) {
//       Logger().e(e);
//       _runFetching();
//       if (kDebugMode) {
//         print("Error -> SensorDataController().fetchData() throw an error !");
//       }
//     }
//     await Future.delayed(const Duration(seconds: 15));
//     //_repeatFetching();
//   }

//   // 1
//   void firstDecision(SensorDataModel data) {
//     if (data.status == "Abnormal") {
//       abnormalFetchCount++;
//       secondDecision(data);
//     } else {
//       notifyDataWithoutNavigation(data);
//     }
//   }

//   // 2 if abnormal true section
//   void secondDecision(SensorDataModel data) {
//     if (cancelCount == 4) {
//       cancelCount++;
//       notifyDataWithResetNotification(data);
//     }else if (cancelCount == 3) {
//       if (abnormalFetchCount > 6) {
//         //6 Chage this if you want
//         abnormalFetchCount = 0;
//         repeatFetch = RepeatFetch.stop;
//         notifyDataWithNaviagtion(data);
//       } else {
//         notifyDataWithoutNavigation(data);
//       }
//     } else if (cancelCount == 2) {
//       if (abnormalFetchCount > 4) {
//         //4 Chage this if you want
//         abnormalFetchCount = 0;
//         repeatFetch = RepeatFetch.stop;
//         notifyDataWithNaviagtion(data);
//       } else {
//         notifyDataWithoutNavigation(data);
//       }
//     } else if (cancelCount == 1) {
//       if (abnormalFetchCount > 2) {
//         //3 Change this
//         abnormalFetchCount = 0;
//         repeatFetch = RepeatFetch.stop;
//         notifyDataWithNaviagtion(data);
//       } else {
//         notifyDataWithoutNavigation(data);
//       }
//     } else if (cancelCount == 0) {
//       abnormalFetchCount = 0;
//       repeatFetch = RepeatFetch.stop;
//       notifyDataWithNaviagtion(data);
//     } else {
//       // from 5 <
//       notifyDataWithoutNavigation(data);
//     }
//   }

//   //! -------------------------------------------
//   // notifyListener - 0
//   void notifyLoadingFetchData() {
//     fetchData = LoadingFetchData();
//     notifyListeners();
//   }

//   // notifyListener - 1
//   void notifyDataWithoutNavigation(SensorDataModel sensorData) async {
//     fetchData = UpdateFetchDataWithoutNavigation(sensorData: sensorData);
//     notifyListeners();
//     await Future.delayed(const Duration(seconds: 5));
//     _runFetching();
//   }

//   // notifyListner - 2
//   void notifyDataWithNaviagtion(SensorDataModel sensorData) {
//     fetchData = UpdateFetchDataWithNaviagtion(sensorData: sensorData);
//     notifyListeners();
//   }

//   // notifyListner - 3
//   void notifyDataWithResetNotification(SensorDataModel sensorData) async {
//     fetchData = UpdateFetchDataWithResetNotification(sensorData: sensorData);
//     notifyListeners();
//     await Future.delayed(const Duration(seconds: 5));
//     _runFetching();
//   }
// }
