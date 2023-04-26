import 'package:flutter/material.dart';

// In int = seconds.
// You can add, edit the list as you like
const List<Duration> delayPeriods = [
  Duration(seconds: 5),
  Duration(seconds: 10),
  Duration(seconds: 20),
  Duration(seconds: 25),
];

// Time for reset after an accident occured
// You can change this value as you like
const Duration resetTime = Duration(minutes: 20);

class AlertDataNotifier extends ChangeNotifier {
  AlertStatus alertStatus = AlertStatus.active;
  int cancelCount = 0;

  void onCancel() {
    cancelCount++;
    alertStatus = AlertStatus.disabled;

    if (cancelCount < delayPeriods.length) {
      Future.delayed(delayPeriods[cancelCount], () {
        alertStatus = AlertStatus.active;
      });
    } else {
      // Resetted : to default (for listen to another accident)
      Future.delayed(resetTime, () {
        cancelCount = 0;
        alertStatus = AlertStatus.active;
      });
    }
  }
}

/*
active   = Can navigates to the AlertScreen
disabled = Temporarily prohibeted the navigation  ()
 */
enum AlertStatus { active, disabled }
