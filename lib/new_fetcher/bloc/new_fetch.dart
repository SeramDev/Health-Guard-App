import 'dart:developer';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:health_guard/controllers/sensorData_controller.dart';
import 'package:health_guard/models/objects.dart';
import 'package:health_guard/screens/alert/alert.dart';

abstract class FetchedUserDataExternalState {
  final SensorDataModel sensorDataModel;

  FetchedUserDataExternalState({required this.sensorDataModel});
}

class LoadingFetchUserData extends FetchedUserDataExternalState {
  LoadingFetchUserData({required super.sensorDataModel});
}

class SucessFetchUserData extends FetchedUserDataExternalState {
  SucessFetchUserData({required super.sensorDataModel});
}

//
abstract class FetchedUserDataInternalState {}

class ShowAlert extends FetchedUserDataInternalState {}

class HideAlert extends FetchedUserDataInternalState {}

//

//OnAlert

class AlertNotifier extends StateNotifier<FetchedUserDataExternalState> {
  AlertNotifier()
      : super(LoadingFetchUserData(
            sensorDataModel: SensorDataModel(0.0, 0.0, 0.0, 0, 0, '', false)));

  int tempFetchCount = 0;
  int cancelCount = 0;
  bool isAbnormalPaused = false;
  bool isSnackBarShowed = false;

  FetchedUserDataInternalState internalState = HideAlert();

  // This is called by HomeScreen(dashboar screen)  period timer
  void fetchUserData(BuildContext context) async {
    // OnAlertScreen
    //

    //!!!!!!!!!!!!!
    //!!!!!!!!!!!! [if state == OnAlert -> nothing happens  (without this double Alertscreen showing)]
    // else -> fetch user data and make decisions

    if (internalState is! ShowAlert) {
      log("state != ShowAlert()");
      try {
        Future.microtask(() {
          state = LoadingFetchUserData(
              sensorDataModel: SensorDataModel(0.0, 0.0, 0.0, 0, 0, '', false));
        });

        SensorDataModel sensorDataModel =
            await SensorDataController().fetchData();
        if (sensorDataModel.isEmergencyButtonPressed == true) {
          // if state == ShowAlert (parent should check this)
          // state = ShowAlert
          //state = ShowAlert();
          updateInternalStates(ShowAlert());
          naviagtesToAlertScreen(context);
          log("isEmergencyButtonPressed = true");
        } else {
          // 1 ST IF
          if (!isAbnormalPaused) {
            isSnackBarShowed = false;
            // 2 ND IF
            if (sensorDataModel.status == "Abnormal") {
              log("SECOND (2nd if)===========");
              // 3 RD IF
              if (cancelCount == 0) {
                //state = ShowAlert();
                updateInternalStates(ShowAlert());
                naviagtesToAlertScreen(context);
                log("THIRD  (3rd if)===========");
              } else {
                // 4 TH IF (cancelCount > 0)
                if (tempFetchCount > cancelCount /* +1 */) {
                  tempFetchCount = 0;
                  // state = ShowAlert
                  //state = ShowAlert();
                  updateInternalStates(ShowAlert());
                  naviagtesToAlertScreen(context);
                  log("FOURTH (4th if)===========");
                } else {
                  tempFetchCount++;
                }
              }
            }
          } else {
            // show paused message snack bar
            if (isSnackBarShowed == false) {
              showPausedSnackBar(context);
            }
            isSnackBarShowed = true;
          }
        }
        //! update on every fetch
        state = SucessFetchUserData(
            sensorDataModel: SensorDataModel(
                sensorDataModel.heartRate,
                sensorDataModel.oxygenSaturation,
                sensorDataModel.temperature,
                sensorDataModel.systolicBloodPressure,
                sensorDataModel.diastolicBloodPressure,
                sensorDataModel.status,
                sensorDataModel.isEmergencyButtonPressed));
      } catch (e) {
        // Nothing
      }
    } else {
      log("At  ShowAlert() state");
    }
  }

  void updateInternalStates(FetchedUserDataInternalState newState) {
    internalState = newState;
  }

  void incrementCancel() {
    //must
    updateInternalStates(HideAlert());
    //
    if (cancelCount == 1) {
      cancelCount = 0;
      isAbnormalPaused = true;
      Future.delayed(const Duration(minutes: 15), () {
        isAbnormalPaused = false;
      });
    } else {
      cancelCount++;
    }
  }

  void naviagtesToAlertScreen(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(
      builder: (BuildContext context) {
        return const AlertScreen();
      },
    ));
  }

  void showPausedSnackBar(BuildContext context) {
    AnimatedSnackBar.rectangle(
      'Warning!',
      'Your Health checking is paused for 15 minutes.',
      type: AnimatedSnackBarType.warning,
      brightness: Brightness.light,
    ).show(
      context,
    );
  }
}

final alertStateProvider =
    StateNotifierProvider<AlertNotifier, FetchedUserDataExternalState>((ref) {
  return AlertNotifier();
});
