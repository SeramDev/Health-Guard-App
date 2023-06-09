import 'package:flutter/material.dart';
import 'package:health_guard/components/custom_text.dart';
import '../utils/app_colors.dart';

class BloodPressureCard extends StatefulWidget {
  const BloodPressureCard({
    Key? key,
    required this.title,
    required this.image_path,
    required this.sbp,
    required this.dbp,
    required this.isLoading,
  }) : super(key: key);

  final String title;
  final String image_path;
  final int? sbp;
  final int? dbp;
  final bool isLoading;

  @override
  State<BloodPressureCard> createState() => _BloodPressureCardState();
}

class _BloodPressureCardState extends State<BloodPressureCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
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
                  widget.title,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                widget.image_path,
                width: 60,
              ),
              widget.isLoading
                  ? const CircularProgressIndicator(
                      color: AppColors.primaryColor,
                    )
                  : CustomText(
                      "${widget.sbp?.toInt().toString() ?? ""}/${widget.dbp?.toInt().toString() ?? ""}",
                      fontSize: 30,
                    ),
            ],
          ),
        ],
      ),
    );
  }
}
