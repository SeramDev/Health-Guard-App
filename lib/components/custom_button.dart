import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import 'custom_text.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.text,
    required this.onTap,
    this.height = 26,
    this.width = 127,
    this.radius = 12,
    this.fontsize = 18,
    this.isLoading = false,
  }) : super(key: key);

  final String text;
  final double width;
  final double height;
  final double radius;
  final double fontsize;
  final Function() onTap;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: isLoading,
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: width,
          height: height,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.primaryRed,
            borderRadius: BorderRadius.circular(radius),
          ),
          child: isLoading
              ? const CircularProgressIndicator(
                  color: AppColors.kWhite,
                )
              : CustomText(
                  text,
                  fontSize: fontsize,
                  color: AppColors.kWhite,
                  fontWeight: FontWeight.w500,
                ),
        ),
      ),
    );
  }
}
