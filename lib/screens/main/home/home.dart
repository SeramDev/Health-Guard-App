import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:health_guard/components/blood_pressure_card.dart';
import 'package:health_guard/providers/fetchdata_notifier.dart';
import 'package:health_guard/screens/alert/alert.dart';
import 'package:provider/provider.dart';
import '../../../components/card_collection.dart';
import '../../../components/custom_text.dart';
import '../../../components/sensor_data_card.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/assets_constants.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      context.read<FetchDataNotifier>().startFetching();
    });
  }

  /*void showAlertOrNot() {
    AlertNavigationNotifier alertNotifier =
        context.read<AlertNavigationNotifier>();
    SensorDataNotifier sensorDataNotifier = context.read<SensorDataNotifier>();
    if (alertNotifier.navigatePermission == AlertNavigatePermission.allowed) {
      alertNotifier.navigatePermission = AlertNavigatePermission.disallowed;
      sensorDataNotifier.fetchingStatus = FetchingStatus.disabled;
      if (alertNotifier.cancelButtonPressTimes == 0) {
        Future.delayed(const Duration(seconds: 5), () {
          Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) {
              return AlertScreen();
            },
          ));
        });
      } else {
        alertNotifier.navigatePermission = AlertNavigatePermission.disallowed;
        sensorDataNotifier.fetchingStatus = FetchingStatus.disabled;
        Future.delayed(const Duration(seconds: 1), () {
          Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) {
              return AlertScreen();
            },
          ));
        });
      }
    }
  }*/
  /*
  This method is called by Consumer widget
  Every times wheb consumer rebuild, this will be called.
  So warning !
  This needed to be well managed, before calling Naviagtor, it will be controlled
   */
  /*void showAlertOrNot() async {
    //AlertDataNotifier alertDataNotifier = context.read<AlertDataNotifier>();
    SensorDataNotifier sensorDataNotifier = context.read<SensorDataNotifier>();
    if (sensorDataNotifier.fetchSensorData. == "Abnormal") {
      print("Abnormal>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
      //whenAbnormal(alertDataNotifier);
    }
  }*/

  /*void whenAbnormal(AlertDataNotifier alertDataNotifier) {
    if (alertDataNotifier.alertStatus == AlertStatus.active) {
      context
          .read<SensorDataProvider>()
          .setFetchDataStatus(FetchSensorDataStatus.disabled);
      //! #### MUST - use between init alert screen to cancel pressed
      alertDataNotifier.alertStatus = AlertStatus.disabled;

      if (alertDataNotifier.cancelCount == 0) {
        Future.delayed(const Duration(seconds: 5), () {
          Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) {
              return AlertScreen();
            },
          ));
        });
      } else {
        Future.delayed(const Duration(milliseconds: 500), () {
          Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) {
              return AlertScreen();
            },
          ));
        });
      }
    }*/
  //}

  void alertNavigationAndSnakbarController() {
    print("${context.read<FetchDataNotifier>().fetchData.runtimeType}");
    if (context.read<FetchDataNotifier>().fetchData
        is UpdateFetchDataWithNaviagtion) {
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.push(context, MaterialPageRoute(
          builder: (BuildContext context) {
            return AlertScreen();
          },
        ));
      });
    } else {
      if (context.read<FetchDataNotifier>().fetchData
          is UpdateFetchDataWithResetNotification) {
        AnimatedSnackBar.rectangle(
          'Resetted',
          'Your Health checking paused for 20 min',
          type: AnimatedSnackBarType.info,
          brightness: Brightness.light,
        ).show(
          context,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        /*floatingActionButton: FloatingActionButton(
          onPressed: () {
            AnimatedSnackBar.rectangle(
              'Resetted',
                'Your Health checking paused for 20 min',
                type: AnimatedSnackBarType.info,
                brightness: Brightness.light,
              ).show(
                context,
              );
            //context.read<FetchDataNotifier>().onCancell();
            //context.read<AlertNavigationNotifier>().onCancellPressed();
          },
        ),*/
        body: FadeInRight(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 28,
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 25,
                ),
                const CustomText(
                  "Dashboard",
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryColor,
                ),
                const SizedBox(
                  height: 30,
                ),
                Expanded(
                  child: Consumer<FetchDataNotifier>(
                    builder: (context, value, child) {
                      //
                      //
                      alertNavigationAndSnakbarController();
                      //
                      //
                      return CardCollection(
                        cards: [
                          SensorDataCard(
                              title: "Heart Rate",
                              image_path: AssetConstants.heartRateIcon,
                              value: value.fetchData is LoadedFetchData
                                  ? ((value.fetchData as LoadedFetchData)
                                      .sensorData
                                      .heartRate)
                                  : 0.0,
                              isLoading: value.fetchData is LoadingFetchData),
                          SensorDataCard(
                              title: "SpO2",
                              image_path: AssetConstants.spo2Icon,
                              value: value.fetchData is LoadedFetchData
                                  ? ((value.fetchData as LoadedFetchData)
                                      .sensorData
                                      .oxygenSaturation)
                                  : 0.0,
                              isLoading: value.fetchData is LoadingFetchData),
                          SensorDataCard(
                              title: "Temperature",
                              image_path: AssetConstants.temperatureIcon,
                              value: value.fetchData is LoadedFetchData
                                  ? ((value.fetchData as LoadedFetchData)
                                      .sensorData
                                      .temperature)
                                  : 0.0,
                              isLoading: value.fetchData is LoadingFetchData),
                          BloodPressureCard(
                              title: "Blood Pressure",
                              image_path: AssetConstants.bloodPressureIcon,
                              sbp: value.fetchData is LoadedFetchData
                                  ? ((value.fetchData as LoadedFetchData)
                                      .sensorData
                                      .systolicBloodPressure)
                                  : 0.0,
                              dbp: value.fetchData is LoadedFetchData
                                  ? ((value.fetchData as LoadedFetchData)
                                      .sensorData
                                      .diastolicBloodPressure)
                                  : 0.0,
                              isLoading: value.fetchData is LoadingFetchData),
                        ],
                      );
                    },
                  ),
                ),
                const CustomText(
                  "Status",
                  fontSize: 25,
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(0, 10),
                        blurRadius: 20,
                        color: AppColors.kAsh.withOpacity(.4),
                      )
                    ],
                  ),
                  child: Consumer<FetchDataNotifier>(
                    builder: (context, value, child) {
                      if (value.fetchData is LoadedFetchData) {
                        return CustomText(
                          value.fetchData is LoadedFetchData
                              ? ((value.fetchData as LoadedFetchData)
                                  .sensorData
                                  .status)
                              : "",
                          fontSize: 30,
                          color: AppColors.kWhite,
                        );
                      } else {
                        return const CircularProgressIndicator(
                          color: AppColors.kWhite,
                        );
                      }
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
