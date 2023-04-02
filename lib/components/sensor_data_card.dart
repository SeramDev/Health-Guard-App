import 'package:flutter/material.dart';
import 'package:health_guard/components/custom_text.dart';
import 'package:health_guard/providers/auth/sensorData_provider.dart';
import 'package:provider/provider.dart';
import '../utils/app_colors.dart';

class SensorDataCard extends StatefulWidget {
  const SensorDataCard({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  State<SensorDataCard> createState() => _SensorDataCardState();
}

class _SensorDataCardState extends State<SensorDataCard> {
  List<String> sensors = [
    "Heart Rate",
    "SpO2",
    "Temperature",
    "Blood Pressure"
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<SensorDataProvider>(
      builder: (context, value, child) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: AppColors.kWhite,
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 10),
                blurRadius: 10,
                color: AppColors.primaryColor.withOpacity(.4),
              )
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: CustomText(
                      sensors[widget.index],
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Icon(
                    Icons.monitor_heart_rounded,
                    color: Colors.red,
                    size: 50,
                  ),
                  value.isLoading
                      ? const CircularProgressIndicator(
                          color: AppColors.primaryColor,
                        )
                      : CustomText(
                          value.sensorDataModel.heartRate.toInt().toString(),
                          fontSize: 30,
                        ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
