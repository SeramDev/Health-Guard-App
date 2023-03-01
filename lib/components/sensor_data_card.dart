import 'package:flutter/material.dart';
import 'package:health_guard/components/custom_text.dart';

import '../utils/app_colors.dart';

class SensorDataCard extends StatelessWidget {
  const SensorDataCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            children: const [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: CustomText(
                  "Heart Rate",
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              Icon(
                Icons.monitor_heart_rounded,
                color: Colors.red,
                size: 50,
              ),
              CustomText(
                "76",
                fontSize: 30,
              ),
            ],
          )
        ],
      ),
    );
  }
}
