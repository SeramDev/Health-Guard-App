import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' as riverpod;
import 'package:health_guard/components/blood_pressure_card.dart';
import 'package:health_guard/new_fetcher/bloc/new_fetch.dart';
import '../../../components/card_collection.dart';
import '../../../components/custom_text.dart';
import '../../../components/sensor_data_card.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/assets_constants.dart';

class Home extends riverpod.ConsumerStatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  riverpod.ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends riverpod.ConsumerState<Home> {
  @override
  Widget build(BuildContext context) {
    var state = ref.watch(alertStateProvider);
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
                    child: CardCollection(
                  cards: [
                    SensorDataCard(
                        title: "Heart Rate",
                        image_path: AssetConstants.heartRateIcon,
                        value: state is SucessFetchUserData
                            ? state.sensorDataModel.heartRate
                            : 0.0,
                        isLoading: state is LoadingFetchUserData),
                    SensorDataCard(
                        title: "SpO2",
                        image_path: AssetConstants.spo2Icon,
                        value: state is SucessFetchUserData
                            ? state.sensorDataModel.oxygenSaturation
                            : 0.0,
                        isLoading: state is LoadingFetchUserData),
                    SensorDataCard(
                        title: "Temperature",
                        image_path: AssetConstants.temperatureIcon,
                        value: state is SucessFetchUserData
                            ? state.sensorDataModel.temperature
                            : 0.0,
                        isLoading: state is LoadingFetchUserData),
                    BloodPressureCard(
                        title: "Blood Pressure",
                        image_path: AssetConstants.bloodPressureIcon,
                        sbp: state is SucessFetchUserData
                            ? state.sensorDataModel.systolicBloodPressure
                            : 0,
                        dbp: state is SucessFetchUserData
                            ? state.sensorDataModel.diastolicBloodPressure
                            : 0,
                        isLoading: state is LoadingFetchUserData),
                  ],
                )),
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
                    color: (state.sensorDataModel.status == "Normal")
                        ? AppColors.primaryColor
                        : AppColors.primaryRed,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(0, 10),
                        blurRadius: 20,
                        color: AppColors.kAsh.withOpacity(.4),
                      )
                    ],
                  ),
                  child: Builder(
                    builder: (context) {
                      if (state is SucessFetchUserData) {
                        return CustomText(
                          state.sensorDataModel.status,
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
