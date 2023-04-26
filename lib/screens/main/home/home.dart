import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:health_guard/components/blood_pressure_card.dart';
import 'package:health_guard/components/custom_button.dart';
import 'package:health_guard/providers/alert_notifier.dart';
import 'package:health_guard/screens/alert/alert.dart';
import 'package:health_guard/utils/util_functions.dart';
import 'package:provider/provider.dart';
import '../../../components/card_collection.dart';
import '../../../components/custom_text.dart';
import '../../../components/sensor_data_card.dart';
import '../../../providers/sensorData_provider.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/assets_constants.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //late Timer _timer;

  @override
  void initState() {
    super.initState();
    context.read<SensorDataProvider>().fetchSensorData();
  }

  /*
  This method is called by Consumer widget
  Every times wheb consumer rebuild, this will be called.
  So warning !
  This needed to be well managed, before calling Naviagtor, it will be controlled
   */
  void showAlertOrNot() async {
    AlertDataNotifier alertDataNotifier = context.read<AlertDataNotifier>();
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
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                  child: Consumer<SensorDataProvider>(
                    builder: (context, value, child) {
                      showAlertOrNot();
                      //!  <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
                      return CardCollection(
                        cards: [
                          SensorDataCard(
                            title: "Heart Rate",
                            image_path: AssetConstants.heartRateIcon,
                            value: value.sensorDataModel?.heartRate,
                            isLoading: value.isLoading,
                          ),
                          SensorDataCard(
                            title: "SpO2",
                            image_path: AssetConstants.spo2Icon,
                            value: value.sensorDataModel?.oxygenSaturation,
                            isLoading: value.isLoading,
                          ),
                          SensorDataCard(
                            title: "Temperature",
                            image_path: AssetConstants.temperatureIcon,
                            value: value.sensorDataModel?.temperature,
                            isLoading: value.isLoading,
                          ),
                          BloodPressureCard(
                            title: "Blood Pressure",
                            image_path: AssetConstants.bloodPressureIcon,
                            sbp: value.sensorDataModel?.systolicBloodPressure,
                            dbp: value.sensorDataModel?.diastolicBloodPressure,
                            isLoading: value.isLoading,
                          ),
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
                  child: Consumer<SensorDataProvider>(
                    builder: (context, value, child) {
                      return value.isLoading == true
                          ? const CircularProgressIndicator(
                              color: AppColors.kWhite,
                            )
                          : CustomText(
                              (value.sensorDataModel?.status == null)
                                  ? ""
                                  : "${value.sensorDataModel?.status}",
                              fontSize: 30,
                              color: AppColors.kWhite,
                            );
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
